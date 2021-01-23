library(shiny)
library(shinysurveys)
ui <- shiny::fluidPage(
  surveyOutput(shinysurveys::teaching_r_questions,
               survey_title = "A survey title",
               survey_description = "A description that is longer than the title.")
)

server <- function(input, output, session) {

  renderSurvey(input = input,
               output = output,
               df = shinysurveys::teaching_r_questions,
               session = session,
               theme = "#63B8FF")

  shiny::observeEvent(input$submit, {

    shiny::showModal(shiny::modalDialog(
      title = "Congrats, you completed your first shinysurvey!",
      "You can customize what actions happen when a user finishes a survey using input$submit."
    ))

  })

}

# Run the application
shiny::shinyApp(ui = ui, server = server)
