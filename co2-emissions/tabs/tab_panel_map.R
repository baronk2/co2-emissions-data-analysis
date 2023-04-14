# tab_panel_map

library("shiny")
library("ggiraph")


# Specify the tab panel elements, including input widgets

tab_panel_map <-tabPanel(
  
  "Map",
  
  titlePanel(
    "Map"
  ),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput(
        "years",
        label = h3(
          "Year Range"
        ),
        min = 1750, 
        max = 2021,
        value = c(
          1850,
          2000
        ),
        ticks = FALSE,
        sep = ""
      ),
      selectInput(
        "temperature_scale",
        label = h3(
          "Temperature Scale"
        ),
        choices = list(
          "Kelvin" = "kelvin",
          "Celsius" = "celsius",
          "Fahrenheit" = "fahrenheit"
          # "Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3
        ), 
        selected = "fahrenheit"
      )
      
    ),
    
    mainPanel(
      
      girafeOutput("co2_map"),
      
      p(
        paste0(
          "This map shows how responsible each country is for global ",
          "temperature change for a given set of years. For most of history, ",
          "dating back to 1750, it can be seen that the United States is the ",
          "leading cause of temperature change, but for more recent time windows, ",
          "other countries emerge as more significant causes of temperature change."
        )
      ),
      
      p(
        "Source: ",
        a(
          "Our World In Data (https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions)",
          href = "https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions"
        )
        
      )
      
    )
    
  )
  
)

