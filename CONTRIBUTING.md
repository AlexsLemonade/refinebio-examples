
# Contributing guidelines

## Rendering notebooks

This repository uses [snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) to render all notebooks.
The `Snakefile` calls the `scripts/render-notebooks.R` which renders the `.html` files but leaves these `.Rmd` files ready for download and use [without the `pandoc` error](https://github.com/AlexsLemonade/refinebio-examples/pull/148#issuecomment-669170681).
`snakemake` should be ran after changes have been made and before any `Pull Request` are filed.

### How to re-render the notebooks

**Step 1)** Install snakemake (if you haven't before).
Follow the installation instructions on the [snakemake docs](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html).

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
Navigate to the `refinebio-examples` repository.

Activate snakemake (if you are using conda; otherwise skip this.)
```
conda activate snakemake
```
Run it!
```
snakemake --cores 1
```
If ran successfully, it will spit out a log and all the `.html` output files will have nicely rendered citations.
Note that all `.nb.html` files are `.gitignore`'d because we want users to be able to render `html_notebook`s, but here we are using `html_document`s.

### About the render-notebooks.R script

The `render-notebooks.R` script adds a `bibliography:` specification in the `.Rmd` header so all citations are automatically rendered.

**Options:**
- `--rmd`: provided by snakemake, the input `.Rmd` file to render.   
- `--bib_file`: File path for the  `bibliography:` header option.
Default is the `references.bib` script at the top of the repository.  
- `--html`: Default is to save the output `.html` file the same name as the input `.Rmd` file. This option allows you to specify an output file name. Default is used by snakemake.


## Adding a new analysis

Copy, paste and rename the `template/template_example.Rmd` file to start a new analysis and the `template/screenshots` folder.
Search for `<<` or `>>` and replace those with the pertinent information.
The introductory info in this template file helps toward our goal of these analyses notebooks being self-contained.

### General guidelines for analyses notebooks

Each analysis `.Rmd` notebook needs to be entirely self-contained so that a user can download the `.Rmd` file and have all the necessary steps and information to complete the example analysis.

**Inputs:**  

- refine.bio download files.  
- Any additional reference files should be downloaded in the notebook.  

**Outputs**  

- A `plots` and/or `results` folder should be created by the analysis notebook.  
- Output results should be `TSV` when possible.  
- Plots should be saved to `PNG` whenever possible.    

**Chunk naming**

Chunks preferably shouldn't be named.
If we do end up using [bookdown](https://bookdown.org/yihui/bookdown/) at some point, repetitive chunk names like `import data` will cause havoc.
Plus its just another thing to have to keep track of.

**No manual section numbering**

Numbering will be done automatically in rendering; so no numbers should be put on the sections.

**Citation**

Sources should be cited whenever possible.
See [the sections about citations](#citing-sources-in-text).

## Formatting of typical words/items:

  - Use "refine.bio", NOT "refinebio"
  - Use `.Rmd`,  NOT "Rmd" or ".Rmd"
  - Use "tidyverse", not "Tidyverse"

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
