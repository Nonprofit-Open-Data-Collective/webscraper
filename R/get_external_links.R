function( input.URL ){
  
  page <- Rcrawler::LinkExtractor(url = input.URL, ExternalLInks = TRUE)
  
  return ( page$ExternalLinks )
}