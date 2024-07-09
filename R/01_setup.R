#' Check oracle.resourcer prerequisites
#'
#' This function checks if the required package `ROracle` is installed.
#' If the required package is missing, it stops and returns an error message.
#' If the package is installed, it returns a confirmation message.
#' 
#' Please note that this function is added to the package so that, when registered as a method, 
#' the Opal UI correctly displays the `oracle.resourcer` package in the list of installed packages, 
#' facilitating its management and discoverability by the data manager.
#'
#' @return A message indicating whether the required package is installed.
#' 
#' @export
.check_oracle_resourcer_prereqs <- function() {
  required_package <- "ROracle"
  if (!requireNamespace(required_package, quietly = TRUE)) {
    error_message <- paste("The required package is missing:", required_package, ". ",
                           "If you have already tried to install the `ROracle` package, it is possible that there were errors with its dependencies. ",
                           "Please refer to https://github.com/isglobal-brge/oracle.resourcer/blob/main/README.md#installation for installation instructions.")
    stop(error_message, call. = FALSE)
  } else {
    return("The `ROracle` package is properly installed!")
  }
}
