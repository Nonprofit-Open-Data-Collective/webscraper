#' @title
#' Get all links on a scraped HTML page
#' @param input.URL Normalized URL that can be scraped.
#' @return Vector of all URLs listed on the inputted webpage
#' @export

get_links <- function( input.URL ){
    html_page <- xml2::read_html( input.URL )

    sample.links <- html_page %>%  # read in the site as an HTML file
      rvest::html_nodes( "a" ) %>% # return all nodes with links in them
      rvest::html_attr( "href" ) # pulls out hypertext reference, links to other pages



    # If there are no sample links pulled from the website, skip.
    if( length( sample.links ) == 0 ){
      return ( "No links scraped" )
    }else{
      sample.links <- sample.links[ grep( "http", sample.links ) ] # Only links, all else is filtered
      return( sample.links )
    }
}

