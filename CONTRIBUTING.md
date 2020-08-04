
# Setting up a new module

### Folders

## Notebook set up

### Rmd Header

```
---
title: "Name of the analysis - Microarray/RNA-seq/Advanced"
author: "CCDL for ALSF"
output:   
  html_notebook:
    toc: true
    toc_float: true
---
```
### Analysis Getting Started Template
Each analysis notebook has its own getting started section before getting to the code.

### Chunk naming

Chunks shouldn't be named?

### Section formatting

Sections shouldn't be numbered?

## Formatting of typical words/items:
    - Use "refine.bio", NOT "refinebio"
    - Use `.Rmd`,  NOT "Rmd" or ".Rmd"

## Citations


### Links

- Links to other notebooks should always go to the online version of the book.
- Links to sections within the notebook can be used as usual (e.g. `#how-to-use-data`)

## How to spell check

In RStudio, go to `Edit` > `Check Spelling`.

## Code Style

These analyses follow the [Google R Style Guide](http://web.stanford.edu/class/cs109l/unrestricted/resources/google-style.html) which is based on the Tidyverse style guide.

Using the [r-lib/styler package](https://github.com/r-lib/styler) can help you automatically fix a lot of the spacing and formatting issues.
You can use the `styler::style_file("name-of-notebook.Rmd")` function to do this all at once for a notebook.
