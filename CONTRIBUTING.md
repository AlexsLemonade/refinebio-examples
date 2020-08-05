
# Contributing guidelines

## General guidelines for analyses notebooks

Each analysis `.Rmd` notebook needs to be entirely self-contained so that a user can download the `.Rmd` file and have all the necessary steps and information to complete the example analysis.
We should also attempt to keep notebooks under 400 lines to whenever possible.

**.Rmd Header**

Each analysis notebook should have this header.
This will automatically number the sections, _so no manual numbering should be used_.

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
---
```

**Inputs:**  

- refine.bio download files.  
- Any additional reference files should be downloaded in the notebook.  

**Outputs**  

- A `plots` and/or `results` folder should be created by the analysis notebook.  
- Output results should be `TSV` when possible.  
- Plots should be saved to `PNG` whenever possible.    

### Analysis Getting Started Template

Each analysis notebook has its own getting started section before getting to the code.
Copy and paste the template here and replace all the `<description>` points with the information that is pertinent to current dataset and analysis example.

### Chunk naming

Chunks preferably shouldn't be named.
If we do end up using [bookdown](https://bookdown.org/yihui/bookdown/) at some point, repetitive chunk names like `import data` will cause havoc.
Plus its just another thing to have to keep track of.

## Formatting of typical words/items:

    - Use "refine.bio", NOT "refinebio"
    - Use `.Rmd`,  NOT "Rmd" or ".Rmd"
    - "tidyverse", not "Tidyverse"

## Citing sources in text

From the RMarkdown Cookbook [bibliographies chapter](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html):
> Items can be cited directly within the documentation using the syntax @key where key is the citation key in the first line of the entry, e.g., @R-base. To put citations in parentheses, use [@key]. To cite multiple entries, separate the keys by semicolons, e.g., [@key-1; @key-2; @key-3]. To suppress the mention of the author, add a minus sign before @, e.g., [-@R-base].

- Note that citations do not have links, so links to helpful docs and vignettes need to be added separately.
- Links to websites can be added in the Markdown format `[]()` but should also be added to the `references.bib` file in the next section.
- Links to other notebooks in `refinebio-examples` should always go to the online version of the book (to maintain the self-contained functionality).
- Links to sections within the same notebook can still be done like: `#how-to-use-data`.

### Adding new sources to the `references.bib`

The references in `reference.bib` should be kept in alphabetical order (this will reduce the chances of adding duplicates).
You can copy and paste

- _R packages_: Use this kind of command in the console: `toBibtex(citation("tidyverse"))`.
Copy and paste the output to the `references.bib` file.

- _Articles_: For PubMed articles, you can use [this website to find the article](https://www.bioinformatics.org/texmed/). Select the correct article that pops up and click `Export`. Then copy and paste the reference to the `references.bib` file.

- _Websites_: Websites can be added using this template:
```
@online{website,
    author = "First Last",
    title = "Title",
    url  = "http://www.someurl.html",
}
```

After you copy and paste the LaTeX formatted reference to the `reference.bib` file (see instructions by source type below), you need to add a key in the first line, after the `{` and before the `,`.
For example the tidyverse citation starts like this:

```
@Article{tidyverse,
```

This allows you to reference it by `@tidyverse` as [mentioned in the section above](#citing-sources-in-text)

## How to spell check

In RStudio, go to `Edit` > `Check Spelling`.
Unfortunately, it will also spell check your code and urls. ¯\\_(ツ)_/¯

## Code Style

These analyses follow the [Google R Style Guide](http://web.stanford.edu/class/cs109l/unrestricted/resources/google-style.html) which is based on the tidyverse style guide.

Using the [r-lib/styler package](https://github.com/r-lib/styler) can help you automatically fix a lot of the spacing and formatting issues.
After installing it with `install.packages("styler")`, set the style to tidyverse using `usethis::use_tidy_style()`.
You can use the `styler::style_file("name-of-notebook.Rmd")` function to do this all at once for a notebook.
