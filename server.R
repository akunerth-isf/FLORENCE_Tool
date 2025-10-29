##Place this code in your server.R file!

#server.R
server = function(input, output, session) {
  #INITIAL TABLE
  output$table1 <- renderReactable({
    #Columns shown are dependent on the user input
      reactable(data[, input$selected_columns, drop = FALSE],
                rownames = FALSE,
                bordered = TRUE,
                striped = TRUE,
                highlight = TRUE,
                searchable = TRUE, minRows = 10,
                groupBy = "Domain",
                columns = list(
                  Domain = colDef(minWidth = 200),
                  Factor = colDef(minWidth = 200),
                  Florida = colDef(
                    sticky = "right",
                    style = sticky_style,
                    headerStyle = sticky_style),
                  U.S. = colDef(
                    sticky = "right",
                    style = sticky_style,
                    headerStyle = sticky_style,
                     )),
                resizable = TRUE,
                wrap = FALSE)
    ##End Reactable
  })
  
  #Second TABLE
  output$table <- renderReactable({
    reactable(data_out[, input$selected_columns, drop = FALSE],
              rownames = FALSE,
              striped = TRUE,
              highlight = TRUE,
              searchable = TRUE, minRows = 10,
              groupBy = "Domain",
              columns = list(
              Florida = colDef(
                sticky = "right",
                style = sticky_style,
                headerStyle = sticky_style),
              U.S. = colDef(
                sticky = "right",
                style = sticky_style,
                headerStyle = sticky_style,
              )),
              resizable = TRUE,
              wrap = TRUE)
    ##End Reactable
  })
###MAP 1
  output$basic_map <- renderLeaflet({
    # Assuming merged_data is already prepared
    leaflet(merged_out) %>%
      addTiles() %>%
      addPolygons(
        fillColor = ~colorQuantile("YlGnBu", GeoScore)(GeoScore),
        weight = 1,
        opacity = 1,
        color = "white",
        fillOpacity = 0.7,
        highlightOptions = highlightOptions(
          weight = 2,
          color = "#666",
          fillOpacity = 0.7,
          bringToFront = TRUE
        ),
        popup = ~paste0( merged_out$NAME," County", ", Risk Score: ", paste0(round(merged_out$GeoScore * 100, 1), "%"),
                        ", SDOH Score: ", paste0(round(merged_out$SDOH * 100, 1), "%"),
                        ", Community Health Score: ", paste0(round(merged_out$Health * 100, 1), "%"),
                        ", Baseline Usage Rates: ", paste0(round(merged_out$Usage * 100, 1), "%"))
      ) %>%
      leaflet::addLegend(
        pal = colorQuantile("YlGnBu", merged_out$GeoScore),
        values = merged_out$GeoScore,
        title = "Geographic Risk Profiles"
      )
  })

###MAP 2
##Initial Map Rendering - Outcomes
  output$map <- renderLeaflet({
    # Assuming merged_data is already prepared
    leaflet(Sliders_out) %>%
      addTiles() %>%
      addPolygons(
        fillColor = ~colorQuantile("YlGnBu", PrimaryScore)(PrimaryScore),
        weight = 1,
        opacity = 1,
        color = "white",
        fillOpacity = 0.7,
        highlightOptions = highlightOptions(
          weight = 2,
          color = "#666",
          fillOpacity = 0.7,
          bringToFront = TRUE
        ),
        popup =  ~paste0( 
          Sliders_out$NAME," County", 
          ", Primary Risk Score: ", paste0(round(Sliders_out$PrimaryScore * 100, 1), "%")
      )) %>%
      leaflet::addLegend(
        pal = colorQuantile("YlGnBu", Sliders_out$PrimaryScore),
        values = Sliders_out$PrimaryScore,
        title = "Primary Outcomes Score")
  })
#END SERVER
}