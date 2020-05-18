create_table_01 <- function( input.URL ){
  result <- list()
  
  df <- check_url_status( input.URL )
  
  result$original_URL <- rep( input.URL, times=nrow(df) )
  result$normalized_URL <- rep( normalize_url(input.URL), times=nrow(df) )
  result$redirected_URL <- rep( get_redirected_url(input.URL), times=nrow(df) )
  
  return( bind_cols(result, df) )
}