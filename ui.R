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
    
    fluidRow(
      # div(id="titlebar","Verteilungsfunktionen und Hypothesentests"),
      div(id="titlebar","Verteilungsfunktionen"),
      br(),
      includeHTML("www/lehrstuhl.html")
    ),
    sidebarLayout(
      
    ### Sidebar panel ----------------------------------------------------------
      
      sidebarPanel(width = 3,
        tabsetPanel(
          tabPanel("Verteilungen",
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
            fluidRow(htmlOutput('dist.options')),
            fluidRow(helpText("3. Wähle den gewünschten x-Achsenbereich"),
            uiOutput('option.range')))
          , # END tabPanel "Verteilungen"
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
            br()
          ) # END tabPanel "Hypothesentests"
          ),
          # tabPanel("Weitere Optionen",
          #          fluidRow(
          #            uiOutput('option.geom'),
          #            uiOutput('option.smoothing.points')
          #            )
          #          ) # END tabPanel "Weitere Optionen"
          fluidRow(actionButton("draw.Plot", strong("Verteilung zeichnen"))
                   ) # END tabsetPanel
        ), # END sidebarLayout
      
    ### MainPanel --------------------------------------------------------------
      
      mainPanel(
        plotOutput('dist.Plot'),
        br(),
        uiOutput('dist.Info')
        ) # END mainPanel
    ) # END sidebar layout
  ) # END fluid page
) # END shiny ui