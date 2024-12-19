library(shiny)
if(!require(bslib)){install.packages("bslib")}
if(!require(googlesheets4)){install.packages("googlesheets4")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(shinyjs)){install.packages("shinyjs")} # Para manejar la interacción con el modal

# Configurar autenticación de Google Sheets
options(gargle_oauth_cache = ".secrets")
gs4_deauth() # Desautenticar primero

# Si estás en modo local (desarrollo)
if (interactive()) {
  gs4_auth(cache = ".secrets", email = TRUE)
} else {
  # Si estás en el servidor (producción)
  gs4_auth(cache = ".secrets")
}

# Configurar tema
my_theme <- bs_theme(
  bg = "#ffffff",
  fg = "rgba(0, 0, 0, 0.8)",
  primary = "#bc7777",
  "font-family-base" = "Oswald, sans-serif",
  "headings-font-family" = "Oswald, sans-serif",
  "headings-color" = "#555555"
) |>
  bs_add_rules(
    "@import url('https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap');
     * { font-family: 'Oswald', sans-serif !important; }"
  )

# ID de la hoja de Google Sheets
sheet_id <- "1ugwS0hKcCziC7MvFLIIpiG1JLBI3L-0opnd3fOd74ig"

# UI
ui <- page_fluid(
  theme = my_theme,
  useShinyjs(),

  card(
    card_header(
      h1("Encuesta de Retroalimentación", class = "text-center")
    ),
    card_body(
      p("Curso: Reproducibilidad y Comunicación de Resultados", class = "lead text-center"),
      p("Diplomado en Data Science para las Ciencias Sociales", class = "text-center"),
      br(),
      p(HTML(
        "Esta encuesta es completamente <strong>voluntaria</strong> y <strong>anónima</strong>.
        Tu retroalimentación es muy valiosa para nosotros ya que nos ayudará a mejorar continuamente el contenido y la calidad del curso.
        Agradecemos tu tiempo y sinceridad en las respuestas. Por cierto, la aplicación de la encuesta está disponible en
        <a href='https://github.com/AGSCL/repr/tree/master/retroalimentacion/' target='_blank'><strong>Github</strong></a>
        (ojo que requiere credenciales de mi propio correo que tendrán que adaptar a sus ejemplos)."
      ), class = "text-muted mb-4"),
      br(),

      selectInput("general_satisfaction",
                  "¿Qué tan satisfecho/a estás con el curso en general?",
                  choices = c("Seleccione una opción" = "",
                              "Muy satisfecho/a" = 5,
                              "Satisfecho/a" = 4,
                              "Neutral" = 3,
                              "Insatisfecho/a" = 2,
                              "Muy insatisfecho/a" = 1)),

      textAreaInput("strengths",
                    "¿Cuáles consideras que fueron las principales fortalezas del curso?",
                    height = "100px"),

      textAreaInput("improvements",
                    "¿Qué aspectos del curso crees que podrían mejorarse?",
                    height = "100px"),

      radioButtons("content_clarity",
                   "¿El contenido del curso fue presentado de manera clara y comprensible?",
                   choices = c("Totalmente de acuerdo" = 5,
                               "De acuerdo" = 4,
                               "Neutral" = 3,
                               "En desacuerdo" = 2,
                               "Totalmente en desacuerdo" = 1)),

      selectInput("instructor_rating",
                  "¿Cómo evaluarías el desempeño de los instructores (René, Amaru y docente)?",
                  choices = c("Seleccione una opción" = "",
                              "Excelente" = 5,
                              "Muy bueno" = 4,
                              "Bueno" = 3,
                              "Regular" = 2,
                              "Deficiente" = 1)),

      textAreaInput("additional_comments",
                    "Comentarios adicionales (opcional)",
                    height = "100px"),

      br(),
      # Mensajes de error/éxito justo antes del botón
      div(id = "error-message", style = "display: none;",
          class = "alert alert-danger mb-3", role = "alert"),
      div(id = "success-message", style = "display: none;",
          class = "alert alert-success mb-3", role = "alert"),

      actionButton("submit", "Enviar Respuestas",
                   class = "btn-primary btn-lg w-100")
    )
  )
)

# Server
server <- function(input, output, session) {
  # Función para validar entradas
  validate_inputs <- function() {
    if (input$general_satisfaction == "") return("Por favor seleccione su nivel de satisfacción general")
    if (input$instructor_rating == "") return("Por favor evalúe el desempeño de los instructores")
    if (trimws(input$strengths) == "") return("Por favor indique las fortalezas del curso")
    if (trimws(input$improvements) == "") return("Por favor indique aspectos a mejorar")
    return(NULL)
  }

  observeEvent(input$submit, {
    # Validar entradas
    validation_message <- validate_inputs()
    if (!is.null(validation_message)) {
      shinyjs::show("error-message")
      shinyjs::html("error-message", validation_message)
      return()
    }

    # Ocultar mensaje de error si existe
    shinyjs::hide("error-message")

    # Intentar guardar los datos
    tryCatch({
      # Crear data frame con las respuestas
      response_data <- data.frame(
        timestamp = as.character(Sys.time()),
        satisfaccion_general = input$general_satisfaction,
        fortalezas = input$strengths,
        aspectos_mejora = input$improvements,
        claridad_contenido = input$content_clarity,
        evaluacion_instructores = input$instructor_rating,
        comentarios_adicionales = input$additional_comments
      )

      # Guardar en Google Sheets
      sheet_append(sheet_id, response_data)

      # Mostrar mensaje de éxito
      shinyjs::show("success-message")
      shinyjs::html("success-message", "¡Gracias! Tus respuestas han sido registradas exitosamente.")

      # Limpiar formulario
      updateSelectInput(session, "general_satisfaction", selected = "")
      updateTextAreaInput(session, "strengths", value = "")
      updateTextAreaInput(session, "improvements", value = "")
      updateRadioButtons(session, "content_clarity", selected = character(0))
      updateSelectInput(session, "instructor_rating", selected = "")
      updateTextAreaInput(session, "additional_comments", value = "")

      # Ocultar mensaje de éxito después de 5 segundos
      shinyjs::delay(5000, shinyjs::hide("success-message"))

    }, error = function(e) {
      # Mostrar mensaje de error
      shinyjs::show("error-message")
      shinyjs::html("error-message",
                    paste("Error al guardar los datos:", e$message))
    })
  })
}

shinyApp(ui = ui, server = server)
