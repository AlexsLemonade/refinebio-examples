# Contributing guidelines

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Contributing guidelines](#contributing-guidelines)
  - [Docker for refinebio-examples](#docker-for-refinebio-examples)
    - [Setting up the docker container](#setting-up-the-docker-container)
  - [Download the datasets](#download-the-datasets)
  - [Rendering notebooks](#rendering-notebooks)
    - [How to re-render the notebooks](#how-to-re-render-the-notebooks)
    - [Run snakemake without queueing up a web browser for the Docker container](#run-snakemake-without-queueing-up-a-web-browser-for-the-docker-container)
    - [About the render-notebooks.R script](#about-the-render-notebooksr-script)
  - [Adding a new analysis](#adding-a-new-analysis)
    - [File naming conventions](#file-naming-conventions)
    - [How to use the template.Rmd](#how-to-use-the-templatermd)
    - [Docker image management](#docker-image-management)
    - [General guidelines for analyses notebooks](#general-guidelines-for-analyses-notebooks)
      - [Inputs](#inputs)
      - [Outputs](#outputs)
      - [Chunk naming](#chunk-naming)
      - [Citation](#citation)
      - [No manual section numbering](#no-manual-section-numbering)
      - [Paragraph formatting](#paragraph-formatting)
      - [Session Info](#session-info)
  - [Formatting of typical words/items:](#formatting-of-typical-wordsitems)
  - [Citing sources in text](#citing-sources-in-text)
    - [Adding new sources to the `references.bib`](#adding-new-sources-to-the-referencesbib)
  - [How to spell check](#how-to-spell-check)
  - [Code Style](#code-style)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Docker for refinebio-examples

This repository uses a Docker image to manage dependencies and keep software versions consistent.
Development should take place in the Docker container.

### Setting up the docker container

Navigate your local `refinebio-examples` repository.
Now, you can build the docker image locally using:
```
docker build -< Dockerfile -t ccdl/refinebio-examples
```
Or by pulling the image from Docker hub (this will by default pull the `latest` version).
```
docker pull ccdl/refinebio-examples
```
Replace `<PASSWORD>` with your own password in the command below.
Then run the command to start up a container (only works correctly if you are in the `refinebio-examples` directory):
```
docker run --mount type=bind,target=/home/rstudio,source=$PWD -e PASSWORD=<PASSWORD> -p 8787:8787 ccdl/refinebio-examples
```
Now you can navigate to http://localhost:8787/ to start developing.
Login to the RStudio server with the username `rstudio` and the password you set above.

## Download the datasets

For developing purposes, you can download all the datasets for examples by running this command in the Docker container:
```
scripts/download-data.sh
```

## Rendering notebooks

This repository uses [snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) to render all notebooks.
The `Snakefile` calls the `scripts/render-notebooks.R` which renders the `.html` files but leaves these `.Rmd` files ready for download and use [without the `pandoc` error](https://github.com/AlexsLemonade/refinebio-examples/pull/148#issuecomment-669170681).
`snakemake` should be ran after changes have been made and before any `Pull Request` are filed.

### How to re-render the notebooks

**Step 1)** Make sure you are running this from a [`ccdl/refinebio-examples` Docker container](#setting-up-the-docker-container).

**Step 2)** Add any new `.Rmd` notebooks should have their `.html` equivalent added underneath the `target:input:` section of the `Snakefile`.
Follow the formatting of the previous files and add a `comma` after like this example where `"a-directory/the-name-of-the-new-rmd.html"` is what we are adding.
```
rule target:
    input:
        "01-getting-started/getting-started.html",
        "a-directory/the-name-of-the-new-rmd.html"
```
File paths should be relative to the `Snakefile`.

**Step 3)** Run the thing!
Make sure you are running this from a `ccdl/refinebio-examples` Docker container.
Run it!
```
snakemake --cores 1
```
If `snakemake` ran successfully, it will spit out a log and all the `.html` output files will have nicely rendered citations.
Note that all `.nb.html` files are `.gitignore`'d because we want users to be able to render `html_notebook`s, but here we are using `html_document`s.

### Run snakemake without queueing up a web browser for the Docker container

Navigate to the `refinebio-examples` repository.
If you already have the `refinebio-examples` docker image:
```
docker run --mount type=bind,target=/home/rstudio,source=$PWD ccdl/refinebio-examples snakemake --cores 1
```
### About the render-notebooks.R script

The `render-notebooks.R` script adds a `bibliography:` specification in the `.Rmd` header so all citations are automatically rendered.

**Options:**
- `--rmd`: provided by snakemake, the input `.Rmd` file to render.   
- `--bib_file`: File path for the  `bibliography:` header option.
Default is the `references.bib` script at the top of the repository.  
- `--html`: Default is to save the output `.html` file the same name as the input `.Rmd` file. This option allows you to specify an output file name. Default is used by snakemake.

## Adding a new analysis

To start a new analysis, copy and paste the `template/template_example.Rmd` file to the new pertinent section's folder.

### File naming conventions

Rename the template file according to what the new analysis' content will be and what analysis group it will belong to.
In other words, `.Rmd` files are named like `<analysis_module>_<section/tech>_<notebook#>_<name_of_analysis>.Rmd`
For example: `dimension_reduction_microarray_01_pca.Rmd` is the first notebook in the dimension reduction group and is in the `02-microarray` section/folder.
Notebooks numbers should be kept in relative order of `least background knowledge/simple implementation` -> `most background knowledge needed/most complex`.

If the analysis you are adding doesn't fit with any of the existing groups, try to carefully label it with a new group name.
Even though it is the only `.Rmd` in its group, it should still be labeled with a `01` in its name.

### How to use the template.Rmd

When editing the new analysis from the `template/template_example.Rmd`, search for `{{` or `}}` and replace those with the pertinent information.
Leave comments that are `<!--`and `-->`.
The introductory info in this template file helps toward our goal of these analyses notebooks being self-contained.

### Docker image management

All necessary packages needed for running the analysis should be added to the `Dockerfile` and it should be re-built to make sure it builds successfully.

In the `refinebio-examples` repository:
```
docker build -< Dockerfile -t ccdl/refinebio-examples
```
After a PR with Dockerfile changes is merged, its associated image should be pushed to the Docker hub repository using a `dev` tag.  
```
# log in with your credentials
docker login

# Attach a tag to your docker image
docker tag ccdl/refinebio-examples ccdl/refinebio-examples:dev

# Push it!
docker push ccdl/refinebio-examples:dev
```
After a few rounds of changes to the Dockerfile has occurred, we can make a new version tag.
For example, if there is a `ccdl/refinebio-examples:v1` we can move to `v2`.
So the same steps would be followed above, but you can change where it says `dev` with the appropriate `v` number.

### Adding datasets to the S3 bucket

You will need an AWS account to add files to S3 bucket.
Go to the [refinebio-examples bucket](https://s3.console.aws.amazon.com/s3/buckets/refinebio-examples/?region=us-east-2) on Amazon Web Services.

Each section has a folder (`02-microarray`, `03-rnaseq`, and `04-advanced-topics`).
1) Click on the section folder you are adding to.
2) Click the `+ Create folder` button and name the folder with the experiment accession (e.g. `GSE12345` - as it would be on refine.bio download, aggregate by experiment).
3) Click `Save`.
4) Click on the experiment_accession folder you created.
5) Click `Upload`.
6) Choose the `metadata` and `data` TSV files you obtained from refine.bio (make sure they are correctly non-QN'ed or QN'ed upon your download).
7) Click `Next`.
8) Under `Manage public permissions` > Choose `Grant public read access to this object`.
9) Click `Next`.
10) Click `Next` again.
11) Click Upload.

Test that the files you've uploaded succesfully download by running the `download-data.sh`
script.
If you run the script and it says `Access Denied` you may have missed step 8, but you can go back to the file and click the `Make it Public` button and try testing your download again.

### General guidelines for analyses notebooks

Each analysis `.Rmd` notebook needs to be entirely self-contained so that a user can download the `.Rmd` file and have all the necessary steps and information to complete the example analysis.

#### Inputs  

- refine.bio download files
- The refine.bio download files should be [added to the S3 bucket](#adding-datasets-to-the-s3-bucket).
- Any additional reference files should be downloaded in the notebook.  

#### Outputs  

Output file names should look like this; `<experiment_accesion>_<sensible_name>.png`
For example: `GSE12345_pca_plot.png`

- A `plots` and/or `results` folder should be created by the analysis notebook.  
- Output results should be `TSV` when possible.  
- Plots should be saved to `PNG` whenever possible.    
- Underscores instead of `-` just so we don't have to think about it.
- No camel case (except for packages/functions where it is already in use!)

#### Chunk naming  

Chunks preferably shouldn't be named.
If we do end up using [bookdown](https://bookdown.org/yihui/bookdown/) at some point, repetitive chunk names like `import data` will cause havoc.
Plus its just another thing to have to keep track of.

#### Citation  

Sources should be cited whenever possible.
See [the sections about citations](#citing-sources-in-text).

#### No manual section numbering  

Numbering will be done automatically in rendering; so no numbers should be put on the sections.

#### Paragraph formatting  

Each sentence should be on its own line.

#### Session Info

`sessionInfo()` should always be printed out at the end.
(It is included in the `.Rmd` template)

## Formatting of typical words/items:

  - Use "refine.bio", NOT "refinebio"
  - Use `.Rmd`,  NOT "Rmd" or ".Rmd"
  - Use "tidyverse", NOT "Tidyverse"
  - Use "TSV",  NOT tsv or `tsv` or .tsv
  - Use "PNG", NOT png or `png` or .png (and etc.)
  - Use "data frame" NOT data.frame or `data frame` (unless referring to the function which should be `data.frame()`)

  - **Functions**: For function references in paragraph, use `getwd()`; with backticks and empty parentheses.
  Since function calls always involve `()` being consistent about this adding in this notation might be helpful for beginning R users referencing our examples.  

  - **Variable names**: Variable names, like those that are stored as column names in a data frame
  should be kept in backticks: `refinebio_treatment` when referenced in a paragraph.

## Citing sources in text

From the RMarkdown Cookbook [bibliographies chapter](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html):
> Items can be cited directly within the documentation using the syntax @key where key is the citation key in the first line of the entry, e.g., @R-base. To put citations in parentheses, use [@key]. To cite multiple entries, separate the keys by semicolons, e.g., [@key-1; @key-2; @key-3]. To suppress the mention of the author, add a minus sign before @, e.g., [-@R-base].

- Note that citations do not have links, so links to helpful docs and vignettes need to be added separately.
- Links to websites can be added in the Markdown format `[]()` but should also be added to the `references.bib` file in the next section.
- Links to other notebooks in `refinebio-examples` should always go to the online version of the book (to maintain the self-contained functionality).
- Links to sections within the same notebook can still be done like: `#how-to-use-data`.

### Adding new sources to the `references.bib`

You can obtain formatted `LaTeX` reference entry following the instructions below and copying and pasting the whole thing in `reference.bib`.
The references in `reference.bib` should be kept in alphabetical order (this will reduce the chances of adding duplicates).

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
