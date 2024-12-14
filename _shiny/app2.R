library(shiny)

# Interfaz de Usuario
ui <- fluidPage(
  # Título de la aplicación
  titlePanel("Visualización de Distribuciones Normales"),

  # Diseño con barra lateral
  sidebarLayout(
    sidebarPanel(
      h4("Configuración"),
      sliderInput(inputId = "n",
                  label = "Tamaño de la muestra:",
                  value = 25,
                  min = 1,
                  max = 100),
      selectInput(inputId = "color",
                  label = "Color del histograma:",
                  choices = c("Azul" = "blue", "Rojo" = "red", "Verde" = "green"),
                  selected = "blue"),
      checkboxInput(inputId = "density",
                    label = "Mostrar curva de densidad",
                    value = TRUE)
    ),

    mainPanel(
      # Salida del histograma
      plotOutput(outputId = "hist"),

      # Línea horizontal y texto explicativo
      tags$hr(),
      h4("Detalles"),
      p("Este histograma muestra una muestra aleatoria de valores con distribución normal.
         Ajusta el tamaño de la muestra y personaliza el gráfico con las opciones disponibles.")
    )
  )
)

# Lógica del Servidor
server <- function(input, output) {
  output$hist <- renderPlot({
    data <- rnorm(input$n) # Generar datos aleatorios

    # Crear histograma
    hist(data,
         col = input$color,
         border = "white",
         main = "Histograma de Distribución Normal",
         xlab = "Valores",
         ylab = "Frecuencia")

    # Agregar curva de densidad si está habilitada
    if (input$density) {
      dens <- density(data)
      lines(dens, col = "black", lwd = 2)
    }
  })
}

# Lanzar la aplicación
shinyApp(ui = ui, server = server)
