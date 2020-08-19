rule target:
    input:
        "01-getting-started/getting-started.html",
        "03-rnaseq/clustering_rnaseq_01_heatmap.html",
        "03-rnaseq/dimension_reduction_rnaseq_01_pca.html"

rule render_citations:
    input:
        rmd = "{basedir}/{basename}.Rmd",
        bib = "references.bib"
    output:
       "{basedir}/{basename}.html"
    shell:
        "Rscript scripts/render-notebooks.R"
        " --rmd {input.rmd}"
        " --bib_file {input.bib}"
        " --html {output}"
        " --style"
