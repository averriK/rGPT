
# rGPT_openAI. Simple helper adapted from r-chatbot from James H Wade (@JamesHWade ).
# See: https://github.com/JamesHWade/r-chatbot.git
# Alejandro Verri K. - averriK@github.com

library(purrr)
library(httr2)

rGPT_azureAI <- function(
    .user,
    .history = NULL,
    .system = "You are a helpful assistant.",
    .model="gpt-3.5-turbo",
    .endpoint = "chat/completions",
    .base_url = "https://api.openai.com/v1",
    .api_key = Sys.getenv("OPENAI_API_KEY"),
    .user_agent="@averriK",
    .headers="application/json",
    .json=FALSE) {

  USER <-  list(list(role = "user", content = .user))
  SYSTEM <- list(list(role = "system", content = .system))
  HISTORY <- .history
  PROMPT <- c(SYSTEM, HISTORY, USER) |> purrr::compact() # preparePrompt(.user, .system=SYSTEM, .history)
  BODY <- list(model = .model,messages = PROMPT)
  REQ <- request(.base_url) |>
    req_url_path_append(.endpoint) |>
    req_auth_bearer_token(token = .api_key) |>
    req_headers("Content-Type" = .headers) |>
    req_user_agent(.user_agent) |>
    req_body_json(BODY) |>
    req_retry(max_tries = 4) |>
    req_throttle(rate = 40) |>
    # req_dry_run()
    req_perform()

  POST <- REQ |> resp_body_json(simplifyVector = TRUE)
  CONT <- POST$choices$message$content
  ifelse(.json==TRUE,return(list(post=POST,content=CONT)),return(CONT))

}
