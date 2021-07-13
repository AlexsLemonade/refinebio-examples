#!/usr/bin/env Rscript
#
# Concat the refinebio-examples homepage together

# Example use:

# Rscript scripts/render-homepage.R


# read in the homepage partial that contains the comments that will be replaced
home_file <- file.path("components", "_homepage.html")
home_lines <- readr::read_lines(home_file)

# find the comment and replace with the contents of components/_navbar.html
navbar_comment<- "<!-- NAVIGATION -->"
navbar_index <- which(grepl(navbar_comment, home_lines))
navbar_file <- normalizePath(file.path("components", "_navbar.html"))
navbar_lines <- readr::read_lines(navbar_file)
home_lines <- append(home_lines, navbar_lines, navbar_index)


# find the comment and replace with the contents of components/footer.html
footer_comment <- "<!-- FOOTER -->"
footer_index <- which(grepl(footer_comment, home_lines))
footer_file <- normalizePath(file.path("components", "footer.html"))
footer_lines <- readr::read_lines(footer_file)
home_lines <- append(home_lines, footer_lines, footer_index)

# replace any relative sources
# Rmarkdown looks for an image locally (inside /components)
# the homepage looks for the file on the server (inside /refinebio-examples/components)
home_lines <- sub('href="../', 'href="/refinebio-examples/', home_lines)
home_lines <- sub('src="../', 'src="/refinebio-examples/', home_lines)

# save to index.html
readr::write_lines(home_lines, 'index.html')
