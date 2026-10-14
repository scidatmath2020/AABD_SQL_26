"""Importación de los CSV ENUT originales a MySQL 8.4.
Instalar en CMD: python -m pip install mysql-connector-python
Ejecutar en terminal: python 02_importar_ENUT2024.py
No ejecutar por líneas en la consola >>>. Cambiar carpeta, puerto y usuario abajo.
"""
from pathlib import Path
from getpass import getpass
from decimal import Decimal, InvalidOperation
import csv
import mysql.connector

carpeta = Path(input('Carpeta que contiene los cinco CSV: ').strip().strip('"'))
host = '127.0.0.1'
puerto = 3306
usuario = 'root'  # Administrador únicamente para preparar la práctica.
base = 'enut2024'
orden = ['tvivienda','thogar','tsdem','tmodulo','tvar_crea']
archivos = {p.stem.lower():p for p in carpeta.glob('*')
            if p.is_file() and p.suffix.lower()=='.csv'}
faltan = [t for t in orden if t not in archivos]
if faltan:
    raise FileNotFoundError('Faltan CSV: '+', '.join(faltan))
clave = getpass('Contraseña de MySQL: ')
con = mysql.connector.connect(host=host, port=puerto, user=usuario,
                              password=clave, database=base,
                              charset='utf8mb4', autocommit=False,
                              raise_on_warnings=True)
del clave
cur = con.cursor()
try:
    cur.execute("SET SESSION sql_mode = 'STRICT_ALL_TABLES,NO_ENGINE_SUBSTITUTION'")
    con.commit()
    for tabla in orden:
        archivo = archivos[tabla]
        cur.execute('SELECT column_name,data_type,character_maximum_length,'
                    'numeric_precision FROM information_schema.columns '
                    'WHERE table_schema=%s AND table_name=%s '
                    'ORDER BY ordinal_position', (base,tabla))
        columnas = cur.fetchall()
        if not columnas:
            raise RuntimeError('Falta la tabla '+tabla+'; ejecutar primero 01_crear_ENUT2024.sql')
        nombres = [c[0].lower() for c in columnas]
        with archivo.open(encoding='utf-8-sig',newline='') as f:
            lector = csv.reader(f)
            cabecera = [x.strip().lower() for x in next(lector)]
            if cabecera != nombres:
                raise ValueError('Encabezado u orden incorrecto en '+archivo.name)
            esperadas = sum(1 for fila in lector)
        cur.execute('SELECT COUNT(*) FROM `'+tabla+'`')
        actuales = cur.fetchone()[0]
        con.commit()
        if actuales:
            if actuales == esperadas:
                print(tabla,': omitida; ya tiene',actuales,'filas. No se compara contenido.')
                continue
            raise RuntimeError(f'{tabla} tiene {actuales} filas, CSV {esperadas}. '
                               'No se agregan registros a una tabla parcialmente cargada.')
        campos = ','.join('`'+c+'`' for c in nombres)
        parametros = ','.join(['%s']*len(nombres))
        consulta = 'INSERT INTO `'+tabla+'` ('+campos+') VALUES ('+parametros+')'
        con.start_transaction()
        lote = []
        cargadas = 0
        numero = 1
        try:
            with archivo.open(encoding='utf-8-sig',newline='') as f:
                lector = csv.reader(f)
                next(lector)
                for numero,fila in enumerate(lector,start=2):
                    if len(fila) != len(columnas):
                        raise ValueError(f'Fila {numero}: número de campos incorrecto')
                    valores = []
                    for texto,(nombre,tipo,largo,precision) in zip(fila,columnas):
                        if tipo in ('decimal','numeric'):
                            if texto.strip()=='':
                                valor = None
                            else:
                                valor = Decimal(texto.strip())
                                if not valor.is_finite() or valor != valor.to_integral_value():
                                    raise ValueError(f'Fila {numero}: factor no entero en {nombre}')
                                if abs(valor) >= Decimal(10)**precision:
                                    raise ValueError(f'Fila {numero}: factor fuera de tamaño en {nombre}')
                        else:
                            if largo is not None and len(texto)>largo:
                                raise ValueError(f'Fila {numero}: texto demasiado largo en {nombre}')
                            valor = texto  # Mantiene ceros, cadenas vacías y códigos especiales.
                        valores.append(valor)
                    if valores[0] is None or str(valores[0]).strip()=='':
                        raise ValueError(f'Fila {numero}: llave primaria vacía')
                    lote.append(tuple(valores))
                    if len(lote)==250:
                        cur.executemany(consulta,lote)
                        cargadas += len(lote)
                        lote.clear()
                if lote:
                    cur.executemany(consulta,lote)
                    cargadas += len(lote)
            if cargadas != esperadas:
                raise RuntimeError('El número cargado no coincide con el CSV')
            cur.execute('SELECT COUNT(*) FROM `'+tabla+'`')
            if cur.fetchone()[0] != esperadas:
                raise RuntimeError('Conteo final incorrecto en '+tabla)
            con.commit()
            print(tabla,':',cargadas,'filas confirmadas')
        except Exception as error:
            con.rollback()
            raise RuntimeError(f'Carga revertida para {tabla}; lote hasta fila {numero}. '
                               f'Causa: {error}') from error
finally:
    cur.close()
    con.close()
