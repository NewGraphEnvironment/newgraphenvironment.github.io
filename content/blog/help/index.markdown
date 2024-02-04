---
title: "Helping the help."
subtitle: "And helping myself in the process"
excerpt: ""
date: 2024-02-03
author: "Allan Irvine"
draft: false
images:
series:
tags:
categories:
layout: single
---




Recieved a question about what this function was doing? Made me realize getting help is a skill so started this reprex
to try to demonstrate some techniques for self-directed help. Ended up _teaching_ myself a whole bunch.


<br>

Below is the function in question:

    # automatically create a bib database for R packages
    knitr::write_bib(c(
      .packages(), 'bookdown', 'knitr', 'rmarkdown'
    ), 'packages.bib')


As the comment from the bookdown template indicates - this chunk does indeed automatically "create" a bib database for 
R packages. To understand how - you can review the help and (output for .packages()) for the functions it calls like so:

    ?.packages
    ?knitr::write_bib
    
    
Results of functions do not always print to the console so to see the results of `.packages()` you either need use the 
function `print()` or assign it to an object. You can see why this is happening with this function by seeing the actual 
code used to write the function by typeing `.packages` into the console. 


```r
.packages
```

```
## function (all.available = FALSE, lib.loc = NULL) 
## {
##     if (is.null(lib.loc)) 
##         lib.loc <- .libPaths()
##     if (all.available) {
##         ans <- character()
##         for (lib in lib.loc[file.exists(lib.loc)]) {
##             a <- list.files(lib, all.files = FALSE, full.names = FALSE)
##             pfile <- file.path(lib, a, "Meta", "package.rds")
##             ans <- c(ans, a[file.exists(pfile)])
##         }
##         return(unique(ans))
##     }
##     s <- search()
##     invisible(.rmpkg(s[startsWith(s, "package:")]))
## }
## <bytecode: 0x127eea608>
## <environment: namespace:base>
```

Looks like the `.packages` function wraps the `invisible` function!  To understand what that function is all about
we can look at the help with

    ?invisible
    
And look at the raw code that makes the function



```r
invisible
```

```
## function (x = NULL)  .Primitive("invisible")
```

`.Primitive` - what the heck

Check out the help!

    ?.Primitive


```r
.Primitive
```

```
## function (name)  .Primitive(".Primitive")
```

Name. Good grief

    ?name
    

```r
#can't build the .Rmd file because of an error if we run
#name
```

Wow.  A lot to unpack here and lots I don't understand but I think that it is just this sort of tracking down of clues
that will lead to conceptual break throughs that will elevate my game.  

<br>
  
To see how to create a reprex Rmarkdown document like this type the following (or something similiar) into google 

    "how do you do a reprex for an rmarkdown doc?"


brings up this link: https://reprex.tidyverse.org/articles/reprex.html
