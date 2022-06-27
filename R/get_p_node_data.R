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
#' get_p_node_data( input.URL )
#' @importFrom magrittr %>%

get_p_node_data <- function( input.URL ){
  redirected.URL <- get_redirected_url( input.URL )
  internal.links <- Rcrawler::LinkExtractor(url = redirected.URL)$InternalLinks

  results.list <- NULL
  results.df <- NULL

  input.URL.list <-NULL
  node.list <- NULL
  xpath.list <- NULL
  URL.list <- NULL
  domain.list <- NULL
  page.list <- NULL
  text.list <- NULL
  tag.list <- NULL

  for ( i in 1:length(internal.links) ){
    node.list[[i]] <- xml2::read_html(internal.links[i]) %>% xml2::xml_find_all('//*/p')
    xpath.list[[i]] <- node.list[[i]] %>% xml2::xml_path()
    text.list[[i]] <- node.list[[i]] %>% xml2::xml_text()

    input.URL.list[[i]] <- rep(input.URL, length(text.list[[i]]))
    URL.list[[i]] <- rep(internal.links[i], length(text.list[[i]]))
    domain.list[[i]] <- rep(redirected.URL, length(text.list[[i]]))
    page.list[[i]] <- rep(stringr::str_remove(internal.links[i], redirected.URL), length(text.list[[i]]))
    tag.list[[i]] <- rep("p", length(text.list[[i]]))

    results.list[[i]] <- dplyr::bind_cols(list(input.URL=input.URL.list[[i]], redirected.URL=domain.list[[i]], URL=URL.list[[i]], page=page.list[[i]], xpath=xpath.list[[i]], text=text.list[[i]], tag=tag.list[[i]]))
  }

  results.df <- dplyr::bind_rows( results.list )

  return( as.data.frame(results.df) )
}

