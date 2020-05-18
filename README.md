# webscraper

R package to scrape content like mission statements and social media handles from nonprofit websites

* input website URL
* specify node types
* get tidy dataset with URL + node content 


## Usage

The package operates by doing the following:

1. User provides an org URL

   -- ( **create_table_01()** )  --

2. clean and parse  
  - save original version  ( **create_table_01()** )
  - create normalized version ("http://some-name.com")   ( **normalize_url()** )
  - create root url from normalized  ( **creat_root_url()** )
3. check URL status  ( **check_url_status()** ) --> error in RCurl::url.exists("WWW.BACASMAINE.ORG")
  - results: exists & active  --> load website (4)
  - exists & not responding  --> try root domain
  - does not exist  --> try root domain
4. identify active host URL 
  - if redirected, capture redirect 

----->  table 1 returned here 



5. load website 
  - catalog all internal links on the landing page for snowball sample
  - search for contact info (not yet implemented)
    - social media sites
    - social media handle
    - (email?)

----->  table 3 returned here  (not yet implemented)

7. build node list on current page
  - capture node data
  - creating node meta-data
8. drill down and repeat (how many levels?)
  - at completion return nodes table (table-02)
  
----->  table 2 returned here 




table-01 (create_table_01 function)
  - org name
  - org id (unique key)
  - **original_URL** - raw web domain reported by the org
  - **normalized_URL** 
  - **redirected_URL**
  - root_URL - root url of original url - http://www.pets.com  [ ROOT VERSION - normalize first, then parse lowest level ]
  - **active_URL** change tested_URL to active_URL - domain that works  
  - url_version - version of the URL that works: original, normalized, redirect, or root 
  - domain_status - change URL.Exists, HTTP.Status and valid to "domain_status": VALID, EXISTS (but http.status = F), DNE (does not exist)

Function try URLS in the following order:
1. original url
2. normalized url 
3. redirected url 
4. root url 



table-02  ( get_p_nodes function )
  - org name
  - org id (unique key)
  - date of data capture
  - "active" URL root
  - subdomain 
  - xpath
  - node type
  - attributes (html class, etc)
  - node text

table-03 (social media) - one-to-many (many accounts for one org)
  - org id
  - working url
  - subdomain 
  - social media type (twitter, linkedin, facebook)
  - ID - handle or account id
  
  




## Use

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


We use the following packages: 

```r
library( dplyr )     # data wrangling 
library( pander )    # document creation 
library( xml2 )      # xml manipulation 
library( RCurl )     # for url.exists
library( httr )      # for http_error
library( stringr )   # for str_extract
library( rvest )     # web scraping in R 
```




### Sample Org Dataset

For a small sample try: 

```r
load_test_urls()
head( sample.urls )

URLs <- sample.urls$ORGURL

create_table_01( URLs[1] )

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
