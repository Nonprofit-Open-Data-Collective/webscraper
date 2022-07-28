#' @title
#' Create a data frame of cleaned URLs
#' @description
#' Creates a data frame from a vector of inputted URLs that provides the cleaned, root, and redirected versions of the inputted URLs
#' @param input String or vector of URLs. Must have a length greater than 1.
#' @export


## Currently Getting errors with issues in curl fetch

create_table <- function( input ){

  if( length( input ) < 1 ){

    stop( "Must Input at Least 1 URL" )

  }

  if( length( input )== 1 ){

    URL.frame <- get_url_formats( input )

  }else{

    URL.frame <- data.frame()

    for( i in 1:length( input ) ){
      URL.table <- get_url_formats( input[i] )
      URL.frame <- rbind( URL.frame, URL.table )
    }

  }

  return(URL.frame)
}


