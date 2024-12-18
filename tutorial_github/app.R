library(shiny)
library(bslib)
library(markdown)

ui <- page_navbar(
  title = "Tutorial: De RStudio a GitHub",
  theme = bs_theme(
    bootswatch = "default",
    base_font = "Oswald",
    heading_font = "Oswald",
    bg = "#ffffff",
    fg = "rgba(0, 0, 0, 0.8)",
    primary = "#bc7777",
    "input-border-color" = "#555555"
  ),

  header = tags$head(
    tags$link(
      href = "https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap",
      rel = "stylesheet"
    ),
    tags$style("
      * {
        font-family: 'Oswald', sans-serif !important;
      }
      pre, code {
        font-family: monospace !important;
      }
    ")
  ),

  nav_panel(
    title = "1. Preparación",
    card(
      class = "border-0",
      style = "background-color: rgba(255, 255, 255, 0.8);",
      card_header(
        style = "background-color: #bc7777; color: white;",
        "Configuración Inicial"
      ),
      card_body(
        HTML("
          <h4 style='color: #555555;'>Requisitos Previos:</h4>
          <ol style='color: rgba(0, 0, 0, 0.8);'>
            <li>Tener instalado RStudio</li>
            <li>Crear cuenta en <a href='https://github.com' target='_blank' style='color: #bc7777;'>GitHub</a></li>
            <li>Instalar <a href='https://desktop.github.com/' target='_blank' style='color: #bc7777;'>GitHub Desktop</a></li>
          </ol>
          <div class='alert' style='background-color: rgba(255, 0, 0, 0.2); border: none;'>
            <strong>Importante:</strong> Asegúrate de tener todos los programas instalados antes de continuar.
          </div>
        ")
      )
    )
  ),

  nav_panel(
    title = "2. Crear Proyecto",
    card(
      class = "border-0",
      style = "background-color: rgba(255, 255, 255, 0.8);",
      card_header(
        style = "background-color: #bc7777; color: white;",
        "Crear Proyecto en RStudio"
      ),
      card_body(
        textInput("proyecto_nombre", "Nombre de tu proyecto:",
                  value = "mi_portafolio",
                  placeholder = "Ejemplo: mi_portafolio"),
        HTML("
          <div class='alert' style='background-color: rgba(255, 0, 0, 0.2); border: none; margin-top: 10px;'>
            <strong>Tip:</strong> Usa un nombre descriptivo y sin espacios
          </div>
          <h4 style='color: #555555;'>Pasos en RStudio:</h4>
          <ol style='color: rgba(0, 0, 0, 0.8);'>
            <li>Abre RStudio</li>
            <li>File → New Project → New Directory → Website usando Quarto</li>
            <li>Nombre del proyecto: "),
        textOutput("nombre_proyecto_display", inline = TRUE),
        HTML("</li>
            <li>Selecciona una ubicación en tu computadora</li>
            <li>Marca la casilla 'Create a git repository'</li>
            <li>Click en 'Create Project'</li>
          </ol>
          <img src='https://raw.githubusercontent.com/rstudio/hex-stickers/master/PNG/RStudio.png' style='max-width: 200px; display: block; margin: 20px auto;' alt='RStudio Logo'>
        ")
      )
    )
  ),

  nav_panel(
    title = "3. Desarrollo",
    card(
      class = "border-0",
      style = "background-color: rgba(255, 255, 255, 0.8);",
      card_header(
        style = "background-color: #bc7777; color: white;",
        "Desarrollar tu Sitio"
      ),
      card_body(
        HTML("
          <h4 style='color: #555555;'>Estructura Básica:</h4>
          <pre style='background-color: rgba(255, 255, 255, 0.8); border: 1px solid #bc7777;'><code>"),
        textOutput("estructura_proyecto"),
        HTML("</code></pre>
          <h4 style='color: #555555;'>En index.qmd:</h4>
          <pre style='background-color: rgba(255, 255, 255, 0.8); border: 1px solid #bc7777;'><code>
---
title: 'Mi Portafolio Académico'
---

# Bienvenidos
Aquí puedes describir tu perfil profesional.

## Proyectos Destacados
Lista tus proyectos principales.
          </code></pre>
        ")
      )
    )
  ),

  nav_panel(
    title = "4. Publicación",
    card(
      class = "border-0",
      style = "background-color: rgba(255, 255, 255, 0.8);",
      card_header(
        style = "background-color: #bc7777; color: white;",
        "Publicar en GitHub"
      ),
      card_body(
        textInput("github_usuario", "Tu nombre de usuario de GitHub:",
                  placeholder = "Ejemplo: usuario123"),
        HTML("
          <div class='alert' style='background-color: rgba(255, 0, 0, 0.2); border: none; margin-top: 10px;'>
            <strong>Importante:</strong> El nombre del repositorio debe ser exactamente: "),
        textOutput("nombre_repo_display", inline = TRUE),
        HTML("</div>
          <h4 style='color: #555555;'>Pasos para Publicar:</h4>
          <ol style='color: rgba(0, 0, 0, 0.8);'>
            <li>Abre GitHub Desktop</li>
            <li>File → Add Local Repository → Selecciona tu proyecto de RStudio</li>
            <li>Publica el repositorio en GitHub</li>
            <li>Nombre del repositorio: "),
        textOutput("nombre_repo_display2", inline = TRUE),
        HTML("</li>
            <li>En GitHub, ve a Settings → Pages</li>
            <li>En Source, selecciona 'main' y carpeta '/docs'</li>
            <li>Guarda los cambios</li>
          </ol>
        ")
      )
    )
  ),

  nav_panel(
    title = "Tips",
    card(
      class = "border-0",
      style = "background-color: rgba(255, 255, 255, 0.8);",
      card_header(
        style = "background-color: #bc7777; color: white;",
        "Consejos Útiles"
      ),
      card_body(
        HTML("
          <h4 style='color: #555555;'>Mejores Prácticas:</h4>
          <ul style='color: rgba(0, 0, 0, 0.8);'>
            <li>Mantén una estructura clara de archivos</li>
            <li>Usa nombres descriptivos para tus commits</li>
            <li>Actualiza frecuentemente tu sitio</li>
            <li>Revisa la vista previa antes de publicar</li>
          </ul>
          <h4 style='color: #555555;'>Recursos:</h4>
          <ul>
            <li><a href='https://quarto.org/docs/websites/' target='_blank' style='color: #bc7777;'>Documentación de Quarto</a></li>
            <li><a href='https://docs.github.com/es' target='_blank' style='color: #bc7777;'>Documentación de GitHub</a></li>
          </ul>
        ")
      )
    )
  )
)

server <- function(input, output, session) {
  # Mostrar nombre del proyecto en diferentes lugares
  output$nombre_proyecto_display <- renderText({
    input$proyecto_nombre
  })

  output$estructura_proyecto <- renderText({
    paste0(input$proyecto_nombre, "/
├── _quarto.yml      # Configuración del sitio
├── index.qmd        # Página principal
├── about.qmd        # Página sobre ti
├── blog.qmd         # Blog (opcional)
├── _mylibs/         # Bibliotecas personalizadas
│   └── custom.js    # Scripts personalizados
├── _figs/          # Figuras e imágenes
│   └── README.md    # Documentación de figuras
├── man/            # Manuales y documentación
│   └── README.md    # Guía de uso
├── style/          # Estilos personalizados
│   ├── styles.css   # CSS principal
│   └── custom.scss  # Estilos SASS
├── _bib/           # Bibliografía
│   ├── refs.bib     # Referencias bibliográficas
│   └── csl/         # Estilos de citación
├── __requirements.txt  # Dependencias del proyecto
├── renv/           # Entorno virtual R
│   └── activate.R   # Script de activación
├── renv.lock       # Archivo de bloqueo de dependencias
├── Dockerfile      # Configuración de contenedor
└── .gitignore      # Archivos ignorados por git")
  })

  # Mostrar nombre del repositorio
  output$nombre_repo_display <- renderText({
    if(input$github_usuario != "") {
      paste0(input$github_usuario, ".github.io")
    } else {
      "usuario.github.io"
    }
  })

  output$nombre_repo_display2 <- renderText({
    if(input$github_usuario != "") {
      paste0(input$github_usuario, ".github.io")
    } else {
      "usuario.github.io"
    }
  })
}

shinyApp(ui, server)
