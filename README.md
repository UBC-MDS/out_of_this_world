
# UFO Sighting

-   author: Group-20 DSCI-522
-   contributors: Jacob McFarlane, Chirag Rank, Steffen Pentelow, Anita
    Li

# Proposal

## Data Set

We have selected the National UFO Reporting Center (NUFORC) maintained
database of sightings of unidentified flying objects (UFO). We will deal
specifically with reports made in British Columbia, Canada and
Washington State, USA before 11/18/2020. While NURFORC does curate
reports and remove obvious hoaxes, the data is submitted by users and in
the majority of cases presented in the users’ own words. The data set
for BC can be found [here](http://www.nuforc.org/webreports/ndxlBC.html)
and the data set for Washington can be found
[here](http://www.nuforc.org/webreports/ndxlWA.html). Each row contains
information on a single reported UFO sighting. Our analysis focuses on
the `shape` and `duration` columns of the data set.

## Primary Question

Our primary questions is inferential: Is the median duration of
sightings of UFOs of different shapes different?

## Analysis Plan

Our main tool for this analysis will be a statistical hypothesis test.
We plan to use a Kruskal-Wallis test in order to answer the question. As
a part of our exploratory analysis, we will create jitter plots of
duration of sightings for each shape. We will also create a table for
summary statistics separated by sighting.

## Report Structure

We will ultimately present a report containing plots to illustrate the
duration of sightings for each UFO shape, the numerical results of our
statistical analysis (Kruskal-Wallis test for difference in median
duration of sightings for each UFO shape), and a discussion of our
procedure and results. As a first step, we have conducted an exploratory
analysis of the data and produced a summary table of durations and
jitter plots for each shape which can be found
[here](https://github.com/UBC-MDS/out_of_this_world/blob/main/src/ufo_eda.pdf).

## Usage

Clone this GitHub repository, install the [dependencies](#dependencies)
listed below, and run the following commands at the terminal from the
root directory of this project:

    # download data
    python src/download_data.py --location='BC WA' --output_file=data/raw/aliens.csv

    # run eda report
    Rscript -e "rmarkdown::render('src/ufo_eda.Rmd')"

    # pre-process data 
    Rscript src/times_cleaning.R --fp_raw="data/raw/aliens.csv" --fp_pro="data/processed/aliens.csv"

    # create and save exploratory data analysis figure
    Rscript src/ufo_eda_BcWa.R --input_data='data/processed/aliens.csv'  --out_dir='results/'

    # statistical analysis
    Rscript src/analysis.R --fp_pro='data/processed/aliens.csv' --fp_results="results/"

    # render final report
    Rscript -e "rmarkdown::render('doc/ufo_report.Rmd', output_format = 'github_document')"

## Dependencies

-   Python 3.8.5 and Python packages:

    -   docopt==0.6.2
    -   feather-format==0.4.1
    -   pandas==1.1.3
    -   lxml==4.6.1

-   R 4.0.2 and R packages:

    -   tidyverse==1.3.0
    -   feather==0.3.5
    -   ggplot2==3.3.2
    -   knitr==1.29
    -   readr==1.3.1
    -   docopt==0.7.1
    -   testthat==3.0.0
    -   arrow==2.0.0
    -   here==1.0.0
    -   DescTools==0.99.38
    -   reshape2==1.4.4
    -   broom==0.7.0
    -   infer==0.5.3

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-docopt" class="csl-entry">

de Jonge, Edwin. 2018. *Docopt: Command-Line Interface Specification
Language*. <https://CRAN.R-project.org/package=docopt>.

</div>

<div id="ref-docoptpython" class="csl-entry">

Keleshev, Vladimir. 2014. *Docopt: Command-Line Interface Description
Language*. <https://github.com/docopt/docopt>.

</div>

<div id="ref-R" class="csl-entry">

R Core Team. 2019. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-Python" class="csl-entry">

Van Rossum, Guido, and Fred L. Drake. 2009. *Python 3 Reference Manual*.
Scotts Valley, CA: CreateSpace.

</div>

<div id="ref-tidyverse" class="csl-entry">

Wickham, Hadley. 2017. *Tidyverse: Easily Install and Load the
’tidyverse’*. <https://CRAN.R-project.org/package=tidyverse>.

</div>

<div id="ref-knitr" class="csl-entry">

Xie, Yihui. 2014. “Knitr: A Comprehensive Tool for Reproducible Research
in R.” In *Implementing Reproducible Computational Research*, edited by
Victoria Stodden, Friedrich Leisch, and Roger D. Peng. Chapman;
Hall/CRC. <http://www.crcpress.com/product/isbn/9781466561595>.

</div>

</div>
