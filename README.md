# webscraper

R package to scrape content like mission statements and social media handles from nonprofit websites

* input website URL
* specify node types
* get tidy dataset with URL + node content 


## Usage

Install: 

```r
devtools::install_github( "Nonprofit-Open-Data-Collective/webscraper" )
library( webscraper )
```

### Demo Get Nodes Function

```r
url <- "https://www.mainewelfaredirectors.org"
dat <- get_p_node_data( url )
head( dat ) %>% pander(style="grid")
```


```
+-----+--------------------------------+
| tag |              text              |
+=====+================================+
|  p  | General Assistance | Referral  |
|     |           | Advocacy           |
+-----+--------------------------------+
|  p  |     Establish and promote      |
|     |    equitable, efficient and    |
|     | standardized administration of |
|     |      General Assistance.       |
+-----+--------------------------------+
|  p  |   Encourage the professional   |
|     |    development, growth, and    |
|     |  knowledge base of those who   |
|     | administer General Assistance. |
+-----+--------------------------------+
|  p  |        Advocate for the        |
|     |  municipalities and citizens   |
|     |         that we serve.         |
+-----+--------------------------------+
|  p  |  Actively promote and present  |
|     |    our program needs to the    |
|     |  Legislature and citizens by   |
|     |   creating a greater public    |
|     |  awareness of the importance   |
|     | and the benefits of equitable, |
|     |   efficient and standardized   |
|     |       General Assistance       |
|     |        administration.         |
+-----+--------------------------------+
|  p  | Click here to download current |
|     |          MWDA Bylaws           |
+-----+--------------------------------+

+--------------------------------------------------+-------------+
|                       URL                        |    page     |
+==================================================+=============+
| http://mainewelfaredirectors.org/association.htm | association |
+--------------------------------------------------+-------------+
| http://mainewelfaredirectors.org/association.htm | association |
+--------------------------------------------------+-------------+
| http://mainewelfaredirectors.org/association.htm | association |
+--------------------------------------------------+-------------+
| http://mainewelfaredirectors.org/association.htm | association |
+--------------------------------------------------+-------------+
| http://mainewelfaredirectors.org/association.htm | association |
+--------------------------------------------------+-------------+
| http://mainewelfaredirectors.org/association.htm | association |
+--------------------------------------------------+-------------

+-----------------------------------------------------------+
|                           xpath                           |
+===========================================================+
|                /html/body/table/tr[2]/td/p                |
+-----------------------------------------------------------+
| /html/body/table/tr[3]/td[2]/strong/blockquote/ul/li[1]/p |
+-----------------------------------------------------------+
| /html/body/table/tr[3]/td[2]/strong/blockquote/ul/li[2]/p |
+-----------------------------------------------------------+
| /html/body/table/tr[3]/td[2]/strong/blockquote/ul/li[3]/p |
+-----------------------------------------------------------+
| /html/body/table/tr[3]/td[2]/strong/blockquote/ul/li[4]/p |
+-----------------------------------------------------------+
|    /html/body/table/tr[3]/td[2]/strong/blockquote/p[1]    |
+-----------------------------------------------------------+

```

### Sample Org Dataset

To collect multiple at a time:  

```r
load_test_urls()
head( sample.urls )
urls <- sample.urls$ORGURL
results.list <- lapply( urls, get_p_node_data )
d <- dplyr::bind_rows( results.list )
```

### Process Overview

The package collects data following this process: 

```
1. user provides a URL
2. normalize the URL   
  - save original URL 
  - create normalized version ("http://some-name.com")  >> normalize_url()
  - create root url from normalized  >> creat_root_url()
3. check URL status >> check_url_status() 
  - results: exists & active  --> load website (4)
  - exists & not responding   --> try root domain
  - does not exist            --> try root domain
4. visit page if URL is active 
  - if redirected, capture redirect 

----->  table 1 captures URL status

5. load website 
  - catalog all internal links on the landing page for snowball sample
  - search for contact info (not yet implemented)
    - social media sites
    - social media handles
    - email?

----->  table 2 captures links and handles

7. build node list on current page
  - capture data for specified node types
  - capture node meta-data (page position, tag attributes) for context
8. drill down and repeat for one level of links
  - at completion return nodes table
  
----->  table 3 contains page content atomized by tags
```


Functions should return the following tables: 

```
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

table-03  ( get_p_nodes function )
  - org name
  - org id (unique key)
  - date of data capture
  - "active" URL root
  - subdomain 
  - xpath
  - node type
  - attributes (html class, id, etc)
  - node text

table-02 (social media) - one-to-many (many accounts for one org)
  - org id
  - working url
  - subdomain 
  - social media type (twitter, linkedin, facebook)
  - ID - handle or account id
```
  

A typical workflow might start by processing all raw URLs in a list to generate table-01, which would report active versus dead or misspelled domains. 

Table-01 could then serve as the sample frame for subsequent steps. 

The user would specify things like site depth to probe (level 0 is the domain landing page, level 1 is all links on the landing page, level 2 is all new links on level 1 pages, etc.), and the types of nodes to collect (typically things like p=paragraphs, ul=lists, th/td=tables). 






### Dependencies 

**webscraper** utilizes the following dependencies: 

```r
library( dplyr )     # data wrangling 
library( pander )    # document creation 
library( xml2 )      # xml manipulation 
library( RCurl )     # for url.exists
library( httr )      # for http_error
library( stringr )   # for str_extract
library( rvest )     # web scraping in R 
```






<br>
<br>

----

<br>
<br>


## Project Management for Package Dev 


### Before Syncing New Code to GitHub

```r
# update documentation
setwd( "webscraper" )
devtools::document()
# update code
setwd( ".." )
devtools::install( "webscraper" )
```

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
