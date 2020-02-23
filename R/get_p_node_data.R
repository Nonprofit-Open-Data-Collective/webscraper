function( input.URL ){
  internal.links <- get_internal_links( input.URL )
  
  results.list <- NULL
  
  URL.list <- NULL
  domain.list <- NULL
  page.list <- NULL
  data.list <- NULL
  tag.list <- NULL

  for ( i in 1:length(internal.links) ){
    data.list[[i]] <- ContentScraper(Url= internal.links[i], XpathPatterns = "//*/p", ManyPerPattern = T)[[1]]
    data.list[[i]] <- data.list[[i]][data.list[[i]] != ""] #remove all empty elements
    
    URL.list[[i]] <- internal.links[i]
    domain.list[[i]] <- input.URL
    page.list[[i]] <- stringr::str_remove(internal.links[i], input.URL)
    tag.list[[i]] <- "p"
  }
  
  results.df <- dplyr::bind_cols( URL.list, domain.list, page.list, data.list, tag.list )

}


