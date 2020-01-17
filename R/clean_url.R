## To clean the URLs for the purpose of intial downloads
## Ensures that every url starts with the same kind of header
clean_url <- function( name ){
  temp <- tolower( name )
  for( i in 1:length( temp ) ){
    if( grepl( "^http:/{2}", temp [ i ] ) == T ){
      temp[ i ] <- sub( "^http:/{2}", "", temp[ i ] ) # removes "http://"
      if( grepl( "^www\\.*", temp[ i ] ) == TRUE ){ 
        temp[ i ] <- paste0( "http://", temp[ i ] ) 
      } else {
        temp[ i ] <- paste0( "http://www.", temp[ i ] ) 
      }
    } else if( grepl( "^https:/{2}", temp [ i ] ) == T ){
      temp[ i ] <- sub( "^https:/{2}", "", temp[ i ] ) # removes "https://"
      if( grepl( "^www\\.*", temp[ i ] ) == TRUE ){ 
        temp[ i ] <- paste0( "https://", temp[ i ] ) 
      } else {
        temp[ i ] <- paste0( "https://www.", temp[ i ] ) 
      }
    } else if( grepl( "^https?:/{2}", temp [ i ] ) != T ) {
      temp[ i ] <- paste0( "http://", temp[ i ] ) 
    }
  }
  temp <- gsub( "/$", "", temp ) # Remove trailing "/", important for initial URL generation
  return( temp )
}

## To clean the names of URLs for the purpose of saving mirrors
cleanName <- function( name ){
  temp <- sub( "^https?:/{2}", "", name ) # removes "http://" and "https://"
  temp <- sub( "^.*w{3}\\.", "", temp ) # removes "www."
  temp <- gsub( "/$", "", temp ) # removes any "/" at the end
  temp <- gsub( " ", "", temp ) # removes any " "
  temp <- gsub( "\\?|:", "", temp ) # removes any "\" or ":"
  temp <- gsub( "/", "_._", temp  ) # converts any "/" within the address to a representative string, "_._"
  return( temp )
}

## To clean the URLs for the purpose of comparing and removing duplicates
cleanURLtoCompare <- function( name ){
  temp <- gsub( " ", "", name ) # removes any " "
  temp <- gsub( "\\>/{2}", "/", temp ) # converts any instances of "//" to "/" after the http(s):// head text
  temp <- gsub( "/$", "", temp ) # removes any "/" at the end
  return( temp )
}