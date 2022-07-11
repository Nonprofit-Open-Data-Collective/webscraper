#' @title
#' Get HTML notes from an inputted URL
#' @export

getNodes <- function( input.URL ){
    html_page <- xml2::read_html( input.URL )

    html_page %>%  # read in the site as an HTML file
      rvest::html_nodes( "a" ) %>% # return all nodes with links in them
      rvest::html_attr( "href" ) -> sample.links # pulls out hypertext reference, links to other pages


    # If there are no sample links pulled from the website, skip.
    if( length( sample.links ) == 0 ){
      return ( "No links scraped" )
    }
}

