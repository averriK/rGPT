# rGPT
Basic functions and helpers for interaction with openAI and azureAI APIs.

## Installation:

Using `remotes`:
`remotes::install_github("averriK/rGPT")`


Using `pak`:
`pak::pak("averriK/rGPT")`


## Usage

`rGPT_openAI(.user,.history = NULL,.system = "You are a helpful assistant.",  .model="gpt-3.5-turbo",.endpoint = "chat/completions",.base_url = "https://api.openai.com/v1",.api_key = Sys.getenv("OPENAI_API_KEY"),    .user_agent="@averriK",.headers="application/json",.verbose=FALSE)`

## Examples:


`rGPT_openAI("My question:")`

`rGPT_openAI(readLines(".\myLongQuestionFile.txt"),.endpoint = "chat/completions",.model="gpt-3.5-turbo-16k)`

`rGPT_openAI("My question:",.endpoint = "chat/completions",.verbose=TRUE)`

`rGPT_openAI("My fine tunning data:",.endpoint="/v1/fine_tuning/jobs",.model="babbage-002)`

`rGPT_openAI("My text to moderate:",.endpoint="/v1/moderationss",.model="text-moderation-latest")`

