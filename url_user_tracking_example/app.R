library(shiny)
library(shinysurveys)
library(tidyverse)

ui <- fluidPage(
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "url_based_user_tracking.css")
    ),
    fluidRow(class = "url-based-header",
              img(src = "http://jdtrat.com/packages/shinysurveys/resources/shinysurveys_hex-final.png", height = 150, align = "left", style = "margin-left: 10px; margin-right: 10px;"),
              h3("{shinysurveys} URL-based user tracking"),
              h4("developed by", a("Jonathan Trattner", href = "https://jdtrat.com"), "and", a("Lucy D'Agostino McGowan", href = "https://lucymcgowan.com")),
              a(href = "https://github.com/jdtrat/shinysurveys", class = "gh-button",
                span(class = "gh-button-icon", icon("github")),
                "View on Github")),
    mainPanel(
        column(width = 10,
               surveyOutput(teaching_r_questions[1,],survey_title = "URL-based user tracking",
                            survey_description = "{shinysurveys} supports URL-based user tracking. \n
                           For illustrative purposes, the user id is printed to the right. \n
                           By default, it is \"NO_USER_ID\". To initiate one, simply add
                           \"?user_id=UNIQUE_ID\" after the backslash in the URL.
                           The user id can be accessed within a reactive Shiny context with `input$userID`.")),
        column(width = 2,
              textOutput("user_id") %>%
        tagAppendAttributes(style = "font-size: 24px;"))
))

server <- function(input, output, session) {
    renderSurvey(teaching_r_questions[1,], input, output, session)
    output$user_id <- renderText({
        base::paste0("User ID: ", input$userID)
    })

    observeEvent(input$submit, {
        showModal(
            modalDialog(title = "Thanks for using {shinysurveys}!",
                        "This survey does nothing with your responses. It just illustrates the url-based user tracking feature.")
        )
    })
}

shinyApp(ui, server)
