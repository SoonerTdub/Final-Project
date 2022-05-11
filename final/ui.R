ui <- dashboardPage(
  skin = "green",
  dashboardHeader(title = "Final Project",
                  titleWidth = 300),
  dashboardSidebar(
    width = 150,
    sidebarMenu(
      menuItem("Intructions", tabName = "intro"),
      menuItem("Simple Models", tabName = "simple"),
      menuItem("Exponential Smoothing Models", tabName = "expo"),
      menuItem("ARIMA Models", tabName = "arima"))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
        box(uiOutput("intro_tab"))
      ),
      tabItem(tabName = "simple",
              fluidRow(
                box(plotOutput('plot_naive')),
                box(plotOutput('plot_snaive')),
                box(plotOutput('plot_mean')),
                box(plotOutput('plot_drift'))
              )
              ),
      tabItem(tabName = "expo",
              fluidRow(
                box(plotOutput('holts')),
                box(plotOutput('hw'))
              )
      ),
      tabItem(tabName = "arima",
              fluidRow(
                box(plotOutput('manarima')),
                box(plotOutput('autoarima'))
              )
              )
      )
    )
)