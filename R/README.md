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



## document the package in help files

[From Building R Packages](http://r-pkgs.had.co.nz/man.html#man-packages)


You can use roxygen to provide a help page for your package as a whole. This is accessed with package?foo, and can be used to describe the most important components of your package. It’s a useful supplement to vignettes, as described in the next chapter.

There’s no object that corresponds to a package, so you need to document NULL, and then manually label it with @docType package and @name <package-name>. This is also an excellent place to use the @section tag to divide up page into useful categories.
  
In the <package-name>.R file:

```r
#' foo: A package for computating the notorious bar statistic.
#'
#' The foo package provides three categories of important functions:
#' foo, bar and baz.
#' 
#' @section Foo functions:
#' The foo functions ...
#'
#' @docType package
#' @name foo
NULL
```

It’s also a good place to put the package level import statements that you’ll learn about in imports.

[EXAMPLE from DPLYR](https://github.com/cran/dplyr/blob/master/R/dplyr.r)

See [PAGE 4](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) for rendered version. 

## importing packages and functions

[From Building R Packages](http://r-pkgs.had.co.nz/namespace.html#imports)

### Imports

NAMESPACE also controls which external functions can be used by your package without having to use ::.

It’s confusing that both DESCRIPTION (through the Imports field) and NAMESPACE (through import directives) seem to be involved in imports. This is just an unfortunate choice of names. The Imports field really has nothing to do with functions imported into the namespace: it just makes sure the package is installed when your package is. It doesn’t make functions available. You need to import functions in exactly the same way regardless of whether or not the package is attached.

Depends is just a convenience for the user: if your package is attached, it also attaches all packages listed in Depends. If your package is loaded, packages in Depends are loaded, but not attached, so you need to qualify function names with :: or specifically import them.

It’s common for packages to be listed in Imports in DESCRIPTION, but not in NAMESPACE. In fact, this is what I recommend: list the package in DESCRIPTION so that it’s installed, then always refer to it explicitly with pkg::fun(). Unless there is a strong reason not to, it’s better to be explicit. It’s a little more work to write, but a lot easier to read when you come back to the code in the future. The converse is not true. Every package mentioned in NAMESPACE must also be present in the Imports or Depends fields.

### R functions

If you are using just a few functions from another package, my recommendation is to note the package name in the Imports: field of the DESCRIPTION file and call the function(s) explicitly using ::, e.g., pkg::fun(). Operators can also be imported in a similar manner, e.g., @importFrom magrittr %>%.

If you are using functions repeatedly, you can avoid :: by importing the function with @importFrom pkg fun. This also has a small performance benefit, because :: adds approximately 5 µs to function evaluation time.

Alternatively, if you are repeatedly using many functions from another package, you can import all of them using @import package. This is the least recommended solution because it makes your code harder to read (you can’t tell where a function is coming from), and if you @import many packages, it increases the chance of conflicting function names.
