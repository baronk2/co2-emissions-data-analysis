# tab_panel_intro

library("shiny")


# Because the values included in the introduction were being displayed as html,
# in a Zoom call with Dave, he determined that the issue was in the order in
# which Shiny was rendering different parts of the files, so he recommended
# that I include a separate reference to the dataframe in this file (which is
# sourced into `app_ui.R`) so that the values would display properly.

# This is not the data flow that Canvas specifies we should have, which is why I
# mention that it was the solution Dave recommended. He also said that it would be
# better form to have all data wrangling in another separate file, which I agree
# with, but given the time constraints after having unsuccessfully tried to
# debug the issue of not being able to publish to shinyapps.io (See Assignment 5
# comments), I have not had time to construct that more elegant and less
# redundant file structure.

# co2_data_temps_intro <- 
#   # co2_data_relevant
#   read.csv(
#     "./data/co2_data_original.csv"
#   ) %>% 
#   filter(
#     iso_code != "",
#     !is.na(
#       iso_code
#     )
#   ) %>% 
#   select(
#     X,
#     country,
#     year,
#     co2
#   ) %>% 
#   mutate(
#     kelvin = 1.11 * co2 / sum(co2, na.rm = TRUE),
#     celsius = kelvin,
#     fahrenheit = kelvin * 9 / 5
#   )
# 
# 
# # Use the dataframe to get values to display in the introduction
# 
# earliest_year <-min(
#   co2_data_temps_intro$year,
#       na.rm = TRUE
#     )
# 
# 
# most_recent_year <- 
#     max(
#       co2_data_temps_intro$year,
#       na.rm = TRUE
#     )
# 
# 
# most_all_time_temperature_change_country <- 
#   co2_data_temps_intro %>% 
#       group_by(
#         country
#       ) %>% 
#       summarize(
#         kelvin = sum(
#           kelvin,
#           na.rm = TRUE
#         )
#       ) %>%
#       filter(
#         kelvin == max(
#           kelvin, na.rm = TRUE
#         )
#       ) %>% 
#       pull(
#         country
#       )
# 
# most_all_time_temperature_change_country_with_the_if_needed <- 
#   ifelse(
#     most_all_time_temperature_change_country == "United States" |
#       most_all_time_temperature_change_country == "United Kingdom" |
#       most_all_time_temperature_change_country == "United Arab Emirates" |
#       most_all_time_temperature_change_country == "Netherlands" |
#       most_all_time_temperature_change_country == "Bahamas" |
#       most_all_time_temperature_change_country == "Gambia" |
#       most_all_time_temperature_change_country == "Maldives" |
#       most_all_time_temperature_change_country == "Philippines" |
#       most_all_time_temperature_change_country == "Republic of Congo" |
#       most_all_time_temperature_change_country == "Democratic Republic of Congo" |
#       most_all_time_temperature_change_country == "British Virgin Islands" |
#       most_all_time_temperature_change_country == "United States Virgin Islands",
#     paste0(
#       "the ",
#       most_all_time_temperature_change_country
#     ),
#     most_all_time_temperature_change_country
#   )
#   
# 
# 
# most_all_time_temperature_change <-
#   co2_data_temps_intro %>% 
#   group_by(
#     country
#   ) %>% 
#   summarize(
#     kelvin = sum(
#       kelvin,
#       na.rm = TRUE
#     )
#   ) %>%
#   filter(
#     kelvin == max(
#       kelvin, na.rm = TRUE
#     )
#   ) %>% 
#   pull(
#     kelvin
#   ) %>% 
#   signif(
#     digits = 4
#   ) %>% 
#   format(
#     scientific = FALSE
#   )

earliest_year <- 
  1750
  
  
most_recent_year <- 
  2021
  

most_all_time_temperature_change_country_with_the_if_needed <- 
  "the United States"
  

most_all_time_temperature_change <- 
  0.2765
  



# Specify the tab panel elements

tab_panel_intro <-
  
  tabPanel(
    
    "Introduction",
    
    titlePanel(
      "Introduction"
    ),
    
    p(
      paste0(
        "This application views global carbon dioxide emissions from each country as recorded by "
      ),
      a(
        "Our World In Data",
        href = "https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions"
      ),
      paste0(
        " through the lens of the global temperature change (rise) they have caused. This uses the global temperature in 1850 as a baseline and assumes that all of the 1.11 K temperature change from then to the present is due to carbon dioxide emissions, as "
      ),
      a(
        "Our World In Data",
        href = "https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions"
      ),
      paste0(
        " describes can be assumed. This represents a global generalization of the temperature change, not a localized view, so some countries may show as contributing less to global temperature change even though they are located geographically where temperature changes may be more pronounced. The earliest year emissions data is represented in the dataset was ",
        earliest_year,
        ", and it runs through ",
        most_recent_year,
        ". Over that entire period, the country responsible for the most global temperature change is ",
        most_all_time_temperature_change_country_with_the_if_needed,
        ", which contributed ",
        most_all_time_temperature_change,
        " K of increased temperature (See Map for conversion to different temperature scales, and to see data for other countries and time periods)."
      )
    )
    
)

