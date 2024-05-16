library(ggplot2)
library(tidyr)
library(dplyr)
library(rlang)
winners_curse_results <- readRDS('2024-05-14_winners_curse/2024-05-16_winners_curse_results.rds')

# Pivot longer only on the `cursed` columns and `ma` columns
long_data <- winners_curse_results %>%
  pivot_longer(
    cols = c(contains('cursed'), contains('ma')),
    names_to = c('model', 'metric', 'edge'),
    names_pattern = '(.*)_(beta|log10_pvals|bias|n)_(.*)',
    values_to = 'value'
  )

bias_data <- long_data %>%
  filter(metric == 'bias')

beta_data <- long_data %>%
  filter(metric == 'beta')

summary_data <-  long_data %>%
  filter(metric %in% c('bias', 'beta')) %>%
  group_by(metric, model, alpha, eta, edge, scale_effects) %>%
  summarize(
    mean = mean(value),
    sd = sd(value),
    median = median(value),
    min = min(value),
    max = max(value)
  )

filter_alpha <- 5e-08 # 1e-07, 5e-08, 1e-09
filter_scale_effects <- 1
mean_bias <- bias_data %>%
  filter(alpha == filter_alpha & scale_effects == filter_scale_effects) %>%
  group_by(model, alpha, eta, edge) %>%
  summarize(
    mean = mean(value)
  )

bias_data %>%
  filter(alpha == filter_alpha & scale_effects == filter_scale_effects) %>%
  ggplot(., aes(x = value, fill = model), alpha = 0.5) +
  facet_grid(rows = vars(edge), cols = vars(eta)) +
  geom_histogram(alpha = 0.5, position="identity") +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_vline(data = mean_bias, aes(xintercept = mean, color = model)) +
  theme_minimal()