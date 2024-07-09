#' Oracle DBI resource connector
#'
#' Makes a Oracle DBI connection from a resource description.
#'
#' @docType class
#' @format A R6 object of class OracleResourceConnector
#' @import R6
#' @import httr
#' @export
OracleResourceConnector <- R6::R6Class(
  "OracleResourceConnector",
  inherit = DBIResourceConnector,
  public = list(

    #' @description Creates a new OracleResourceConnector instance.
    #' @return A OracleResourceConnector object.
    initialize = function() {},

    #' @description Check that the provided resource has a URL that locates a Oracle object: the URL scheme must be "oracle".
    #' @param resource The resource object to validate.
    #' @return A logical.
    isFor = function(resource) {
      !is.null(resource$url) && !is.null(resource$identity) && !is.null(resource$secret) &&
      super$parseURL(resource)$scheme %in% c("oracle")
    },

    #' @description Creates a DBI connection object from a resource.
    #' @param resource A valid resource object.
    #' @return A DBI connection object.
    createDBIConnection = function(resource) {
      if (self$isFor(resource)) {
        super$loadDBI()
        private$loadROracle()
        driver <- ROracle::Oracle()
        url <- super$parseURL(resource)
        DBI::dbConnect(driver, username = resource$identity, password = resource$secret,
                       dbname = paste("//", url$host, ":", url$port, "/", super$getDatabaseName(url), sep = ""))
      } else {
        stop("Resource is not located in a Oracle database")
      }
    }

  ),
  private = list(
    loadROracle = function() {
      if (!require("ROracle")) {
        install.packages("ROracle", repos = "https://cloud.r-project.org", dependencies = TRUE)
      }
    }
  )
)
