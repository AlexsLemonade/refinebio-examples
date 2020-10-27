---
name: New analysis PR
about: Use this PR template for filing a new analysis issue
title: 'New Analysis'
labels: new analysis
assignees: ''

---

## Pull request stage

<!-- Let the reviewer know what stage this analysis example is at -->

This is a **Draft PR** - needs review of big concepts and outline

This is a **Refined PR** - needs review of details and polishing

<!-- In the case of the Refined PR, link the draft PR here -->

## Purpose

<!-- What new analysis issue(s) does your PR address? -->

## Strategy

<!-- What was your strategy for this new or edited analysis? -->

<!-- Is there anything you found out in implementation that required you to shift strategies from what was originally discussed? -->

## Concerns/Questions for reviewers:

<!-- Are there any items you would like the reviewer to take an extra close look? -->

<!-- Any results that don't quite make sense? -->

<!-- Anywhere that you are unsure about wording or how to guide the user? -->

## Analysis Pull Request Check List (roughly in order):

### Content checks
* [ ] All `{{BLANKS}}` have been replaced with the correct content.
* [ ] [Sources are cited](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#citing-sources-in-text)
* [ ] Seed is set (if applicable)

### Formatting Checks
* [ ] Removed any manual numbering of sections.
* [ ] Removed any instances of chunk naming.
* [ ] Comments and documentation are up to date.
* [ ] All links have been checked and are properly formatted.

### Add datasets to S3
* [ ] Added [data and metadata files to S3](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#adding-datasets-to-the-S3-bucket).

### Docker/Snakemake rendering components
* [ ] Added the `.html` [link to the navigation bar](https://github.com/AlexsLemonade/refinebio-examples/blob/master/CONTRIBUTING.md#add-new-analyses-to-the-navbar).
* [ ] Any not yet added packages needed for this analysis have been added to the Dockerfile and it successfully builds.
