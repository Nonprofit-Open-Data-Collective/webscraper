# webscraper

R package to scrape content like mission statements and social media handles from nonprofit websites

* input website URL
* specify node types
* get tidy dataset with URL + node content 


The package operates by doing the following:

1. User selects an org URL. 
2. clean and parse
3. test site


...

8. return tidy format 





## Use


Useful packages: 

```r
library( dplyr )     # data wrangling 
library( pander )    # document creation 
library( xml2 )      # xml manipulation 
library( RCurl )     # for url.exists
library( httr )      # for http_error
library( stringr )   # for str_extract
library( rvest )     # web scraping in R 
```


Install: 

```r
devtools::install_github( "Nonprofit-Open-Data-Collective/webscraper" )
library( webscraper )
```



### Demo Get Nodes Function

```r
# example URL
url <- "HTTP://GMFD.ORG/GMFRA/GMFRAINDEX.HTM"
dat <- get_p_node_data( url )
head( as.data.frame( dat ) )
```





### Sample Org Dataset

```r
load_test_urls()
head( sample.urls )

sample.urls$clean.urls <- cleanURLtoDownload( sample.urls$ORGURL )
sample.urls$ORGNAME <- gsub( " $", "", sample.urls$ORGNAME ) # remove any trailing spaces

# Using the URLs column from the input file
URL.values <- sample.urls$clean.urls

compiled.URLs <- c() #object used to collect every URL compiled throughout the process, the full list for each provided site.

URL.redirect <- c()
input.URL <- c() #holds the URLs provided at the start of each iteration, before any cropping
  
head( URL.values )
```


<br>
<br>

----

<br>
<br>


## Project Management 

### [:ballot_box_with_check: KanBan Board](https://github.com/Nonprofit-Open-Data-Collective/webscraper/projects/1) 

**Includes Task Lists**

- [x] Task 01
- [ ] Task 02
- [ ] Task 03

https://help.github.com/en/github/managing-your-work-on-github/about-task-lists



## Package Build Steps



(1) Install tools:

```r
install.packages(c("devtools", "roxygen2", "testthat", "knitr"))
# if devtools is not working try
# devtools::build_github_devtools() 
```

(2) Create package skeleton:

```r
# has been deprecated - needs update
library(devtools)
has_devel()
# setwd()
devtools::create( "pe" )
```

(3) Document: 

Complete roxygen comments in R files for functions, then:

```r
setwd( "pe" )
document()
```

(4) Install:

```r
setwd( ".." )
devtools::install( "pe" )
```

```r
devtools::install_github( "Nonprofit-Open-Data-Collective/webscraper" )
```
