# Contributing guidelines - refinebio-examples

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Docker for refinebio-examples](#docker-for-refinebio-examples)
  - [Setting up the docker container](#setting-up-the-docker-container)
  - [Docker image updates](#docker-image-updates)
- [Download the datasets](#download-the-datasets)
- [Add a new analysis](#add-a-new-analysis)
  - [Setting up a new analysis file](#setting-up-a-new-analysis-file)
    - [How to use the template.Rmd](#how-to-use-the-templatermd)
    - [Adding datasets to the S3 bucket](#adding-datasets-to-the-s3-bucket)
- [Guidelines for analysis notebooks](#guidelines-for-analysis-notebooks)
  - [Notebook code chunks](#notebook-code-chunks)
    - [Input files](#input-files)
    - [Output files](#output-files)
    - [Chunk naming](#chunk-naming)
    - [Code Style](#code-style)
    - [Session Info](#session-info)
  - [Notebook text](#notebook-text)
    - [Formatting of typical words/items:](#formatting-of-typical-wordsitems)
    - [No manual section numbering](#no-manual-section-numbering)
    - [Paragraph formatting](#paragraph-formatting)
    - [Citing sources in text](#citing-sources-in-text)
      - [Adding new sources to the `references.bib`](#adding-new-sources-to-the-referencesbib)
      - [Key naming](#key-naming)
    - [Spell checking](#spell-checking)
- [Rendering notebooks](#rendering-notebooks)
  - [Mechanics of the rendering](#mechanics-of-the-rendering)
  - [How to re-render the notebooks locally](#how-to-re-render-the-notebooks-locally)
  - [Run snakemake without queueing up a web browser for the Docker container](#run-snakemake-without-queueing-up-a-web-browser-for-the-docker-container)
- [Pull Requests](#pull-requests)
    - [Add to the testing branch: merges to staging](#add-to-the-testing-branch-merges-to-staging)
    - [Publish: staged changes merged to master](#publish-staged-changes-merged-to-master)
    - [Publish a change, but quickly: direct merges to master, hotfixes](#publish-a-change-but-quickly-direct-merges-to-master-hotfixes)
    - [A summary of types of PRs.](#a-summary-of-types-of-prs)
  - [Automatic rendering using GitHub actions](#automatic-rendering-using-github-actions)
  - [About the render-notebooks.R script](#about-the-render-notebooksr-script)
  - [Add new analyses to the Snakefile](#add-new-analyses-to-the-snakefile)
  - [Add new analyses to the navbar](#add-new-analyses-to-the-navbar)
- [Pull request status checks](#pull-request-status-checks)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Docker for refinebio-examples

This repository uses a Docker image to manage dependencies and keep software versions consistent.
Development should take place in the Docker container.

### Setting up the docker container

Navigate your local `refinebio-examples` repository.
Now, you can build the docker image locally using:
```
docker build -< docker/Dockerfile -t ccdl/refinebio-examples
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

### Docker image updates

All necessary packages needed for running all analyses should be added to the `Dockerfile` and it should be re-built to make sure it builds successfully.
Successful building of the `Dockerfile` will also be checked when the PR is filed by GitHub Actions.

In the `refinebio-examples` repository:
```
docker build -< docker/Dockerfile -t ccdl/refinebio-examples
```
When a PR with Dockerfile changes is merged, its associated image will be automatically pushed to the Docker hub repository.


## Download the datasets

For development purposes, you can download all the datasets for the example notebooks by running this command in the Docker container:
```
scripts/download-data.sh
```

## Add a new analysis

Here are the summarized steps for adding a new analysis.
Click on the links to go to the detailed instructions for each step.

- On your new git branch, [set up the analysis file from the template](#setting-up-the-analysis-file).
- Add a [link to the html file to `_navbar.html`](#add-new-analyses-to-the-navbar)
- [Cite sources and add them to the reference.bib file](#citing-sources-in-text)
- Add [data and metadata files to S3](#adding-datasets-to-the-s3-bucket)
- Add not yet added packages needed for this analysis to the Dockerfile (make sure it successfully builds).
- Add the [expected output html file to snakemake](#add-new-analyses-to-the-snakefile)
- In the Docker container, run [snakemake for rendering](#how-to-re-render-the-notebooks-locally)

### Setting up a new analysis file

To start a new analysis, copy and paste the `template/template_example.Rmd` file to the new pertinent section's folder.

Rename the template file according to the module group, section, and analysis name following the following format: `<analysis-module>_<section/tech>_<notebook#>_<name-of-analysis>.Rmd`.
Separate multi-word phrases within a section with hyphens.

For example: `dimension-reduction_microarray_01_pca.Rmd` is the first notebook in the dimension reduction group and is in the `02-microarray` section/folder.
Notebooks numbers should be kept in relative order of `least background knowledge/simple implementation` -> `most background knowledge needed/most complex`.

If the analysis you are adding doesn't fit with any of the existing groups, try to carefully label it with a new group name.
Even though it is the only `.Rmd` in its group, it should still be labeled with a `01` in its name.

#### How to use the template.Rmd

When editing the new analysis from the `template/template_example.Rmd`, search for `{{` or `}}` and replace those with the pertinent information.
Leave comments that are `<!--`and `-->`.
The introductory info in this template file helps toward our goal of these analyses notebooks being self-contained.

#### Adding datasets to the S3 bucket

You will need an AWS account to add files to S3 bucket.
Go to the [refinebio-examples bucket](https://s3.console.aws.amazon.com/s3/buckets/refinebio-examples/) on Amazon Web Services.

Each section has a folder (`02-microarray`, `03-rnaseq`, and `04-advanced-topics`).
1) Click on the folder for the section you are adding to, then on the `data` subfolder.
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

Test that the files you've uploaded successfully download by running the `download-data.sh`
script.
If you run the script and it says `Access Denied` you may have missed step 8, but you can go back to the file and click the `Make it Public` button and try testing your download again.

## Guidelines for analysis notebooks

Each analysis `.Rmd` notebook needs to be entirely self-contained so that a user can download the `.Rmd` file and have all the necessary steps and information to complete the example analysis.

### Notebook code chunks

#### Input files

- refine.bio download files
- The refine.bio download files should be [added to the S3 bucket](#adding-datasets-to-the-s3-bucket).
- Any additional reference files should be downloaded in the notebook.  

#### Output files

Output file names should look like this; `<experiment_accession>_<sensible_name>.png`
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

#### Code Style

These analyses follow the [Google R Style Guide](https://google.github.io/styleguide/Rguide.html) which is based on the tidyverse style guide.

Snakemake will automatically runs the [r-lib/styler package](https://github.com/r-lib/styler)  on each `.Rmd` file called in the `Snakefile`.
This will help fix some spacing and formatting issues automatically.

#### Session Info

`sessioninfo::session_info()` should always be printed out at the end.
(It is included in the `.Rmd` template)

### Notebook text

#### Formatting of typical words/items:

  - Use "data frame" NOT data.frame or `data frame` (unless referring to the function which should be `data.frame()`)
  - Use _e.g._, NOT "eg" or "_eg_" or "e.g."
  - Use et al., NOT et. al.
  - Use "gene sets", NOT "genesets"
  - Use "IDs" or "ID", NOT "ids"/"id" or "Ids"/"Ids"
  - Use "NA" or "NAs", NOT na/nas or Na or `NA` or `NA`s or NA's
  - Use "PNG", NOT png or `png` or .png (and etc.)
  - Use "probe sets", NOT "probesets"
  - Use "refine.bio", NOT "refinebio"
  - Use `.Rmd`,  NOT "Rmd" or ".Rmd"
  - Use "tidyverse", NOT "Tidyverse"
  - Use "TSV",  NOT "tsv" or `tsv` or ".tsv"

  - **Functions**: For function references in paragraph, use `getwd()`; with backticks and empty parentheses.
  Since function calls always involve `()` being consistent about this adding in this notation might be helpful for beginning R users referencing our examples.  

  - **Variable names**: Variable names, like those that are stored as column names in a data frame
  should be kept in backticks: `refinebio_treatment` when referenced in a paragraph.

- **Gene names**: When being referenced as a variable name, as in "let's extract the `ENSG0000000123` data", backticks should be used.
But if the gene is being referred to more as a concept or something that is not specifically referring to code, the backticks can/should be dropped.

- `::` or `library()` - for most packages there is no stipulations on which strategy to use.
We like to be able to show both strategies.
However, for ggplot2, we always use `library(ggplot2)` to avoid the repetition needed for making a plot that could lead to troubleshooting problems for users that may be trying to modify plots.
See [issue #211](https://github.com/AlexsLemonade/refinebio-examples/issues/211).

#### No manual section numbering  

Numbering will be done automatically in rendering; so no numbers should be put on the sections.

#### Paragraph formatting  

Each sentence should be on its own line.

#### Citing sources in text

From the RMarkdown Cookbook [bibliographies chapter](https://bookdown.org/yihui/rmarkdown-cookbook/bibliography.html):
> Items can be cited directly within the documentation using the syntax @key where key is the citation key in the first line of the entry, e.g., @R-base. To put citations in parentheses, use [@key]. To cite multiple entries, separate the keys by semicolons, e.g., [@key-1; @key-2; @key-3]. To suppress the mention of the author, add a minus sign before @, e.g., [-@R-base].

- Note that citations do not have links, so links to helpful docs and vignettes need to be added separately.
- Links to websites can be added in the Markdown format `[]()` but should also be added to the `references.bib` file in the next section.
- Links to other notebooks in `refinebio-examples` should always go to the online version of the book (to maintain the self-contained functionality).
- Links to sections within the same notebook can still be done like: `#how-to-use-data`.

##### Adding new sources to the `references.bib`

You can obtain formatted `LaTeX` reference entry following the instructions below and copying and pasting the whole thing in `reference.bib`.
The references in `reference.bib` should be kept in alphabetical order (this will reduce the chances of adding duplicates).

Automatic reference renders (like those recommended below) don't maintain consistent syntax (though they usually will still work).
You may/will still need to do some manual edits to maintain consistency with the current `references.bib`-listed sources.

**Adding sources rules:**  

- All sources need to have URLs.
- Where applicable, sources should have doi's.
- `{}` are preferred to `" "`.
- To preserve capitalization, use an extra `{}` around words that require special capitalization (genes, software packages, etc).
- All journal names should be given in full, not abbreviated
- Author names with abbreviations should include a period after the abbreviation. i.e. `Harry S. Truman` not `Harry S Truman` and `Truman, H. S.` not `Truman, HS`.

**How to add sources by type**  

- _R packages_: Use this kind of command in the console: `toBibtex(citation("tidyverse"))`.
Copy and paste the output to the `references.bib` file.

- _Articles_: For articles (or any item with a DOI), you can use [doi2bib.org](https://www.doi2bib.org/) to get a BibTex-formatted reference.
Then copy and paste the reference to the `references.bib` file.

- _Websites_: Websites can be added using this template:
```
@website{citekey,
    author = {First Last},
    title = {Title},
    url  = {http://www.someurl.html},
}
```

After you copy and paste the LaTeX formatted reference to the `reference.bib` file (see instructions by source type below), you need to add a key in the first line, after the `{` and before the `,`.

##### Key naming

Whenever possible, tags for all types of references should follow this format: `LastnameoffirstauthorYear` so `Love2014`.

For example the tidyverse citation starts like this:

```
@article{Wickham2019,
```

This allows you to reference it by `@Wickham2019` as [mentioned in the section above](#citing-sources-in-text)

If there is no author name or no year associated with the reference, then turn to key words, all lower case with `-` in between (unless there is an obvious name: aka `RStudio`).

For example:
```
@website{pca-visually-explained,
```
Had no year associated with it, so it has keywords for its tag `pca-visually-explained`.

#### Spell checking

Spell checks are run automatically using GitHub actions upon opening a PR for `master` or `staging`.
GitHub actions will abort if there are more than 2 spelling errors and you will need to fix those before continuing.
You can obtain the list of spelling errors on GitHub by going to `Actions` and clicking the workflow of PR you are working on.
Click on the `style-n-check` step and in the upper right hand corner, there is a button that says "Artifacts" which should list a file called `spell-check-results`.
Click on `spell-check-results` to download a zip file that contains the list of misspelled words.
Alternatively, click on the "Check on spell check results" step in the workflow log to see the misspellings.

Any terms that should be recognized by the spell check, you can add to `components/dictionary.txt`.
Keep words alphabetical; each word is on its own line.

If you want to run a spell check of all `.Rmd` files locally, you can use run `Rscript scripts/spell-check.R` and it will print out the same type of file in your current directory.

## Rendering notebooks

### Mechanics of the rendering

The `Snakefile` calls the `scripts/render-notebooks.R` which renders the `.html` files but leaves these `.Rmd` files ready for download and use [without the `pandoc` error](https://github.com/AlexsLemonade/refinebio-examples/pull/148#issuecomment-669170681).
However, the `snakemake` workflow should also be run locally during development so that the author and reviewers can see the rendered output of the new material during the `Pull Request` process.

Ideally snakemake will not re-render the `.html` for `.Rmd` files you have not edited, but if it does, you should only commit and push the files you have intended to change.
All `.html` files will be re-rendered upon merging to `master` or `staging`, but by not committing files that are only altered incidentally, the `Files changed` page of your PR on GitHub will be more focused, easing the burden on reviewers.

### How to re-render the notebooks locally

**Step 1)** Make sure you are running this from a [`ccdl/refinebio-examples` Docker container](#setting-up-the-docker-container).

**Step 2)** Make sure any newly added analyses are [added to the Snakefile](#add-new-analyses-to-the-snakefile) and [added to the navbar](#add-new-analyses-to-the-navbar).

**Step 3)** Run the thing!
Make sure you are running this from a `ccdl/refinebio-examples` Docker container.
Run it!
```
snakemake --cores 4 # using 4 cores for some parallelism. Modify as appropriate.
```
If `snakemake` ran successfully, it will spit out a log and all the `.html` output files will have nicely rendered citations.
Note that all `.nb.html` files are `.gitignore`'d because we want users to be able to render `html_notebook`s, but here we are using `html_document`s.

### Run snakemake without queueing up a web browser for the Docker container

Navigate to the `refinebio-examples` repository.
If you already have the `refinebio-examples` docker image:
```
docker run --mount type=bind,target=/home/rstudio,source=$PWD ccdl/refinebio-examples snakemake --cores 4
```

## Pull Requests

There are two protected branches in this repo:

`staging` - where changes are initially sent for testing and previewing.
`master` - where changes that were tested are made user-facing.

This two branch set up allows us to make incremental changes that we can test before publishing to our user-facing github pages.
It also means that pull requests have some extra methodology.

#### Add to the testing branch: merges to staging

After you've prepared the new or altered material for this repository, you can file a pull request to the `staging` branch this is the default branch for this repository so you should not have to change anything.
The `staging` branch does not feed into the published, user-facing material so you can feel free to make your pull requests as iterative and incremental as it is useful.
Use `squash and merge` when merging these pull requests into `staging` after approval.
`squash and merge` will be helpful for us if we need to "cherry pick" commits if particular project or example is not yet ready for user-facing but other material is.

After merging a pull request into `staging`, check that all the changes are correct by reviewing the newly generated pages using html preview.
Go here and navigate to the pertinent pages that you've changed.
`http://htmlpreview.github.io/?https://github.com/AlexsLemonade/refinebio-examples/gh-pages-stages/01-getting-started/getting-started.html`
You may also want to spot-check other pages to be sure that there have not been inadvertent or unexpected  changes introduced.

#### Publish: staged changes merged to master

Once a set of changes that are merged to `staging` are ready to be published, you can file a merge to `master` pull request.

These types of PRs should only involve well-polished and ready for the public material.

**Scenario 1: All changes from staging should be published**  

- Create a new branch from the most up-to-date `master` branch, call it `publish-mychanges` where `mychanges` is a short tag relevant to the changes.
- Checkout your newly created `publish` branch.
- If you are certain that all changes in `staging` should be carried over to `master` (aka published to Github pages), then you can do a `git merge staging` into your new branch.
- Now you can use the new branch to create the pull request to master as you would normally do.
- Try to be as specific as possible about what PRs (and by relation, their commits) you are requesting to merge to `master`.

This strategy allows you to resolve any merge conflicts in your new branch so we don't do a bad thing by committing conflict resolutions directly to `staging`.
It also provides us with a "snapshot" if merges are continuing to happen to `staging` on other PRs -- this can make review hard if it keeps changing.

**Scenario 2: Only some changes from staging should be published**  

- Create a new branch from the most up-to-date `master` branch, call it `publish-mychanges` where `mychanges` is a short tag relevant to the changes.
- Checkout your newly created `publish` branch.
- For each commit that needs to be published, add it to your new branch by using `git cherry-pick <commit_id>`.
Or in GitKraken, you can right click on the commit and choose `Cherry pick commit`.
- Now you can use the new branch to [create the pull request where the `master` branch](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request#changing-the-branch-range-and-destination-repository) is the base branch.
- Try to be as specific as possible about what PRs (and by relation, their commits) you are requesting to merge to `master`.

This strategy allows us to move forward changes from `staging` that are ready to be public facing even if other changes aren't ready (or if there isn't great timing for when the other changes will be ready).

_Tips for getting commits ids_  
GitKraken shows commits, but sometimes I find it hard to follow which commits belong to which branch.
If you checkout `staging` and use `git log` you can see all the most recent commits for the `staging` branch.
If you want to save it to a file for easy browsing and copy/pasting you can use this command `git log --pretty=format:'%h was %an, %ar, message: %s' > git.log`

#### Publish a change, but quickly: direct merges to master, hotfixes

In (hopefully rare) scenarios where something that has already been published is noted to be broken and should be addressed quickly, [hotfix branch](https://nvie.com/posts/a-successful-git-branching-model/#hotfix-branches) pull requests are allowed.
These PRs should only be fairly small PRs and not anything that would require intense review.
This more for situations where "this is broken and here's a fix".

- Create a new branch from the most up-to-date `master` branch and call it `hotfix-mybug`, where where `mybug` is a short tag relevant to the changes.
- Checkout your newly created `hotfix` branch.
- Make the hotfix change.
- Create a [pull request with `master` branch as the base branch](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request#changing-the-branch-range-and-destination-repository).
- After your PR to `master` is approved and merged, merge the most up-to-date `staging` branch into your `hotfix` branch.
- File a second PR for `hotfix` but this time with [`staging` as the base branch](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request#changing-the-branch-range-and-destination-repository).

#### A summary of types of PRs.

- `some-branch` -> `staging` -> NOT published to user-facing content.
This will be how most material is prepared so we can be more incremental with our changes and ultimately make sure only the very polished material is made user-facing.

- Group of changes in `staging` -> `master` -> published to user-facing.
This is for when the updates from the previous kinds of PRs are "ready for prime time".

- Hotfix PR: `hotfix` -> `master` -> published to user-facing.
For "this-is-broken" type changes that should be hastened to the user-facing content.
This requires a follow up pull request and merge to `staging`.

### Automatic rendering using GitHub actions

This repository uses [snakemake](https://snakemake.readthedocs.io/en/stable/getting_started/installation.html) to render all notebooks.
All notebooks are automatically re-rendered by GitHub actions upon merges to master.
The newly rendered html files are all pushed to the `gh-pages` branch which will publish the material to https://alexslemonade.github.io/refinebio-examples/.

If this automatic rendering fails, you will see a failed check at at the bottom of your PR on GitHub (and probably an email).
You can see the details of this error on  by going to `Actions` and clicking the workflow of PR you are working on that also says `Build Docker` underneath.
Click on `build` on the left bar and click on the step that has failed to see the error message.
Hopefully the error message helps you track down the problem, but you can also contact this repo's maintainers for support.

### About the render-notebooks.R script

The `render-notebooks.R` script adds a `bibliography:` specification in the `.Rmd` header so all citations are automatically rendered.

**Options:**
- `--rmd`: provided by snakemake, the input `.Rmd` file to render.   
- `--bib_file`: File path for the  `bibliography:` header option.
Default is the `references.bib` in the `components` folder.  
- `--html`: Default is to save the output `.html` file the same name as the input `.Rmd` file. This option allows you to specify an output file name. Default is used by snakemake.

### Add new analyses to the Snakefile

Any new `.Rmd` notebooks should have their `.html` equivalent added underneath the `target:input:` section of the `Snakefile`.
Follow the formatting of the previous files and add a `comma` after like this example where `"a-directory/the-name-of-the-new-rmd.html"` is what we are adding.
```
rule target:
    input:
        "01-getting-started/getting-started.html",
        "a-directory/the-name-of-the-new-rmd.html"
```
File paths should be relative to the `Snakefile`.

### Add new analyses to the navbar

Follow these steps to add the `.html` link to the navigation bar upon rendering.

1) Open up the `components/_navbar.html` file with a text editor of your choice.  
2) Look for the corresponding dropdown section (look for this kind of thing: `<!-- RNA-Seq dropdown -->`) according to which section you are adding the new analysis for.  
3) See the part where it says `<!-- Individual _____ pages go in this list -->`.  
4) Use this kind of structure to add in the new line:
```
<li><a href="../tech-section/analysis_file_name.html">Brief Analysis Name</a></li>
```
5) Replace `Brief Analysis Name` with the brief name for the analysis that will show up as the button.  
6) Replace  `tech-section`, `analysis_file_name` with the corresponding file names.  
7) Save the file!  
8) After you [render the notebook with snakemake](#rendering-notebooks), test the link to make sure it works.  

## Pull request status checks

To require that branches are up-to-date with `master` or `staging` before merging, we need to require that a status check passes before merging to `master` or `staging`.
Turning on this setting mitigates the risk that changes that have been merged will be undone by a pull request that was filed first and alters the same file.
The status check used is a GitHub Action that test builds the docker image.
Most of the time, this should pull cached docker layers, so this will complete in a matter of minutes.
As a bonus, this process also checks that any changes to the Dockerfile result in a buildable image.
