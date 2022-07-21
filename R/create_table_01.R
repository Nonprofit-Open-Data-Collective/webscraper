#' @title
#' Create a data frame of different URL formats

create_table_01 <- function( input.URL ){

  original_URL <- input.URL
  normalized_URL <- normalize_url( input.URL )
  http_status_code <- httr::GET( normalized_URL )$all_headers[[1]]$status
  is_redirected <- as.integer( http_status_code/100 ) == 3
  redirected_URL <- ifelse( is_redirected, get_redirected_url( normalized_URL ), NA )
  root_URL <- create_root_url( normalized_URL )
  active_URL <- NA
  url_version <- NA
  domain_status <- NA

  if( check_url_status2( original_URL ) == "VALID" ){
    active_URL <- original_URL
    url_version <- "original"
    domain_status <- check_url_status2( original_URL )

  } else if( check_url_status2( normalized_URL ) == "VALID" ){
    active_URL <- normalized_URL
    url_version <- "normalized"
    domain_status <- check_url_status2( normalized_URL )

  } else if( is_redirected ){
    if( check_url_status2( redirected_URL ) == "VALID" ){
      active_URL <- redirected_URL
      url_version <- "redirect"
      domain_status <- check_url_status2( redirected_URL )
    }
  } else{
    if( check_url_status2( root_URL ) == "VALID" ){
      active_URL <- root_URL
      url_version <- "root"
      domain_status <- check_url_status2( root_URL )
    }
  }

  result <- data.frame( org_id = sample.urls$EIN[sample.urls$ORGURL == original_URL],
                        org_name =  sample.urls$ORGNAME[sample.urls$ORGURL == original_URL],
                        original_URL,
                        normalized_URL,
                        redirected_URL,
                        root_URL,
                        active_URL,
                        url_version,
                        domain_status )

  return( result )
}
