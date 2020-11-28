# author: Steffen Pentelow
# date: 2020-11-27

"This script performs a Kruskal-Wallis test and Dunn's test.  The results are
recorded in an RDS file for the Kruskal-Wallis results, and an RDS file and .png
figure for the Dunn's test results.

Usage: analysis.R --fp_pro=<fp_pro> --fp_results=<fp_results>

Options:
--fp_pro = <fp_pro>         Path of the cleaned .csv file to analyze (e.g., 
                            'data/processed/aliens.csv')
--fp_results = <fp_results> Location to save results (e.g. 'results/')
" -> doc

library(here)
library(tidyverse)
library(testthat)
library(docopt)
library(DescTools)
library(reshape2)
library(ggplot2)

opt <- docopt(doc)

main <- function() {
  processed_data <- read_csv(here(opt$fp_pro))
  # Remove unwanted shapes and group data
  shape_duration <- processed_data %>%
    select(Shape, duration_sec) %>%
    filter(Shape != c('Flash', 'Light')) %>%
    mutate(Shape = factor(Shape))
  
  
  alpha <- 0.05  # Specifying level of significance of 0.05
  
  # Kruskal-Wallis test
  kusk <- kruskal.test(duration_sec ~ Shape, data = shape_duration)
  write_rds(tidy(kusk), here(opt$fp_results, 'KW.rds'))
  
  # Dunn Test
  Dunn_table <-
    DunnTest(shape_duration$duration_sec, shape_duration$Shape, method = 'bonferroni')
  Dunn_table <-
    as_tibble(Dunn_table[[1]], rownames = 'Comparison') %>%
    select(Comparison, pval) %>%
    filter(pval > alpha)
 write_rds(Dunn_table, here(opt$fp_results, 'Dunn.rds'))
  
  # Create matrix of pairwise adjusted p values from Dunn test for plotting
  Dunn_matrix <-
    DunnTest(
      shape_duration$duration_sec,
      shape_duration$Shape,
      method = 'bonferroni',
      out.list = FALSE
    )[[1]]
  
  n_shapes = dim(Dunn_matrix)[1] + 1
  
  Dunn_matrix = rbind(rep(NA, n_shapes - 1), Dunn_matrix)
  Dunn_matrix = cbind(Dunn_matrix, rep(NA, n_shapes))
  rownames(Dunn_matrix)[1] = colnames(Dunn_matrix)[1]
  colnames(Dunn_matrix)[n_shapes] = rownames(Dunn_matrix)[n_shapes]
  
  # Create boolean matrix based on sigificance of p-value
  pairwise_matrix_sig <- Dunn_matrix < alpha
  pairwise_melted <- melt(pairwise_matrix_sig)
  
  #Visualization
  pairwise_plt <- ggplot(pairwise_melted) +
    aes(x = Var1,
        y = Var2,
        fill = value) +
    geom_tile() +
    scale_fill_manual(
      labels = c(
        'Fail to reject null hypothesis (p>0.05)',
        'Reject null hypothesis (p<0.05)',
        ''
      ),
      values = c('grey', 'red'),
      na.value = 'white'
    ) +
    theme(
      axis.text.x = element_text(angle = 90),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      legend.title = element_blank(),
      legend.position='bottom'
    ) +
    ggtitle("Results of pairwise comparison of duration distributions using Dunn's Test")
  
  ggsave(here(opt$fp_results, 'pairwise_plt.png'))
}


main()
