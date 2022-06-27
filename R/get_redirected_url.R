#' @title
#' Get a redirected URL from an input URL
#' @description
#' This function returns a redirected URL. If the website of input URL is contained within a frame,
#' it extract the URL embedded within the frame and use that URL as the redirect value.
#' @param input.URL An URL
#' @return An URL redirected
#' @export
#' @examples
#' input.URL <- "HTTP://GMFD.ORG/GMFRA/GMFRAINDEX.HTM"
#' get_redirected_url( input.URL )

get_redirected_url <- function( input.URL ){
        # Add a check if the URL value redirects. If so, that redirected portion is what needs to be pasted to the front of the outgoing link
        http_status_code <- httr::GET( input.URL )$all_headers[[1]]$status
        is_redirected <- as.integer( http_status_code/100 ) == 3

        if( is_redirected ){
                URL.redirect <- normalize_url( httr::GET( input.URL )[ 1 ] )

                html_page <- xml2::read_html( URL.redirect )
                # See if the website is contained within a frame. If so, extract the URL embedded within the frame
                # Use that URL as the redirect value
                html_page %>%
                        rvest::html_nodes( "frame") %>%
                        rvest::html_attr( "src" ) -> frame.links

                # Include some sort of check; if frame.links != length( 0 ), then should use that URL
                if( length( frame.links ) != 0 ){
                        # Definitely have it overwrite the html_page, need to wrap in read_html()
                        html_page <- read_html( frame.links[ !is.na( frame.links ) ] )
                        # Have this overwrite the redirected value
                        return( normalize_url( httr::GET( frame.links[ !is.na( frame.links ) ] )[1] ) )
                }
                else{
                        return( URL.redirect )
                }
        } else{
                return( NA )
        }
}
