
shinyServer(
  function(input, output){

    library(caret)
    library(e1071)
    library(klaR)
    library(randomForest)
    library(kernlab)
    df00<-data.frame(iris)
    inTrain<-createDataPartition(df00$Species,p=3/4)[[1]]

    output$IrisData <- renderPrint({
      combo<-combo_output()
      if(combo[[4]]==1) return("Iris Data - Misclassified Observations")
      else return("Iris Data - Full Data Set (No Misclassifications)")
    })
    output$plot2 <- renderPlotly({
      
      plot_ly(iris, x = ~Sepal.Length, y = ~Sepal.Width, color = ~Petal.Length,
              size = ~Petal.Width, text = ~paste("Species: ", Species))      
      
      
    })  
    output$plot <- renderPlotly({
      combo<-combo_output()
      if(combo[[4]]==1){
        data<-combo[[3]]
      }
      else{
       data = iris;
      }
      plot_ly(data, x = ~Sepal.Length, y = ~Sepal.Width, color = ~Petal.Length, 
              size = ~Petal.Width, text = ~paste("Species: ", Species))
    })
#    inTrain <- function()({
#            df00<-data.frame(iris)
#            createDataPartition(df00$Species,p=3/4)[[1]]
#   })
    combo_output <- reactive({
        algorithm <- switch(input$algorithm,
                        #r = "r",
                        rf = "rf",
                        rda = "rda",
                        nb = "nb",
                        lda = "lda",
                        svmPoly = "svmPoly"
                        )
        if(algorithm!="r"){
          df00<-data.frame(iris)
          training<-df00[inTrain,]
          testing<-df00[-inTrain,]
          set.seed(33833)
          modelFit<-train(Species~.,data=training,method=algorithm)#algorithm
          predictions1<-predict(modelFit,newdata=testing)
          df01<-confusionMatrix(predictions1,testing$Species)
          df02<-df00[predictions1!=testing$Species,]
          if(nrow(df02)>0) a<-list(df01[[3]][1],predictions1,df02,1)
          else a<-list(df01[[3]][1],predictions1,0,0)
          a
        }
        else{
          a<-list(0.5,0,0,0)
          a
        }
    })
    output$accuracy <- renderPrint({
      combo<-combo_output()
      combo[[1]]
    })
  }
)
