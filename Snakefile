folders = ["02-microarray", "03-rnaseq", "04-advanced-topics"]

rule target:
    input: 
        "01-getting-started/getting-started.html",
        "03-rnaseq/clustering_rnaseq_01_heatmap.html",
        expand("{basedir}/data", basedir = folders)
        
rule download: 
    output:
        directory(expand("{basedir}/data", basedir = folders))
    shell:  
       "scripts/download-data.sh"

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
