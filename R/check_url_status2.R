#' @title
#' Checks URLS Status
#' @export

check_url_status2 <- function( input.URL ){

  URL_Exists <- RCurl::url.exists( input.URL )
  URL_Active <- "Success" == tryCatch( httr::http_status( httr::GET( input.URL ) )[[1]], error = function( e ){ NA } )
  domain_status <- ifelse( URL_Exists && URL_Active, "VALID", ifelse( URL_Exists, "EXISTS", "DNE" ) )

  return (domain_status)
}
