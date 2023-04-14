#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("ggiraph")


source("tabs/tab_panel_intro.R")
source("tabs/tab_panel_map.R")


ui <- navbarPage(
  title = "Global Temperature Change",
  position = "fixed-top",

  # A simple header
  header = list(
    tags$style(type = "text/css", "body {padding-top: 70px;}"),
    hr(),
    HTML(""),
    hr()
  ),

  # A simple footer
  footer = list(
    tags$style(type = "text/css", "body {padding-top: 70px;}"),
    hr(),
    HTML(""),
    hr()
  ),

  # The project introduction
  tab_panel_intro,

  # The project map
  tab_panel_map
)
