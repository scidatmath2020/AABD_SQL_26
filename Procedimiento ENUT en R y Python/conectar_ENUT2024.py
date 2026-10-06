"""
# Bases de datos con SQL                            
# Tema: Conexión de BD de PostgreSQL en R y Python  
# ENUT2024 | Conexión por servicio desde R        
# Docente: Alexis Adonai Morales Alberto            
# SciData                                           
"""
# pip install --user --upgrade "psycopg[binary]" - Instalación correcta
# pip install pycopg - no lo instala completamente porque requiere
# permisos de administrador

from pathlib import Path
from getpass import getpass
import os
import pandas as pd
import psycopg
from psycopg import sql
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import font_manager

# 1. Configuración editable

carpeta = Path(__name__).resolve().parent
archivo_servicio = carpeta / "pg_service.conf"
if not archivo_servicio.is_file():
    raise FileNotFoundError(archivo_servicio)
os.environ["PGSERVICEFILE"] = str(archivo_servicio)
servicio = "enut2024"
usuario = "enut_lector"
esquema = "enut"
tabla = "tvar_crea"
tablas_validas = {"tvivienda", "thogar", "tsdem", "tmodulo", "tvar_crea"}
if tabla not in tablas_validas:
    raise ValueError("Tabla no prevista en la ENUT")
clave = "ENUT_2024_OCT_26"

# 2. Conexión y cierre automático, incluso ante errores
with psycopg.connect(service=servicio, user=usuario,
                     password=clave, autocommit=True) as con:
    del clave
    with con.cursor() as cur:
        # 3. Comprobar conexión
        cur.execute("SELECT current_database(), current_user")
        print(cur.fetchone())

        # 4. Tabla elegida con identificadores protegidos
        consulta = sql.SQL("SELECT * FROM {} LIMIT %s").format(
            sql.Identifier(esquema, tabla)
        )
        cur.execute(consulta, (10,))
        vista_previa = pd.DataFrame(cur.fetchall(),
                                   columns=[c.name for c in cur.description])
        print(vista_previa.head())

        # 5. Filtro: los valores se envían separados del SQL
        entidad = "01"
        cur.execute("""
            SELECT llavemod, sexo, fac_per, trab_no_rem_hog
            FROM enut.tvar_crea WHERE cve_ent = %s
            ORDER BY llavemod LIMIT 100
        """, (entidad,))
        personas = pd.DataFrame(cur.fetchall(),
                                columns=[c.name for c in cur.description])
        print(personas.head())

        # 6. Indicador sobre todos los registros válidos, sin LIMIT
        cur.execute("""
            SELECT sexo, COUNT(*) AS n_muestra,
                   SUM(fac_per) AS personas_participantes,
                   ROUND(SUM(NULLIF(TRIM(trab_no_rem_hog), '')::numeric * fac_per)
                         / NULLIF(SUM(fac_per), 0), 2) AS media_horas
            FROM enut.tvar_crea
            WHERE fac_per > 0 AND sexo IN ('1', '2')
              AND NULLIF(TRIM(trab_no_rem_hog), '')::numeric > 0
            GROUP BY sexo ORDER BY sexo
        """)
        indicador = pd.DataFrame(cur.fetchall(),
                                columns=[c.name for c in cur.description])
        print(indicador)

        # 7. Unión de personas con hogares
        cur.execute("""
            SELECT p.llavemod, p.sexo, p.fac_per,
                   h.p2_4_13 AS internet_hogar
            FROM enut.tvar_crea p
            JOIN enut.thogar h USING (llavehog)
            WHERE p.cve_ent = %s ORDER BY p.llavemod LIMIT 100
        """, (entidad,))
        personas_hogar = pd.DataFrame(cur.fetchall(),
                                      columns=[c.name for c in cur.description])
        print(personas_hogar.head())



# Gráfico 

datos_grafico = indicador.copy()

datos_grafico["Sexo"] = (
    datos_grafico["sexo"]
    .astype(int)
    .map({1: "Hombres", 2: "Mujeres"})
)

datos_grafico = (
    datos_grafico
    .set_index("Sexo")
    .loc[["Mujeres", "Hombres"]]
)

horas = datos_grafico["media_horas"].to_numpy(dtype=float)
posiciones = np.array([1, 0])

# 3. Colores y tipografía.
colores = ["#08989C", "#003057"]
color_texto = "#4D565E"

fuentes_disponibles = {
    f.name for f in font_manager.fontManager.ttflist
}

fuente = next(
    (
        f for f in ["Arial", "Noto Sans", "DejaVu Sans"]
        if f in fuentes_disponibles
    ),
    "sans-serif"
)

# 4. Construir el gráfico.
with plt.rc_context({"font.family": fuente, "font.size": 12}):

    fig, ax = plt.subplots(figsize=(10, 5.2), dpi=150)

    fig.patch.set_facecolor("white")
    ax.set_facecolor("white")

    fig.subplots_adjust(
        left=0.16, right=0.94,
        bottom=0.24, top=0.73
    )

    ax.barh(
        posiciones,
        horas,
        height=0.48,
        color=colores,
        zorder=3
    )

    # Etiquetas al final de cada barra.
    maximo = horas.max()

    for posicion, valor, color in zip(posiciones, horas, colores):
        ax.text(
            valor + maximo * 0.025,
            posicion,
            f"{valor:.2f} h",
            ha="left",
            va="center",
            fontsize=14,
            fontweight="bold",
            color=color
        )

    # Ejes y escala.
    ax.set_yticks(posiciones)
    ax.set_yticklabels(
        datos_grafico.index,
        fontsize=13,
        fontweight="bold",
        color=color_texto
    )

    ax.set_ylim(-0.65, 1.65)
    ax.set_xlim(0, maximo * 1.25)

    ax.set_xticks(
        np.arange(0, np.ceil(maximo / 10) * 10 + 1, 10)
    )

    ax.set_xlabel(
        "Horas promedio",
        color=color_texto,
        labelpad=12
    )

    ax.tick_params(
        axis="both",
        length=0,
        colors=color_texto,
        pad=9
    )

    # Cuadrícula discreta y eliminación de bordes.
    ax.set_axisbelow(True)
    ax.grid(axis="x", color="#E8ECEF", linewidth=0.7)

    for borde in ax.spines.values():
        borde.set_visible(False)

    # Título, subtítulo y fuente.
    fig.text(
        0.06, 0.92,
        "Trabajo no remunerado en el hogar",
        ha="left",
        fontsize=18,
        fontweight="bold",
        color="#003057"
    )

    fig.text(
        0.06, 0.85,
        "Horas promedio por sexo · 2024",
        ha="left",
        fontsize=12,
        color=color_texto
    )

    fig.text(
        0.06, 0.07,
        "Fuente: INEGI. Encuesta Nacional sobre Uso del Tiempo "
        "(ENUT), 2024.",
        ha="left",
        fontsize=9,
        color=color_texto
    )

    # 5. Guardar en alta resolución y mostrar.
    fig.savefig(
        "ENUT_horas_trabajo_no_remunerado.png",
        dpi=500,
        facecolor="white",
        bbox_inches="tight"
    )

    plt.show()

# Cerrar conexión 

con.close()
