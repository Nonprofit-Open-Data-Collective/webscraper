function( input.URL ){
  
  page <- Rcrawler::LinkExtractor(url = input.URL)
  
  return ( page$InternalLinks )
}