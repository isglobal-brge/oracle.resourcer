#' Oracle DBI Resource Connector
#'
#' @description
#' A specialized connector class for establishing and managing Oracle database connections through DBI.
#' This class extends the DBIResourceConnector to provide Oracle-specific connection handling.
#'
#' @details
#' The OracleResourceConnector provides functionality to:
#' * Validate Oracle database resource configurations
#' * Create and manage Oracle database connections
#' * Handle Oracle-specific connection parameters and requirements
#'
#' The connector expects resources with:
#' * A valid Oracle URL (scheme: "oracle")
#' * Authentication credentials (identity/username and secret/password)
#' * Proper database connection parameters (host, port, database name)
#'
#' @examples
#' \dontrun{
#' # Create a new connector
#' connector <- OracleResourceConnector$new()
#'
#' # Example resource configuration
#' resource <- list(
#'   url = "oracle://localhost:1521/ORCL",
#'   identity = "username",
#'   secret = "password"
#' )
#'
#' # Create connection
#' conn <- connector$createDBIConnection(resource)
#' }
#'
#' @docType class
#' @format An R6 class object extending DBIResourceConnector
#' @import R6
#' @import httr
#' @export
OracleResourceConnector <- R6::R6Class(
  "OracleResourceConnector",
  inherit = DBIResourceConnector,
  public = list(

    #' @description
    #' Initialize a new OracleResourceConnector instance.
    #' This method sets up the basic structure for Oracle database connections.
    #'
    #' @return An initialized OracleResourceConnector object.
    initialize = function() {},

    #' @description
    #' Validates whether a given resource configuration is suitable for Oracle connections.
    #'
    #' @details
    #' Performs validation checks on the resource object to ensure it contains:
    #' * A valid URL
    #' * Authentication credentials (identity and secret)
    #' * Correct URL scheme ("oracle")
    #'
    #' @param resource A list containing resource configuration parameters:
    #'   \itemize{
    #'     \item url: The Oracle database URL
    #'     \item identity: Username for authentication
    #'     \item secret: Password for authentication
    #'   }
    #' @return logical TRUE if the resource is valid for Oracle connections, FALSE otherwise
    isFor = function(resource) {
      # Check for required components and correct scheme
      !is.null(resource$url) && !is.null(resource$identity) && !is.null(resource$secret) &&
        super$parseURL(resource)$scheme %in% c("oracle")
    },

    #' @description
    #' Establishes a connection to an Oracle database using the provided resource configuration.
    #'
    #' @details
    #' The connection process involves:
    #' 1. Validating the resource configuration
    #' 2. Loading required dependencies (DBI and ROracle)
    #' 3. Creating an Oracle driver instance
    #' 4. Parsing the connection URL
    #' 5. Establishing the database connection
    #'
    #' @param resource A list containing Oracle connection parameters:
    #'   \itemize{
    #'     \item url: The Oracle database URL (format: "oracle://host:port/database")
    #'     \item identity: Username for database authentication
    #'     \item secret: Password for database authentication
    #'   }
    #' @return A DBI connection object for the Oracle database
    #' @throws Error if the resource is not a valid Oracle database configuration
    createDBIConnection = function(resource) {
      if (self$isFor(resource)) {
        # Load required dependencies
        super$loadDBI()
        private$loadROracle()

        # Initialize Oracle driver
        driver <- ROracle::Oracle()

        # Parse connection URL
        url <- super$parseURL(resource)

        # Establish database connection
        DBI::dbConnect(
          driver,
          username = resource$identity,
          password = resource$secret,
          dbname = paste("//", url$host, ":", url$port, "/", super$getDatabaseName(url), sep = "")
        )
      } else {
        stop("Resource is not located in a Oracle database")
      }
    }
  ),

  private = list(
    #' @description
    #' Internal helper function to ensure ROracle package is available.
    #' Attempts to install the package if not already present.
    #'
    #' @keywords internal
    loadROracle = function() {
      if (!require("ROracle")) {
        install.packages("ROracle", repos = "https://cloud.r-project.org", dependencies = TRUE)
      }
    }
  )
)
