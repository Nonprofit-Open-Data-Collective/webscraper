normalize_url <- function( input.URL ){
  temp <- tolower( input.URL )
  
  temp <- sub( "^https?:/{2}", "", temp ) # remove HTTP(S) protocol from the URL
  temp <- sub( "^www\\.", "", temp ) # remove www. from the URL
  temp <- gsub( " ", "", temp ) # removes any " "
  temp <- gsub( "\\|:", "", temp ) # removes any "\" or ":"
  temp <- gsub( "\\>/{2}", "/", temp ) # converts any instances of "//" to "/" after the http(s):// head text
  temp <- gsub( "/$", "", temp ) # remove trailing slash
  
  # sort query parameters alphabetically
  # regex pattern from https://stackoverflow.com/questions/14679113/getting-all-url-parameters-using-regex
  query_params <- stringr::str_extract_all( temp, "[^&?]*?=[^&?]*" ) %>%
    unlist() %>% sort() %>% paste0( collapse="&" ) # sort query parameters
  
  if( query_params != "" ){
    query_params <- paste0( "?", query_params )
    temp <- gsub( "\\?.*", "", temp ) # remove all query parameters
    temp <- paste0(temp, query_params) # combine query parameters to the URL
  }
  
  temp <- paste0("http://", temp)
  
  return( list( original_URL = input.URL, normalized_URL = temp ) )
}

