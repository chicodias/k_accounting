server <- function(input, output) {
  # Define the query function
  transfers <- function(account) {
    query <- paste0(
      "SELECT DISTINCT ON (creationtime, amount, modulename, from_acct, to_acct, tr.requestkey, tr.chainid) ",
      "creationtime as timestamp, amount, modulename as token, from_acct as from_acc, to_acct as to_acc, ",
      "tr.requestkey as request_key, tr.chainid as chain ",
      "FROM transfers AS tr ",
      "LEFT JOIN transactions AS tx ON tr.requestkey = tx.requestkey ",
      "WHERE tr.from_acct = '", account, "' OR tr.to_acct = '", account, "'"
    )

    # Execute the query and retrieve the data
    data <- dbGetQuery(con, query)

    return(data)
  }

  # Reactive value for selected dataset ----
  datasetInput <- reactive({
    # Retrieve the account value from the input field
    account <- input$account
    # Perform the query and retrieve the data
    data <- transfers(account)
    data
  })

  # Table of selected dataset ----
  output$table <- renderTable({
    datasetInput()
  })

  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$account, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
}
