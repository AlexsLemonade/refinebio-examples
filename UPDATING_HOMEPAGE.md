# Updating Homepage- refinebio-examples

## Making Changes

You can edit `components/_homepage.html` and save to apply your changes to the homepage.

Editing `components/_navbar.html` or `components/footer.html` will be incorporated into all pages including the homepage

### Rendering

The rule for updating the homepage will not be applied when calling `snakemake --forceall` so you must render and commit changes. The github action does not render these out on merges.
To render the changes to the homepage you can call:

```shell
$ docker run --mount type=bind,target=/home/rstudio,source=$PWD ccdl/refinebio-examples snakemake render_homepage
```

### Local Development

Launching a simple server is helpful for previewing changes. In order to mirror how github-pages works it is recommended to run the server from the parent directory of the project.
```shell
python -m SimpleHTTPServer 8000
```
