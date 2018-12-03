ui <-  navbarPage(theme = shinytheme("spacelab"),
                 title="OGI Estonian Pilot", 
                 windowTitle = "OGI Estonian Pilot",
                 tabPanel("Map of Tallinn",
                 sidebarLayout(
                   sidebarPanel(
                     textInput("address", "Address", value = ""),
                     verbatimTextOutput("value"),
                     actionButton("addressButton", "Search"),
                     p(
                       "Type in an address and press 'search' to mark the location on the map!"
                     )
                   ,
                   selectizeInput("datasetChoice", "Choose Data to Show", multiple = TRUE, datasetOptions, selected = TRUE),
                   dateRangeInput('dateSelect',
                                  label = 'Date Range Select',
                                  start = as.Date("2017-12-01"), end = as.Date("2017-12-31"), 
                                  min = as.Date("2013-01-01"), max = as.Date("2017-12-31"), 
                                  weekstart = 1, language = "en", separator = "-"
                   )),
                   mainPanel(
                       tags$div(style="row", leafletOutput("outputmap", width = "100%", height = "800px"))
                     #  , tags$div(style="row", DTOutput("dataview"))
                     ,
                     hr(
                       "This project has received funding from the European Union’s Horizon 2020 research and innovation programme under grant agreement No 693849."
                     )))),

tabPanel(title = "Data Explorer",
         fluidPage(
           tags$div(
             style = "height: 700px;", # needs to be in fixed height container
             esquisserUI(
               id = "esquisse",
               header = FALSE, # dont display gadget title
               choose_data = TRUE # dont display button to change data
             )))
           # sidebarPanel(
           #  # selectizeInput("datavis","Choose Dataset to Visualize", datasetOptions, multiple = FALSE),
           #   radioButtons(
           #     inputId = "data",
           #     label = "Data to use:",
           #     choices = c("school", "property","lasteaed","public","schools","traffic","schools"),
           #     inline = FALSE
           #   )),
             
           # radioButtons("plotType", "Choose a Plot", c("Bar Stacked" = "barstack", "Line" = "line", "Bar" = "bar"), inline = TRUE, selected = "line"),
           #   fluidRow(
           #     downloadButton("downloadData",
           #                    "Laadi alla: CSV")
           #   )
           # ),
         #   mainPanel(
         #     
         #     )
         #  #   ,         DTOutput("dataview")
         #   )
         # )),
),
tabPanel(title = "About", 
                    fluidRow(
                      column(8, offset = 1,
                             includeMarkdown("about.md"))))


)