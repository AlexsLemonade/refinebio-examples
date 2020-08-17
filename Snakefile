rule target:
    input:
        "01-getting-started/getting-started.html",
        "03-rnaseq/clustering_rnaseq_01_heatmap.html",
        "03-rnaseq/differential_expression_rnaseq_01_rnaseq.html"

rule render_citations:
    input:
        rmd = "{basename}.Rmd",
        bib = "references.bib"
    output:
       "{basename}.html"
    shell:
        "Rscript scripts/render-notebooks.R"
        " --rmd {input.rmd}"
        " --bib_file {input.bib}"
        " --html {output}"
        " --style"
