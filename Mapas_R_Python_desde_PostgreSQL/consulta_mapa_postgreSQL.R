#///////////////////////////////////////////////////#
# Bases de datos con SQL                            #
# Tema: Conexión de BD de PostgreSQL en R y Python  #
# Mapa de CDMX | Conexión por servicio desde R      #
# Docente: Alexis Adonai Morales Alberto            #
# SciData                                           #
#///////////////////////////////////////////////////#

# Limpieza de memoria del programa -----

rm(list=ls())

# Ejecutar paso a paso. Establecer como directorio de trabajo esta carpeta.

# Uso de pacman para carga de paquetes ----

pacman::p_load("DBI", "RPostgres", "getPass",
               "tidyverse", "sf", "scales")

# NOTA: En caso de que un paquete no este instalado
# pacman mediante p_load, realiza la instalación

# Verificación de archivos necesarios -----

getwd()
file.exists("mapa_alcaldias.sql")

# Crear función de consulta de postgis -----

consultar_postgis <- function(
  Host = "localhost",
  Puerto = 5432,
  Servicio = "gis_cdmx",
  Usuario = "gis_lector",
  Contraseña = "CdMx_M@pa_202S"
){
  if(is.null(Contraseña)){
    Contraseña <- getPass::getPass("Contraseña: ")
  }
  conexion <- DBI::dbConnect(
    RPostgres::Postgres(),
    host = Host,
    port = as.integer(Puerto),
    dbname = Servicio,
    user = Usuario,
    password = Contraseña,
    connect_timeout = 10
  )
  on.exit(DBI::dbDisconnect(conexion), add = TRUE)
  
  consulta <- paste(readLines(
    file.path("mapa_alcaldias.sql"),
    encoding = "UTF-8"
  ), collapse = "\n")
  
  sf::st_read(conexion, query = consulta, quiet = TRUE)
}

mapa <- consultar_postgis()

# Construcción del mapa 

etiquetas <- st_point_on_surface(mapa)

mapa |> 
  ggplot()+
  geom_sf(aes(fill = poblacion_2020), colour = "white",
          linewidth = 0.4)+
  geom_sf_label(data = etiquetas,
                aes(label = cve_mun),
                size = 2.5,
                fill = "white", 
                linewidth = 0)+
  scale_fill_gradientn(
    colours = c("#EDF8F7", "#08989C", "#003057"),
    name = "Personas en 2020",
    labels = scales::label_comma(accuracy = 1)
  )+
  labs(title = "Población por alcadía de la CDMX",
       subtitle = "Censo 2020 · Límites geoestadísticos diciembre 2025",
       caption = "Fuente. INEGI. Marco geoestadístico, 2025.")+
  theme_void(base_family = "sans", base_size = 11) +
  theme(
    plot.title = ggplot2::element_text(face = "bold", 
                                       size = 16, colour = "black"),
    plot.subtitle = ggplot2::element_text(colour = "#4D565E"),
    plot.caption = ggplot2::element_text(colour = "#4D565E",
                                         hjust = 0, size = 9),
    legend.position = "right", 
    plot.margin = ggplot2::margin(5,0, 0, 5)
  )

  
