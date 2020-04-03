normalize_url <- function( input.URL ){
  temp <- tolower( input.URL )
  
  has_http_or_https <- grepl( "^https?:/{2}", temp )
  has_www <- grepl( "www\\.*" , temp)
    
  if( has_http_or_https & has_www ){
    temp <- paste0( "http://", temp ) 
  }
    
  if( has_http_or_https & !has_www){
    temp <- sub( "^https?:/{2}", "http://www.", temp )
  }
  
  if( !has_http_or_https & has_www){
    temp <- paste0( "http://", temp )
  }
  
  if( !has_http_or_https & !has_www){
    temp <- paste0( "http://www.", temp )
  }
  
  temp <- gsub( "/$", "", temp ) # removes any "/" at the end
  
  return( temp )
}