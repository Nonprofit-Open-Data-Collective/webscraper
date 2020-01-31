getNodes <- function( input.URL ){
    html_page <- xml2::read_html( input.URL )
    
    ## Extract the URL portion after the primary domain, for comparisons within the loop
    URL.tail <- gsub( "^https?:/{2}([[:alnum:]\\.]*/)", "", input.URL  )
    
    
    html_page %>%  # read in the site as an HTML file
      rvest::html_nodes( "a" ) %>% # return all nodes with links in them
      rvest::html_attr( "href" ) -> sample.links # pulls out hypertext reference, links to other pages
    
    
    # If there are no sample links pulled from the website, skip.
    if( length( sample.links ) == 0 ){ 
      return ( "No links scraped" )
    } 
}

