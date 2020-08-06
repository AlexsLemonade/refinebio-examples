rule target:
    input: 
        "01-getting-started/getting-started.html" 

rule render_citations:
    input:
        rmd = "01-getting-started/getting-started.Rmd",
        bib = "references.bib
    output: 
       "01-getting-started/getting-started.html"
    shell:
        "Rscript scripts/render-notebooks.R \"
        "--rmd {input.rmd} \"
        "--bib_file {input.bib} \"
        "--html {output}"