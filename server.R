
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
# # # # # # # 
#    deployApp()
   