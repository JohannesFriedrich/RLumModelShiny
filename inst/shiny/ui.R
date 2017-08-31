shinyUI(fluidPage(

  navbarPage("RLumModel",
    tabPanel("Model",
      fluidRow(
        column(4,
          selectInput("model",
                      label = "Model",
                      choices = c("Bailey 2001", "Bailey 2002", "Bailey 2004",
                                  "Pagonis 2007", "Pagonis 2008", "Friedrich 2017"),
                      selected = "Bailey 2001"),
          uiOutput("model_URL"),
          hr(),
          radioButtons("show_diagram", 
                       label = "Show energy band",
                       choices = list(
                         Yes = TRUE,
                         No = FALSE
                       ), 
                       selected = FALSE)
        ),
        column(8,
          htmlOutput("model_diagram")
               )
  )), # end tabPanel "MODEL"
  
  tabPanel("Sequence", 
           
          fluidRow(
           column(4,
           h3("Select sequence input"),
           selectizeInput("sequence_step",
                          label = "Select sequence step",
                          choices = c("OSL",
                                      "TL",
                                      "RF/RL",
                                      "LM-OSL",
                                      "Irradiation",
                                      "Pause",
                                      "Illumination",
                                      "Cut-Heat",
                                      "Pre-Heat",
                                      "RF heating"),
                          options = list(
                            placeholder = 'Select step',
                            onInitialize = I('function() { this.setValue(""); }'))),
           fileInput('seq_file_input', 
                     label = 'Choose SEQ File',
                     accept = c(
                       '.SEQ',
                       '.seq')),
           # hr(),
           # actionButton("start_simulation",
           #              label = "Start simulation",
           #              icon = icon("paper-plane"),
           #              style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
           hr(),
           actionButton("reset", 
                        label = "Reset",
                        icon = icon("refresh"),
                        style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
           ),
           column(4,
                  h3("Current sequence step"),
            uiOutput("ui"),
           actionButton("apply_SequenceStep", 
                        label = "Apply step to sequence",
                        style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
           br(),
           br(),
           actionButton("remove_LastSequenceStep", 
                        label = "Remove last step",
                        style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
          ),
           column(4,
                  h3("Sequence list"),
            verbatimTextOutput("sequence_out"))
          )
           
  ), # end tabPanel "SEQUENCE"
  tabPanel("Signal", 
           fluidRow(
             column(4,
                    radioButtons("combine_plots",
                                  label = "Combine plots", 
                                  c(
                                    Yes = TRUE,
                                    No = FALSE))
                                 ),
             column(8,
            plotOutput("signal_output")))
           ),
  tabPanel("Concentrations", 
           fluidRow(
             column(4,
                    radioButtons("combine_plots_conc",
                                 label = "Combine plots", 
                                 c(
                                   Yes = TRUE,
                                   No = FALSE))
             ),
             column(8,
                    plotOutput("concentration_output"))
           )
  ),
  
  tabPanel("About",
           h5("Authors"),
           p("Johannes Friedrich, University of Bayreuth (Germany)"),
           h5("Contact"),
           p("johannes.friedrich@uni-bayreuth.de"),
           a("RLumModel", href = "https://github.com/R-Lum/RLumModel"),
           a("RLum", href = "https://github.com/R-Lum/Luminescence"),
           br(),
           h5("License"),
           p("This program is free software: you can redistribute it and/or
             modify it under the terms of the GNU General Public License as
             published by the Free Software Foundation, either version 3 of
             the License, or any later version."),
           p("This program is distributed in the hope that it will be useful
             , but WITHOUT ANY WARRANTY; without even the implied warranty
             of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the",
             a("GNU General Public License"), "for more details.")
           
           
           
           )
  ) ## end main panel
))
