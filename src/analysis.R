# author: Steffen Pentelow
# date: 2020-11-26

"This script ###

Usage: analysis.R --fp_pro=<fp_pro>

Options:
--fp_pro = <fp_pro>  Location to read the cleaned data to analyze
"-> doc

library(tidyverse)
library(testthat)
library(docopt)
library(arrow)

opt <- docopt(doc)

main <- function(){
  df <- read_feather(opt$fp_raw)
  df <- df %>%
    clean_times(Duration, duration_sec) %>%
    drop_na(duration_sec, Shape) %>%
    filter(!Shape %in% c('Unknown', 'Other', 'Changing', '')) %>%
    select(`Date / Time`, City, State, Shape, duration_sec) %>%
    mutate(log_sec = log(duration_sec)) %>%
    rename(date_time = `Date / Time`) %>%
    write_feather(opt$fp_pro)
}