library(tidyverse)
library(feather)
library(ggplot2)
library(knitr)
library(broom)

ufo_tidy <- ufo_tidy %>%
  mutate(log_seconds = log(duration_sec)) 

ufo_shapiro <- ufo_tidy %>%
  group_by(Shape) %>%
  nest() %>%
  mutate(
    shapiro_wilks_test = map_df(data, ~tidy(shapiro.test(.$log_seconds))),
    var_log_secs = map_dbl(data, ~var(.$log_seconds))) %>%
  select(Shape, shapiro_wilks_test) 

# Distributions
ggplot(data = ufo_tidy, aes(sample = log_seconds)) +
  stat_qq() +
  facet_wrap(~Shape)

# Homogeneity of Variance
# Levene Test:
# Suggests heterogeneous variance. Welch's Test Maybe?
ufo_tidy <- ufo_tidy %>%
  mutate(log_seconds = log(duration_sec))

tidy(leveneTest(log_seconds ~ Shape, data = ufo_tidy))
