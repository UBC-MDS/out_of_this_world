## Makefile
## The Out of This World Crew, 12/1/2020
##
## This driver script downloads the data and runs the analysis for our project.
## This script takes no arguments
##
## Example usage:
## make all

all : doc/ufo_report.md

# If we tweak the download script, we need to rerun it
data/raw/aliens.csv : src/download_data.py 
	python src/download_data.py --location='BC WA' --output_file=data/raw/aliens.csv

# The cleaning script should be rerun if we redownload the data or change the cleaning script
data/processed/aliens.csv : src/times_cleaning.R data/raw/aliens.csv
	Rscript src/times_cleaning.R --fp_raw="data/raw/aliens.csv" --fp_pro=" data/processed/aliens.csv"

# If we change our EDA script or the data, these figures and tables should be recreated
ufo_duration_distriubution.png summary_shape.rds ufo_duration_summary.rds : data/processed/aliens.csv src/ufo_eda.RMD
	Rscript src/ufo_eda_bcwa.R --input_data='data/processed/aliens.csv'  --out_dir='results/'

# We need to recreate these objects/ images if we tweak the analysis
KW.rds Dunn.rds pairwise_plt.png : src/analysis.R data/processed/aliens.csv
	Rscript src/analysis.R --fp_pro='data/processed/aliens.csv' --fp_results="results/"
  
# We need to regenerate the final report should any of these files be changed
doc/ufo_report.md : KW.rds Dunn.rds pairwise_plt.png summary_shape.rds ufo_duration_summary.rds src/ufo_eda.rmd doc/ufo_refs.bib
	Rscript -e "rmarkdown::render('doc/ufo_report.Rmd', output_format = 'github_document')"  
  
# Cleaning
clean :
	rm data/raw/aliens.csv
	rm data/processed/aliens.csv
	rm -f results/*.png
	rm -f results/*.rds
	rm doc/ufo_report.md
  
  


