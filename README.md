# webscraper

R package to scrape content like mission statements and social media handles from nonprofit websites

* input website URL
* specify node types
* get tidy dataset with URL + node content 


## Use

Install: 

```r
devtools::install_github( "Nonprofit-Open-Data-Collective/webscraper" )
library( webscraper )
```

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

### Demo Get Nodes Function

```r
# example URL
url <- "HTTP://GMFD.ORG/GMFRA/GMFRAINDEX.HTM"
dat <- get_p_node_data( url )
head( as.data.frame( dat ) )
```



----------------------------------------------------
                        URL                         
----------------------------------------------------
 https://sites.google.com/view/gmfr/fire-department 

 https://sites.google.com/view/gmfr/fire-department 

 https://sites.google.com/view/gmfr/fire-department 

 https://sites.google.com/view/gmfr/fire-department 

 https://sites.google.com/view/gmfr/fire-department 

 https://sites.google.com/view/gmfr/fire-department 
----------------------------------------------------

Table: Table continues below

 
-------------------------------------------------------
               domain                       page       
------------------------------------ ------------------
 https://sites.google.com/view/gmfr   /fire-department 

 https://sites.google.com/view/gmfr   /fire-department 

 https://sites.google.com/view/gmfr   /fire-department 

 https://sites.google.com/view/gmfr   /fire-department 

 https://sites.google.com/view/gmfr   /fire-department 

 https://sites.google.com/view/gmfr   /fire-department 
-------------------------------------------------------

Table: Table continues below

 
-------------------------------------------------------------------------------------------------------------------
                                                       xpath                                                       
-------------------------------------------------------------------------------------------------------------------
 /html/body/div[1]/div/div[2]/div[2]/div[1]/section[2]/div[2]/div/div[1]/div/div/div[1]/div/div/div/div/a/div[1]/p 

 /html/body/div[1]/div/div[2]/div[2]/div[1]/section[2]/div[2]/div/div[1]/div/div/div[2]/div/div/div/div/a/div[1]/p 

 /html/body/div[1]/div/div[2]/div[2]/div[1]/section[2]/div[2]/div/div[2]/div/div/div[1]/div/div/div/div/a/div[1]/p 

 /html/body/div[1]/div/div[2]/div[2]/div[1]/section[2]/div[2]/div/div[2]/div/div/div[2]/div/div/div/div/a/div[1]/p 

 /html/body/div[1]/div/div[2]/div[2]/div[1]/section[2]/div[2]/div/div[3]/div/div/div[1]/div/div/div/div/a/div[1]/p 

 /html/body/div[1]/div/div[2]/div[2]/div[1]/section[2]/div[2]/div/div[3]/div/div/div[2]/div/div/div/div/a/div[1]/p 
-------------------------------------------------------------------------------------------------------------------

Table: Table continues below

 
------------------------------
          text            tag 
------------------------ -----
    CUSTOMER SURVEY        p  

 COMPLAINT / COMPLIMENT    p  

       EMPLOYMENT          p  

    BURNING PERMITS        p  

     CHIEF 8-1 BLOG        p  

    CHIEF'S REPORTS        p  
------------------------------






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
