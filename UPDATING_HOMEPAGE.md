# Updating Homepage- refinebio-examples

## Making Changes

You can edit `components/_homepage.html` and save to apply your changes to the homepage.

Editing `components/_navbar.html` or `components/footer.html` will be incorporated into all pages including the homepage


To render the homepage you can call.

```shell
$ docker run --mount type=bind,target=/home/rstudio,source=$PWD ccdl/refinebio-examples snakemake render_homepage
```

Please note the rule for updating the homepage will not be applied when calling `snakemake --forceall` so you must render and commit changes. The github action does not render these out on merges.
