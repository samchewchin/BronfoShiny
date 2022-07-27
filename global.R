# resources
# https://debruine.github.io/shinyintro/index.html

# load libraries ----
library(shiny)
library(leaflet)
library(tidyverse)

# load data ----
Long<-read_csv("data/eDNARachgeo.csv")


# Add column with a string containing all detected species

# define function to do the work

findfish<-function(sitename){
  fishlist<-Long%>%filter(Site==sitename)%>%select(scientific_name)
  stringlist<-paste(fishlist$scientific_name, collapse="<br>")
  return(stringlist)
}

# Make tibble of sites and stringlists of fishes
Bronfo<-Long%>%
  group_by(Site)%>%
  summarize()%>%
  rowwise()%>%
    mutate(Fishes=findfish(Site))%>%
  left_join(Long, by="Site")


# app variables ----

fish_list <- sort(unique(Bronfo$scientific_name))
