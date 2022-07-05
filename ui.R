ui <- fluidPage(
  
  # App title ----
  titlePanel("Bronx Fishes"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select fish ----
      selectInput("fishes", label = "Fishes:",
                  choices = fish_list, 
                  multiple = TRUE)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Leaflet Map ----
      leafletOutput(outputId = "map")
      
    )
  )
)