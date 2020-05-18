create_table_01 <- function( input.URL ){
  result <- list()
  
  original_URL <- input.URL
  normalized_URL <- normalize_url( input.URL )
  http_status_code <- httr::GET( input.URL )$all_headers[[1]]$status
  is_redirected <- as.integer( http_status_code/100 ) == 3
  redirected_URL <- ifelse( is_redirected, get_redirected_url( input.URL ), NA )
  root_URL <- create_root_url( normalized_URL )
  
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
  
  result$original_URL <- origninal_URL
  result$normalized_URL <- normalized_URL
  result$redirected_URL <- redirected_URL
  result$root_URL <- root_URL
  result$active_URL <- active_URL
  result$url_version <- url_version
  result$domain_status <- domain_status
  
  return( result )
}