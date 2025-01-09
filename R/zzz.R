#' Package Attachment Hook
#'
#' @description
#' This function is automatically called when the package is attached (loaded with library() or require()).
#' It registers the OracleResourceConnector with the resourcer package's DBI connector registry.
#'
#' @details
#' The .onAttach hook performs the following steps:
#' 1. Creates a new instance of OracleResourceConnector
#' 2. Registers this connector with resourcer's DBI connector registry system
#' This enables automatic handling of Oracle database connections through the resourcer framework.
#'
#' @param libname The library name where the package is installed (provided by R)
#' @param pkgname The name of the package being attached (provided by R)
#'
#' @keywords internal
#' @noRd
.onAttach <- function(libname, pkgname) {
  # Create new Oracle connector instance and register it with resourcer
  # This enables automatic Oracle database connection handling
  resourcer::registerDBIResourceConnector(OracleResourceConnector$new())
}
