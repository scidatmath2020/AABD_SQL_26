#///////////////////////////////////////////////////#
# Bases de datos con SQL                            #
# Tema: Conexión de BD de PostgreSQL en R y Python  #
# ENUT2024 | Conexión por servicio desde R          #
# Docente: Alexis Adonai Morales Alberto            #
# SciData                                           #
#///////////////////////////////////////////////////#

# Ejecutar paso a paso. Establecer como directorio de trabajo esta carpeta.

# Instalar una sola vez ----

install.packages(c("DBI", "RPostgres", "getPass"))

# Cargar en la sesión los siguientes paquetes ----

library(DBI)
library(RPostgres)

pacman::p_load(
  "DBI",
  "RPostgres",
  "tidyverse"
)

# Configuración editable ----

## Servicio de postgreSQL (local) -----

archivo_servicio <- normalizePath("pg_service.conf",
                                  mustWork = TRUE)

Sys.setenv(PGSERVICEFILE = archivo_servicio)

## Definción de qué consultará y con qué usuario ----

servicio <- "enut2024"
usuario <- "enut_lector"
esquema <- "enut"
tabla <- "tmodulo"
tablas_validas <- c("tvivienda", "thogar", 
                    "tsdem", "tmodulo", "tvar_crea")

stopifnot(tabla %in% tablas_validas)
clave <- getPass::getPass("Contraseña de PostgreSQL: ")

# Conexión a PostgreSQL -----

con <- dbConnect(
  RPostgres::Postgres(), service = servicio,
  user = usuario, password = clave
)

rm(clave)

# Comprobar servidor, base y usuario ----

dbGetQuery(con, 
           "SELECT current_database() AS base, current_user AS usuario")

dbGetQuery(con, "
  SELECT table_schema, table_name
  FROM information_schema.tables
  WHERE table_schema = 'enut' 
  ORDER BY table_name
")

# Elegir una tabla sin concatenar identificadores sin protección ----

identificador <- dbQuoteIdentifier(con,
                                   Id(schema = esquema, 
                                      table = tabla))

consulta <- paste0("SELECT * FROM ", identificador)

vista_previa <- dbGetQuery(con, consulta)

print(vista_previa)

# Filtro parametrizado: 01 = Aguascalientes ----

entidad <- "01"

personas <- dbGetQuery(con, "
 SELECT llavemod, sexo, fac_per, trab_no_rem_hog
 FROM enut.tvar_crea WHERE cve_ent = $1
 ORDER BY llavemod", params = list(entidad))

head(personas)

# Indicador completo, calculado en el servidor: sin LIMIT ----

indicador <- dbGetQuery(
  con,
  "
  SELECT sexo, COUNT(*) AS n_muestra,
       SUM(fac_per) AS personas_participantes,
       ROUND(SUM(NULLIF(TRIM(trab_no_rem_hog), '')::numeric * fac_per)
             / NULLIF(SUM(fac_per), 0), 2) AS media_horas
  FROM enut.tvar_crea
  WHERE fac_per > 0 AND sexo IN ('1', '2')
    AND NULLIF(TRIM(trab_no_rem_hog), '')::numeric > 0
  GROUP BY sexo ORDER BY sexo
")

print(indicador)

# Combinación entre SQL y R: Gráfico con datos de consulta ----

datos_grafico <- indicador

datos_grafico$Sexo <- factor(
  as.character(datos_grafico$sexo),
  levels = c("2", "1"),
  labels = c("Mujeres", "Hombres")
)

datos_grafico$Etiqueta <- sprintf(
  "%.2f h",
  datos_grafico$media_horas
)

colores <- c(
  "Hombres" = "#003057",
  "Mujeres" = "#08989C"
)

maximo <- max(datos_grafico$media_horas, na.rm = TRUE)

fuente <- "Arial"

grafico_horas <- ggplot(
  datos_grafico,
  aes(x = media_horas, y = fct_rev(Sexo))
) +
  geom_col(
    aes(fill = Sexo),
    width = 0.48
  ) +
  geom_text(
    aes(label = Etiqueta, colour = Sexo),
    hjust = 0,
    nudge_x = maximo * 0.025,
    family = fuente,
    fontface = "bold",
    size = 5
  ) +
  scale_fill_manual(values = colores, guide = "none") +
  scale_colour_manual(values = colores, guide = "none") +
  scale_x_continuous(
    limits = c(0, maximo * 1.25),
    breaks = seq(0, ceiling(maximo / 10) * 10, by = 10),
    expand = expansion(mult = c(0, 0))
  ) +
  scale_y_discrete(
    expand = expansion(add = 0.65)
  ) +
  labs(
    title = "Trabajo no remunerado en el hogar",
    subtitle = "Horas promedio por sexo · 2024",
    x = "Horas promedio",
    y = NULL,
    caption = paste0(
      "Fuente: INEGI. Encuesta Nacional sobre Uso del Tiempo ",
      "(ENUT), 2024."
    )
  ) +
  theme_minimal(
    base_size = 12,
    base_family = fuente
  ) +
  theme(
    plot.background = element_rect(
      fill = "white", colour = NA
    ),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_line(
      colour = "#E8ECEF", linewidth = 0.4
    ),
    axis.text.y = element_text(
      size = 13, face = "bold", colour = "#4D565E"
    ),
    axis.text.x = element_text(
      colour = "#4D565E"
    ),
    axis.title.x = element_text(
      colour = "#4D565E",
      margin = margin(t = 12)
    ),
    plot.title = element_text(
      size = 18, face = "bold", colour = "#003057"
    ),
    plot.subtitle = element_text(
      size = 12,
      colour = "#4D565E",
      margin = margin(t = 7, b = 18)
    ),
    plot.caption = element_text(
      size = 9,
      colour = "#4D565E",
      hjust = 0,
      margin = margin(t = 18)
    ),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.margin = margin(20, 25, 16, 20)
  )

grafico_horas


# Cerrar al terminar (también si interrumpes una consulta con error) ----

dbDisconnect(con)
