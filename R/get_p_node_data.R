#' @title
#' Create a data frame that contains texts inside p nodes in every internal websites in a given URL
#' @description
#'
#' @details
#' @param input.URL An URL for searching every p nodes in its interal links
#' @return A data frame
#' @export
#' @examples
#'
#' @importFrom magrittr %>%

get_p_node_data <- function( input.URL ){
  input.URL <- get_redirected_url( input.URL )
  internal.links <- Rcrawler::LinkExtractor(url = input.URL)$InternalLinks

  results.list <- NULL
  results.df <- NULL

  node.list <- NULL
  xpath.list <- NULL
  URL.list <- NULL
  domain.list <- NULL
  page.list <- NULL
  data.list <- NULL
  tag.list <- NULL

  for ( i in 1:length(internal.links) ){
    node.list[[i]] <- xml2::read_html(internal.links[i]) %>% xml2::xml_find_all('//*/p')
    xpath.list[[i]] <- node.list[[i]] %>% xml2::xml_path()
    data.list[[i]] <- node.list[[i]] %>% xml2::xml_text()

    URL.list[[i]] <- rep(internal.links[i], length(data.list[[i]]))
    domain.list[[i]] <- rep(input.URL, length(data.list[[i]]))
    page.list[[i]] <- rep(stringr::str_remove(internal.links[i], input.URL), length(data.list[[i]]))
    tag.list[[i]] <- rep("p", length(data.list[[i]]))

    results.list[[i]] <- dplyr::bind_cols(list(URL=URL.list[[i]], domain=domain.list[[i]], page=page.list[[i]], xpath=xpath.list[[i]], data=data.list[[i]], tag=tag.list[[i]]))
  }

  results.df <- dplyr::bind_rows( results.list )

  return(results.df)
}

