# Proposal

## Data Set

We have selected the National UFO Reporting Center (NUFORC) maintained database of sightings of unidentified flying objects (UFO). We will deal specifically with reports made in British Columbia, Canada before 11/18/2020. While NURFORC does curate reports and remove obvious hoaxes, the data is submitted by users and in the majority of cases presented in the users's own words.  The data set can be found [here](http://www.nuforc.org/webreports/ndxlBC.html).  Each row contains information on a single reported UFO sighting.  Our analysis focuses on the `shape` and `duration` columns of the data set.

## Primary Question

Our primary questions is inferential: Is the mean duration of sightings of UFOs of different shapes different?

## Analysis Plan

Our main tool for this analysis will be a statistical hypothesis test. We plan to follow an analysis of variance (ANOVA) procedure followed by a post-hoc test like Tukey's HSD (honest significant difference) in order to answer the question. As a part of our exploratory analysis, we will create a violin plot of duration of sighting seperated by each shape. We will also create a table for summary statistics seperated by sighting.

## Report Structure

We will ultimately present a report containing plots to illustrate the duration of sightings for each UFO shape, the numerical results of our statistical analysis (ANOVA and Turkey's HSD for the mean duration of sightings for each UFO shape), and a discussion of our proceedure and results.  As a first step, we have produced individual violin plots of particularly interesting shapes.