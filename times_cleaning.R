
library(testthat)
library(tidyverse)

#' Cleans times
#'
#' This is a function to take times inputted by users of online forms without any restrictions
#' and converts them to seconds
#' 
#' @param df 
#' @param column 
#'
#' @return df 
#' @export
#'
#' @examples
clean_times <- function(df, col_to_clean, clean_col_name){
  return(df)
}


# Tests
# Setting up test data
dirty_times <- c("2 minutes", "5 mins", "10 min.", "1 minute", "25 MINS",
                 "2 hours", "5 hours", "10 hour.", "1 HOUR", "25 hours",
                 "1 second", "5 seconds", "10. seconds", "5 SEC", "120 SECS",
                 "~1 sec", "1-2 mins", "all night", "now", "ten seconds!!!", "<10 secs",
                 ">10 secs", "almost 10 secs", "7:45-9:21", "1 hour approx.")

labels <- rep(c("minute", "hour", "second", "NA", "NA"), each = 5)

clean_times <- c(120, 300, 600, 60, (25 * 60),
                 2 * 3600, 5 * 3600, 10 * 3600, 1 * 3600, 25 * 3600,
                 1, 5, 10, 5, 120,
                 rep(NA, 10))

test_tib <- tibble(dirty_times = dirty_times, labels = labels, clean_times = clean_times)

# Does the function handle minutes well?

test_mins <- test_tib %>%
  filter(labels == "minute")

test_that("Function converts minutes well",
          expect_equal())






# # basic cleaning
# ufo_tidy <- ufos %>%
#   mutate(approximate = if_else(str_detect(Duration, "~|About|<|>"),1,0),
#          range = if_else(str_detect(Duration, "-|:|to"),1,0),
#          decimal = if_else(str_detect(Duration, "\\."),1,0),
#          nightly = if_else(str_detect(Duration, "night"),1,0),
#          minute = if_else(str_detect(Duration, "((M|m)in)|MIN"),1,0),
#          second = if_else(str_detect(Duration, "((S|s)ec)|SEC"),1,0),
#          hour = if_else(str_detect(Duration, "((H|h)our)|HOUR"),1,0)) %>%
#   filter(approximate == 0 & range == 0 & decimal == 0, nightly == 0) %>%
#   mutate(numeric_vals = str_extract_all(Duration, "[:digit:]+")) %>%
#   unnest(numeric_vals) %>%
#   mutate(numeric_vals = as.numeric(numeric_vals), 
#          clean_vals = case_when(
#            hour == 1 ~ (numeric_vals * 3600),
#            minute == 1 ~ (numeric_vals * 60),
#            second == 1 ~ numeric_vals)) %>%
#   drop_na(clean_vals, Shape) %>%
#   filter(!Shape %in% c('Unknown', 'Other', 'Changing', '')) %>%
#   select(`Date / Time`, City, State, Shape, clean_vals) %>%
#   rename(
#     data_time = `Date / Time`,
#     duration_sec = clean_vals
#   )