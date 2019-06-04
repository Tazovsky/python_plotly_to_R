# Render `python` `plotly` chart in `R` `Shiny` app

Making waterfall chart in pure `R` `plotly` package is breakingneck challenge compared to `python` `plotly` library. So I came up with an idea to convert `python` chart to `R` using [`reticulate`](https://blog.rstudio.com/2018/03/26/reticulate-r-interface-to-python) R package.

## Example

```r
library(reticulate)
py <- import("plotly.offline")
go <- import("plotly.graph_objs")

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
```

To see example implementation in `Shiny` app see file `profit_and_loss_statement_2018_shiny_app.R`.

## Sources

* https://plot.ly/python/getting-started/
* https://plot.ly/python/getting-started/#installation
* https://plot.ly/python/waterfall-charts/