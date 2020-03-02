get_p_node_data <- function( input.URL ){
  internal.links <- get_internal_links( input.URL )
  
  results.list <- NULL
  results.df <- NULL
  
  URL.list <- NULL
  domain.list <- NULL
  page.list <- NULL
  data.list <- NULL
  tag.list <- NULL

  for ( i in 1:length(internal.links) ){
    data.list[[i]] <- ContentScraper(Url= internal.links[i], XpathPatterns = "//*/p", ManyPerPattern = T)[[1]]
    data.list[[i]] <- data.list[[i]][data.list[[i]] != ""] #remove all empty elements
    
    URL.list[[i]] <- rep(internal.links[i], length(data.list[[i]]))
    domain.list[[i]] <- rep(input.URL, length(data.list[[i]]))
    page.list[[i]] <- rep(stringr::str_remove(internal.links[i], input.URL), length(data.list[[i]]))
    tag.list[[i]] <- rep("p", length(data.list[[i]]))
    
    results.list[[i]] <- dplyr::bind_cols(list(URL=URL.list[[i]], domain=domain.list[[i]], page=page.list[[i]], data=data.list[[i]], tag=tag.list[[i]]))
  }
  
  results.df <- dplyr::bind_rows( results.list )
  
  return(results.df)
}

