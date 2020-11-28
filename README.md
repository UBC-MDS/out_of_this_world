# Proposal

## Data Set

We have selected the National UFO Reporting Center (NUFORC) maintained database of sightings of unidentified flying objects (UFO). We will deal specifically with reports made in British Columbia, Canada and Washington State, USA before 11/18/2020. While NURFORC does curate reports and remove obvious hoaxes, the data is submitted by users and in the majority of cases presented in the users' own words.  The data set for BC can be found [here](http://www.nuforc.org/webreports/ndxlBC.html) and the data set for Washington can be found [here](http://www.nuforc.org/webreports/ndxlWA.html).  Each row contains information on a single reported UFO sighting.  Our analysis focuses on the `shape` and `duration` columns of the data set.

## Primary Question

Our primary questions is inferential: Is the median duration of sightings of UFOs of different shapes different?

## Analysis Plan

Our main tool for this analysis will be a statistical hypothesis test. We plan to use a Kruskal-Wallis test in order to answer the question. As a part of our exploratory analysis, we will create jitter plots of duration of sightings for each shape. We will also create a table for summary statistics separated by sighting.

## Report Structure

We will ultimately present a report containing plots to illustrate the duration of sightings for each UFO shape, the numerical results of our statistical analysis (Kruskal-Wallis test for difference in median duration of sightings for each UFO shape), and a discussion of our procedure and results.  As a first step, we have conducted an exploratory analysis of the data and produced a summary table of durations and jitter plots for each shape which can be found [here](https://github.com/UBC-MDS/out_of_this_world/blob/main/src/ufo_eda.pdf).

## Usage


```r
# run eda report
Rscript -e "rmarkdown::render('src/ufo_eda.Rmd')"

# create exploratory data analysis table and figure and write to file 
Rscript src/ufo_eda_bcwa.r --input_data=data/processed/aliens.csv --out_dir=results

```

## Dependencies

- Python 3.8.5 and Python packages:

  - docopt==0.6.2
  - feather-format==0.4.1
  - pandas==1.1.3
  - lxml==4.6.1
  
- R 4.0.2 and R packages:
  - tidyverse==1.3.0
  - feather==0.3.5
  - ggplot2==3.3.2
  - knitr==1.29
  - readr==1.3.1
  

