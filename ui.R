ui <- dashboardPage(
  dashboardHeader(title = "K:accounting dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Input account", tabName = "tab1")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "tab1",
        h2("Search TRANSFER events"),
        textInput("account", "Account:", value = ""),
        actionButton("searchButton", "Search "),
        tableOutput("table"),
        # Button
        downloadButton("downloadData", "Download CSV")
      )
    )
  )
)
