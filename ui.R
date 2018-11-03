library(shiny)
library(markdown)


#This a Shiny User Interface
shinyUI(
        fluidPage(
                titlePanel("Data Science Capstone: the WordPredictor Application"),
                sidebarLayout(
                        sidebarPanel(
                                helpText("Enter a word or a phrase"),
                                hr(),
                                textInput("inputText", "Enter text here:",value = ""),
                                hr(),
                                helpText("After entering the text the next word will be shown.", 
                                         hr(),
                                         "The application will also show the entered phrase or the sentence. Additionally, the information on the n-gram backoff algorithm used in the prediction is highlighted.",
                                         hr(),
                                         "This application is built on the NLP techniques with the help of the tm r-package. "),
                                hr(),
                                hr()
                        ),
                        mainPanel(
                                h2("The next word is:"),
                                verbatimTextOutput("prediction"),
                                strong("The input phrase is:"),
                                strong(code(textOutput('sentence1'))),
                                br(),
                                strong("The n-gram matrix used in the prediction:"),
                                strong(code(textOutput('sentence2'))),
                                hr(),
                                hr(),
                                hr(),
                                img(src = "swiftkey_logo.jpg", height = 100, width = 100),
                                hr(),
                                hr(),
                                img(src = "coursera_logo.png", height = 100, width = 100),
                                hr()
                        )
                )
        )
)
