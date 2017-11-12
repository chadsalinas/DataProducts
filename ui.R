library(shiny)
library(shinythemes)
shinyUI(fluidPage(theme = shinytheme("cerulean"),
    
  navbarPage("Golf Market Size Predictor",
             tabPanel("Plot by Rounds",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("sliderRP", "How many rounds do you think will be played this year?", 460, 500, value = 463),
                          #checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE), 
                          radioButtons("plotType", "Plot Type",
                                       c("Super Scatter"="l", "Basic Scatter"="p")
                          )
                        ),
                        mainPanel(
                          h3("Predict 2018 Golf Market Size"),
                          plotOutput("mktSizePlotByRounds"),
                          h3("Predicted Market Size by Rounds Played:"),
                          textOutput("pred1"),
                          br(),
                          br(),
                          bookmarkButton()
                          #enableBookmarking(store = "url")
                        )
                      )
             ),
             tabPanel("Plot by Participation",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("sliderRP2", "How many people play golf?", 23, 31, value = 25),
                          radioButtons("plotType2", "Plot Type",
                                       c("Super Scatter"="l", "Basic Scatter"="p")
                          )
                        ),
                        mainPanel(
                          h3("Predict 2018 Golf Market Size"),
                          plotOutput("mktSizePlotByParticipation"),
                          h3("Predicted Market Size by Participation:"),
                          textOutput("pred2"),
                          br(),
                          br(),
                          bookmarkButton()
                          #enableBookmarking(store = "url")
                        )
                      )
             ),
             navbarMenu("Help",
                        tabPanel("Readme",
                                 fluidRow(
                                   column(6, 
                                          includeMarkdown("Readme.Rmd")
                                          ),
                                   column(3, 
                                          img(class="img-polaroid",
                                              src=paste0("http://www.chadsalinas.com/",
                                                  "wp-content/uploads/2017/11/",
                                                  "KaiZoeTennessee.jpg")),
                                          tags$small(
                                            "Source: Photographed at 54-Hole Challenge at GreyStone ",
                                            "Hurricane Junior Golf Tour May 29, 2017 ",
                                            "Kai and Zoë Salinas by Chad Salinas ",
                                            a(href="http://chadsalinas.com")
                                          )
                                   )
                                   
                                 )
                        )
             )
  )
)
)

