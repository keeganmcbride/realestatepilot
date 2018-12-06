library(shiny)
library(data.table)
library(stringr)
library(shinythemes)
library(leaflet) 
library(DT)
library(geojsonio)
library(ggmap)
library(dplyr)
library(esquisse)
library(readxl)
library(RJSONIO)

lasteaed <- readRDS("lasteaedData.RDS")
traffic <- readRDS("trafficCrimeEdited.RDS")
traffic$ToimKpv <- as.Date(traffic$ToimKpv)
public <- readRDS("publicCrimeEdited.RDS")
public$ToimKpv <- as.Date(public$ToimKpv)
property <- readRDS("propertyCrimeEdited.RDS")
property$ToimKpv <- as.Date(property$ToimKpv)
schools <- readRDS("schools.RDS")
crashDataCleanedFixed <- readRDS("crashDataCleanedFixed.RDS")
sportCenters <- readRDS("sportsCenters.RDS")
salePrices <- readRDS("salePrices.RDS")
school <- readRDS("school.RDS")
dogParks <- readRDS("dogParks.RDS")
playgrounds <- readRDS("playgrounds.RDS")

datasetOptions <- c("Property Crime" = "property",
                    "Traffic Incidents (until 2016)" = "crashDataCleanedFixed",
                    "Public Crime" = "public",
                    "School Locations" = "school",
                    "Lasteaed Locations" = "lasteaed",
                    "Traffic Crimes" = "traffic",
                    "Child Playgrounds" = "playgrounds",
                    "Dog Parks" = "dogParks"
)

datasetExplorer <- c("Property Crime" = "property",
                     "Traffic Incidents (until 2016)" = "crashDataCleanedFixed",
                     "Public Crime" = "public",
                     "School Locations" = "school",
                     "Lasteaed Locations" = "lasteaed",
                     "Traffic Crimes" = "traffic",
                     "Child Playgrounds" = "playgrounds",
                     "Dog Parks" = "dogParks",
                     "School Performance" = "schools",
                     "Sport Facilities" = "sportCenters",
                     "Historic Sale Prices" = "salePrices"
)





