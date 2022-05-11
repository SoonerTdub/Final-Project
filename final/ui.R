ui <- dashboardPage(
  skin = "red",
  dashboardHeader(title = "Final Project",
                  titleWidth = 300),
  dashboardSidebar(
    width = 150,
    sidebarMenu(
      menuItem("Intructions", tabName = "intro"),
      menuItem("base", tabName = "base"),
      menuItem("seasonality", tabName = "season"),
      menuItem("autocorrelation", tabName = "autocorrelation"),
      menuItem("decomposition", tabName = "decomp"),
      menuItem("Simple Models", tabName = "simple"),
      menuItem("Exponential Smoothing Models", tabName = "expo"),
      menuItem("ARIMA Models", tabName = "arima"))
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "intro",
              box(uiOutput("intro_tab"))
      ),
      tabItem(tabName = "base",
              fluidRow(
                box(plotOutput('base_ts'))
              )
      ),
      tabItem(tabName = "season",
              fluidRow(
                box(plotOutput('seasonal')),
                box(uiOutput('seasonal_int'))
              )
      ),
      tabItem(tabName = "autocorrelation",
              fluidRow(
                box(plotOutput('auto')),
                box(uiOutput('auto_int'))
              )
      ),
      
      tabItem(tabName = "decomp",
              fluidRow(
                box(plotOutput('decomp_ts')),
                box(uiOutput('decomp_int'))
              )
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
