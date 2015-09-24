library(shiny)
library(datasets)
data(mtcars)
y<-mtcars$mpg-mean(mtcars$mpg)
x<-mtcars$wt-mean(mtcars$wt)
fit<-lm(mpg~wt, data=mtcars)
n<-length(y)

shinyServer(function(input, output) {
                slope <- reactive({input$slope})
                resid<-reactive({y-x*slope()})
                sigma<-reactive({sqrt(sum(resid()^2)/(n-2))})
                newdata<-reactive({data.frame(wt=input$wt)})
                predict<-reactive({predict.lm(fit,newdata=newdata())})
                
               
                output$caption <- renderText({
                        sigma()
                })

                output$summary <- renderPrint({
                        summary(fit)
                })
                
                output$line <- renderPlot({
                        plot(x, y, xlab="weight-mean(weight)", ylab="mpg-mean(mpg)", main="MPG ~ weigth", col='blue', pch=20)
                        abline(coef=c(0, slope()),col="red",lwd=2)
                        text(63, 150, paste("slope = ", slope()))})
                
                output$residuals <- renderPlot({
                        plot(x,resid(), xlab='Weight-mean(weight)', ylab="residuals", col='red',main='Residuals')
                        abline(h=0,col="blue",lwd=1)
                        })
                
                output$Prediction <- renderText({
                        predict()
                        

                })
        
})