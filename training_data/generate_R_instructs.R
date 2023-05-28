library("openai")
library("stringr")
library(rjson)
library(purrr)

Sys.setenv(
  OPENAI_API_KEY = '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'
)
chat_save <- insistently(create_chat_completion)

training_data <- list()
for(level in c("beginner","intermediate","advanced")){
for(package in c("ggplot2","dplyr","stats","brms","shiny","lme4","stringr","lubridate",
                 "devtools","readr","knitr","mgcv","nlme","survival","glmnet","glmer","gt",
                 "psych","caret","forcast","gt","rmarkdown","quarto","kable","xts","data.table")){
  for(prompt in 1:2){ 
    if(prompt ==1){prom <- paste0("What are 8 questions a ",level," R user might ask about the ",package," package?")}
    if(prompt ==2){prom <- paste0("What are 8 questions about common errors a ",level," R user might ask about errors that arise when using the ",package," package?")}

    
    
qa <- chat_save(
  model = "gpt-3.5-turbo",
  messages = list(
    list(
      "role" = "system",
      "content" = "You are a helpful assistant."
    ),
    list(
      "role" = "user",
      "content" = prom
    )
  )
)

qa_split <- str_split(qa$choices$message.content,"\n")
qa_split
print(qa_split)


for (i in 1:8){
ak <- chat_save(
  model = "gpt-3.5-turbo",
  messages = list(
    list(
      "role" = "system",
      "content" = "You are a helpful assistant."
    ),
    list(
      "role" = "user",
      "content" = substring(qa_split[[1]][i],first = 4)
    )
  )
)
training_data <- append(training_data, paste0('### Human: ',substring(qa_split[[1]][i],first = 4),'### Assistant: ',ak$choices$message.content))
}}}}

training_data2 <- gsub(pattern = "[\r\n]",replacement = "\\\\\\n",training_data)

lapply(training_data2, write, "tidyllama_training.txt", append=TRUE, ncolumns=1000)
