ui <- fluidPage(
  
  # App title ----
  titlePanel("Bronx Fishes"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select fish ----
      checkboxGroupInput("fishes", label = "Fishes:",
                  choices = fish_list,
                  selected = c("Alosinae"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Leaflet Map ----
      leafletOutput(outputId = "map")
      
    )
  )
)