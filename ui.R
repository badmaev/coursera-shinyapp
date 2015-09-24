library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("MPG (Miles per gallon) dependency on vehicle weight"),
        sidebarPanel(
                sliderInput('slope', 'specify the slope value',value = 0, min = -10, max = 10, step = 0.05),
                'To predict MPG value based on vehicle weight we are going to use this simple linear regression model:',
                verbatimTextOutput("summary"),
                numericInput('wt', 'Enter Vehicle Weight(lb/1000)', 0, min = 0, max = 6.5, step=0.1),
                h4 ('Predicted MPG (based on lm(mpg~wt) model):'),
                textOutput("Prediction")
        ),
        mainPanel(
                tabsetPanel(
                tabPanel("Plots",
                plotOutput('line'),
                h3 ('Residual Standard Error'),
                textOutput("caption"),
                plotOutput('residuals')),
                tabPanel("Documentation", textOutput("Documentation"))
                )
        )
))