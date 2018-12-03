#Server
server <- function(input, output) {
  key <- "yourkeyhere"
  register_google(key=key)
  dataset <- reactive({
    plotDataset <- get(input$datasetChoice)
  })
  
  datasetTest <- reactive({
    datasetVisualization <- get(input$data)
    if(input$data == "school"){
      datasetVisualization <- school %>% select(Nimi,Õppekeel,Aadress)
    }
    if(input$data == "lasteaed"){
      datasetVisualization <- lasteaed %>%  select(Nimi,Õppekeel, Aadress)
    }
    if(input$data == "public"){
      datasetVisualization <- public %>% select(ToimKpv,ToimKell,ToimNadalapaev,SyndmusLiik,SyndmusTaiendavStatLiik,KohtNimetus)
    }
    if(input$data == "property"){
      datasetVisualization <- property  %>% select(ToimKpv,ToimKell,ToimNadalapaev,SyndmusLiik,SyndmusTaiendavStatLiik,Kahjusumma)
    }
    if(input$data == "traffic"){
      datasetVisualization <- traffic %>% select(ToimKpv,ToimKell,ToimNadalapaev,KohtNimetus,SoidukMark,RikkujaVanus,RikkujaSugu)
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
      
      map <- map %>%   addAwesomeMarkers(lng = school$Lon,
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
  
  #Outputs the datatable that is shown underneath the plot on main page
  # output$dataview <- renderDataTable({
  #   DT::datatable(datasetTest(), filter = 'top', options= list(autoWidth=TRUE))
  # })

  #prints out the data that is shown in the datatable
  output$downloadData <- downloadHandler(
    filename = function(){
      paste("shiny_pilot_data_download", ".csv", sep = "")
    },
    content = function(file){
      write.csv(datasetVisualization[input[["dataview_rows_all"]], ], file, row.names = FALSE)
      }
  )

  
  
  # observeEvent(input$data, {
  #   if (input$plotData == "property") {
  #     data_r$plotData <- iris
  #     data_r$plotData <- "iris"
  #   } else {
  #     data_r$data <- mtcars
  #     data_r$name <- "mtcars"
  #   }
  # })
  data_r <- reactiveValues(data = property, name = "property")
  
  
  observeEvent(input$data, {
    if(input$data == "property"){
      data_r$data <- property
      data_r$data <- "property"
    }
    if(input$data == "traffic"){
        data_r$data <- traffic
        data_r$data <- "traffic"
      }
    if(input$data == "public"){
      data_r$data <- public
      data_r$data <- "public"
    }
    if(input$data == "schools"){
      data_r$data <- schools
      data_r$data <- "schools"
    }
    if(input$data == "lasteaed"){
      data_r$data <- lasteaed
      data_r$data <- "lasteaed"
    }
  })
  
  callModule(module = esquisserServer, id = "esquisse", data = data_r)
  

}  
