library(shiny)
library(ggplot2)

golfData <- read.csv(file="golfMarketPrediction.csv", header=TRUE, sep=",")
prevYearMktSize <- golfData$sales[10]
prevYearRoundsPlayed <- golfData$numRounds[10]
prevYearParticipation <- golfData$participation[10]

shinyServer(function(input, output) {
  
  model1 <- lm(sales ~ numRounds, data = golfData)

  model1pred <- reactive({
    rpInput <- input$sliderRP
    newdata = data.frame(numRounds = rpInput)
    predict(model1, newdata)
  })
  
  output$pred1 <- renderText({
    text <- paste0("$", round(model1pred(), 0), " Billion")
  })
  
  output$mktSizePlotByRounds <- renderPlot({
    rpInput <- input$sliderRP
    type <- input$plotType
    
    p <- ggplot(golfData, aes(numRounds, sales))
    p <- p + geom_point()
    p <- p + geom_point(aes(rpInput, model1pred()), col = "red", pch = 16, cex = 4)
    p <- p + geom_point(aes(rpInput, prevYearMktSize), col = "darkgreen", pch = 16, cex = 3)
    p <- p + geom_hline(yintercept=prevYearMktSize, color="green")    
    p <- p + geom_text(aes(rpInput,prevYearMktSize,label = "PY Market Size", hjust = 0, vjust = -1), col = "darkgreen")
    p <- p + geom_text(aes(rpInput,model1pred(),label = "Pediction", hjust = 0, vjust = -1), col = "red")
    p <- p + geom_vline(xintercept=prevYearRoundsPlayed, color="green")   
    p <- p + ggtitle("by Rounds Played")
    p <- p + xlab("Number of Rounds Played (in millions)")
    p <- p + ylab("Total Market Size (in millions USD)")
    p <- p + xlim(460, 500)
    p <- p + ylim(1650, 2050)
    if(type == 'l'){
      p <- p + stat_smooth(method = 'lm')
      p <- p + geom_point(aes(rpInput, prevYearMktSize), col = "darkgreen", pch = 16, cex = 3)
      p <- p + geom_smooth(method = "lm", se = TRUE, col = "red", lwd = 1)
    }
    
    print(p)    
  })
  
  
  model2 <- lm(sales ~ participation, data = golfData)
  
  model2pred <- reactive({
    rpInput2 <- input$sliderRP2
    newdata = data.frame(participation = rpInput2)
    predict(model2, newdata)
  })
  
  output$pred2 <- renderText({
    text <- paste0("$", round(model2pred(), 0), " Billion")
  })
  
  output$mktSizePlotByParticipation <- renderPlot({
    rpInput2 <- input$sliderRP2
    type2 <- input$plotType2
    
    p <- ggplot(golfData, aes(participation, sales))
    p <- p + geom_point()
    p <- p + geom_point(aes(rpInput2, model2pred()), col = "red", pch = 16, cex = 4)
    p <- p + geom_point(aes(rpInput2, prevYearMktSize), col = "darkgreen", pch = 16, cex = 3)
    p <- p + geom_hline(yintercept=prevYearMktSize, color="green")    
    p <- p + geom_text(aes(rpInput2,prevYearMktSize,label = "PY Market Size", hjust = 0, vjust = -1), col = "darkgreen")
    p <- p + geom_text(aes(rpInput2,model2pred(),label = "Pediction", hjust = 0, vjust = -1), col = "red")
    p <- p + geom_vline(xintercept=prevYearParticipation, color="green")   
    p <- p + ggtitle("by Participation")
    p <- p + xlab("Golf Participation (in millions)")
    p <- p + ylab("Total Market Size (in millions USD)")
    p <- p + xlim(23, 30)
    p <- p + ylim(1650, 2050)
    if(type2 == 'l'){
      p <- p + stat_smooth(method = 'lm')
      p <- p + geom_point(aes(rpInput2, prevYearMktSize), col = "darkgreen", pch = 16, cex = 3)
      p <- p + geom_smooth(method = "lm", se = TRUE, col = "red", lwd = 1)
    }
    
    print(p)    
  })
  
  
})