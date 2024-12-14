library(shiny)
library(bslib)
library(ggplot2)

# Crear tema personalizado
my_theme <- bs_theme(
  base_font = font_google("Oswald"),
  bg = "white",
  fg = "#555555",  # title color
  primary = "#bc7777",  # header color
  "body-color" = "rgba(0, 0, 0, 0.8)",
  "card-bg" = "white",
  "navbar-bg" = "#bc7777",
  "navbar-light-brand-color" = "#999999",  # changed to gray60
  "navbar-light-color" = "#999999",        # changed to gray60
  "navbar-light-active-color" = "#999999", # added for active items
  "navbar-light-hover-color" = "#999999"   # added for hover state
)

ui <- page_navbar(
  title = "Tutorial de Shiny",
  theme = my_theme,

  # El resto del código UI permanece igual, solo cambiaré algunos estilos específicos
  nav_panel(
    title = "Instalación",
    layout_columns(
      card(
        card_header("Paso 1: Instalación de R y RStudio"),
        card_body(
          HTML("
            <ol style='color: rgba(0, 0, 0, 0.8);'>
              <li>Descarga e instala R desde <a href='https://cran.r-project.org/' target='_blank' style='color: #bc7777;'>CRAN</a></li>
              <li>Descarga e instala RStudio desde <a href='https://posit.co/download/rstudio-desktop/' target='_blank' style='color: #bc7777;'>Posit</a></li>
              <li>Abre RStudio</li>
            </ol>
          ")
        )
      ),
      card(
        card_header("Paso 2: Instalación de Shiny"),
        card_body(
          HTML("
            <p style='color: rgba(0, 0, 0, 0.8);'>En la consola de RStudio, ejecuta el siguiente comando:</p>
            <pre>install.packages('shiny')</pre>
            <p style='color: rgba(0, 0, 0, 0.8);'>Para verificar la instalación, ejecuta:</p>
            <pre>library(shiny)</pre>
          ")
        )
      )
    )
  ),

  nav_panel(
    title = "Crear una App",
    layout_columns(
      card(
        card_header("Estructura Básica"),
        card_body(
          HTML("
            <p style='color: rgba(0, 0, 0, 0.8);'>Una aplicación Shiny tiene dos componentes principales:</p>
            <ul style='color: rgba(0, 0, 0, 0.8);'>
              <li><strong>UI (Interfaz de Usuario):</strong> Define cómo se ve la aplicación</li>
              <li><strong>Server:</strong> Define cómo funciona la aplicación</li>
            </ul>
            <p style='color: rgba(0, 0, 0, 0.8);'>Ejemplo básico:</p>
            <pre>
library(shiny)

ui <- fluidPage(
    titlePanel('Mi Primera App'),
    sidebarLayout(
        sidebarPanel(
            sliderInput('numero',
                       'Elige un número:',
                       min = 1,
                       max = 50,
                       value = 25)
        ),
        mainPanel(
            textOutput('resultado')
        )
    )
)

server <- function(input, output) {
    output$resultado <- renderText({
        paste('Seleccionaste:', input$numero)
    })
}

shinyApp(ui = ui, server = server)
            </pre>
          ")
        )
      )
    )
  ),

nav_panel(
  title = "Ejemplo Interactivo",
  layout_sidebar(
    sidebar = sidebar(
      title = "Controles",
      selectInput("tipo_grafico", "Tipo de Gráfico:",
                  choices = c("Dispersión" = "scatter",
                              "Caja" = "box",
                              "Violín" = "violin")),
      selectInput("especie", "Filtrar por Especie:",
                  choices = c("Todas", unique(iris$Species))),
      sliderInput("punto_tamano", "Tamaño de Puntos:",
                  min = 1, max = 10, value = 3),
      checkboxInput("mostrar_suavizado", "Mostrar línea de tendencia", TRUE)
    ),
    card(
      card_header("Visualización Interactiva con datos de Iris"),
      card_body(
        plotOutput("plot_iris"),
        HTML("
            <br>
            <p style='color: rgba(0, 0, 0, 0.8);'><strong>Explicación:</strong></p>
            <p style='color: rgba(0, 0, 0, 0.8);'>Este ejemplo muestra cómo Shiny permite crear visualizaciones interactivas:</p>
            <ul style='color: rgba(0, 0, 0, 0.8);'>
              <li>Puedes cambiar el tipo de gráfico dinámicamente</li>
              <li>Filtrar datos por especie</li>
              <li>Ajustar el tamaño de los puntos</li>
              <li>Mostrar/ocultar la línea de tendencia</li>
            </ul>
          ")
      )
    )
  )
),

nav_panel(
  title = "Consejos",
  layout_columns(
    card(
      card_header("Consejos Importantes"),
      card_body(
        HTML("
            <ul style='color: rgba(0, 0, 0, 0.8);'>
              <li>Guarda tu app en un archivo llamado <code>app.R</code></li>
              <li>Asegúrate de cargar todos los paquetes necesarios al inicio del archivo</li>
              <li>Prueba tu app con el botón 'Run App' en RStudio</li>
              <li>Usa <code>runApp('ruta/a/tu/app')</code> para ejecutar desde la consola</li>
            </ul>
          ")
      )
    ),
    card(
      card_header("Crear una App Shiny"),
      card_body(
        HTML('
            <h4 style="color: #555555;">Pasos en RStudio</h4>
            <img src="https://shiny.posit.co/r/_w_80270736/images/new-shiny-project.png"
                 style="width: 100%; margin-bottom: 20px;"
                 alt="Crear nueva app Shiny">
            <p style="color: rgba(0, 0, 0, 0.8);">Para crear una nueva app Shiny:</p>
            <ol style="color: rgba(0, 0, 0, 0.8);">
              <li>File → New Project → New Directory → Shiny Application</li>
              <li>O File → New File → Shiny Web App</li>
            </ol>
            <img src="https://shiny.posit.co/r/_w_80270736/images/running-shiny-project.png"
                 style="width: 100%; margin-bottom: 20px;"
                 alt="Ejecutar app Shiny">
            <p style="color: rgba(0, 0, 0, 0.8);">Para ejecutar la app:</p>
            <ul style="color: rgba(0, 0, 0, 0.8);">
              <li>Clic en el botón "Run App" en la barra superior del editor</li>
              <li>O usa el comando <code>runApp()</code> en la consola</li>
            <p>
            <p style="color: rgba(139, 0, 0, 0.8);">En .gitignore, excluir los secrets (pone en peligro su cuenta)</p>
            </ul>
          ')
      )
    ),
    card(
      card_header("Recursos Adicionales"),
      card_body(
        HTML("
            <ul style='color: rgba(0, 0, 0, 0.8);'>
              <li><a href='https://shiny.posit.co/r/getstarted/' target='_blank' style='color: #bc7777;'>Tutorial oficial de Shiny</a></li>
              <li><a href='https://shiny.posit.co/r/gallery/' target='_blank' style='color: #bc7777;'>Galería de ejemplos</a></li>
              <li><a href='https://mastering-shiny.org/' target='_blank' style='color: #bc7777;'>Libro: Mastering Shiny</a></li>
              <li><a href='https://gallery.shinyapps.io/assistant/' target='_blank' style='color: #bc7777;'>Libro: Asistente Shiny</a></li>
            </ul>
          ")
      )
    )
  )
)
)

server <- function(input, output) {
  datos_filtrados <- reactive({
    if (input$especie == "Todas") {
      iris
    } else {
      iris[iris$Species == input$especie,]
    }
  })

  output$plot_iris <- renderPlot({
    p <- ggplot(datos_filtrados(), aes(x = Sepal.Length, y = Petal.Length, color = Species)) +
      theme_minimal(base_family = "Oswald") +
      labs(x = "Longitud del Sépalo", y = "Longitud del Pétalo") +
      scale_color_manual(values = c("#bc7777", "#555555", "#666666"))

    if (input$tipo_grafico == "scatter") {
      p <- p + geom_point(size = input$punto_tamano)
      if (input$mostrar_suavizado) {
        p <- p + geom_smooth(method = "lm", se = FALSE)
      }
    } else if (input$tipo_grafico == "box") {
      p <- p + geom_boxplot()
    } else if (input$tipo_grafico == "violin") {
      p <- p + geom_violin(fill = "transparent") +
        geom_jitter(size = input$punto_tamano/2, width = 0.2)
    }

    p
  })
}

shinyApp(ui = ui, server = server)
