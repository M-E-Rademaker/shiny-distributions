library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(
  fluidPage(
    theme = "stylesheet.css",
    withMathJax(),
    column(width = 12,
           column(width = 10, titlePanel("Verteilungsfunktionen und Hypothesentests"))),
    column(width = 11, br()),
    column(
      width = 3,
      tabsetPanel(
        tabPanel(
          "Verteilungen",
          fluidRow(
            helpText("1. Wähle eine Verteilung"),
            selectInput(
              'dist',NULL,
              c(
                'Normal distribution','Log-normal distribution',
                'Exponential distribution','Beta distribution',
                'Binomial distribution','Chi-Square','Poisson distribution',
                't-distribution','F-distribution','Uniform distribution'
              )
            )
          ),
          uiOutput('dist.options'),
          helpText("3. Wähle den gewünschten x-Achsenbereich"),
          uiOutput('option.range')
        ),
        tabPanel(
          "Hypothesentests",
          checkboxInput('add.checkbox', label = 'Ablehnungsbereich anzeigen', value = F),
          selectInput(
            'test.type','Testrichtung',
            c('Two-Sided', 'Left-Sided', 'Right-Sided')
          ),
          numericInput(
            "hypothesis.los.value", "Signifikanzniveau", NA, min = 0, max = 1, step = 0.01
          ),
          verbatimTextOutput("crit.value")
          #numericInput("hypothesis.crit.value", "Critical Value", NA, step = 0.01),
        ),
        tabPanel("Weitere Optionen",
                 fluidRow(
                   uiOutput('option.geom'),
                   uiOutput('option.smoothing.points')
                 ))
      ),
      fluidRow(actionButton("draw.Plot", strong("Verteilung zeichnen")))
    ),
    # mainPanel(width = 9,
    #           plotOutput('dist.Plot'),
    #           br(),
    #           includeMarkdown("inputTest.md")
    #           )#,
    mainPanel(width = 9,
              plotOutput('dist.Plot'),
              br(),
              if (!is.null('dist.Plot')) {
                uiOutput('dist.Info')
              })#,
    #br(),
    #htmlOutput('help.line')
    )
  )