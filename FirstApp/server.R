library(shiny)
library(caret)
library(tidyverse)
library(DT)
data("GermanCredit")
shinyServer(function(input, output) {
#Taking user input for the generation of specified bar graph
  output$barPlotClass <- renderPlot({
    g <- ggplot(GermanCredit, aes(x=Class))

    if(input$barPlotInput=="Just Classification"){
      return(g + geom_bar())
    } 
    else if(input$barPlotInput=="Classification and Unemployed"){
      return(g + geom_bar(aes(fill = as.factor(EmploymentDuration.Unemployed)), position = "dodge") +
                scale_fill_discrete(name="Unemployment status", labels = c("Employed", "Unemployed")))
    } 
    else if(input$barPlotInput=="Classification and Foreign"){
      return(g + geom_bar(aes(fill=as.factor(ForeignWorker)), position = "dod") + 
        scale_fill_discrete(name="Status", labels = c("German", "Foreign")))
    }

  }

  ) 
#Taking user input for the generation of specified data table
  output$summaryTable<- renderDataTable({
    GermanCredit %>%
      select("Class", "InstallmentRatePercentage", input$var) %>%
      group_by(Class, InstallmentRatePercentage) %>%
      summarize(mean = round(mean(get(input$var)), input$round))
  })
})


