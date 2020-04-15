normalize_url <- function( input.URL ){
  temp <- tolower( input.URL )
  
  temp <- sub( "^https?:/{2}", "", temp ) # remove HTTP(S) protocol from the URL
  temp <- sub( "^www\\.", "", temp ) # remove www. from the URL
  temp <- gsub( " ", "", temp ) # removes any " "
  temp <- gsub( "\\|:", "", temp ) # removes any "\" or ":"
  temp <- gsub( "\\>/{2}", "/", temp ) # converts any instances of "//" to "/" after the http(s):// head text
  temp <- gsub( "/$", "", temp ) # remove trailing slash
  temp <- gsub( "html$", "htm", temp ) # replace html at the end with htm
  
  # sort query parameters alphabetically
  # regex pattern from https://stackoverflow.com/questions/14679113/getting-all-url-parameters-using-regex
  query_params <- stringr::str_extract_all( temp, "[^&?]*?=[^&?]*", simplify = TRUE ) %>%
    sort() %>% paste0( collapse="&" ) # sort query parameters
  
  if( query_params != "" ){
    query_params <- paste0( "?", query_params )
    temp <- gsub( "\\?.*", "", temp ) # remove all query parameters
    temp <- paste0(temp, query_params) # combine query parameters to the URL
  }
  
  # avoid adding "www" in unnecessary cases (e.g. http://www.sites.google.com/view/gmfr)
  if( grepl("/", temp) ){ # check if url has slash(/)
    string_before_first_slash <- stringr::str_extract_all( temp, "^(.*?)(?=/)", simplify = TRUE) # extract string before the first '/'
  } else{
    string_before_first_slash <- temp
  }
  
  if ( strsplit(string_before_first_slash, split="\\.") %>% unlist %>% length() == 3 ){
    temp <- paste0("http://", temp)
  } else{
    temp <- paste0("http://www.", temp)
  }
  
  return( temp )
}

