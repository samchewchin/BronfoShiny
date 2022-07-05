server <- function(input, output) {
  
  map_df <- reactive({
    Bronfo %>%
      filter(scientific_name %in% c(input$fishes),
             Presence != 0) %>%
      pivot_wider(id_cols = -totalcount,
                  names_from = scientific_name,
                  values_from = Presence)
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>% 
      setView(lng = -73.82,
              lat = 40.93,   
              zoom = 10.50) %>%
      addProviderTiles(providers$Stamen.Toner)
  })
  
  # use leafletProxy observer to add points
  # https://rstudio.github.io/leaflet/shiny.html
  observe({
    if (nrow(map_df()) != 0) {
      leafletProxy("map", data=map_df()) %>%
        # clear any previous markers
        clearMarkers() %>%
        addMarkers(data=map_df(),
                   label=~Site)
    } else {
      leafletProxy("map", data=map_df()) %>%
        # clear any previous markers
        clearMarkers()
    }
  })
  
}