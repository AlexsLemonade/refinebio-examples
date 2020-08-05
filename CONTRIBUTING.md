
# Setting up a new module

## Notebook set up

### Rmd Header

```
---
title: "Name of the analysis - Microarray/RNA-seq/Advanced"
author: "CCDL for ALSF"
date:"`r format(Sys.time(), '%B, %Y')`"
output:   
  html_notebook:
    toc: true
    toc_float: true
    number_sections: true
bibliography: ../../references.bib  
---
```
**Inputs:**
- refine.bio download files.
- Any additional reference files should be downloaded in the notebook.

**Outputs**
- A `plots` and/or `results` folder should be created by the analysis notebook
- Output results should be `TSV` when possible.
- Plots should be saved to `PNG` whenever possible.  

### Analysis Getting Started Template

Each analysis notebook has its own getting started section before getting to the code.
Copy and paste the template here and replace all the `<description>` points with the information that is pertinent to current dataset and analysis example.

### Chunk naming

Chunks shouldn't be named?

### Section formatting

Sections shouldn't be numbered?

## Formatting of typical words/items:
    - Use "refine.bio", NOT "refinebio"
    - Use `.Rmd`,  NOT "Rmd" or ".Rmd"
    -
## Citations

For sources, add them to the `references.bib` file.

### Citing R packages
Use this kind of command in the console: `toBibtex(citation("ComplexHeatmap"))`.
Copy and paste the output to the `references.bib` file.

### Citing Articles


### Links

- Links to other notebooks should always go to the online version of the book.
- Links to sections within the notebook can be used as usual (e.g. `#how-to-use-data`)

## How to spell check

In RStudio, go to `Edit` > `Check Spelling`.

## Code Style

These analyses follow the [Google R Style Guide](http://web.stanford.edu/class/cs109l/unrestricted/resources/google-style.html) which is based on the tidyverse style guide.

Using the [r-lib/styler package](https://github.com/r-lib/styler) can help you automatically fix a lot of the spacing and formatting issues.
After installing it with `install.packages("styler")`, set the style to tidyverse using `usethis::use_tidy_style()`.
You can use the `styler::style_file("name-of-notebook.Rmd")` function to do this all at once for a notebook.
