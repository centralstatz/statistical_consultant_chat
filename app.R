# Load packages
library(shiny)
library(bslib)
library(ellmer)
library(shinychat)

# Import system prompt
system_prompt <- readLines("system_prompt.txt") 

# The user interface
ui <- page_fluid(
  chat_ui(
    id = "chat",
    placeholder = "Hi, I'm a statistical consultant, how can I help you?"
  )
)

# The app server
server <- function(input, output, session) {
  
  # Setup the chat
  chat <- chat_gemini(system_prompt = paste(system_prompt, collapse = ""))
  
  # Stream responses as they come
  observeEvent(input$chat_user_input, {
    stream <- chat$stream_async(input$chat_user_input)
    chat_append("chat", stream)
  })
  
}

shinyApp(ui, server)