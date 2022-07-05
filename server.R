server <- function(input, output) {
  
  map_df <- reactive({
    Bronfo %>%
      filter(scientific_name %in% c(input$species),
             Presence != 0) %>%
      pivot_wider(id_cols = -totalcount,
                  names_from = scientific_name,
                  values_from = Presence)
  })
  
  output$map <- renderLeaflet({
    leaflet()%>%
      addTiles()%>% 
      setView(-73.82,40.93,   zoom = 10.50)%>%
      addProviderTiles(providers$Stamen.Toner)
  })
  
  # use leafletProxy observer to add points
  # https://rstudio.github.io/leaflet/shiny.html
  # observe({
  #   leafletProxy("map", data=map_df()) %>%
  #     # clear any previous markers
  #     clearShapes() %>%
  #     addMarkers(data=map_df(),
  #                label=~Site)
  # })
  
}