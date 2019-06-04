# to install python plotly follow the guide: https://plot.ly/python/getting-started/#installation
# example plot is from https://plot.ly/python/waterfall-charts/

library(shinydashboard)
library(plotly)
library(reticulate)
py <- import("plotly.offline")
go <- import("plotly.graph_objs")

renderPythonPlotly <- function(py, go, output_type = if (interactive()) "file" else "div" ) {
  
  trace = go$Waterfall(
    name = "20", 
    orientation = "v", 
    measure = c("relative", "relative", "total", "relative", "relative", "total"), 
    x = c("Sales", "Consulting", "Net revenue", "Purchases", "Other expenses", "Profit before tax"), 
    textposition = "outside", 
    text = c("+60", "+80", "", "-40", "-20", "Total"), 
    y = c(60, 80, 0, -40, -20, 0), 
    connector = list("line" = list("color" = "rgb(63, 63, 63)"))
  )
  
  layout = go$Layout(
    title = "Profit and loss statement 2018", 
    showlegend = TRUE
  )
  
  fig <- go$Figure(list(trace), layout)
  
  py$plot(fig, output_type = output_type)
}

header <- dashboardHeader(
  title = "Python plotly to R"
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
           box(width = NULL, solidHeader = TRUE,
               uiOutput("plot")
           )
    )
  )
)

ui <- dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)

server <- function(input, output, session) {
  output$plot <- renderUI({
    HTML(renderPythonPlotly(py, go, output_type = "div"))
  })
}

shinyApp(ui = ui, server = server)