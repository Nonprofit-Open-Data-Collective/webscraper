#' @title
#' Create a data frame that contains information about p nodes in every internal links in a given URL
#' @description
#' First, this function finds redirected url from a given url. This redirected url is used for
#' subsequent parts of this function. It makes a list of internal links using LinkExtractor function
#' in Rcrawler package. Then, information related to every p nodes in each internal link is scraped and
#' combined in a data frame. This information include xpath, text, url, domain, and tag.
#' @details
#' @param input.URL An URL for searching every p nodes in its interal links
#' @return A data frame
#' @export
#' @examples
#' input.URL <- "HTTP://GMFD.ORG/GMFRA/GMFRAINDEX.HTM"
#' get_p_node_data( input.URL )

check_url_status <- function( input.URL ){
        
  result <- data.frame(matrix(ncol=5,nrow=1,dimnames=list(NULL,
                        c("URL","Type","URL.Exists","HTTP.Status","Valid"))))

  result[["URL"]] <- input.URL #store the url being checked
  result[["Type"]] <- "raw"
  result[["URL.Exists"]] <- RCurl::url.exists( result[["URL"]] ) 
  result[["HTTP.Status"]] <- tryCatch( httr::http_status( httr::GET( result[["URL"]] ) )[[1]] , 
              error = function( e ){ NA } )
  result[["Valid"]] <- result[["URL.Exists"]] && (result[["HTTP.Status"]] == "Success")

  URL.cropped <- stringr::str_extract( result[["URL"]], "^https?://[[:alpha:]]*\\.[[:alpha:]]*\\.[[:alpha:]]*" )
  
  if( result [["Valid"]] == FALSE && URL.cropped != result[["URL"]] ){
          result_cropped <- data.frame(matrix(ncol=5,nrow=1,dimnames=list(NULL,
                        c("URL","Type","URL.Exists","HTTP.Status","Valid"))))
          
          result_cropped[["URL"]] <- URL.cropped #store the url being checked
          result_cropped[["Type"]] <- "cropped"
          result_cropped[["URL.Exists"]] <- if( url.exists( result_cropped[["URL"]] ) ) 
          result_cropped[["HTTP.Status"]] <- tryCatch( http_status( GET( result_cropped[["URL"]] ) )[[1]] , 
              error = function( e ){ NA } )
          result_cropped[["Valid"]] <- result_cropped[["URL.Exists"]] && (result_cropped[["HTTP.Status"]] == "Success")
          
          result <- rbind(result, result_cropped)
  }
  
  return( result )
}
