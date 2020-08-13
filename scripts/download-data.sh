# Download refinebio-example data for development purposes
# C. Savonen

set -e
set -o pipefail

# Set the working directory to the directory of this file
cd "$(dirname "${BASH_SOURCE[0]}")"

# Download each folder to its respective folder
FOLDERS=(02-microarray 03-rnaseq 04-advanced-topics)

# Download by each folder
for FOLDER in "${FOLDERS[@]}"
  do
  mkdir -p ../$FOLDER/data/
  aws --no-sign-request s3 cp s3://refinebio-examples/$FOLDER ../$FOLDER/data --recursive
  done
