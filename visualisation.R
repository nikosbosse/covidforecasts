library(EpiSoon)
library(bsts)
library(cowplot)
library(ggplot2)

# ========= load data and results ========== #

results_dir <- "../epipredictr/data/results/"
date <- as.Date("2020-03-13")
data <- EpiNow::get_timeseries(results_dir = results_dir, 
                                date = date)

data <- readRDS("data/data.rds")

regions <- unique(data$rt$region)
observations <- lapply(seq_along(regions),
                       function (i) {
                         data[[1]] %>% 
                           dplyr::filter(region == regions[i]) %>%
                           dplyr::select("median", "date") %>%
                           dplyr::rename(rt = median)
                       })
names(observations) <- unique(data$rt$region)

evaluations <- readRDS("forecast_evaluation.rds")

# regions for which we have forecasts
regions <- unique(evaluations$forecasts$region)
observations[!(names(observations) %in% regions)] <- NULL

#============================================================== # 
# look at one day ahead forecasts
# ============================================================= #

# ============================================================= #
# predictions
observations <- do.call(rbind, observations)
observations$region <- gsub("\\..*","", rownames(observations))

out <- plot_forecast_evaluation(forecasts = evaluations$forecasts, 
                                observations = observations, c(1)) +
  ggplot2::facet_grid(region ~ model) +
  cowplot::panel_border() + theme(text = element_text(family = 'Sans Serif'),
                                  legend.position = "bottom")

ggsave2("results/plots/forecasts_one_ahead_all_regions.png",
        plot = out, width = 15,height = 30)

# ============================================================= #
# scores

horizon <- summarise_scores(evaluations$scores, variables = "horizon")
horizon %>% dplyr::filter(horizon == 1) %>% kableExtra::kable()

tmp <- horizon %>% dplyr::filter(horizon == 1) 
tmp <- evaluations$scores %>% dplyr::filter(horizon == 1)

metrics <- unique(horizon$score)

out <- lapply(seq_along(metrics),
              function (i) {
                ggplot(data = tmp,
                       aes(
                         y = .data[[metrics[i]]],
                         x = model,
                         group = model,
                         color = model,
                         fill = model
                       )) +
                  geom_violin(alpha = 0.4) +
                  theme(text = element_text(family = 'Sans Serif'),
                        legend.position = "bottom") +
                  ggtitle("Performance across all countries")
              })
names(out) <- metrics
out <- patchwork::wrap_plots(out, ncol = 1)
ggsave2("results/plots/metrics_one_ahead_across_regions.png",
          plot = out, width = 15,height = 20)


#============================================================== # 
# look at three days ahead forecasts
# ============================================================= #

# ============================================================= #
# predictions
out <- plot_forecast_evaluation(forecasts = evaluations$forecasts, 
                                observations = observations, c(3)) +
  ggplot2::facet_grid(region ~ model) +
  cowplot::panel_border() + theme(text = element_text(family = 'Sans Serif'),
                                  legend.position = "bottom")

ggsave2("results/plots/forecasts_three_ahead_all_regions.png",
        plot = out, width = 15,height = 30)



# ============================================================= #
# scores

tmp <- evaluations$scores %>% dplyr::filter(horizon == 3)

metrics <- unique(horizon$score)

out <- lapply(seq_along(metrics),
              function (i) {
                ggplot(data = tmp,
                       aes(
                         y = .data[[metrics[i]]],
                         x = model,
                         group = model,
                         color = model,
                         fill = model
                       )) +
                  geom_violin(alpha = 0.4) +
                  theme(text = element_text(family = 'Sans Serif'),
                        legend.position = "bottom") +
                  ggtitle("Performance across all countries")
              })
names(out) <- metrics
out <- patchwork::wrap_plots(out, ncol = 1)
ggsave2("results/plots/metrics_three_ahead_across_regions.png",
        plot = out, width = 15,height = 20)


#============================================================== # 
# look at seven days ahead forecasts
# ============================================================= #

# ============================================================= #
# predictions
out <- plot_forecast_evaluation(forecasts = evaluations$forecasts, 
                                observations = observations, c(7)) +
  ggplot2::facet_grid(region ~ model) +
  cowplot::panel_border() + theme(text = element_text(family = 'Sans Serif'),
                                  legend.position = "bottom")

ggsave2("results/plots/forecasts_seven_ahead_all_regions.png",
        plot = out, width = 15,height = 30)


# ============================================================= #
# scores

tmp <- evaluations$scores %>% dplyr::filter(horizon == 7)

metrics <- unique(horizon$score)

out <- lapply(seq_along(metrics),
              function (i) {
                ggplot(data = tmp,
                       aes(
                         y = .data[[metrics[i]]],
                         x = model,
                         group = model,
                         color = model,
                         fill = model
                       )) +
                  geom_violin(alpha = 0.4) +
                  theme(text = element_text(family = 'Sans Serif'),
                        legend.position = "bottom") +
                  ggtitle("Performance across all countries")
              })
names(out) <- metrics
out <- patchwork::wrap_plots(out, ncol = 1)
ggsave2("results/plots/metrics_seven_ahead_across_regions.png",
        plot = out, width = 15,height = 20)



