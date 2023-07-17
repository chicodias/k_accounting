library(shiny)
library(shinydashboard)
library(tidyverse)
library(RPostgreSQL)

# Establish a connection to the database
con <- dbConnect(PostgreSQL(),
  host = "localhost",
  port = 1234,
  user = "chainweb",
  password = "",
  dbname = "chainweb"
)


source("server.R")


source("ui.R")

shinyApp(ui, server)
