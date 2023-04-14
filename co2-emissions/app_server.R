#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library("dplyr")
library("shiny")
library("ggplot2")
library("ggiraph")
library("RColorBrewer")


# Read in data from OWID (previously stored to repo file)
# Remove any geographic entities that don't have ISO codes
# Select relevant data
# Add temperature data

co2_data_temps <- 
  read.csv(
    "./data/co2_data_original.csv"
  ) %>% 
  filter(
    iso_code != "",
    !is.na(
      iso_code
    )
  ) %>% 
  select(
    X,
    country,
    year,
    co2
  ) %>% 
  mutate(
    kelvin = 1.11 * co2 / sum(co2, na.rm = TRUE),
    celsius = kelvin,
    fahrenheit = kelvin * 9 / 5
  )


# Read in landmass (country) shapes (file previously stored to repo file)
# Rename `region` column to `country` to match OWID's dataframe for joining
# Remove whitespace from records in `subregion` column since some was found,
# which would interfere with string matching
# Rename certain countries and modify associated subregions to match country
# names as they appear in OWID dataframe.
# (Many attempts were made to handle this renaming in a more elegantly coded
# way, using a dataframe which used old names as keys to match to new names, but
# `dplyr` was unable to handle these approaches. In the end, this ugly brute
# force solution was the only one that was working.)

country_shapes <-
  read.csv(
    "./data/country_shapes_original.csv"
  ) %>%
  rename(
    country = region
  ) %>%
  mutate(
    subregion = trimws(
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Antigua",
      "Antigua",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Barbuda",
      "Barbuda",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Nevis",
      "Nevis",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Saint Kitts",
      "Saint Kitts",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Bonaire",
      "Bonaire",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Sint Eustatius",
      "Sint Eustatius",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Saba",
      "Saba",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Trinidad",
      "Trinidad",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Tobago",
      "Tobago",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Grenadines",
      "Grenadines",
      subregion
    )
  ) %>% 
  mutate(
    subregion = ifelse(
      country == "Saint Vincent",
      "Saint Vincent",
      subregion
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Antigua",
      "Antigua and Barbuda",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Barbuda",
      "Antigua and Barbuda",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Ivory Coast",
      "Cote d'Ivoire",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Democratic Republic of the Congo",
      "Democratic Republic of Congo",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Republic of Congo",
      "Congo",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Czech Republic",
      "Czechia",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Faroe Islands",
      "Faeroe Islands",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Micronesia",
      "Micronesia (country)",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "UK",
      "United Kingdom",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Nevis",
      "Saint Kitts and Nevis",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Saint Kitts",
      "Saint Kitts and Nevis",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Saint Martin",
      "Saint Martin (French part)",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Bonaire",
      "Bonaire Sint Eustatius and Saba",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Sint Eustatius",
      "Bonaire Sint Eustatius and Saba",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Saba",
      "Bonaire Sint Eustatius and Saba",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Swaziland",
      "Eswatini",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Sint Maarten",
      "Sint Maarten (Dutch part)",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Timor-Leste",
      "Timor",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Trinidad",
      "Trinidad and Tobago",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Tobago",
      "Trinidad and Tobago",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "USA",
      "United States",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Grenadines",
      "Saint Vincent and the Grenadines",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Saint Vincent",
      "Saint Vincent and the Grenadines",
      country
    )
  ) %>% 
  mutate(
    country = ifelse(
      country == "Virgin Islands" & subregion == "British",
      "British Virgin Islands",
      country
    )
  ) %>%
  mutate(
    country = ifelse(
      country == "Virgin Islands" & subregion == "US",
      "United States Virgin Islands",
      country
    )
  )



# Function that returns the map as a ggplot object with other layers and specs

