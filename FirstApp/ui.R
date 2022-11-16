library(caret)
data("GermanCredit")
library(shiny)
library(DT)
shinyUI(fluidPage(
  titlePanel("Summaries for German Credit Data"),
  sidebarLayout(
    sidebarPanel(
#tags$a(href="website", "TEXT") creates a hyperlink on your shiny app
      h3("This data set comes from the", tags$a(href="https://topepo.github.io/caret/", "caret package -"), "originally from the UCI machine learning repository"),
      br(),
      h4("You can create a few bar plots using the radio buttons below."),
#Creating inputId called "barPlotType" (accessed by input$barPlotType) for use with the renderPlot() function on the server side. This will be used to take information that the user inputs to build the specified bar graph.
            radioButtons(inputId = "barPlotInput", 
                   label = "Select the Plot Type", 
                   choices = c("Just Classification",
                               "Classification and Unemployed",
                               "Classification and Foreign")
                   ),
      br(),
#tags$b() will bold the text in parentheses
      h4("You can find the", tags$b("sample mean"), "for a few variables below:"),
#selectInput generates a select box for user input. Here we are creating an inputId called "var" that we can then use on the server side (accessed by input$var) to generate the user specified data table.
      selectInput(inputId = "var",
                  label = "Variables to Summarize",
                  choices = c("Duration",
                              "Amount",
                              "Age"),
                  selected = "Age"),
#numericInput generates a select box for user input of numeric data. Here we are creating an inputId called "round" that we can then use on the server side (accessed by input$round) to generate the user specified rounding information for the mean output on our data table.
      numericInput(inputId = "round",
                   label = "Select the number of digits for rounding",
                   value = 2,
                   min = 0,
                   max = 5,
                   step = 1)
    ),
#The code below creates placeholders for our two desired outputs, our bar graph and our data table. We can name them when creating our UI code and then access them using that name on the server side to generate our desired output. We will store our barplot on the server side as "output$barPlotClass" and our table as "output$summaryTable".
    mainPanel(
      plotOutput("barPlotClass"),
      dataTableOutput("summaryTable")
    )
  )
))

