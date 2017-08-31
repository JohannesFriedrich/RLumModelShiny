shinyServer(function(input, output) {
  
  sequence_add <- reactiveValues(List = NULL)
  
  model <- reactive({
    
    switch(input$model, 
           "Bailey 2001" = "Bailey2001",
           "Bailey 2002" = "Bailey2002",
           "Bailey 2004" = "Bailey2004",
           "Pagonis 2007" = "Pagonis2007",
           "Pagonis 2008" = "Pagonis2008",
           "Friedrich 2017" = "Friedrich2017")

  })
  
output$model_diagram <- renderUI({
    
    if(as.logical(input$show_diagram)){
      
      switch(input$model, 
             "Bailey 2001" = img(src = "Bailey2001_diagram.png"),
             "Bailey 2002" = "Bailey2002",
             "Bailey 2004" = "Bailey2004",
             "Pagonis 2007" = "Pagonis2007",
             "Pagonis 2008" = "Pagonis2008",
             "Friedrich 2017" = img(src = "Bailey2001_diagram.png"))

    } else {
      return()
    }
    
  })
  

  model_URL <- reactive({
    
    switch(input$model, 
           "Bailey 2001" = a("ScienceDirect", 
                             href = "http://www.sciencedirect.com/science/article/pii/S1350448700001001"),
           "Bailey 2002" = a("Oxford Academic", 
                             href = "https://academic.oup.com/rpd/article/100/1-4/33/1594920/Simulations-of-Variability-in-the-Luminescence"),
           "Bailey 2004" = a("ScienceDirect", 
                             href = "http://www.sciencedirect.com/science/article/pii/S135044870300310X"),
           "Pagonis 2007" = a("IOP Science", 
                              href = "http://iopscience.iop.org/article/10.1088/0022-3727/40/4/012/meta"),
           "Pagonis 2008" = a("ScienceDirect", 
                              href = "http://www.sciencedirect.com/science/article/pii/S1350448708000437"),
           "Friedrich 2017" = a("ScienceDirect", 
                                href = "http://www.sciencedirect.com/science/article/pii/S0022231316317082"))
    
  })
  
  output$model_URL <- renderUI({
    tagList("URL link:", model_URL())
  })
  
  seq_file <- reactive({
    
    input_file <- input$seq_file_input
    
    if (is.null(input_file)){
      
      return(NULL)
      
    } else {
      if(input$reset){
        sequence_add$List <- NULL
      } else {
        sequence_add$List <- read_SEQ2R(input_file$datapath, txtProgressBar = FALSE)
      }
      return(sequence_add$List)
    }
    
  })
  
  output$ui <- renderUI({
    
    if(is.null(input$sequence_step))
      return()
  
    switch(input$sequence_step,
      "TL" =  list(
        numericInput(inputId = "TL_begin", 
                     label = "Start temperature [°C]", 
                     value = 20),
        numericInput(inputId = c("TL_end"), 
                     label = "End temperature [°C]", 
                     value = 300),
        numericInput(inputId = "TL_heating_rate", 
                     label = "Heating rate [°C/s]", 
                     value = 5)), ## TL
    
      "OSL" = list(
        numericInput(inputId = "OSL_temp", 
                     label = 'Reading temperature [°C]', 
                     value = 125),
        numericInput(inputId = "OSL_duration", 
                     label = "Duration [s]", 
                     value = 40),
        numericInput(inputId = "OSL_optical_power", 
                     label = "Optical power [%]", 
                     value = 90)), ## OSL
      
      "Irradiation" = list(
        numericInput(inputId = c("IRR_temp"),
                     label = "Irradiation temperature [°C]",
                     value = 20),
        numericInput(inputId = "IRR_dose",
                     label = "Dose [Gy]",
                     value = 1),
        numericInput(inputId = "IRR_dose_rate",
                     label = "Dose rate [Gy/s]",
                     value = 1)), ## IRR
      
      "Illumination" = list(
        numericInput(inputId = c("Ill_temp"),
                     label = "Illumination temperature [°C]",
                     value = 125),
        numericInput(inputId = "Ill_duration",
                     label = "Duration [s]",
                     value = 40),
        numericInput(inputId = "Ill_optical_power",
                     label = "Optical power [%]",
                     value = 90)), ## Illumination
      
      "LM-OSL" = list(
        numericInput(inputId = c("LM_OSL_temp"),
                     label = "Reading temperature [°C]",
                     value = 125),
        numericInput(inputId = "LM_OSL_duration",
                     label = "Duration [s]",
                     value = 40),
        numericInput(inputId = "LM_OSL_start_power",
                     label = "Start power [%]",
                     value = 0),
        numericInput(inputId = "LM_OSL_end_power",
                     label = "End power [%]",
                     value = 100)), ## LM-OSL
      "RF/RL" = list(
        numericInput(inputId = c("RF_temp"),
                     label = "Irradiation temperature [°C]",
                     value = 20),
        numericInput(inputId = "RF_dose",
                     label = "Dose [Gy]",
                     value = 1),
        numericInput(inputId = "RF_dose_rate",
                     label = "Dose rate [Gy/s]",
                     value = 1)), ## RF/RL
      
      "RF heating" = list(
        numericInput(inputId = c("RF_heating_begin"),
                     label = "Start temperature [°C]",
                     value = 20),
        numericInput(inputId = c("RF_heating_end"),
                     label = "End temperature [°C]",
                     value = 500),
        numericInput(inputId = "RF_heating_heating_rate",
                     label = "Heating rate [°C/s]",
                     value = 1),
        numericInput(inputId = "RF_heating_dose_rate",
                     label = "Dose rate [Gy/s]",
                     value = 1)), ## RF heating
      
      "Cut-Heat" = list(
        numericInput(inputId = c("CH_end"),
                     label = "End temperature [°C]",
                     value = 20),
        numericInput(inputId = c("CH_duration"),
                     label = "Duration [s]",
                     value = NA),
        numericInput(inputId = "CH_heating_rate",
                     label = "Heating rate [°C/s]",
                     value = NA)), ## CH
      
      "Pre-Heat" = list(
        numericInput(inputId = c("PH_end"),
                     label = "End temperature [°C]",
                     value = 20),
        numericInput(inputId = c("PH_duration"),
                     label = "Duration [s]",
                     value = 10),
        numericInput(inputId = "PH_heating_rate",
                     label = "Heating rate [°C/s]",
                     value = NA)), ## PH
      
      "Pause" = list(
        numericInput(inputId = c("pause_temp"),
                     label = "Temperature [°C]",
                     value = 20),
        numericInput(inputId = c("pause_duration"),
                     label = "Duration [s]",
                     value = 10))
        
    ) # end switch
    
  }) # end renderUI
  
  observeEvent(input$apply_SequenceStep, {
    
    temp <- NULL
    
    switch(input$sequence_step,
           
           "TL" =   temp <- list(TL = c(input$TL_begin, input$TL_end, input$TL_heating_rate)),
           "OSL" =  temp <- list(OSL = c(input$OSL_temp, input$OSL_duration, input$OSL_optical_power)),
           "Irradiation" =  temp <- list(IRR = c(input$IRR_temp, input$IRR_dose, input$IRR_dose_rate)),
           "Illumination" =  temp <- list(ILL = c(input$Ill_temp, input$Ill_duration, input$Ill_optical_power)),
           "LM-OSL" =  temp <- list(LM_OSL = c(input$LM_OSL_temp, input$LM_OSL_duration, input$LM_OSL_start_power, input$LM_OSL_end_power)),
           "RF/RL" =  temp <- list(RF = c(input$RF_temp, input$RF_dose, input$RF_dose_rate)),
           "RF heating" =   temp <- list(RF_heating = c(input$RF_heating_begin, input$RF_heating_end, input$RF_heating_heating_rate, input$RF_heating_dose_rate)),
           "Cut-Heat" =   temp <- list(CH = c(input$CH_temp, input$CH_duration, input$CH_heating_rate)),
           "Pre-Heat" =   temp <- list(PH = c(input$PH_temp, input$PH_duration, input$PH_heating_rate)),
           "Pause" =   temp <- list(PAUSE = c(input$pause_temp, input$pause_duration))
    )
    
    ## combine sequence
    sequence_add$List <- c(isolate(sequence_add$List), temp)

  })
  
  observeEvent(input$reset, {
    
    sequence_add$List <- NULL
    
  })

  output$sequence_out <- renderPrint({
    
    if(is.null(seq_file())){
      if(!is.null(sequence_add$List))
          return(sequence_add$List)

    } else {
      if(!is.null(sequence_add$List)){
        sequence_add$List <- seq_file()
        return(sequence_add$List)
      } else {
        return(sequence_add$List)
      }
    }

  })
  
  start_simulation <- reactive({
    
    if(length(sequence_add$List) == 0)
      return()

    model.output <- model_LuminescenceSignals(
      model = model(),
      sequence = sequence_add$List,
      plot = FALSE)

  }) ## end eventReactive
  
  ## REMOVE LAST STEP ##
  
  observeEvent(input$remove_LastSequenceStep, {
    
    sequence_add$List <- sequence_add$List[-length(sequence_add$List)]
    
  })
  
  ## SINGAL OUTPUT ##
  
  output$signal_output <- renderPlot({
    
    if(length(sequence_add$List) == 0)
      return()
    
    combine <- as.logical(input$combine_plots)

    signals <- get_RLum(start_simulation(),
                        recordType = c("RF$", "TL$", "OSL$", "LM-OSL$", "RF_heating$", "pause$"),
                        drop = FALSE)
    Luminescence::plot_RLum.Analysis(signals, combine = combine)

    if(input$reset)
      return()
  })
  
  ## CONCENTRATION OUTPUT ##
  
  output$concentration_output <- renderPlot({
    
    if(length(sequence_add$List) == 0)
      return()
    
    conc <- get_RLum(start_simulation(), 
                     recordType = "conc. ", 
                     drop = FALSE)
    
    Luminescence::plot_RLum.Analysis(conc)
    
    if(input$reset)
      return()
  })
      
}) ## end shinyServer

