library(shiny)
library(ggplot2)
library(gridExtra)

if (!exists("allowed.Ranges", mode = "function"))
  source("static.R")

##############################################################################
#                                                                            #
#                             Default Values                                 #
#                                                                            #
##############################################################################

smoothing.points <- 1001;

##############################################################################
#                                                                            #
#                               Shiny Server                                 #
#                                                                            #
##############################################################################

shinyServer(function(input, output) {
  output$dist.options <- renderUI({
    # This functions selects the distribution paramters corresponding to each
    # distribution for the user to choose from.
    
    switch(input$dist,
      'Normal distribution' = {
        list(
          helpText("2. Wähle die Parameter der Verteilung und klicke", br(),
                   "anschließend auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(inputId = 'mu', label = 'μ', value = 0),
          numericInput(inputId = 'sigma', label = 'σ', value = 1, min = 0)
          )
      },
      't-distribution' = {
        list(
          helpText("Wähle den Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(
            inputId = 'df',label = 'Freiheitsgrade', value = 1, min = 0)
        )
      },
      'Chi-Square' = {
        list(
          helpText("Wähle den Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(inputId = 'df',label = 'Freiheitsgrade', value = 1, min = 0)
        )
      },
      'F-distribution' = {
        list(
          helpText("Wähle die Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(inputId = 'df1',label = 'Zählerfreiheitsgrade', 
                       value = 10, min = 0),
          numericInput(inputId = 'df2',label = 'Nennerfreiheitsgrade', 
                       value = 5, min = 0)
        )
      },
      'Exponential distribution' = {
        list(
          helpText("Wähle den Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(inputId = 'rate', label = 'λ', value = 1, min = 0, step = 0.5)
          )
      },
      'Uniform distribution' = {
        list(
          helpText("Wähle die Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          sliderInput("dist.range", "Unter- und Obergrenze", 
                      min = allowed.Ranges[1] + 1,
                      max = allowed.Ranges[2] - 1,
                      value = c(allowed.Ranges[3] + 1, allowed.Ranges[4] - 1)
          )
        )
      },
      'Binomial distribution' = {
        list(
          helpText("Wähle die Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(inputId = 'size', label = 'n', value = 10),
          numericInput(inputId = 'prob', label = 'p', value = 0.5, 
                       min = 0, max = 1, step = 0.1)
          )
      },
      'Poisson distribution' = {
        list(
          helpText("Wähle den Parameter der Verteilung und klicke anschließend
                   auf den", strong("Verteilung zeichnen"), "Button."),
          numericInput(inputId = 'lambda',label = 'λ', value = 1, min = 0, step = 0.5)
          )
      }
      # 'Log-normal distribution' = {
      #   list(
      #     helpText("2. Wähle die Parameter der Verteilung und klicke anschließend
      #              auf den", strong("Verteilung zeichnen"), "Button."),
      #     numericInput(inputId = 'mu', label = 'μ', value = 0),
      #     numericInput(inputId = 'sigma', label = 'σ', value = 1, min = 0)
      #     )
      # },
      # 'Beta distribution' = {
      #   list(
      #     helpText("Enter the parameters below:"),
      #     numericInput(
      #       inputId = 'shape1',label = 'p', value = 1
      #     ),
      #     numericInput(
      #       inputId = 'shape2',label = 'q', value = 1
      #     )
      #   )
      # },
    ) # END switch
  }) # END renderUI
  
  ##############################################################################
  #                                                                            #
  #                           Advanced Options                                 #
  #                                                                            #
  ##############################################################################
  
  output$option.range <- renderUI({
    # 
    allowed.Ranges <- allowed.Ranges(input)
    sI <- sliderInput("draw.range", NULL, 
                      min = allowed.Ranges[1],
                      max = allowed.Ranges[2], 
                      value = c(allowed.Ranges[3], allowed.Ranges[4])
                      )
        return(sI)
    })
  
  output$option.geom <- renderUI({
    if (!(input$dist %in% c('Binomial distribution', "Poisson distribution")))
    selectInput('geom','Stuff', c('line','point','bar'))
  })
  
  output$option.smoothing.points <- renderUI({
    if (!(input$dist %in% c('Binomial distribution', "Poisson distribution")))
      numericInput('n','Smoothing points', smoothing.points)
  })
  
  output$crit.value <- renderText({
    if(!is.na(input$hypothesis.los.value)){
      return(paste("To a level of significance of", input$hypothesis.los.value,
                   "the corresponding critical value is", crit.value.calculator(input)))
    }else{
      return("No level of significance given.")
    }
  })
  
  ##############################################################################
  #                                                                            #
  #                           Plotting Distr.                                  #
  #                                                                            #
  ##############################################################################
  
  output$dist.Plot <- renderPlot({
    # This is the part that defines what plot is shown in the mainPanel.
    # Default is the density and distribution function of the normal distribution
    # Once the user clicks on the "Verteilung zeichnen" button, nplot is returned 
    if (input$draw.Plot) {
      op <- nplot()
    } else {
      
      # Density function
      op1 <- ggplot(data.frame(x = -5:5), aes(x)) + 
        stat_function(fun = dnorm) +
        ggtitle("Dichtefunktion der Normalverteilung") + 
        labs(y = "f(x)")
      
      # Distribution function
      op2 <- ggplot(data.frame(x = -5:5), aes(x)) + 
        stat_function(fun = pnorm)+
        ggtitle("Verteilungsfunktion der Normalverteilung") + 
        labs(y = "F(x) = P(X < x)")
      
      op <- grid.arrange(op1, op2)
    }
    return(op)
  })
  
### Define the what happens if the user clicks on "Verteilung zeichnen"
  
  nplot <- eventReactive(input$draw.Plot, {
    if (is.null(input$draw.range)) {
      outputrange <- allowed.Ranges(input)[3:4]
    } else {
      outputrange <- input$draw.range
    } 
    if (is.null(input$geom)) {
      geom <- "line"
    } else {
      geom <- input$geom
    }
    if (is.null(input$n)) {
      n <- smoothing.points
    } else {
      n <- input$n
    }
    outplot <- ggplot(data.frame("x" = seq(outputrange[1], outputrange[2], 
                                           abs(outputrange[1] - outputrange[2])/n)), 
                      aes(x))
    switch(input$dist,
      'Normal distribution' = {
        # Density Function
        outplot1 <- outplot + 
          stat_function(fun = dnorm, args = list(mean = input$mu, sd = input$sigma), 
                        geom = geom, n = n) +
          ggtitle("Dichtefunktion der Normalverteilung") + 
          labs(y = paste("Dichte: ", expression(f(x))))
        # Distribution Function
        outplot2 <- outplot + 
          stat_function(fun = pnorm, 
                        args = list(mean = input$mu, sd = input$sigma), 
                        geom = geom, n = n) +
          ggtitle("Verteilungsfunktion der Normalverteilung") + 
          labs(y = "F(x) = P(X < x)")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'Exponential distribution' = {
        outplot <- outplot +
          stat_function(fun = dexp, args = list(rate = input$rate), 
                        geom = geom, n = n)
      },
      'Binomial distribution' = {
        outplot <- outplot +
          stat_function(fun = dbinom, args = list(size = input$size, prob = input$prob), 
                        geom = "bar",
                        n = abs(outputrange[2] - outputrange[1]) + 1)
      },
      'Chi-Square' = {
        outplot <- outplot + 
          stat_function(fun = dchisq, args = list(df = input$df), 
                        geom = geom, n = n)
      },
      'Poisson distribution' = {
        outplot <- outplot + 
          stat_function(fun = dpois, args = list(lambda = input$lambda), 
                        geom = "bar", 
                        n = abs(outputrange[2] - outputrange[1]) + 1)
      },
      't-distribution' = {
        outplot <- outplot + 
          stat_function(fun = dt, args = list(df = input$df), 
                        geom = geom, n = n)
      },
      'F-distribution' = {
        outplot <- outplot + 
          stat_function(fun = df, args = list(df1 = input$df1, df2 = input$df2), 
                        geom = geom, n = n)
      },
      'Uniform distribution' = {
        outplot <- outplot + 
          stat_function(fun = dunif, args = list(min = input$dist.range[1], 
                                                 max = input$dist.range[2]),
                        geom = geom, n = n)
      }
  # 'Beta distribution' = {
  #   outplot <- outplot +
  #     stat_function(fun = dbeta, args = list(shape1 = input$shape1, 
  #                                            shape2 = input$shape2, ncp = 0), 
  #                   geom = geom, n = n)
  # },
  # 'Log-normal distribution' = {
  #   outplot <- outplot +
  #     stat_function(fun = dlnorm, args = list(mean = input$mu, sd = sqrt(input$sigma)), 
  #                   geom = geom, n = n)
  # },
    )
    if (input$add.checkbox) {
      outplot <- grid.arrange(outplot1 + hypothesis.plot(input, n), 
                              outplot2)
    }
    return(outplot)
  })
  
  ##############################################################################
  #                                                                            #
  #                        Distribution Information                            #
  #                                                                            #
  ##############################################################################
  
  output$dist.Info <- renderUI({
    withMathJax(ninfo())
  })
  
  ninfo <- eventReactive(input$draw.Plot, {
    switch(input$dist,
      'Normal distribution' = includeMarkdown("docs/NormalDistribution.md"),
      't-distribution' = includeMarkdown("docs/tDistribution.md"),
      'Chi-Square' = includeMarkdown(),
      'F-distribution' = includeMarkdown(),
      'Exponential distribution' = includeMarkdown(),
      'Uniform distribution' = includeMarkdown(),
      'Binomial distribution' = includeMarkdown(),
      'Poisson distribution' = includeMarkdown()
      # 'Log-normal distribution' = 
      # 'Beta distribution' = 
    ) # END switch
  }) # END eventReactive
}) # END shinyServer