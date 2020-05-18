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
    if( check_url_status2( normalized_URL ) == "VALID" ){
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
  
  df <- check_url_status( input.URL )
  
  result$original_URL <- rep( input.URL, times=nrow(df) )
  result$normalized_URL <- rep( normalize_url(input.URL), times=nrow(df) )
  result$redirected_URL <- rep( get_redirected_url(input.URL), times=nrow(df) )
  
  return( bind_cols(result, df) )
}