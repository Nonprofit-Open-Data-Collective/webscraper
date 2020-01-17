# webscraper
R package to scrape content like mission statements and social media handles from nonprofit websites


Package build steps: 

(1) Install tools:

```r
install.packages(c("devtools", "roxygen2", "testthat", "knitr"))
# if devtools is not working try
# devtools::build_github_devtools() 
```

Create package skeleton:

```r
# has been deprecated - needs update
library(devtools)
has_devel()
# setwd()
devtools::create( "pe" )
```

Document: 

Complete roxygen comments in R files for functions, then:

```r
setwd( "pe" )
document()
```

Install:

```r
setwd( ".." )
devtools::install( "pe" )
```

```r
devtools::install_github( "Nonprofit-Open-Data-Collective/webscraper" )
```
