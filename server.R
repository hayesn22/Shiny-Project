#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(HistData)
data(GaltonFamilies)
library(dplyr)
library(ggplot2)

gf <- GaltonFamilies
model1 <- lm(childHeight ~ father + mother + gender, data = gf)


shinyServer(function(input, output) {
    output$pText <- renderText({
      paste("Mother's height is",
            strong(round(input$MotherSlider,1)),
            "inches, and father's height is",
            strong(round(input$FatherSlider,1)),
            "inches, then:")
    })
    
    output$pred <- renderText({
      df <- data.frame(mother = input$MotherSlider,
                       father = input$FatherSlider,
                       gender = factor(input$ChildGender, levels = levels(gf$gender)))
      child <- predict(model1, newdata = df)
      Gen <- ifelse(
        input$ChildGender == "female",
        "Daughter",
        "Son"
      )
      paste0(em(strong(Gen)),
             "'s predicted height is approximately",
             em(strong(round(child))),
             "inches")
    })
    output$plot1 <- renderPlot({
      Gen <- ifelse(
        input$ChildGender == "female",
        "Daughter",
        "Son"
      )
      df <- data.frame(mother = input$MotherSlider,
                       father = input$FatherSlider,
                       gender = factor(input$ChildGender, levels = levels(gf$gender)))
      child <- predict(model1, newdata = df)
      yvals <- c("Mother", "Child", "Father")
      df <- data.frame(
        x = factor(yvals, levels = yvals, ordered = TRUE),
        y = c(input$MotherSlider, child, input$FatherSlider))
      ggplot(df, aes(x=x, y=y, color = c("Blue", "Green", "Red"), fill = c("Blue", "Green", "Red"))) + 
        geom_bar(stat = "identity", width = 0.5) +
        xlab("") + ylab("Height (in)") + theme_minimal() +
        theme(legend.position = "none")
    })

})
