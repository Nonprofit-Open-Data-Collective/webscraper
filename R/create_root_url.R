create_root_url <- function(input.URL){
  
  root_URL <- paste0("http://", httr::parse_url(temp)$hostname)
  
  return( root_URL )
}