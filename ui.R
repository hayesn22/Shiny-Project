#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    titlePanel("Galton Data"),
    sidebarLayout(
        sidebarPanel(
          helpText("Predicting child's height:"),
          h4("Mother's Height (in)"),
          sliderInput("MotherSlider", "Slide", 58, 71, 58),
          h4("Father's Height (in)"),
          sliderInput("FatherSlider", "slide", 62, 80, 62),
          radioButtons(inputId = "ChildGender",
                       label = "Child's Gender:",
                       choices = c("Female" = "female", "Male" = "male"),
                       inline = TRUE)
          
        ),
        mainPanel(
         htmlOutput("pText"),
         htmlOutput("pred"),
         plotOutput("plot1", width = "50%")
        )
    )
))
