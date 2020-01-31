get_primary_url <- function ( sample.link, URL.redirect ){
  
  ## Then test that against the sample link, and extract the common text
  string.shared <- stringr::str_match( sample.link, URL.tail )
  
  ## Drop that from the URL portion after the primary domain
  URL.redirect.print <- sub( string.shared, "", URL.redirect )
  
  ## If there is no tail, then just use the redirected URL as is 
  if( URL.tail == URL.redirect ){ URL.redirect.print <- URL.redirect }
  
  
  ## Paste the modified URL and the sample link, if needed
  
  if( grepl( "^https?:/{2}", sample.link ) == T ){  # If it starts with http:// or https://, just capture that
    
    primary.URL <- sample.links
    
  } else if( grepl( "^/{1}", sample.link ) == T ) { # If it only starts with /, then capture
    
    proper.link <- paste0( URL.redirect.print, sample.link ) #string already starts with "/"
    primary.URL <- cleanURLtoCompare( proper.link ) #removes extra "/" from the string
    
  } else if( grepl( "^(?!mail).*[[:alpha:]]", sample.link, perl = T ) == T ){
    
    # pattern adapted from: https://stackoverflow.com/questions/2078915/a-regular-expression-to-exclude-a-word-string
    ## Response from Alix Axel, answered Jan 16 2010.
    # Corrected with https://stackoverflow.com/questions/27986361/regular-expression-excluding-word-in-r
    ## Response from hwnd, answered January 16 2015
    # Should catch any links that start with letters but don't start with mailto, i.e., email hyperlinks
    proper.link <- paste0( URL.redirect.print, "/", sample.link ) # start of string is missing "/", not an email hyperlink
    primary.URL <- cleanURLtoCompare( proper.link ) #removes extra "/" from the string
  }
  
  if( length( primary.URLs ) != 0 ){
    if( grepl( "^NA", primary.URL ) ){ primary.URL <- NA } # for situations where URL redirect test creates NA at start of string
  }
  
  return ( primary.URL )
}
