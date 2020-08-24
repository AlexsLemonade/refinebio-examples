rule target:
    input:
        "01-getting-started/getting-started.html",
        "02-microarray/00-intro-to-microarray.html",
        "03-rnaseq/clustering_rnaseq_01_heatmap.html",
        "03-rnaseq/differential-expression_rnaseq_01.html",
        "03-rnaseq/00-intro-to-rnaseq.html",
        "03-rnaseq/dimension_reduction_rnaseq_01_pca.html",
        "04-advanced-topics/00-intro-to-advanced-topics.html"

rule render_citations:
    input:
        rmd = "{basedir}/{basename}.Rmd",
        nav = "{basedir}/_navbar.html",
        bib = "references.bib",
        csl = "components/genetics.csl"
    output:
       "{basedir}/{basename}.html"
    shell:
        "Rscript scripts/render-notebooks.R"
        " --rmd {input.rmd}"
        " --bib_file {input.bib}"
        " --cite_style {input.csl}"
        " --html {output}"
        " --style"
