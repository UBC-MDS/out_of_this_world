
library(testthat)
library(tidyverse)

#' Cleans times
#'
#' This is a function to take times inputed by users of online forms without any restrictions
#' and converts them to seconds
#' 
#' @param df 
#' @param column 
#'
#' @return
#' @export
#'
#' @examples
clean_times <- function(df, col_to_clean, clean_col_name){
  return(df)
}

# Tests
# Minutes
dirty_minutes <- c("2 minutes", "5 mins", "10 min.", "1 minute")
clean_minutes <- c(120, 300, 600, 60)

minute_tests <- tibble(dmins = dirty_minutes, 
                       cmins = clean_minutes)

clean_minute_tests <- clean_times(minute_tests, dmins, ct_mins)

test_that("The minutes are converted per specifications",
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