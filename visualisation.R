library(EpiSoon)
library(bsts)
library(cowplot)
library(ggplot2)

# ========= load data and results ========== #
# results were pre-calculated and stored
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

evaluations <- readRDS("forecast_evaluation_21.rds")

# set regions to the regions for which we have forecasts
regions <- unique(evaluations$forecasts$region)
observations[!(names(observations) %in% regions)] <- NULL

# put all observations in one proper data.frame for plotting
observations <- do.call(rbind, observations)
observations$region <- gsub("\\..*","", rownames(observations))




#============================================================== # 
# make prediction plots
# ============================================================= #
# plot an evaluation 
horizons <- c(1,3,7,14,21)

for (horizon in horizons) {
  out <- plot_forecast_evaluation(forecasts = evaluations$forecasts, 
                                  observations = observations, c(horizon)) +
    ggplot2::facet_grid(region ~ model, scales = "free") +
    cowplot::panel_border() + theme(text = element_text(family = 'Sans Serif'),
                                    legend.position = "bottom")
  
  filename <- paste("results/plots/forecasts_", horizon, 
                    "_ahead_all_regions.png", sep = "")
  ggsave2(filename,
          plot = out, width = 15,height = 30)
}


#============================================================== # 
# make scoring plots for different horizons
# ============================================================= #

# ============================================================= #
# all models one time point
horizons <- c(1,3,7,14,21)
metrics <- c("bias", "crps", "logs", "dss", "sharpness")
for (horizon in horizons) {
  t <- horizon
  eval_score <- evaluations$scores %>% dplyr::filter(horizon == t)
  
  for (metric in metrics) {
    bound <- summarise_scores(eval_score) %>% 
      dplyr::filter(score == metric) %>% dplyr::select(top) %>% 
      unlist %>% min() * 1.3

    title <- paste(metric, "across all regions for", 
                   horizon, "day ahead forecasts")
    out <- ggplot(data = eval_score,
                  aes(
                    y = .data[[metric]],
                    x = model,
                    group = model,
                    color = model,
                    fill = model
                  )) +
      geom_violin(color = NA, alpha = 0.1) +
      geom_jitter(alpha = 0.1) +
      geom_boxplot(alpha = 0.6) +
      theme(text = element_text(family = 'Sans Serif'),
            legend.position = "bottom") +
      ggtitle(title)
    
    if (metric == "bias") {
      out <- out + 
        ggplot2::geom_hline(yintercept = 0.5, linetype = "dashed")
    } 
    else {
      if (metric == "logs") {bound <- min(bound, 10)}
      out <- out +
        ggplot2::coord_cartesian(ylim = c(NA, bound))
    }
    
    
    filename <- paste("results/plots/", metric, "_across_regions_", 
                      horizon, "_day_ahead_forecasts", ".png", sep = "")
    ggsave2(filename,
            plot = out, width = 15)
  }
}

# ============================================================= #
# metrics - one model all time points

models <- unique(evaluations$scores$model)
summarised_scores <- summarise_scores(evaluations$scores, 
                        "horizon")
for (metric in metrics) {
  
  # summary plot with every ribbon separated by model
  tmp <- summarised_scores %>% dplyr::filter(score == metric)
  title <- paste(metric, "across all regions for different horions")
  out <- ggplot(data = tmp,
                aes(x = horizon,
                    group = model,
                    color = model,
                    fill = model
                )) +
    geom_line(aes(y = median)) +
    geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.5) +
    geom_ribbon(aes(ymin = bottom, ymax = top), alpha = 0.3) +
    facet_grid(model ~ ., scales = "free") +
    theme(text = element_text(family = 'Sans Serif'),
          legend.position = "bottom") +
    ggtitle(title)
  
  if (metric == "bias") {
    out <- out + ggplot2::geom_hline(yintercept = 0.5, linetype = "dashed")
  } 
  # else {
  #   out <- out + ggplot2::geom_hline(yintercept = 0, linetype = "dashed")
  # }
  
  filename <- paste("results/plots/", metric, "across_regions", 
                    "_all_horizons.png", sep = "")
  ggsave2(filename,
          plot = out, width = 15, height = 10)
  
  
  # make one just with the median to show them all against each other
  out <- ggplot(data = tmp,
                aes(x = horizon,
                    group = model,
                    color = model,
                    fill = model
                )) +
    geom_line(aes(y = median), size = 1.2) +
    geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.1, size = .1) +
    theme(text = element_text(family = 'Sans Serif'),
          legend.position = "bottom") +
    ggtitle(title)
  
  if (metric == "bias") {
    out <- out + ggplot2::geom_hline(yintercept = 0.5, linetype = "dashed")
  }
  # else {
  #   out <- out + ggplot2::geom_hline(yintercept = 0, linetype = "dashed")
  # }
  
  filename <- paste("results/plots/", metric, "_median_across_regions", 
                    "_all_horizons.png", sep = "")
  ggsave2(filename,
          plot = out, width = 15, height = 10)
}

