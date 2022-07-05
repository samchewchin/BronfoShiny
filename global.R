# resources
# https://debruine.github.io/shinyintro/index.html

# load libraries ----
library(shiny)
library(leaflet)
library(tidyverse)

# load data ----

# Read in data
# These files are outputs from DataPipe.Rmd. I'll use my Hellinger transformed read abundances of fish taxa and join them with the metadata, which include spatial coordinates
# Long format of all detections
Long<-read_csv("data/Bron_optax_long.csv")%>%
  select(-Type)
# Species detections
#Hellinger transformed relative read abundances
Hell<-read_csv("data/Bron_optax_Hell.csv")
#Presence Absence
Pres<-read_csv("data/Bron_optax_binary.csv")

# Metadata, including lat/lon
Meta<-read_csv("data/Bron_meta.csv")%>%
  select(Site, Lat, Lon)
#Diversity stats
Divs<-read_csv("data/Bron_Hell_divs.csv")

# prep data ----

Pres_long<-Pres%>%
  pivot_longer(names_to="scientific_name", 
               values_to="Presence",
               cols=-Site)

# create shiny app dataframe
Bronfo<-Long%>%select(-River)%>%
  full_join(Pres_long, 
            by = c("Site", "scientific_name"))%>%
  left_join(Meta, by="Site")

# remove unused dataframes
rm(Divs, Hell, Long, Meta, Pres, Pres_long)

# app variables ----

fish_list <- unique(Bronfo$scientific_name)


# test functionality
# Bronfo %>%
#   filter(scientific_name %in% c("Ameiurus natalis"),
#          Presence != 0) %>%
#   pivot_wider(id_cols = -totalcount,
#               names_from = scientific_name,
#               values_from = Presence)
