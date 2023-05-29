# tidyllama
repo for code &amp; data for a llama model fine-tuned to be an R tutor.

draft training script in in a notebook and runs on google colab, draft trainign data is in the training data folder.


## generating the training data

1. I asked chatGPT (via API) to generate a list of 8 questions a begginner/intermediate/advanced user could ask about one of ~24 R packages. This yields 1240 ish questions
2. I then ask chtGPT htese questions to generate an aanswer.

risks: The inconsistent formating of the results from step 1 means that in some cases the parsingof these data misfisres and abotu 5% of "questions" are parsed wron. This degrades the quality of the training data. 

## Fine-tuning the model

I use a bog standard Llama finetune usign 4-bit QLoRA to enable me to train a 7b parameter model on google colab


## next steps

1. replace Llama for an alternative with a better licence
2. replace ChatGPT with a 65b Llama based model to generate the Q&A in order to escape the use of ChatGPT and avoid conflicts with their terms of service if this ever progresses form reseach to an open acccess model. 
3. implement a quantized CPU friedly verison of the model that fits in uder 5Gb & can run on light macbooks and laptops.


all licences are inheritted from OpenAI (generating training data for reseach perposes only) and meta (Llama model licence). 
