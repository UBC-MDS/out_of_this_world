# author: Jacob McFarlane
# date: 2020-11-25
# From terminal in the root of the project, call:
# Rscript src/times_cleaning.R --fp_raw="data/raw/aliens.csv" --fp_pro="data/processed/aliens.csv"


"This script cleans the raw text duration input from the database and 
converts it into seconds

Usage: times_cleaning.R --fp_raw=<fp_raw> --fp_pro =<fp_pro>

Options:
--fp_raw = <fp_raw>        Path to the raw file
--fp_pro = <fp_pro>  Location to write the cleaned data
"-> doc

library(tidyverse)
library(testthat)
library(docopt)

opt <- docopt(doc)

main <- function(){
  df <- read_csv(opt$fp_raw)
  df <- df %>%
    clean_times(Duration, duration_sec) %>%
    drop_na(duration_sec, Shape) %>%
    select(`Date / Time`, City, State, Shape, duration_sec) %>%
    mutate(log_sec = log(duration_sec)) %>%
    rename(date_time = `Date / Time`) %>%
    write_csv(opt$fp_pro)}

#' Cleans times
#'
#' This is a function to take times inputted by users of online forms without any restrictions
#' and converts them to seconds. Approximate times, times given as a range, or times given 
#' in units other than seconds, minutes, or hours return NA.
#' 
#' @param df The Dataframe to Clean
#' @param col_to_clean The Column of Raw Text Durations
#' @param clean_col_name The Name of The New Column
#'
#' @return df 
#' @export
#'
#' @examples
clean_times <- function(df, col_to_clean, clean_col_name){
  df %>%
    # Note: Creates many extra columns, I'm keeping those in for now in case we want
    # To handle approximations, decimals, or ranges differently.
    
    # Big ugly regex to pickout different features in the string slugs
    mutate(approximate = if_else(str_detect({{ col_to_clean }}, "~|About|<|>"),1,0),
         range = if_else(str_detect({{ col_to_clean }}, "-|:|to"),1,0),
         decimal = if_else(str_detect({{ col_to_clean }}, "[:digit:]\\.[:digit:]"),1,0),
         nightly = if_else(str_detect({{ col_to_clean }}, "night"),1,0),
         minute = if_else(str_detect({{ col_to_clean }}, "((M|m)in)|MIN"),1,0),
         second = if_else(str_detect({{ col_to_clean }}, "((S|s)ec)|SEC"),1,0),
         hour = if_else(str_detect({{ col_to_clean }}, "((H|h)our)|HOUR"),1,0)) %>%
    
    # Filtering out values if they triggered the regex for approximate, range,
    # Duration of nights, or  decimal
    filter(approximate == 0 & range == 0 &  nightly == 0 & decimal == 0) %>%
    
    # Pulling our the actual numeric values
    mutate(numeric_vals = str_extract_all({{ col_to_clean }}, "[:digit:]+")) %>%
    unnest(numeric_vals) %>%
    
    # Converting numeric values to seconds
    mutate(numeric_vals = as.numeric(numeric_vals),
         {{ clean_col_name }} := case_when(
           hour == 1 ~ (numeric_vals * 3600),
           minute == 1 ~ (numeric_vals * 60),
           second == 1 ~ numeric_vals)) %>%
    select(-c(range, decimal, nightly, minute, second, hour, approximate, numeric_vals))
}

# Testing 

# Setting up test data
dirty_times <- c("2 minutes", "5 mins", "10 min.", "1 minute", "25 MINS",
                 "2 hours", "5 hours", "10 hour.", "1 HOUR", "25 hours",
                 "1 second", "5 seconds", "10. seconds", "5 SEC", "120 SECS",
                 "~1 sec", "1-2 mins", "all night", "now", "ten seconds!!!", "<10 secs",
                 ">10 secs", "almost 10 secs", "7:45-9:21", "1 hour approx.", "1.1")

labels <- c(rep(c("minute", "hour", "second", NA, NA), each = 5), NA)

clean_vals <- c(120, 300, 600, 60, (25 * 60),
                 2 * 3600, 5 * 3600, 10 * 3600, 1 * 3600, 25 * 3600,
                 1, 5, 10, 5, 120,
                 rep(NA, 11))

test_tib <- tibble(dirty_times = dirty_times, labels = labels, clean_vals = clean_vals)

# Does the function handle minutes well?
mins_df <- test_tib %>% 
 filter(labels == "minute")

test_that("Function converts minutes well",
          expect_equal((clean_times(df = mins_df,
                                   col_to_clean = dirty_times,
                                   clean_col_name = duration)) %>% pull(duration),
                       mins_df %>% pull(clean_vals)))

# Does the function handle hours well?
hours_df <- test_tib %>% 
  filter(labels == "hour")

test_that("Function converts hours well",
          expect_equal((clean_times(df = hours_df,
                                    col_to_clean = dirty_times,
                                    clean_col_name = duration)) %>% pull(duration),
                       hours_df %>% pull(clean_vals)))

# Does the function handle seconds per specification?
secs_df <- test_tib %>% 
  filter(labels == "second")

test_that("Function converts seconds well",
          expect_equal((clean_times(df = secs_df,
                                    col_to_clean = dirty_times,
                                    clean_col_name = duration)) %>% pull(duration),
                       secs_df %>% pull(clean_vals)))


# Does the function drop time values that are approximate, represent ranges, or 
# Invalid inputs?

nas_df <- test_tib %>%
  filter(labels == "NA")

test_that("The function drops appropriate values",
          expect_equal((clean_times(df = nas_df,
                                    col_to_clean = dirty_times,
                                    clean_col_name = duration)) %>% pull(duration),
                       nas_df %>% pull(clean_vals)))

main()