# extra violin plot for bias
metric = "bias"
tmp <- evaluations$scores %>% dplyr::filter(horizon %in% horizons)
title <- paste("Bias across all regions for different horions")
out <- ggplot(data = tmp,
              aes(x = model,
                  y = .data[[metric]],
                  group = model,
                  color = model,
                  fill = model
              )) +
  geom_violin(alpha = 0.4) +
  facet_grid(horizon ~ .) +
  theme(text = element_text(family = 'Sans Serif'),
        legend.position = "bottom") +
  ggtitle(title)

filename <- paste("results/plots/", metric, "Bias_violin_across_regions", 
                  "_different_horizons.png", sep = "")
ggsave2(filename,
        plot = out, width = 15, height = 10)





































# 
# 
# 
# 
# # ============================================================= #
# # scores
# 
# horizon <- summarise_scores(evaluations$scores, variables = "horizon")
# horizon %>% dplyr::filter(horizon == 1) %>% kableExtra::kable()
# 
# tmp <- horizon %>% dplyr::filter(horizon == 1) 
# 
# 
# 
# 
# out <- lapply(seq_along(metrics),
#               function (i) {
#                 ggplot(data = tmp,
#                        aes(
#                          y = .data[[metrics[i]]],
#                          x = model,
#                          group = model,
#                          color = model,
#                          fill = model
#                        )) +
#                   geom_violin(alpha = 0.4) +
#                   theme(text = element_text(family = 'Sans Serif'),
#                         legend.position = "bottom") +
#                   ggtitle("Performance across all countries")
#               })
# names(out) <- metrics
# out <- patchwork::wrap_plots(out, ncol = 1)
# ggsave2("results/plots/metrics_one_ahead_across_regions.png",
#           plot = out, width = 15,height = 20)
# 
# 
# #============================================================== # 
# # look at three days ahead forecasts
# # ============================================================= #
# 
# # ============================================================= #
# # predictions
# out <- plot_forecast_evaluation(forecasts = evaluations$forecasts, 
#                                 observations = observations, c(3)) +
#   ggplot2::facet_grid(region ~ model, scales = "free") +
#   cowplot::panel_border() + theme(text = element_text(family = 'Sans Serif'),
#                                   legend.position = "bottom")
# 
# ggsave2("results/plots/forecasts_three_ahead_all_regions.png",
#         plot = out, width = 15,height = 30)
# 
# 
# 
# # ============================================================= #
# # scores
# 
# tmp <- evaluations$scores %>% dplyr::filter(horizon == 3)
# 
# metrics <- unique(horizon$score)
# 
# out <- lapply(seq_along(metrics),
#               function (i) {
#                 ggplot(data = tmp,
#                        aes(
#                          y = .data[[metrics[i]]],
#                          x = model,
#                          group = model,
#                          color = model,
#                          fill = model
#                        )) +
#                   geom_violin(alpha = 0.4) +
#                   theme(text = element_text(family = 'Sans Serif'),
#                         legend.position = "bottom") +
#                   ggtitle("Performance across all countries")
#               })
# names(out) <- metrics
# out <- patchwork::wrap_plots(out, ncol = 1)
# ggsave2("results/plots/metrics_three_ahead_across_regions.png",
#         plot = out, width = 15,height = 20)
# 
# 
# #============================================================== # 
# # look at seven days ahead forecasts
# # ============================================================= #
# 
# # ============================================================= #
# # predictions
# out <- plot_forecast_evaluation(forecasts = evaluations$forecasts, 
#                                 observations = observations, c(7)) +
#   ggplot2::facet_grid(region ~ model, scales = "free") +
#   cowplot::panel_border() + theme(text = element_text(family = 'Sans Serif'),
#                                   legend.position = "bottom")
# 
# ggsave2("results/plots/forecasts_seven_ahead_all_regions.png",
#         plot = out, width = 15,height = 30)
# 
# 
# # ============================================================= #
# # scores
# 
# tmp <- evaluations$scores %>% dplyr::filter(horizon == 7)
# 
# metrics <- unique(horizon$score)
# 
# out <- lapply(seq_along(metrics),
#               function (i) {
#                 ggplot(data = tmp,
#                        aes(
#                          y = .data[[metrics[i]]],
#                          x = model,
#                          group = model,
#                          color = model,
#                          fill = model
#                        )) +
#                   geom_violin(alpha = 0.4) +
#                   theme(text = element_text(family = 'Sans Serif'),
#                         legend.position = "bottom") +
#                   ggtitle("Performance across all countries")
#               })
# names(out) <- metrics
# out <- patchwork::wrap_plots(out, ncol = 1)
# ggsave2("results/plots/metrics_seven_ahead_across_regions.png",
#         plot = out, width = 15,height = 20)
# 


