rule target:
    input: 
        "01-getting-started/getting-started.html" 

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
