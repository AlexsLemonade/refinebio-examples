rule target:
    input: 
        "01-getting-started/getting-started.html" 

rule render_citations:
    input:
        "01-getting-started/getting-started.Rmd"
    shell:
        "Rscript scripts/render-notebooks.R --rmd {input} --bib_file references.bib"