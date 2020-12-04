
# UFO Sighting

  - author: Group-20 DSCI-522
  - contributors: Jacob McFarlane, Chirag Rank, Steffen Pentelow, Anita
    Li

## About

Unidentified flying objects (UFOs) have different shapes and could
potentially be linked with the duration of sightings. In this analysis
we use Kruskal-Wallis test to answer whether the duration of sightings
of UFOs of different shapes are significantly different. The result
indicates that there are differences in duration among these shapes.
Then, we selected Dunn’test for Post-Hoc analysis with Bonferroni’s
correction to identify pairs of groups whose median duration are
significantly different.

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

## Report

The final report can be found
[here](https://github.com/UBC-MDS/out_of_this_world/blob/main/doc/ufo_report.md).

## Usage

Clone this GitHub repository, install the [dependencies](#dependencies)
listed below, and run the following commands at the terminal from the
root directory of this project:

    make all

To reset the repo to a clean state, with no intermediate or result
files, run the following command at the terminal from the root directory
of this preoject:

    make clean

## Dependencies Diagram

![](Makefile.png)

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
      - docopt==0.7.1
      - testthat==3.0.0
      - arrow==2.0.0
      - here==1.0.0
      - DescTools==0.99.38
      - reshape2==1.4.4
      - broom==0.7.0
      - infer==0.5.3

# References

<div id="refs" class="references">

<div id="ref-docopt">

de Jonge, Edwin. 2018. *Docopt: Command-Line Interface Specification
Language*. <https://CRAN.R-project.org/package=docopt>.

</div>

<div id="ref-docoptpython">

Keleshev, Vladimir. 2014. *Docopt: Command-Line Interface Description
Language*. <https://github.com/docopt/docopt>.

</div>

<div id="ref-R">

R Core Team. 2019. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.
<https://www.R-project.org/>.

</div>

<div id="ref-Python">

Van Rossum, Guido, and Fred L. Drake. 2009. *Python 3 Reference Manual*.
Scotts Valley, CA: CreateSpace.

</div>

<div id="ref-tidyverse">

Wickham, Hadley. 2017. *Tidyverse: Easily Install and Load the
’Tidyverse’*. <https://CRAN.R-project.org/package=tidyverse>.

</div>

<div id="ref-knitr">

Xie, Yihui. 2014. “Knitr: A Comprehensive Tool for Reproducible Research
in R.” In *Implementing Reproducible Computational Research*, edited by
Victoria Stodden, Friedrich Leisch, and Roger D. Peng. Chapman;
Hall/CRC. <http://www.crcpress.com/product/isbn/9781466561595>.

</div>

</div>
