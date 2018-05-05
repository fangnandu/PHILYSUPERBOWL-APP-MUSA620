
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(plotly)
library(scatterD3)

shinyUI(
  navbarPage("Super Bowl Night Location Popularity Mapping", id="nav",
             tabPanel("Animation Map",icon = icon("map"),
                      div(class="outer",
                          tags$head(
                            # Include our custom CSS
                            includeCSS("styles.css")
                          ),
                          htmlOutput("frame"),width="100%", height="100%",
                          absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                        draggable = TRUE, top = "15%", left = "auto", right = "1%", bottom = "auto",
                                        width = 350, height = "auto",
                                        
                                        h3("Animation Map Visualization"),
                                        fluidRow(
                                          column(5, actionButton("button1", "3 Days Animation before Superbowl"))
                                        ),
                                        fluidRow(
                                          column(5, actionButton("button2", "During The Super Bowl show time"))
                                        ),
                                        fluidRow(
                                          column(5, actionButton("button3", "After The Super Bowl show time")
                                          )
                                        ))
                      )
             ),
             tabPanel("Block Popularity",icon = icon("map"),
                      leafletOutput("blockmap",width = "100%", height = 700),
                      tags$style(type="text/css", "div.info.legend.leaflet-control br {clear: both;}"),
                      absolutePanel(id = "controls2", class = "panel panel-default", fixed = TRUE,
                                    draggable = TRUE, top = "15%", left = "auto", right = "1%", bottom = "auto",
                                    width = 350, height = "auto",
                                    h3("Block Popularity Visualization"),
                                    fluidRow(
                                      column(8, h4("feature to plot"), selectInput("Blockcharacter","Select a feature to plot",c("medianrent"="medrent1","population"="population","crime_dens"="crime_dens","income"="income1","popularity" = "Count_"),selected ="Count_"))     
                                    ),
                                    fluidRow(
                                      column(8, selectInput("vizmethod","Select a visualiztion option",c("Before the superbowl"="before","during the superbowl"="during","after the superbowl"="after"),selected ="after"))     
                                    ),
                                    
                                    fluidRow(
                                      column(12,h5("Spatial Correlation for popularity and selected feature"), scatterD3Output("commute_pl2", height = 300))
                                    )
                                    
                      )
             ),
             
             tabPanel("Club Popularity", icon = icon("map"),
                      fluidRow(
                        column(4, actionButton("button4", "Distrubution of popular club(click point)")),
                        column(4, actionButton("button5", "The distrubution of active device"))),
                      hr(),
                      fluidRow(
                        column(12, leafletOutput("map1"),
                               tags$style(type="text/css", "div.info.legend.leaflet-control br {clear: both;}")
                               
                               )),
                      hr(),
                      fluidRow(
                        column(12, selectInput("viztarget","Select a club for Emoji Sentiment Analysis",c("club ranks 1st"="1","club ranks 2nd"="2", "club ranks 3rd"="3"),selected ="1"))),
                      hr(),
                      fluidRow(
                        column(12, imageOutput("myImage"))),
                      hr()
             ),
             
             tabPanel("About",icon = icon("github-alt"),
                      div(class="about",
                          tags$head(
                            # Include our custom CSS
                            includeCSS("styles.css")
                          ),
                          fluidRow(
                            column(width = 10,
                                   includeMarkdown("about.md"))
                          )
                      )
                      
             ))
  
)
