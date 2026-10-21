"""
# Bases de datos con SQL                            
# Tema: Conexión de BD de PostgreSQL en R y Python  
# Mapa de CDMX | Conexión por servicio desde Python        
# Docente: Alexis Adonai Morales Alberto            
# SciData                                           
"""

# Modulos iniciales

!pip install sqlalchemy geopandas

from getpass import getpass
from sqlalchemy import URL, create_engine, text
import geopandas as gpd
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.ticker import FuncFormatter
from pathlib import Path

# Realizar consulta

clave = "CdMx_M@pa_202S" 
url = URL.create(
  "postgresql+psycopg",
  username = "gis_lector",
  password = clave,
  host = "localhost",
  port = 5432,
  database = "gis_cdmx"
)
engine = create_engine(
  url, connect_args = {"connect_timeout": 10}
)

archivo_sql = Path("mapa_alcaldias.sql")
consulta = archivo_sql.read_text(encoding = "utf-8")

try:
  with engine.connect() as con:
    alcaldias = gpd.read_postgis(
      text(consulta), con, geom_col = "geom"
    )
finally:
  engine.dispose()
  
print(alcaldias)

# Visualizar mapa 

def dibujar_mapa_poblacion(alcaldias, origen='Marco geoestadístico, 2025'):
    cmap = LinearSegmentedColormap.from_list('edl', ['#EDF8F7','#08989C','#003057'])
    fig, ax = plt.subplots(figsize=(8,9), dpi = 500)
    alcaldias.plot(column='poblacion_2020', cmap=cmap, linewidth=0.7,
                   edgecolor='white', legend=False, ax=ax)
    for _, fila in alcaldias.iterrows():
        punto = fila.geom.representative_point()
        ax.text(punto.x, punto.y, fila.cve_mun, ha='center', va='center',
                fontsize=8, color='#202020', bbox={'facecolor':'white',
                'alpha':0.78,'edgecolor':'none','pad':0.8})
    escala = plt.cm.ScalarMappable(cmap=cmap,
        norm=plt.Normalize(alcaldias.poblacion_2020.min(),alcaldias.poblacion_2020.max()))
    barra = fig.colorbar(escala, ax=ax, orientation='horizontal', fraction=0.04,pad=0.02)
    barra.set_ticks([200000,600000,1000000,1400000,1800000])
    barra.set_label('Personas en 2020')
    barra.ax.xaxis.set_major_formatter(FuncFormatter(lambda x,pos: f'{x:,.0f}'))
    ax.set_title('Población por alcaldía de la CDMX',loc='left',fontsize=15,fontweight='bold',pad=25)
    ax.text(0,1.015,'Censo 2020 · Límites geoestadísticos diciembre 2025',
            transform=ax.transAxes,color='#4D565E',fontsize=10)
    ax.set_axis_off()
    ax.set_aspect('equal')
    fig.text(0.13,0.025,f'Fuente: INEGI. {origen}. Etiquetas: clave municipal.\n'
             'Mapa descriptivo; los límites geoestadísticos no acreditan propiedad.',
             fontsize=8,color='#4D565E')
    fig.subplots_adjust(bottom=0.14,top=0.88,left=0.10,right=0.96)
    for ext in ['png','svg']:
        fig.savefig(f'mapa_poblacion_python.{ext}',dpi=500,facecolor='white')
    plt.close(fig)
    

dibujar_mapa_poblacion(alcaldias)

# Exportar mapa como shp 

carpeta = Path.cwd() / "CDMX_Alcaldias"
carpeta.mkdir(parents = True, exist_ok = True)

salida = alcaldias.copy()

archivo = carpeta / "alcaldias_cdmx.shp"

salida.to_file(
  archivo,
  driver = "ESRI Shapefile",
  encoding = "UTF-8",
  index = False
)
