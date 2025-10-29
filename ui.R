ui <- page_fluid(
  shiny::navbarPage(
    title = div(
      img(src = "DCF.JPG", height = "80px", style = "margin-right: 5px;"),
      tags$h1("FLORENCE Tool", style = "color:white")),
    navbar_options = navbar_options(
      bg = "#072384",
      underline = TRUE,
      color = "F9FAFC"
    ),
    nav_spacer(),###End TITLE Section
    #Population Page
    #First Page Nav Panel
    nav_panel(tags$p("Current Population", style = "color:white"),
              tags$style(HTML("
    .navbar-nav > li > a {
      font-size: 24px; /* Adjust the font size as needed */
    }
    .navbar-brand {
      font-size: 22px; /* Adjust the title size */
    }
  ")),
              page_fillable(
                layout_columns(
                  card(full_screen = FALSE,
                       card_header("Information:"),
                       "This sample page is intended for DCF-SAMH preliminary 
           review and feedback as part of the FLORENCE predictive model visualization tool. 
           All numbers represented in the table below are manufactured for display purposes 
           only and are not representative of any true dataset. Data points will be replaced 
           with data analyzed and weighted during predictive modeling and, in future iterations, 
           will indicate a representative score for each indicator listed in the leftmost column. 
           These datapoints will be developed using multiple datasets and weighting criteria developed 
           over the course of tool development."),
                  card(full_screen = TRUE,
                       card_header("Current Geographic Risk Scores"), 
                       leafletOutput("basic_map")),
                  card(full_screen = TRUE,
                       card_header("Current Population Table"), 
                       layout_sidebar(
                         sidebar = sidebar(
                           bg = "lightgrey",
                           checkboxGroupInput(
                             inputId = "selected_columns",
                             label = "Select Counties to Display",
                             choices = all_columns,
                             selected = c("Domain", "Factor", "Florida", "U.S.") #initially selected columns
                           )
                         ),
                       reactableOutput("table1"))),
                row_heights = c(200,1000),
                col_widths = c(4, 8, 12)
                #Layout Columns
                ))),
    #Second Page Nav Panel
    nav_panel(tags$p("Projected Population", style = "color:white"), 
              layout_columns(
                card(card_header("Interventions"),
                     layout_columns(
                       col_widths = c(6,6),
                       #First Column of Interventions
                       div(
                         sliderInput(inputId = "MOUD",
                                     label = "MOUD (Any)",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = ""),
                         sliderInput(inputId = "Buprenorphine",
                                     label = "Buprenorphine",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = ""),
                         sliderInput(inputId = "Methadone",
                                     label = "Methadone",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = ""),
                         sliderInput(inputId = "Naltrexone",
                                     label = "Naltrexone",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = "")
                       ),
                       #Second Column of Interventions  
                       div(
                         sliderInput(inputId = "Therapy",
                                     label = "Therapy or Support Services",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = ""),
                         sliderInput(inputId = "MAT",
                                     label = "MOUD + Therapy or Support Services.",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = ""),
                         sliderInput(inputId = "Naloxone",
                                     label = "Naloxone",
                                     value = 0,
                                     min = min(-100),
                                     max = max(100),
                                     step = 25,
                                     sep = "")))),
                card(full_screen = TRUE, card_header("This sample page is intended for DCF-SAMH preliminary 
                                       review and feedback as part of the FLORENCE tool. All 
                                       datapoints within this page have been randomized for data 
                                       security and integrity during this review cycle. Outcomes modeled 
                                       on this map are currently reactive to the MOUD (Any) toggle only. 
                                       Future functionality of multiple toggles at once, and the reactive 
                                       changes to the map will be determined through predictive modeling 
                                       equations and the intended utility of the tool, as determined by 
                                       DCF-SAMH."),
                     #End Sidebar
                     leafletOutput("map")),
                card(full_screen = TRUE, 
                     card_header("Projected Risk Table"), 
                     layout_sidebar(
                       sidebar = sidebar(
                         bg = "lightgrey",
                         checkboxGroupInput(
                           inputId = "selected_columns",
                           label = "Select Counties to Display",
                           choices = all_columns2
                         )),
                     reactableOutput("table"))),
                row_heights = c(200,1000),
                col_widths = c(4, 8, 20)
                
                #Layout Columns
              )
              #Second Nav Panel
    ),
    #ISF Info
    nav_panel(
      title = div(
        img(src = "2024_New ISF Logo.JPG", height = "40px", style = "margin-left: 50px;"), 
        br(),
    tags$h6("Developed by ISF Inc.", style = "color:white"))),
    #ISF Info
    nav_panel(
      title = div(
        img(src = "FSUFCPR.JPG", height = "40px", style = "margin-left: 10px;"), 
        br(),
        tags$h6("In coordination with FSU-FCPR.", style = "color:white"))),
    #Page Navbar
  )
  #Page Fluid
)