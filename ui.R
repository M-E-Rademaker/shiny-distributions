################################################################################
#
#                               Shiny user interface (ui)
#
################################################################################
### Begin ui -------------------------------------------------------------------

shinyUI(
  fluidPage(
    theme = "stylesheet.css",
    
    ### Header -----------------------------------------------------------------

    fluidRow(# div(id="titlebar","Verteilungsfunktionen und Hypothesentests"),
      div(id = "spacer",
        div(id = "titlebar",br(),"Verteilungsfunktionen",br()," "),
        br(),
        includeHTML("www/lehrstuhl.html"),
        tags$head(
          tags$link(href = "shared/font-awesome/css/font-awesome.min.css",
                    rel = "stylesheet")
        )
      )),

    sidebarLayout(
      ### Sidebar panel ----------------------------------------------------------

      sidebarPanel(
        width = 3,
        tabsetPanel(
          tabPanel(
            "Verteilungen",
            fluidRow(
              helpText("1. Wähle eine Verteilung"),
              selectInput('dist', NULL, 
                          c('Normalverteilung', 
                            't-Verteilung',
                            'Chi-Quadrat-Verteilung', 
                            'F-Verteilung', 
                            'Exponentialverteilung',
                            'Stetige Gleichverteilung',
                            'Binomialverteilung',
                            'Poisson-Verteilung'
                            )
                          )
              ), # END fluidRow 

            ### Conditonal Panels ----------------------------------------------------------
            conditionalPanel("input.dist == 'Normalverteilung'",
                             helpText("2. Wähle die Parameter der Verteilung."),
                             numericInput(inputId = 'mu', label = 'μ', value = 0), 
                             numericInput(inputId = 'sigma', label = 'σ', value = 1, min = 0, step = 0.5),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.norm", label = NULL, min = -50, max = 50, value = c(-5, 5))),
            conditionalPanel("input.dist == 't-Verteilung'",
                             helpText("2. Wähle den Parameter der Verteilung."),
                             numericInput(inputId = 'df.t',label = 'Freiheitsgrade', value = 5, min = 0),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.t", label = NULL, min = -50, max = 50, value = c(-5, 5))),
            conditionalPanel("input.dist == 'Chi-Quadrat-Verteilung'",
                             helpText("2. Wähle den Parameter der Verteilung."),
                             numericInput(inputId = 'df.chi',label = 'Freiheitsgrade', value = 3, min = 0),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.chi", label = NULL, min = -1, max = 100, value = c(0, 10))),
            conditionalPanel("input.dist == 'F-Verteilung'",
                             helpText("2. Wähle die Parameter der Verteilung."),
                             numericInput(inputId = 'df1',label = 'Zählerfreiheitsgrade', value = 10, min = 0),
                             numericInput(inputId = 'df2',label = 'Nennerfreiheitsgrade', value = 5, min = 0),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.f", label = NULL, min = -0, max = 50, value = c(0, 5))),
            conditionalPanel("input.dist == 'Exponentialverteilung'",
                             helpText("2. Wähle den Parameter der Verteilung."),
                             numericInput(inputId = 'rate',label = 'Alpha', value = 1, min = 0, step = 0.5),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.exp", label = NULL, min = -1, max = 100, value = c(0, 5))),
            conditionalPanel("input.dist == 'Stetige Gleichverteilung'",
                             helpText("2. Wähle die Parameter der Verteilung."),
                             sliderInput("axis.updown", label = "Ober- und Untergrenze", 
                                         min = -50, max = 50, value = c(-5, 5)),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.cu", label = NULL, min = -50, max = 50, value = c(-10, 10))),
            conditionalPanel("input.dist == 'Binomialverteilung'",
                             helpText("2. Wähle die Parameter der Verteilung."),
                             numericInput(inputId = 'size',label = 'n', 
                                          value = 5, min = 0, step = 1),
                             numericInput(inputId = 'prop',label = 'p', 
                                          value = 0.5, min = 0, max = 1, step = 0.1),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.bin", label = NULL, min = 0, max = 100, value = c(0, 10))),
            conditionalPanel("input.dist == 'Poisson-Verteilung'",
                             helpText("2. Wähle den Parameter der Verteilung."),
                             numericInput(inputId = 'lambda',label = 'Lambda', value = 1, min = 0, step = 0.1),
                             helpText("3. Wähle den gewünschten x-Achsenbereich"),
                             sliderInput("axis.pois", label = NULL, min = 0, max = 100, value = c(0, 10)))
          ), # tabPanel
          tabPanel("Hypothesentests",
                   helpText("1. Wähle die Art des Testes"),
                   selectInput('test.type', NULL, c('Rechtsseitig', 'Linksseitig', 'Zweiseitig')),
                   helpText("2. Wähle das gewünschte Signifikanzniveau"),
                   numericInput("sig.niveau", NULL, value = 0.05, max = 1, step = 0.1),
                   helpText("3. Ablehnungsbereich einzeichnen ?"),
                   checkboxInput('crit.value.checkbox', label = "Ja", value = F)
          ) # END tabPanel 
        ) # END tabsetPanel
        ), # END sidebarLayout

### MainPanel ------------------------------------------------------------------
      
      mainPanel(
        
        plotOutput('plot'),
        br(),
        uiOutput("crit.value.text"),
        br(),
        uiOutput('dist.info')
        
        ) # END mainPanel
    ) # END sidebar layout
  ) # END fluid page
) # END shiny ui