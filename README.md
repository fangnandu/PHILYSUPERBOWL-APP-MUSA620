## MUSA620 FINAL PROJECT 
### - Super Bowl /Philly Eagle with Philadelphia
#### Project Created By Fangnan Du / Xiaotong Wang

app link: https://fangnan.shinyapps.io/musa620final-phily_super_bowl-app/


[You can access the application from here](https://fangnan.shinyapps.io/musa620final-phily_super_bowl-app/)

# Table of contents
1. [Assignment Steps]
2. [Data Cleaning]
3. [Building the Shiny Interactive App]
     1. [Page 1: Philadelphia People's Traveling Pattern Heat Map]
     2. [Page 2: Block Popularity Visualization]
     3. [Page 3: Club Popularity]
4. [Codes Behind the Screen ]
      1. [Codes for Data Cleaning and Reformating]
      2. [Code for server:]
      3. [Code for UI design]
      4. [Code for css]


___

This is the ReadMe file for the MUSA 620's final project. The main focus of this project is about the data of Super Bowl 2018. The Super Bowl 2018 was played in Feb 2018 at U.S. Bank Stadium in Minneapolis, between the team New England Patriots and Philadelphia Eagles, and the Philadelphia Eagles finally beat the England Patriots, becoming the winner. The residents of Philadelphia has enormous passion toward the game. As Penn students, we can personally feel the great happiness that the city of Philadelphia has when our local team wins the great game. At the same time, our team has a strong interest in people's activity pattern during the game period.
Through collecting the remote sensing data that people's phone generated from Feb 1 to Feb 5, our primary goal will be monitoring the people's movement and travel pattern through the game period inside the border of City Philadelphia.

## 1 Assignment Steps:
#### - Step 1 
Data Cleaning and Formating (R and ArcMap), geo-locate remote sensing points by three time period 
#### - Step 2
Using multiple ways to properly plot and display the cleaned dataset
#### - Step 3
Building a Leaflet map and Shiny app to allow users to visualize our analysis by visualizing data in the interactive map app
___


## 2 Data Cleaning
For the initial data, there are total of 24039869 observation records. The initial data contains the longitude and latitude geological information for each remote sensing recording points and the time each point being recorded. 
We have seperated the five date into three time periods and we have plotted people's location in each time segment
- the time section before the game (Feb 1 to Feb 4 18:00 pm); 
- the time section during the game (Feb 4 18:00 pm - 22:00 pm);
- the time section after the game (Feb 4 22:00 pm - Feb 5)

For each period, we have clipped the data to count points inside the City of Philadelphia only, and we have used the "sample" function in R to extract 20,000 sample points for each period, because the very initial large data contents will slow the working process. After the data cleaning and reformating, we have 20000 device geological records for each time segment, a total of 60,000 device records used in the analyzing process.
We then installed the points into ArcMap, using Philly's demographic data (medium rents; average region income, etc.) and the crime data to spatial join with points, so that the point layer will contain more sophisticated spatial information.
When we have projected point data and Philly neighborhood data, we then installed the data back into the R, starting the next step.

___


## 3 Building the Shiny Interactive App
We have used the cleaned data to build an interactive app to display our work results and analysis conclusion.
The finished Shiny app contains three pages: The Animation Heat Map ; The Block Popularity Visualization Map and The Super Bowl Night Popular Club Visualization.

___

#### Page 1: Philadelphia People's Traveling Pattern Heat Map

![show1](https://cdn.rawgit.com/wangxt0719/MUSA620FINALPROJECT/f2b38753/pic1.jpg)

In this page, we mapped the location of collected phone devices inside the City of Philadelphia. We use the Heat Map as a good way to display the density of devices in the spatial map. 
##### Page Highlights
- Through giving the background map a dark color, we could clearly observe, during the certain time period, each device's location in the map and people's density for certain region areas. 
- In the app interface, users could choose different time period to check people's density for each region in different dates. 
- The page contains a time bar, and the time bar will slowly change at the same speed with the density heat map. 

___

#### Page 2: Block Popularity Visualization
##### Page Highlights
In this page section, we choose to use Philadelphia's neighborhood map, sorting the device location data by using the neighborhood as our calculation units. There is a total of 318 neighborhood area in Philly. 
- 1. The user could click each neighborhood area to closely check this neighborhood's detailed information - the crime rate; neighborhood population; the income level of this neighborhood...
- 2. The neighborhood polygon map also follow the timelines - it displays the neighborhood's device density by using three time periods - before the game; during the game and after the game. So that users could check the spatial pattern of device density during different time by using the neighborhood information as a reference. The user could click the right top list to change spatial factors they want to visualize, and they can also switch from the three time periods.
- 3. In the right corner of the page is the correlation scatter plot between different variables - when users choose different display factors from the two list "Select Feature to Plot" and "Select a Visualization Option," the plot will show the correlation plot of the two elements to decide if there are spatial coefficients.

![show2](https://cdn.rawgit.com/wangxt0719/MUSA620FINALPROJECT/eceefb8b/pic2.jpg)

___

#### Page 3: Club Popularity
During the game time, people tend to visit bars in the town, gathering around the bar table, holding a beer and watching the exicted games. So we made a hypothesis that the bar will have much more visitors than usual. 
##### Page Highlights
- 1. We have collected the geographic information of the top popular bars in the City of Philadelphia, and we spatial join the bar area with devices map inside ArcMap, so that we can know during the game time, how many people gathered at which bars in town, and which one is the most popular bars for football fans.
- 2. We have dealed with the bar's visitor density by using two spatial scales - the large scale and the small scale. Reader could zoom in and zoom out in the map to choose the map scale they want to view.
- 3. In the bottom of the page is the sentiment analysis table, showing the top five most often used emojis that relates to each bar in the Twitter. User could choose the bar's name in the bottom list to view the different bar's emoji table.

The Large Scale Bar Map -The location of Most Popular 15 bars in Philadelphia (2018)

![show3](https://cdn.rawgit.com/wangxt0719/MUSA620FINALPROJECT/f2b38753/pic3.jpg)

The Small Scale Bar Map - The most popular bars in the Super Bowl night (bars with top 5 dense population)
In the center of each bar circle is the number of devices that fall into the bar area during the game time (how many people stay at the bar to watch the game)
![show4](https://cdn.rawgit.com/wangxt0719/MUSA620FINALPROJECT/f2b38753/pic4.jpg)

After deciding which bar is the most popular one in the Super Bowl night, we are very curious about people's sentiments when they staying at the most popular bar of the night, so we use the rtweet package in R to collect 1000 tweets about the top 3 popular bars of the night and do a sentiment analysis to each of bars - so that we can see when people mentioned those bars in the Twitter, what's their feeling about the bar. :+1:
![show5](https://cdn.rawgit.com/wangxt0719/MUSA620FINALPROJECT/f2b38753/pic5.jpg)

___





## Codes Behind the Screen 

#### Codes for Data Cleaning and Reformating

```
during_game<- movement [18028750:18968862,]
before_small <- before[sample(nrow(before_small), 540113), ]
write.csv(before_small, "before_small.csv")
after_game <- movement[18968863:24039869,]
random_after <- after_game[sample(nrow(after_game),940113),]
write.csv(random_after,file = "random_after.csv")
write.csv(during_game,"during_game.csv")
write.csv(random_before,"random_before.csv")

```



#### Code for server:
```

# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(ggplot2)
library(RColorBrewer)
library(scales)
library(lattice)
library(tidyr)
library(dplyr)
library(sf)
library(plotly)
library(scatterD3)
library(rgdal)


#
# #second page
# #before
# before_nei <- readOGR(".", layer = "census_before1", verbose = FALSE)
# #
# plot(before_nei)
# before_nei <- spTransform(before_nei, CRS("+init=epsg:4326"))
#
#
# # #after
# # #bar buffer
# after_nei <- readOGR(".", layer = "census_after_new", verbose = FALSE)
# #  plot(after_nei)
#after_nei <- spTransform(after_nei, CRS("+init=epsg:4326"))
# # #
#
# # #during
# during_nei <- readOGR(".", layer = "during_census1", verbose = FALSE)
# # plot(during_nei)
# during_nei <- spTransform(after_nei, CRS("+init=epsg:4326"))
#
# # #bar buffer
# point<- readOGR(".", layer = "during_points", verbose = FALSE)
# plot(point)
# point <- spTransform(point, CRS("+init=epsg:4326"))

# # #bar buffer
#   bar_buffer <- readOGR(".", layer = "barbuffer_during", verbose = FALSE)
# # plot(bar_buffer)
#  bar_buffer <- spTransform(bar_buffer, CRS("+init=epsg:4326"))




shinyServer(function(input, output) {


# the first animation function page

test <<- paste0("https://fangnandu.carto.com/builder/f2ae427e-2f88-4a59-9950-adc2f0ac9b73/embed")

output$frame <- renderUI({
my_test <- tags$iframe(src=test, height=720, width="100%")
print(my_test)
my_test})

observeEvent(input$button1, {
test <<- paste0("https://fangnandu.carto.com/builder/f2ae427e-2f88-4a59-9950-adc2f0ac9b73/embed")


output$frame <- renderUI({
my_test <- tags$iframe(src=test, height=720, width="100%")
print(my_test)
my_test
})

})

observeEvent(input$button2, {
test <<- paste0("https://fangnandu.carto.com/builder/c9266b65-82ab-4367-a946-5d0848ec3432/embed")

output$frame <- renderUI({
my_test <- tags$iframe(src=test, height=720, width="100%")
print(my_test)
my_test
})

})

observeEvent(input$button3, {
test <<- paste0("https://fangnandu.carto.com/builder/31ca90c2-3b9a-41aa-8c9d-35ece0e7bfc2/embed")

output$frame <- renderUI({
my_test <- tags$iframe(src=test, height=720, width="100%")
print(my_test)
my_test
})

})


#


observe({


if(input$vizmethod == "before") {
neiborhood <-before_nei
} else {
if(input$vizmethod == "during") {
neiborhood <-during_nei
}else{
if(input$vizmethod == "after") {
neiborhood <-after_nei
}
}
}

output$blockmap <- renderLeaflet({


num_popup <- paste0("<strong>BlockID: </strong>",
neiborhood$NAME10,
"<br><strong> Popoularity Index: </strong>",
neiborhood$Count_,
"<br><strong> Crime density Index: </strong>",
neiborhood$crime_dens,
"<br><strong> Population Index: </strong>",
neiborhood$population,
"<br><strong> Median rent Index: </strong>",
neiborhood$medrent1,
"<br><strong> Income Index: </strong>",
neiborhood$income1
)

if(input$Blockcharacter =="Count_"){


pal<-colorQuantile("YlOrRd", as.numeric(neiborhood$Count_))

leaflet(neiborhood) %>%
setView(lng=-75.010613,lat=39.981634,zoom=11) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal(as.numeric(Count_)), popup=num_popup ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal, values = ~as.numeric(Count_),
title = "Popularity",
opacity = 1)

}else {
if(input$Blockcharacter == "crime_dens") {

pal<-colorQuantile("YlOrRd", as.numeric(neiborhood$crime_dens))

leaflet(neiborhood) %>%
setView(lng=-75.010613,lat=39.981634,zoom=11) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal(as.numeric(crime_dens)), popup=num_popup ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal, values = ~as.numeric(crime_dens),
title = "Crime density",
opacity = 1)

}else {

if(input$Blockcharacter == "medrent1") {
pal<-colorQuantile("YlOrRd", as.numeric(neiborhood$medrent1))

leaflet(neiborhood) %>%
setView(lng=-75.010613,lat=39.981634,zoom=11) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal(as.numeric(medrent1)), popup=num_popup ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal, values = ~as.numeric(medrent1),
title = "median rent",
opacity = 1)

}else {
if(input$Blockcharacter == "population") {
pal<-colorQuantile("YlOrRd", as.numeric(neiborhood$population))

leaflet(neiborhood) %>%
setView(lng=-75.010613,lat=39.981634,zoom=11) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal(as.numeric(population)), popup=num_popup ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal, values = ~as.numeric(population),
title = "population",
opacity = 1)

}else {
if(input$Blockcharacter == "income1") {
pal<-colorQuantile("YlOrRd", as.numeric(neiborhood$income1))

leaflet(neiborhood) %>%
setView(lng=-75.010613,lat=39.981634,zoom=11) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal(as.numeric(income1)), popup=num_popup ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal, values = ~as.numeric(income1),
title = "Popularity",
opacity = 1)

}}

}
}
}

})


#
##
#install.packages("scatterD3")
if(input$Blockcharacter =="Count_"){

output$commute_pl2 <- renderScatterD3({
# use plotly to plot.
scatterD3(x = neiborhood$Count_, y = neiborhood$medrent1, point_size = 15,point_opacity = 0.5,xlab = "Popularity", ylab = "population")
})

}else {
if(input$Blockcharacter == "crime_dens") {

output$commute_pl2 <- renderScatterD3({
# use plotly to plot.
scatterD3(x = neiborhood$Count_, y = neiborhood$crime_dens, point_size = 15,point_opacity = 0.5,xlab = "Popularity", ylab = "crime density")

})
}else {

if(input$Blockcharacter == "medrent1") {
output$commute_pl2 <- renderScatterD3({
# use plotly to plot.
scatterD3(x = neiborhood$Count_, y = neiborhood$medrent1, point_size = 15,point_opacity = 0.5,xlab = "Popularity", ylab = "median rent")
})


}else {
if(input$Blockcharacter == "population") {
output$commute_pl2 <- renderScatterD3({
# use plotly to plot.
scatterD3(x = neiborhood$Count_, y = neiborhood$population, point_size = 15,point_opacity = 0.5,xlab = "Popularity", ylab = "population")
})
}else {
if(input$Blockcharacter == "income1") {
output$commute_pl2 <- renderScatterD3({
# use plotly to plot.
scatterD3(x = neiborhood$Count_, y = neiborhood$income1, point_size = 15,point_opacity = 0.5,xlab = "Popularity", ylab = "income")
})
}}



}
}
}




#Third page








output$map1<- renderLeaflet({

num_popup2 <- paste0("<strong>Club name: </strong>",
bar_buffer$club_name,
"<br><strong> Address: </strong>",
bar_buffer$address,
"<br><strong> Popularity Index: </strong>",
bar_buffer$Count_)

pal2<-colorQuantile("YlOrRd", as.numeric(bar_buffer$Count_))

leaflet(bar_buffer) %>%
#setView(lng=-75.1210613,lat=39.981634,zoom=12) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal2(as.numeric(Count_)), popup=num_popup2 ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal2, values = ~as.numeric(Count_),
title = "Popularity",
opacity = 1)
})



})


observeEvent(input$button4, {


output$map1<- renderLeaflet({



pal2<-colorQuantile("YlOrRd", as.numeric(bar_buffer$Count_))

leaflet(bar_buffer) %>%
#setView(lng=-75.1210613,lat=39.981634,zoom=12) %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
addPolygons(stroke=FALSE, smoothFactor = 0.3,
fillOpacity = 0.5,color = ~pal2(as.numeric(Count_)), popup=num_popup2 ,
highlight = highlightOptions(
fillColor = "yellow",
opacity = 1, weight = 2,
fillOpacity = 1,
#bringToFront = FALSE
bringToFront = TRUE, sendToBack = TRUE))%>%
addLegend("bottomleft", pal = pal2, values = ~as.numeric(Count_),
title = "Popularity",
opacity = 1)
})

})


observeEvent(input$button5, {


output$map1<- renderLeaflet({

leaflet() %>%
addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>%
#addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
addCircleMarkers(data=point,
lng = ~LONGITUDE,
lat = ~LATITUDE,
popup=num_popup2,
radius = 5,
fillOpacity = 1,
#fillColor = ~paletteBins(-persons),
#fillColor = ~paletteFactor(drunk_dr),
#fillColor = ~paletteContinuous(latitude + longitud),
color = "red",
#opacity = 1,
stroke=F,
#stroke=T,
weight = 200,
clusterOptions = markerClusterOptions()
)

})

})

observeEvent(input$viztarget,{
output$myImage <- renderImage({
# When input$n is 3, filename is ./images/image3.jpeg
filename <- normalizePath(file.path('.',
paste('image', input$viztarget, '.png', sep='')))

# Return a list containing the filename and alt text
list(src = filename,
alt = paste("Image number", input$n))

}, deleteFile = FALSE)


})




})


#    library('rsconnect')
# # # # # #
#    setAccountInfo(name='fangnan', token='F0B5B103AAD0752E2B98682871AC38B2', secret='8z7Bqirt+uxa0xYUN7OXYyoAF6mZuWfjDB2EZcss') #
# # # # # # #
#    deployApp()
```





#### Code for UI design

```

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
```




#### Code for css


```
input[type="number"] {
max-width: 80%;
}

.outer {
position: fixed;
top: 41px;
left: 0;
right: 0;
bottom: 0;
overflow: hidden;
padding: 0;
}

.about {
position: fixed;
width:75%;
top: 50px;
left: 150px;
right: 200px;
bottom: 1px;
overflow: scroll;
}

img[alt="show1"] {
max-width:  700px;
display: block;
}
img[alt="show2"] {
max-width:  700px;
display: block;
}
img[alt="show3"] {
max-width:  700px;
display: block;
}
img[alt="show4"] {
max-width:  700px;
display: block;
}
img[alt="show5"] {
max-width:  700px;
display: block;
}

/* Customize fonts */
body, label, input, button, select {
font-family: 'Helvetica Neue', Helvetica;
font-weight: 300;
}
h1, h2, h3, h4 { font-weight: 300; }

#controls {
/* Appearance */
background-color: white;
padding: 0 20px 20px 20px;
cursor: move;
/* Fade out while not hovering */
opacity: 0.85;
zoom: 0.9;
transition: opacity 500ms 1s;
}
#controls:hover {
/* Fade in while hovering */
opacity: 0.95;
transition-delay: 0;
}

/* If not using map tiles, show a white background */
.leaflet-container {
background-color: white !important;
}

```











