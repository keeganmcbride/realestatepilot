#Server
server <- function(input, output) {
  key <- "your own key :)"
  register_google(key=key)
  dataset <- reactive({
    plotDataset <- get(input$datasetChoice)
  })
  
  datasetTest <- reactive({
    datasetVisualization <- get(input$datasets)
    if(input$datasets == "school"){
      datasetVisualization <- school %>% select(Nimi,Õppekeel,Aadress)
    }
    if(input$datasets == "lasteaed"){
      datasetVisualization <- lasteaed %>%  select(Nimi,Õppekeel, Aadress)
    }
    if(input$datasets == "public"){
      datasetVisualization <- public %>% select(ToimKpv,ToimKell,ToimNadalapaev,SyndmusLiik,KohtNimetus)
    }
    if(input$datasets == "property"){
      datasetVisualization <- property  %>% select(ToimKpv,ToimKell,ToimNadalapaev,SyndmusLiik,Kahjusumma)
    }
    if(input$datasets == "crashDataCleanedFixed"){
      datasetVisualization <- crashDataCleanedFixed %>% select(Kuupäev,Kellaaeg, Situatsiooni.tüüp, Kahju.suurus..euro.)
    }
    if(input$datasets == "traffic"){
      datasetVisualization <- traffic %>% select(ToimKpv,ToimKell,ToimNadalapaev,KohtNimetus,SoidukMark,RikkujaVanus,RikkujaSugu)
    }
    if(input$datasets == "playgrounds"){
      datasetVisualization <- playgrounds %>% select(name,district)
    }
    if(input$datasets == "dogParks"){
      datasetVisualization <- dogParks %>% select(name,district)
    }
    if(input$datasets == "sportCenters"){
      datasetVisualization <- sportCenters
    }
    if(input$datasets == "salePrices"){
      datasetVisualization <- salePrices
    }
    if(input$datasets == "schools"){
      datasetVisualization <- schools
    }
    
    datasetVisualization
  })
  
  ##Create Custom Icons Here
  schoolIcons <- awesomeIcons(
    icon = 'graduation-cap',
    markerColor = 'lightblue',
    library = 'fa',
    iconColor = 'black'
  )
  
  lasteaedIcons <- awesomeIcons(
    icon = 'graduation-cap',
    markerColor = 'darkpurple',
    library = 'fa',
    iconColor = 'black'
  )
  
  addressIcons <- awesomeIcons(
    icon = 'home',
    markerColor = "red",
    library = 'fa',
    iconColor = 'black'
  )
  
  output$outputmap <- renderLeaflet({
    map <- leaflet() %>% addProviderTiles(providers$OpenStreetMap.Mapnik)  %>% setView(lng =  24.753574,
                                                                                                   lat = 59.436962,
                                                                                                   zoom = 12) 
      if("property" %in% input$datasetChoice){
       property <- property %>% filter(ToimKpv>=input$dateSelect[1] & ToimKpv<=input$dateSelect[2])
      map <- map %>%  addAwesomeMarkers(lng = property$lon,
                                lat = property$lat,
                                clusterOptions = markerClusterOptions(),
                                popup= paste(
                                  "Time:", paste(property$ToimKpv ,property$ToimKell),
                                  "<br>",
                                  "Type:", paste(property$SyndmusLiik, property$SyndmusTaiendavStatLiik),
                                  "<br>",
                                  "Code:", property$ParagrahvTais,
                                  "<br>",
                                  "Damage:", property$Kahjusumma
                                ))
    }
    if("crashDataCleanedFixed" %in% input$datasetChoice){
      crashDataCleanedFixed <- crashDataCleanedFixed %>% filter(Kuupäev>=input$dateSelect[1] & Kuupäev<=input$dateSelect[2])
      map <- map %>% addAwesomeMarkers(lng = crashDataCleanedFixed$Lon,
                                lat = crashDataCleanedFixed$Lat,
                                clusterOptions = markerClusterOptions(),
                                popup = paste(
                                  "Time:", paste(crashDataCleanedFixed$Kuupäev ,crashDataCleanedFixed$Kellaaeg),
                                  "<br>",
                                  "Situation:", crashDataCleanedFixed$Situatsiooni.tüüp,
                                  "<br>",
                                  "Damage:", crashDataCleanedFixed$Kahju.suurus..euro.
                                ))
    }
    if("public" %in% input$datasetChoice){
      public <- filter(public, public$ToimKpv>=input$dateSelect[1],public$ToimKpv<=input$dateSelect[2])
      
      map <- map %>% addAwesomeMarkers(lng = public$lon,
                                lat = public$lat,
                                clusterOptions = markerClusterOptions(),
                                popup = paste(
                                  "Time:", paste(public$ToimKpv, public$ToimKell),
                                  "<br>",
                                  "Type:", paste(public$SyndmusLiik, public$SyndmusTaiendavStatLiik),
                                  "<br>",
                                  "Code:", public$ParagrahvTais,
                                  "<br>",
                                  "Damage:", public$Kahjusumma
                                    
                                ))
    }
    if("school" %in% input$datasetChoice){
      
      map <- map %>% addAwesomeMarkers(lng = school$Lon,
                                lat = school$Lat, icon = schoolIcons,
                                popup = paste(
                                  "Name:",
                                  school$Nimi,
                                  "<br>",
                                  "Type:",
                                  school$Type,
                                  "<br>",
                                  "Teaching Language:",
                                  school$Õppekeel,
                                  "<br>",
                                  "Address:",
                                  school$Aadress
                                )
                                )
    }
    if("traffic" %in% input$datasetChoice){
      traffic <- traffic %>% filter(ToimKpv>=input$dateSelect[1] & ToimKpv<=input$dateSelect[2])
      
      map <- map %>% addAwesomeMarkers(lng = traffic$lon,
                                       lat = traffic$lat,
                                       clusterOptions = markerClusterOptions(),
                                       popup = paste(
                                         "Time:", paste(traffic$ToimKpv ,traffic$ToimKell),
                                         "<br>",
                                         "Type and Make:", paste(traffic$SoidukLiik, traffic$SoidukMark),
                                         "<br>",
                                         "Code:", property$ParagrahvTais
                                       ))
    }
    if("playgrounds" %in% input$datasetChoice){
      map <-  map %>%   addAwesomeMarkers(lng = playgrounds$longitude,
                                          lat = playgrounds$latitude,
                                          popup = paste(
                                            "Name:",
                                            playgrounds$name))
      
    }
    if("dogParks" %in% input$datasetChoice){
      map <-  map %>%   addAwesomeMarkers(lng = dogParks$longitude,
                                          lat = dogParks$latitude,
                                          popup = paste(
                                            "Name:",
                                            dogParks$name))
      
    }
    
    if("lasteaed" %in% input$datasetChoice){
      map <-  map %>%   addAwesomeMarkers(lng = lasteaed$Lon,
                                lat = lasteaed$Lat,icon = lasteaedIcons,
                                popup = paste(
                                  "Name:",
                                  lasteaed$Nimi,
                                  "<br>",
                                  "Type:",
                                  lasteaed$Type,
                                  "<br>",
                                  "Teaching Language:",
                                  lasteaed$Õppekeel,
                                  "<br>",
                                  "Address:",
                                  lasteaed$Aadress
                                )

                                )
    }
    
    map
    
    })
  
  ##Geocoding of custom address input
  geocoding <-
    eventReactive(input$addressButton, {
      geocode(input$address)
    })
  
  
  #Takes an address input and places a marker on the map at given location
  observeEvent(input$addressButton, {
     # leaflet::clearMarkers(leafletProxy('outputmap'))
      newMarker <- geocoding()
      leafletProxy('outputmap') %>% addAwesomeMarkers(
        lng = newMarker$lon,
        lat = newMarker$lat,
        icon = addressIcons,
        label = input$address)
 
  })
  
 # Outputs the datatable that is shown underneath the plot on main page
  output$dataview <- renderDataTable({
    DT::datatable(datasetTest(), filter = 'top', options= list(autoWidth=TRUE))
  })

  #prints out the data that is shown in the datatable
  output$downloadData <- downloadHandler(
    filename = function(){
      paste("shiny_pilot_data_download", ".csv", sep = "")
    },
    content = function(file){
      write.csv(datasetVisualization[input[["dataview_rows_all"]], ], file, row.names = FALSE)
      }
  )
  data_r <- reactiveValues(data = property, name = "property")
  callModule(module = esquisserServer, id = "esquisse", data = data_r)
  

}  
