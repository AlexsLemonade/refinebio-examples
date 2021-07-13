# Updating Homepage- refinebio-examples

## Making Changes

You can edit `components/_homepage.html` and save to apply your changes to the homepage.

Editing `components/_navbar.html` or `components/footer.html` will be incorporated into all pages including the homepage when rendered.

### Rendering

```shell
$ docker run --mount type=bind,target=/home/rstudio,source=$PWD ccdl/refinebio-examples snakemake --cores 4
```

### Local Development

Launching a simple server is helpful for previewing changes. In order to mirror how github-pages works it is recommended to run the server from the parent directory of the project. This will will give you urls like `http://localhost:8000/refinebio-examples/001-example/link-to-example.html`.

```shell
python -m SimpleHTTPServer 8000
```
or

```shell
python3 -m http.server 8000
```
