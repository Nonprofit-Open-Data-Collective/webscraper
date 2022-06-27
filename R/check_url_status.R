#' @title
#' Create a data frame that contains information about p nodes in every internal links in a given URL
#' @description
#' First, this function finds redirected url from a given url. This redirected url is used for
#' subsequent parts of this function. It makes a list of internal links using LinkExtractor function
#' in Rcrawler package. Then, information related to every p nodes in each internal link is scraped and
#' combined in a data frame. This information include xpath, text, url, domain, and tag.
#' @param input.URL An URL for searching every p nodes in its interal links
#' @return A data frame
#' @export
#' @examples
#' input.URL <- "HTTP://GMFD.ORG/GMFRA/GMFRAINDEX.HTM"
#' check_url_status( input.URL )

check_url_status <- function( input.URL ){
  result <- data.frame(matrix(ncol=5,nrow=1,dimnames=list(NULL,
                        c("tested_URL","cropped","URL.Exists","HTTP.Status","valid"))))

  result[["tested_URL"]] <- input.URL
  result[["cropped"]] <- FALSE
  result[["URL.Exists"]] <- RCurl::url.exists( result[["tested_URL"]] )
  result[["HTTP.Status"]] <- tryCatch( httr::http_status( httr::GET( result[["tested_URL"]] ) )[[1]] ,
              error = function( e ){ NA } )
  result[["valid"]] <- result[["URL.Exists"]] && (result[["HTTP.Status"]] == "Success")

  root_URL <- create_root_url( input.URL )

  if( result [["valid"]] == FALSE && root_URL != result[["tested_URL"]] ){
          result_root <- data.frame(matrix(ncol=5,nrow=1,dimnames=list(NULL,
                        c("tested_URL","cropped","URL.Exists","HTTP.Status","valid"))))

          result_root[["tested_URL"]] <- URL.cropped #store the url being checked
          result_root[["cropped"]] <- TRUE
          result_root[["URL.Exists"]] <- RCurl::url.exists( result_root[["tested_URL"]] )
          result_root[["HTTP.Status"]] <- tryCatch( httr::http_status( httr::GET( result_root[["tested_URL"]] ) )[[1]] ,
              error = function( e ){ NA } )
          result_root[["valid"]] <- result_root[["URL.Exists"]] && (result_root[["HTTP.Status"]] == "Success")

          result <- rbind(result, result_root)
  }

  return( result )
}
