rule target:
    input:
        "01-getting-started/getting-started.html",
        "03-rnaseq/clustering_rnaseq_01_heatmap.html",
        "03-rnaseq/differential_expression_rnaseq_01_rnaseq.html"
        "02-microarray/00-intro-to-microarray.html",
        "03-rnaseq/00-intro-to-rnaseq.html",
        "03-rnaseq/clustering_rnaseq_01_heatmap.html",
        "03-rnaseq/00-intro-to-rnaseq.html",
        "04-advanced-topics/00-intro-to-advanced-topics.html"

rule render_citations:
    input:
        rmd = "{basedir}/{basename}.Rmd",
        nav = "{basedir}/_navbar.html",
        bib = "references.bib"
    output: 
       "{basedir}/{basename}.html"
    shell:
        "Rscript scripts/render-notebooks.R"
        " --rmd {input.rmd}"
        " --bib_file {input.bib}"
        " --html {output}"
        " --style"
