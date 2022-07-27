server <- function(input, output) {
  

# Base map, doesn't refresh with user selections
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      setView(lng = -73.82,
              lat = 40.93,   
              zoom = 10.50) %>%
      addProviderTiles(providers$Stamen.Toner)%>%
      addLayersControl(
                       overlayGroups = c("eDNA","Capture"),
                       options = layersControlOptions(collapsed=FALSE))
  })
  


# Filtered eDNA data
filt_eDNA <- reactive({
    Bronfo %>%
      filter(scientific_name %in% c(input$fishes),
             eDNA != 0) %>%
      pivot_wider(
                  names_from = scientific_name,
                  values_from = eDNA)
  })  

# Filtered cap data

filt_cap <- reactive({
  Bronfo %>%
    filter(scientific_name %in% c(input$fishes),
           Capture != 0) %>%
    pivot_wider(
      names_from = scientific_name,
      values_from = Capture)
})  


# Add markers use leafletProxy observer to add points
  # https://rstudio.github.io/leaflet/shiny.html

# eDNA markers
  observe({
    if (nrow(filt_eDNA())!= 0 ) {
      leafletProxy("map", data=filt_eDNA()) %>%
        # clear any previous markers
        clearGroup(group="eDNA") %>%
        addCircleMarkers(group="eDNA",
                         lat = filt_eDNA()$Lat,
                         lng = filt_eDNA()$Lon,
                         radius=10,
                         stroke=F,
                         fill=T,
                         fillColor="deepskyblue",
                         fillOpacity = .5,
                        label=filt_eDNA()$Site, 
                        popup=paste("<strong>","eDNA Site: </strong>",filt_eDNA()$Site,"<br><strong>Resolved fishes:</strong><br>",filt_eDNA()$Fishes))
    } else {
      leafletProxy("map", data=filt_eDNA()) %>%
        # clear any previous markers
        clearGroup(group="eDNA")
    }
  })
  
# Cap markers
  observe({
    if (nrow(filt_cap())!= 0 ) {
      leafletProxy("map", data=filt_cap()) %>%
        # clear any previous markers
        clearGroup(group="Capture") %>%
        addCircleMarkers(group="Capture",
                         lat = filt_cap()$Lat,
                         lng = filt_cap()$Lon,
                         radius=10,
                         stroke=F,
                         fill=T,
                         fillColor="orange",
                         fillOpacity = .5,
                         label=filt_cap()$Site,
                         popup=paste("<strong>","Capture Site: </strong>",filt_cap()$Site,"<br><strong>Observed fishes:</strong><br>",filt_cap()$Fishes))
    } else {
      leafletProxy("map", data=filt_cap()) %>%
        # clear any previous markers
        clearGroup(group="Capture")
    }
  })
  

  
  
  
  
  
}