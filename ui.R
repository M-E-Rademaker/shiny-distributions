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
      div(id="titlebar","Verteilungsfunktionen und Hypothesentests"),
      br()
      # column(width = 12,
      #        column(width = 12, 
      #               titlePanel("Verteilungsfunktionen und Hypothesentests"))),
      # column(width = 11, br())
    ),
    sidebarLayout(
      
    ### Sidebar panel ----------------------------------------------------------
      
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
              ), # END fluidRow 
            uiOutput('dist.options'),
            helpText("3. Wähle den gewünschten x-Achsenbereich"),
            uiOutput('option.range'))
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
          )), # END tabPanel "Hypothesentests"
          # tabPanel("Weitere Optionen",
          #          fluidRow(
          #            uiOutput('option.geom'),
          #            uiOutput('option.smoothing.points')
          #            )
          #          ) # END tabPanel "Weitere Optionen"
          fluidRow(actionButton("draw.Plot", strong("Verteilung zeichnen"))) # END tabsetPanel
        ), # END sidebarLayout
      
    ### MainPanel --------------------------------------------------------------
      
      mainPanel(
        plotOutput('dist.Plot'),
        br(), 
        if (!is.null('dist.Plot')) { 
          uiOutput('dist.Info')
          }) # END mainPanel
    ) # END sidebar layout
  ) # END fluid page
) # END shiny ui