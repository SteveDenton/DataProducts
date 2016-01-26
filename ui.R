# The user-interface definition of the Shiny web app.
library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
  navbarPage("Car Selector (mtcars dataset)", 
    tabPanel("Choose Options",
      sidebarPanel(
        p("Identify your ideal car by selecting ranges for MPH, HP and Displacement, along with number of cylinders and transmission type:"),
        sliderInput("mpg", "MPG:", min = 10, max = 34, value = c(10, 30)),
        sliderInput("hp", "HP:", min = 50, max = 350, value = c(100, 300)),
        sliderInput("disp", "Displacement (cu in):", min = 70, max = 475, value = c(100, 300)),
        uiOutput("cylCBox"), # the id
        uiOutput("tranCBox") # the id
      ),
      mainPanel(dataTableOutput(outputId="dCars"))     
    ), 
    tabPanel("About/GitHub", mainPanel(includeMarkdown("about.md"))) 
  )  
)
