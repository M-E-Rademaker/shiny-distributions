##############################################################################
#                                                                            #
#                               Shiny Server                                 #
#                                                                            #
##############################################################################

### Load required packages

library(shiny)
library(shinythemes)
library(ggplot2)
library(gridExtra)

### Source static.r

if (!exists("allowed.Ranges", mode = "function"))
  source("static.R")

smoothing.points <- 1001
### Begin server ---------------------------------------------------------------

shinyServer(function(input, output, session) {
  observeEvent(input$dist, {
    # This function checks, whether the selected distribution is changed by the
    # users input and disables the drawing of hypothesis areas if so.
    updateCheckboxInput(session, 'add.checkbox', value = F)
  })
  
  output$dist.options <- renderUI({
    render <- Renderer()
    # print(render$option)
    return(render$option)
  }) # END renderUI
  
  Renderer <- eventReactive(input$dist,{
    # This functions defines which paramaters the user can choose from after
    # selecting a distribution and what values these paramters can take.
    allowed.Ranges <- allowed.Ranges(input)
    switch(
      input$dist,
      'Normalverteilung' = {
        option <- list(
          helpText(
            "2. Wähle die Parameter der Verteilung und klicke anschließend 
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'mu', label = 'μ', value = 0
          ),
          numericInput(
            inputId = 'sigma', label = 'σ', value = 1, min = 0
          )
        )
      },
      't-Verteilung' = {
        option <- list(
          helpText(
            "2. Wähle den Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'df',label = 'Freiheitsgrade', value = 1, min = 0
          )
          )
      },
      'Chi-Quadrat-Verteilung' = {
        option <- list(
          helpText(
            "2. Wähle den Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'df',label = 'Freiheitsgrade', value = 1, min = 0
          )
          )
      },
      'F-Verteilung' = {
        option <- list(
          helpText(
            "2. Wähle die Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'df1',label = 'Zählerfreiheitsgrade',
            value = 10, min = 0
          ),
          numericInput(
            inputId = 'df2',label = 'Nennerfreiheitsgrade',
            value = 5, min = 0
          )
          )
      },
      'Exponentialverteilung' = {
        option <- list(
          helpText(
            "2. Wähle den Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'rate', label = 'λ', value = 1, min = 0, step = 0.5
          )
          )
      },
      'Stetige Gleichverteilung' = {
        option <- list(
          helpText(
            "2. Wähle die Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          sliderInput(
            "dist.range", "Unter- und Obergrenze",
            min = allowed.Ranges[1] + 1,
            max = allowed.Ranges[2] - 1,
            value = c(allowed.Ranges[3] + 1, allowed.Ranges[4] - 1)
          )
          )
      },
      'Binomialverteilung' = {
        option <- list(
          helpText(
            "2. Wähle die Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'size', label = 'n', value = 10
          ),
          numericInput(
            inputId = 'prob', label = 'p', value = 0.5,
            min = 0, max = 1, step = 0.1
          )
          )
      },
      'Poisson-Verteilung' = {
        option <- list(
          helpText(
            "2. Wähle den Parameter der Verteilung und klicke anschließend
            auf den", strong("Verteilung zeichnen"), "Button."
          ),
          numericInput(
            inputId = 'lambda',label = 'λ', value = 1, min = 0, step = 0.5
          )
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
      # }
    ) # END switch
    
    # #   ninfo <- eventReactive(input$draw.Plot, {
    # 
    # switch(
    #   input$dist,
    #   'Normalverteilung' = md <-
    #     includeMarkdown("docs/NormalDistribution.md"),
    #   't-Verteilung' = md <-
    #     includeMarkdown("docs/tDistribution.md"),
    #   'Chi-Quadrat-Verteilung' = md <-
    #     includeMarkdown("docs/ChiSquaredDistribution.md"),
    #   'F-Verteilung' = md <-
    #     includeMarkdown("docs/FDistribution.md"),
    #   'Exponentialverteilung' = md <-
    #     includeMarkdown("docs/ExponentialDistribution.md"),
    #   'Stetige Gleichverteilung' = md <-
    #     includeMarkdown("docs/UniformDistribution.md"),
    #   'Binomialverteilung' = md <-
    #     includeMarkdown("docs/BinomialDistribution.md"),
    #   'Poisson-Verteilung' = md <-
    #     includeMarkdown("docs/PoissonDistribution.md")
    #   # 'Log-normal distribution' =
    #   # 'Beta distribution' =
    # ) # END switch
    # return(list(option = option, md = md))
    return(list(option = option))
  }) # END eventReactive
  
  ### Advanced Options
  
  output$option.range <- renderUI({
    #
    allowed.Ranges <- allowed.Ranges(input)
    sI <- sliderInput(
      "draw.range", NULL,
      min = allowed.Ranges[1],
      max = allowed.Ranges[2],
      value = c(allowed.Ranges[3], allowed.Ranges[4])
    )
    return(sI)
  })
  
  # output$option.geom <- renderUI({
  #   if (!(input$dist %in% c('Binomialverteilung', "Poisson-Verteilung")))
  #   selectInput('geom','Stuff', c('line','point','bar'))
  # })
  
  # output$option.smoothing.points <- renderUI({
  #   if (!(input$dist %in% c('Binomialverteilung', "Poisson-Verteilung")))
  #     numericInput('n','Smoothing points', smoothing.points)
  # })
  
  output$crit.value <- renderText({
    if (!is.na(input$hypothesis.los.value)) {
      return(
        paste(
          "Der kritische Wert für ein Signifikanznvieau von",
          expression("alpha"), "=", input$hypothesis.los.value, "ist:",
          crit.value.calculator(input)
        )
      )
    } else {
      return("Kein Signifikanzniveau angegeben")
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
        stat_function(fun = pnorm) +
        ggtitle("Verteilungsfunktion der Normalverteilung") +
        labs(y = "F(x) = P(X < x)")
      
      op <- grid.arrange(op1, op2)
    }
    return(op)
  })
  
  ### Define what happens if the user clicks on "Verteilung zeichnen"
  
  nplot <- eventReactive(input$draw.Plot, {
    if (is.null(input$draw.range)) {
      outputrange <- allowed.Ranges(input)[3:4]
    } else {
      outputrange <- input$draw.range
    }
    
    geom <- "line"
    n <- smoothing.points
    
    outplot_continuous <-
      ggplot(data.frame("x" = seq(
        outputrange[1], outputrange[2],
        abs(outputrange[1] - outputrange[2]) /
          n
      )),
      aes(x))
    outplot <-
      ggplot(data.frame("x" = seq(
        outputrange[1], outputrange[2],
        abs(outputrange[1] - outputrange[2]) /
          n
      )),
      aes(x))
    outplot_discrete <-
      ggplot(data.frame("x" = outputrange[1]:outputrange[2]), aes(x))
    
    switch(
      input$dist,
      'Normalverteilung' = {
        # Density Function
        outplot1 <- outplot_continuous +
          stat_function(
            fun = dnorm, args = list(mean = input$mu, sd = input$sigma),
            geom = geom, n = n
          ) +
          ggtitle("Dichtefunktion der Normalverteilung") +
          labs(y = paste("Dichte: ", expression(f(x))))
        
        # Distribution Function
        outplot2 <- outplot_continuous +
          stat_function(
            fun = pnorm,
            args = list(mean = input$mu, sd = input$sigma),
            geom = geom, n = n
          ) +
          ggtitle("Verteilungsfunktion der Normalverteilung") +
          labs(y = "F(x) = P(X < x)")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      't-Verteilung' = {
        # Density Function
        outplot1 <- outplot_continuous +
          stat_function(
            fun = dt, args = list(df = input$df),
            geom = geom, n = n
          ) +
          labs(y = paste("Dichte: ", expression(f(x)))) +
          ggtitle("Dichtefunktion der t-Verteilung")
        
        # Distribution Function
        outplot2 <- outplot_continuous +
          stat_function(
            fun = pt, args = list(df = input$df),
            geom = geom, n = n
          ) +
          labs(y = "F(x) = P(X < x)") +
          ggtitle("Verteilungsfunktion der t-Verteilung")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'Chi-Quadrat-Verteilung' = {
        # Density Function
        outplot1 <- outplot_continuous +
          stat_function(
            fun = dchisq, args = list(df = input$df),
            geom = geom, n = n
          ) +
          labs(y = paste("Dichte: ", expression(f(x)))) +
          ggtitle("Dichtefunktion der Chi-Quadrat-Verteilung")
        
        # Distribution Function
        outplot2 <- outplot_continuous +
          stat_function(
            fun = pchisq, args = list(df = input$df),
            geom = geom, n = n
          ) +
          labs(y = "F(x) = P(X < x)") +
          ggtitle("Verteilungsfuntkion der Chi-Quadrat-Verteilung")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'F-Verteilung' = {
        # Density Function
        outplot1 <- outplot_continuous +
          stat_function(
            fun = df, args = list(df1 = input$df1, df2 = input$df2),
            geom = geom, n = n
          ) +
          labs(y = paste("Dichte: ", expression(f(x)))) +
          ggtitle("Dichtefunktion der F-Verteilung")
        
        # Distribution Function
        outplot2 <- outplot_continuous +
          stat_function(
            fun = pf, args = list(df1 = input$df1, df2 = input$df2),
            geom = geom, n = n
          ) +
          labs(y = "F(x) = P(X < x)") +
          ggtitle("Verteilungsfunktion der F-Verteilung")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'Exponentialverteilung' = {
        # Density Function
        outplot1 <- outplot_continuous +
          stat_function(
            fun = dexp, args = list(rate = input$rate),
            geom = geom, n = n
          ) +
          ggtitle("Dichtefunktion der Exponentialverteilung") +
          labs(y = paste("Dichte: ", expression(f(x))))
        
        # Distribution Function
        outplot2 <- outplot_continuous +
          stat_function(
            fun = pexp, args = list(rate = input$rate),
            geom = geom, n = n
          ) +
          labs(y = "F(x) = P(X < x)") +
          ggtitle("Verteilungsfunktion der Exponentialverteilung")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'Stetige Gleichverteilung' = {
        # Density Function
        outplot1 <- outplot_continuous +
          stat_function(
            fun = dunif, args = list(
              min = input$dist.range[1],
              max = input$dist.range[2]
            ),
            geom = geom, n = n
          ) +
          labs(y = paste("Dichte: ", expression(f(x)))) +
          ggtitle("Dichtefunktion der Gleichverteilung")
        
        # Distribution Function
        outplot2 <- outplot_continuous +
          stat_function(
            fun = punif, args = list(
              min = input$dist.range[1],
              max = input$dist.range[2]
            ),
            geom = geom, n = n
          ) +
          labs(y = "F(x) = P(X < x)") +
          ggtitle("Verteilungsfunktion der Gleichverteilung")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'Binomialverteilung' = {
        outplot1 <- outplot_discrete +
          geom_bar(aes(y = dbinom(
            x, size = input$size, prob = input$prob
          )),
          stat = "identity",
          width = 0.2) +
          scale_x_continuous(breaks = seq(outputrange[1], outputrange[2])) +
          labs(y = paste("Wahrscheinlichkeit: ", expression(p(x)))) +
          ggtitle("Wahrscheinlichkeitsfunktion der Binomialverteilung")
        
        outplot2 <- outplot_discrete  +
          geom_bar(aes(y = pbinom(
            x, size = input$size, prob = input$prob
          )),
          stat = "identity",
          width = 0.2) +
          scale_x_continuous(breaks = seq(outputrange[1], outputrange[2])) +
          labs(y = "F(x) = P(X < x)") +
          ggtitle("Verteilungsfunktion der Binomialverteilung")
        
        outplot <- grid.arrange(outplot1, outplot2)
      },
      'Poisson-Verteilung' = {
        outplot1 <- outplot_discrete +
          geom_bar(aes(y = dpois(x, lambda = input$lambda)),
                   stat = "identity",
                   width = 0.2) +
          scale_x_continuous(breaks = seq(outputrange[1], outputrange[2])) +
          labs(y = paste("Wahrscheinlichkeit: ", expression(p(x)))) +
          ggtitle("Wahrscheinlichkeitsfunktion der Poissonverteilung")
        
        outplot2 <- outplot_discrete +
          geom_bar(aes(y = ppois(x, lambda = input$lambda)),
                   stat = "identity",
                   width = 0.2) +
          scale_x_continuous(breaks = seq(outputrange[1], outputrange[2])) +
          labs(y = paste("Wahrscheinlichkeit: ", expression(p(x)))) +
          ggtitle("Verteilungsfunktion der Poissonverteilung")
        
        outplot <- grid.arrange(outplot1,outplot2)
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
  
  ninfo <- eventReactive(input$draw.Plot, {
  # ninfo <- eventReactive(input$dist, {
    switch(input$dist,
           'Normalverteilung' = includeMarkdown("docs/NormalDistribution.md"),
           't-Verteilung' = includeMarkdown("docs/tDistribution.md"),
           'Chi-Quadrat-Verteilung' = includeMarkdown("docs/ChiSquaredDistribution.md"),
           'F-Verteilung' = includeMarkdown("docs/FDistribution.md"),
           'Exponentialverteilung' = includeMarkdown("docs/ExponentialDistribution.md"),
           'Stetige Gleichverteilung' = includeMarkdown("docs/UniformDistribution.md"),
           'Binomialverteilung' = includeMarkdown("docs/BinomialDistribution.md"),
           'Poisson-Verteilung' = includeMarkdown("docs/PoissonDistribution.md")
           # 'Log-normal distribution' =
           # 'Beta distribution' =
    ) # END switch
  }) # END eventReactive

  output$dist.Info <- renderUI({
    withMathJax(ninfo())
  
  # output$dist.Info <- renderUI({
  #   render <- Renderer()
  #   return(withMathJax(render$md))
  }) # renderUI
}) # END shinyServer