# author: Anita Li
# date: 2020-11-27

"Create eda summary table and plot for the pre-processed training data from BC, Canada
and Washington States, USA UFO sighting data.
Saves table as rds file, and plot as png file.

Usage: src/ufo_eda_BcWa.R --input_data=<input_data>  --out_dir=<out_dir>

Options:
--input_data=<input_data>         Path (including filename) to pre-processed data(e.g. 'data/processed/aliens.csv') 
--out_dir=<out_dir>               Location to save results (i.e. 'results/')
" -> doc

library(tidyverse)
library(readr)
library(docopt)
library(ggplot2)
library(infer)

opt <- docopt(doc)

main <- function(input_data, out_dir) {
  ufo_tidy <- read_csv(input_data)
  
  ufo_summary <- ufo_tidy %>%
    group_by(Shape) %>%
    summarise(median = median(duration_sec),
              count = n(),
              min = min(duration_sec),
              max = max(duration_sec)) %>%
    arrange(median)
  
  write_rds(ufo_summary, paste0(out_dir, '/summary_shape.rds'))
  
  # get the order of shapes by median
  shape_order <- as.vector(ufo_summary$Shape)
  ufo_plot <- ufo_tidy %>%
    filter(Shape %in% shape_order) %>%
    ggplot(aes(x = duration_sec, 
               y = factor(Shape, levels = shape_order))) +
    geom_boxplot(size = 1) +
    scale_x_log10(labels = scales::comma) +
    xlab("Duration (in log10 scale)") +
    ylab("UFO shape") +
    theme(legend.position = 'top',
          legend.title = element_blank(),
          panel.background = element_blank(),
          axis.line = element_line(size = 1),
          axis.ticks = element_line(size = 1),
          axis.ticks.length = unit(.25, 'cm'),
          text = element_text(size = 15),
          plot.margin = unit(c(1, 1, 1, 1), 'cm')
    )
  ggsave(paste0(out_dir, "/ufo_duration_distribution.png"),
         ufo_plot,
         width = 10,
         height = 9)
}


main(opt[["--input_data"]], opt[["--out_dir"]])

