library(shiny)
library(tm)
library(stringr)


# Reading the bi-gram, tri-gram and four-gram word matrices (source data)
bg <- readRDS("df_bigrams.RData"); tg <- readRDS("df_trigrams.RData"); qd <- readRDS("df_fourgrams.RData")

names(bg)[names(bg) == 'word1'] <- 'w1'; names(bg)[names(bg) == 'word2'] <- 'w2';
names(tg)[names(tg) == 'word1'] <- 'w1'; names(tg)[names(tg) == 'word2'] <- 'w2'; names(tg)[names(tg) == 'word3'] <- 'w3';
names(qd)[names(qd) == 'word1'] <- 'w1'; names(qd)[names(qd) == 'word2'] <- 'w2'; names(qd)[names(qd) == 'word3'] <- 'w3'
names(qd)[names(qd) == 'word4'] <- 'w4';
message <- "" 

predictWord <- function(the_word) {
        word_add <- stripWhitespace(removeNumbers(removePunctuation(tolower(the_word),preserve_intra_word_dashes = TRUE)))
        the_word <- strsplit(word_add, " ")[[1]]
        n <- length(the_word)
        if (n == 1) {the_word <- as.character(tail(the_word,1)); function_Bigram(the_word)}
        else if (n == 2) {the_word <- as.character(tail(the_word,2)); function_Trigram(the_word)}
        else if (n >= 3) {the_word <- as.character(tail(the_word,3)); function_Fourgram(the_word)}
}


function_Bigram <- function(the_word) {
        if (identical(character(0),as.character(head(bg[bg$w1 == the_word[1], 2], 1)))) {
                message<<-"The the most common word is used is nothing else is found" 
                as.character(head("it",1))
        }
        else {
                message <<- "The Bigram Frequency Matrix was used for prediction"
                as.character(head(bg[bg$w1 == the_word[1],2], 1))
        }
}

function_Trigram <- function(the_word) {
        if (identical(character(0),as.character(head(tg[tg$w1 == the_word[1]
                                                        & tg$w2 == the_word[2], 3], 1)))) {
                as.character(predictWord(the_word[2]))
        }
        else {
                message<<- "The Trigram Frequency Matrix was used for prediction"
                as.character(head(tg[tg$w1 == the_word[1]
                                     & tg$w2 == the_word[2], 3], 1))
        }
}


function_Fourgram <- function(the_word) {
        if (identical(character(0),as.character(head(qd[qd$w1 == the_word[1]
                                                        & qd$w2 == the_word[2]
                                                        & qd$w3 == the_word[3], 4], 1)))) {
                as.character(predictWord(paste(the_word[2],the_word[3],sep=" ")))
        }
        else {
                message <<- "The Fourgram Frequency Matrix was used for prediction"
                as.character(head(qd[qd$w1 == the_word[1] 
                                     & qd$w2 == the_word[2]
                                     & qd$w3 == the_word[3], 4], 1))
        }       
}


# This is a Shiny Server code for the predictWord function
shinyServer(function(input, output) {
        output$prediction <- renderPrint({
                result <- predictWord(input$inputText)
                output$sentence2 <- renderText({message})
                result
        });
        output$sentence1 <- renderText({
                input$inputText});
}
)
