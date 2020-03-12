# Folder Content

## files

Each .R file consists of one function of the same name, and the Roxygen2 documentation. 

For example, the file **get_nodes.R** contains the function _**get_nodes()**_.

## documentation

When building the R package, the documentation is generated from the Roxygen2 comments included in each file. Minimally they should have: 

```r
#' @title
#' @description
#' @details
#' @param 
#' @return 
#' @examples
#' @export
function_name <- function( )
{
  # some code
}
```


## examples

If you would like to see examples of what documented functions looks like, the **dplyr** package repo is located here:

https://github.com/cran/dplyr/tree/master/R



## utility functions

There are some functions created for internal use inside of a package, but not exported to the user and thus not accessible when the package is loaded. 

For example, if you have one long function that you want to break into steps for testing, so you split the code into several smaller functions that help with efficiency and maintenance. The user might not ever need one of these subfunctions, but they are necesarry for the function they do use.

In this package, steps like **clean_url()** are utility functions. 

You may or may not document these functions, and if you do you will not export them: 

```r
### do NOT include the @export

#' @export
function_name <- function( )
{
  # some code
}
```

**Store all of these functions in the >>  utils.R  << file.**

You can also load specific functions or operators in this file so they are available inside of package functions, and also export them so they are available once your package is loaded. For example, the pipe operator is loaded by: 

```r
#' @importFrom magrittr %>%
```

To load and export: 

```r
#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`
```

Though it is recommended to NOT use pipe operators inside of package functions because is slows down code significantly: 

https://stackoverflow.com/questions/27947344/r-use-magrittr-pipe-operator-in-self-written-package

https://cran.r-project.org/doc/manuals/r-release/R-exts.html

