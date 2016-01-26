library(shiny)
require(data.table)
library(dplyr)
library(DT)
library(rCharts)
library(datasets)

data(mtcars)

## Pull out the columns we need
d <- subset(mtcars, select=c("mpg","hp","cyl","disp","am"))
d$am[d$am == 0] <- "Automatic"
d$am[d$am == 1] <- "Manual"
d <- cbind(Vehicle = rownames(d), d)

cyl <- sort(unique(d$cyl))
trans <- sort(unique(d$am))

filterResults <- function(dt, minMPG, maxMPG, minHP, maxHP, minDsp, maxDsp, Cyls, tran) {
  result <- dt %>% filter(mpg  >= minMPG, mpg  <= maxMPG,
                          hp   >= minHP,  hp   <= maxHP,
                          disp >= minDsp, disp <= maxDsp,
                          cyl %in% Cyls,  am %in% tran) 
  return(result)
}

# Shiny server
shinyServer(
  function(input, output) {

    output$tranCBox <- renderUI({
      radioButtons('tran', 'Transmission Type:', trans)
    })

    output$cylCBox <- renderUI({
      checkboxGroupInput('Cyls', 'Cylinders:', cyl, selected = cyl)
    })
    
    popTable <- reactive({
      filterResults(d, input$mpg[1], input$mpg[2], input$hp[1], input$hp[2],
                    input$disp[1], input$disp[2], input$Cyls, input$tran)
    })
    
    output$dCars <- renderDataTable({popTable()})
  }
)