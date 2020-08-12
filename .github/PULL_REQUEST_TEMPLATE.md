## Purpose:
What issue(s) does your PR address?

## Strategy
What was your strategy for this new or edited analysis?

## Concerns/Questions for reviewers:
What things should reviewers look out for?

## Analysis Pull Request Check List (roughly in order):

### Content checks
* [ ] All `{{BLANKS}}` have been replaced with the correct content.
* [ ] [Sources are cited](https://github.com/AlexsLemonade/refinebio-examples/CONTRIBUTING.md#citing-sources-in-text)
* [ ] Set the seed (if applicable)

### Formatting Checks
* [ ] Removed any manual numbering of sections.
* [ ] Removed any instances of chunk naming.
* [ ] Spell checked any Rmd file or md file.
* [ ] Comments and documentation are up to date.

### Docker/Snakemake
* [ ] Any not yet added packages needed for this analysis have been added to the Dockerfile and it successfully builds.
* [ ] In the Docker container, run [snakemake for rendering](https://github.com/AlexsLemonade/refinebio-examples/CONTRIBUTING.md#how-to-re-render-the-notebooks)
