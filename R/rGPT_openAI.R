rGPT_openAI <- function(
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


  # rGPT_openAI. Simple helper adapted from r-chatbot from James H Wade (@JamesHWade ).
  # See: https://github.com/JamesHWade/r-chatbot.git
  # Alejandro Verri K. - averriK@github.com

  USER <-  list(list(role = "user", content = .user))
  SYSTEM <- list(list(role = "system", content = .system))
  HISTORY <- .history
  PROMPT <- c(SYSTEM, HISTORY, USER) |> purrr::compact() # preparePrompt(.user, .system=SYSTEM, .history)
  BODY <- list(model = .model,messages = PROMPT)
  REQ <- httr2::request(.base_url) |>
    httr2::req_url_path_append(.endpoint) |>
    httr2::req_auth_bearer_token(token = .api_key) |>
    httr2::req_headers("Content-Type" = .headers) |>
    httr2::req_user_agent(.user_agent) |>
    httr2::req_body_json(BODY) |>
    httr2::req_retry(max_tries = 4) |>
    httr2::req_throttle(rate = 40) |>
    # httr2::req_dry_run()
    httr2::req_perform()

  POST <- REQ |> httr2::resp_body_json(simplifyVector = TRUE)
  CONT <- POST$choices$message$content
  ifelse(.json==TRUE,return(list(post=POST,content=CONT)),return(CONT))

}
