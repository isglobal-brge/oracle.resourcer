.onAttach <- function(libname, pkgname) {
  resourcer::registerDBIResourceConnector(OracleResourceConnector$new())
}