get_world_temperature_changes_map <-
  function(
    all_year_temps,
    country_shapes,
    start_year,
    end_year,
    temperature_scale
  ) {
    
    # Filter the data to be between `start_year` and `end_year`
    # Add up the cumulative temperature change from `start_year` to `end_year`
    # Add a `tooltip_text` column since `ggiraph` can only display data from
    # one column
    
    period_temps <- 
      all_year_temps %>% 
      filter(
        year >= start_year,
        year <= end_year
      ) %>% group_by(
        country
      ) %>%
      summarize(
        country = country,
        years = paste0(
          start_year,
          "-",
          end_year
        ),
        co2 = sum(
          co2,
          na.rm = TRUE
        ),
        kelvin = sum(
          kelvin,
          na.rm = TRUE
        ),
        celsius = sum(
          celsius,
          na.rm = TRUE
        ),
        fahrenheit = sum(
          fahrenheit,
          na.rm = TRUE
        ),
        tooltip_text = paste0(
          country,
          "\n",
          years,
          "\n",
          case_when(
            temperature_scale == "kelvin" ~ paste0(
              format(
                signif(
                  kelvin,
                  digits = 4
                ),
                scientific = FALSE
              ),
              " K"
            ),
            temperature_scale == "celsius" ~ paste0(
              format(
                signif(
                  celsius,
                  digits = 4
                ),
                scientific = FALSE
              ),
              " °C"
            ),
            temperature_scale == "fahrenheit" ~ paste0(
              format(
                signif(
                  fahrenheit,
                  digits = 4
                ),
                scientific = FALSE
              ),
              " °F"
            )
          )
          
        )
      ) %>% 
      distinct(
        country,
        years,
        co2,
        kelvin,
        celsius,
        fahrenheit,
        tooltip_text
      )
    
    # Join the OWID/temps dataframe and the `country_shapes` dataframes togethe
    # by `country`
    
    country_shapes_period_temps <- 
      country_shapes %>% 
      left_join(
        period_temps,
        by = "country"
      )
  
    
    # Function for setting the aesthetics of the plot
    
    my_theme <- function () {
      theme_bw() + 
        theme(
          plot.title = element_text(
            hjust=0.5
          ),
          plot.subtitle = element_text(
            hjust=0.5
          ),
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          legend.position = "right",
          panel.border = element_blank(),
          strip.background = element_rect(
            fill = 'white',
            color = 'white'
          )
        )
    }
    

    # Specify the plot for the world map using `ggiraph`'s `geom_polygon_interactive()`

    map <- ggplot() +
      geom_polygon_interactive(
        data = subset(
          country_shapes_period_temps,
        ),
        color = 'gray70',
        size = 0.1,
        aes(
          x = long,
          y = lat,
          fill = case_when(
            temperature_scale == "kelvin" ~ kelvin,
            temperature_scale == "celsius" ~ celsius,
            temperature_scale == "fahrenheit" ~ fahrenheit
          ),
          group = group,
          tooltip = tooltip_text
        )
      ) +

      scale_fill_gradientn(
        colors = rev(
          brewer.pal(
            5,
            "Spectral"
          )
        ),
        na.value = 'white'
      ) +

      labs(
        fill = case_when(
          temperature_scale == "kelvin" ~ "Kelvin",
          temperature_scale == "celsius" ~ "°C",
          temperature_scale == "fahrenheit" ~ "°F"
        ),
        title = "Temperature Change From Each Country",
        subtitle = country_shapes_period_temps$years,
        x = NULL,
        y = NULL
      ) +

      my_theme()

    return(
      map
    )
  }


# Function that returns a `girafe()` object, which will allow the map to be
# interactive like a `plotly` plot

get_interactive_map <-
  function(
    world_temperature_changes_map
  ) {
    interactive_map <- 
      girafe(
        ggobj = world_temperature_changes_map,
        width_svg = 7,
        height_svg = 4
      )
    
    return(
      interactive_map
    )
  }


# Function that defines the output (map) based on inputs (slider values and 
# temperature scale)

server <-
  function(
    input,
    output 
  ) {
  
  output$co2_map <-
    renderGirafe({
      get_interactive_map(
        get_world_temperature_changes_map(
          co2_data_temps,
          country_shapes,
          input$years[[1]],
          input$years[[2]],
          input$temperature_scale
        )
      )

    })
    
  
}


