library(shiny)
library(shinythemes)

### Begin ui

shinyUI(
  fluidPage(
    theme = "stylesheet.css",
    fluidRow(
      column(width = 12,
             column(width = 10, 
                    titlePanel("Verteilungsfunktionen und Hypothesentests"))),
      column(width = 11, br())
    ),
    sidebarLayout(
      sidebarPanel(width = 3,
        tabsetPanel(
          tabPanel("Verteilungen",
            fluidRow(
              helpText("1. Wähle eine Verteilung"),
              selectInput('dist', NULL, 
                          c('Normal distribution', 
                            't-distribution',
                            'Chi-Square', 
                            'F-distribution', 
                            'Exponential distribution',
                            'Uniform distribution',
                            'Binomial distribution',
                            'Poisson distribution'
                            )
                          )
              ), 
            uiOutput('dist.options'),
            helpText("3. Wähle den gewünschten x-Achsenbereich"),
            uiOutput('option.range'),
            fluidRow(actionButton("draw.Plot", strong("Verteilung zeichnen")))
          ),
          tabPanel("Hypothesentests",
            checkboxInput('add.checkbox', 
                          label = 'Ablehnungsbereich anzeigen', value = F),
            selectInput('test.type','Art des Tests', 
                        c('Two-Sided', 'Left-Sided', 'Right-Sided')
            ),
            numericInput("hypothesis.los.value", "Signifikanzniveau", 
                         NA, min = 0, max = 1, step = 0.01
            ),
            verbatimTextOutput("crit.value"),
            br(),
            fluidRow(actionButton("draw.Plot", strong("Verteilung zeichnen")))
          ),
          tabPanel("Weitere Optionen",
                   fluidRow(
                     uiOutput('option.geom'),
                     uiOutput('option.smoothing.points')
                   ))
        )), 
      ### END sidebar panel
      
      mainPanel(
        plotOutput('dist.Plot'),
        br(), 
        if (!is.null('dist.Plot')) { 
          uiOutput('dist.Info')
          })
    ) # END sidebar layout
  ) # END fluid page
) # END shiny ui