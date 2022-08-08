#' @title
#' Create a data frame of different URL formats
#' @param input.URL Single URL with working URL
#' @return Table of different URL formats the inputted URL
#' @export

get_url_formats <- function( input.URL ){

  original_URL <- input.URL
  normalized_URL <- normalize_url( input.URL )
  url_status <- try(httr::http_error( normalized_URL ), silent = T)

  if(class(url_status) == "try-error"){
    result <- data.frame( original_URL,
                          normalized_URL = normalize_url,
                          redirected_URL = NA,
                          root_URL = NA,
                          active_URL = NA,
                          url_version = NA,
                          domain_status = "URL does not exist")
  }else if(httr::http_error( normalized_URL ) == TRUE ){
    result <- data.frame( original_URL,
                          normalized_URL = NA,
                          redirected_URL = NA,
                          root_URL = NA,
                          active_URL = NA,
                          url_version = NA,
                          domain_status = paste("Error:", httr::status_code( httr::GET( normalized_URL ) )))
  }else{
  http_status_code <- httr::GET( normalized_URL )$all_headers[[1]]$status
  is_redirected <- as.integer( http_status_code/100 ) == 3
  redirected_URL <- ifelse( is_redirected, get_redirected_url( normalized_URL ), NA )
  root_URL <- create_root_url( normalized_URL )
  active_URL <- NA
  url_version <- NA
  domain_status <- NA

  if( check_url_status( original_URL ) == "VALID" ){
    active_URL <- original_URL
    url_version <- "original"
    domain_status <- check_url_status( original_URL )

  } else if( check_url_status( normalized_URL ) == "VALID" ){
    active_URL <- normalized_URL
    url_version <- "normalized"
    domain_status <- check_url_status( normalized_URL )

  } else if( is_redirected ){
    if( check_url_status( redirected_URL ) == "VALID" ){
      active_URL <- redirected_URL
      url_version <- "redirect"
      domain_status <- check_url_status( redirected_URL )
    }
  } else{
    if( check_url_status( root_URL ) == "VALID" ){
      active_URL <- root_URL
      url_version <- "root"
      domain_status <- check_url_status( root_URL )
    }
  }

  result <- data.frame( original_URL,
                        normalized_URL,
                        redirected_URL,
                        root_URL,
                        active_URL,
                        url_version,
                        domain_status )
  }
  return( result )
}
