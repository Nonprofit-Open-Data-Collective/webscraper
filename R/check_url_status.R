check_url_status <- function( input.URL ){
        
  result <- data.frame(matrix(ncol=5,nrow=1,dimnames=list(NULL,
                        c("URL","Type","URL.Exists","HTTP.Status","Valid"))))

  result[["URL"]] <- input.URL #store the url being checked
  result[["Type"]] <- "raw"
  result[["URL.Exists"]] <- url.exists( result[["URL"]] ) 
  result[["HTTP.Status"]] <- tryCatch( http_status( GET( result[["URL"]] ) )[[1]] , 
              error = function( e ){ NA } )
  result[["Valid"]] <- result[["URL.Exists"]] && (result[["HTTP.Status"]] == "Success")

  URL.cropped <- str_extract( result[["URL"]], "^https?://w{3}\\.[[:alpha:]]*\\.[[:alpha:]]*" )
  
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