#' Run RLumModelShiny app
#' 
#' A wrapper for [`runApp`] to start interactive shiny apps for the R package RLumModel.
#' The `app_RLum()` function is just a wrapper for [`runApp`]. 
#' Via the `...` argument further arguments can be directly passed to [`runApp`]. 
#' See `?shiny::runApp` for further details on valid arguments.
#' 
#' @param ... further arguments to pass to [`runApp`]
#' 
#' @author Johannes Friedrich, University of Bayreuth (Germany)
#' 
#' @examples 
#' 
#' \dontrun{
#' 
#' run_rxylib()
#' 
#' }
#' 
#' @seealso [`runApp`]
#' @md
#' @export
run_RLumModel <- function(...) {
  
  # start application
  app_dir <- system.file(paste0("shiny/"), package = "RLumModelShiny")
  app <- shiny::runApp(app_dir, launch.browser = TRUE,  ...)
}