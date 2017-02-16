
  
  UI <- fluidPage(
    library(plotly),
    library(e1071),
    titlePanel("Various Machine Learning Models Applied to the Iris Data Set"),
    sidebarLayout(
        sidebarPanel(
              radioButtons("algorithm", "Machine Learning Models:",
                           c("Linear Discriminant Analysis" = "lda",
                             "Random forest" = "rf",
                             "Robust Discriminant Analysis" = "rda",
                             "Naive Bayes" = "nb",
                             "Support Vector Machine" = "svmPoly"
                             )),
              h4("Result:"),
              verbatimTextOutput("accuracy"),
              br(),
              h4("Instructions"),
              h5("Select one of the machine learning models above. The model will 
                 be applied to the Iris data set. Note that when you open the page
                 or select a new machine learning model, it may take some time, up
                 to a minute for the calculation and for the result and plots to show. 
                 The fastest algorithm is the linear discriminant analysis.
                 The upper plot, shows the complete Iris set, the lower 
                 plots shows the observations that are misclassified by the algorithm. 
                 In the case there are no misclassifications, the full data set is 
                 displayed. The Plotly plots features various tools, e.g., zooming 
                 and pan, just hoover with the mouse over the upper part of each 
                 plot to see the tool icons. Every time a selected machine learning 
                 model is applied, it is trained on a random part of the full data 
                 set, and evaluated on the remainding set after training. For that 
                 reason the results will vary from time to time."),
              h4("Edgar Anderson's Iris Data"),
              h5("The famous (Fisher's or Anderson's) iris data set gives the 
                 measurements in centimeters of the variables sepal length and width 
                 and petal length and width, respectively, for 50 flowers from each 
                 of 3 species of iris. The species are Iris setosa, versicolor, and 
                 virginica.The plots shows simultaneously all the
                 five variables: Sepal Length (x-axis), Sepal Width (y-axis), Petal Length 
                 (color gradient), Petal Width (size) and Species (text).")
        ),
        mainPanel(
          h4("Iris Data"),
          plotlyOutput("plot2"),
          br(),
          verbatimTextOutput("IrisData"),
          plotlyOutput("plot")
        )
    )
  )

#http://shiny.rstudio.com/tutorial/lesson2/