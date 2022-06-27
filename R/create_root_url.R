#' @title
#' Creates a root URL form an inputted URL
#' @description
#' Creates the root URL of a given URL. Function can only take a object of length 1 in order to work
#' @param input.URL Specified URL string
#' @return Root of imputted URL
#' @export

create_root_url <- function(input.URL){

  root_URL <- paste0("http://", httr::parse_url(input.URL)$hostname)

  return( root_URL )
}
