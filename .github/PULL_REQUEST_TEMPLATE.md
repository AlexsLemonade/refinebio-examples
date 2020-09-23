## Purpose:
What issue(s) does your PR address?

## Strategy
What was your strategy for this new or edited analysis?

## Concerns/Questions for reviewers:
What things should reviewers look out for?

## Analysis Pull Request Check List (roughly in order):

### Content checks
* [ ] All `{{BLANKS}}` have been replaced with the correct content.
* [ ] [Sources are cited](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#citing-sources-in-text)
* [ ] Seed is set (if applicable)

### Formatting Checks
* [ ] Removed any manual numbering of sections.
* [ ] Removed any instances of chunk naming.
* [ ] Spell checked any Rmd file or md file.
* [ ] Comments and documentation are up to date.
* [ ] All links, particularly the "download this Rmd file" link have been tested.

### Add datasets to S3
* [ ] Added [data and metadata files to S3](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#adding-datasets-to-the-S3-bucket).

### Docker/Snakemake rendering components
* [ ] Added the `.html` [link to the navigation bar](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#add-new-analyses-to-the-navbar).
* [ ] Any not yet added packages needed for this analysis have been added to the Dockerfile and it successfully builds.
* [ ] In the Docker container, [snakemake was run for rendering](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#how-to-re-render-the-notebooks).
