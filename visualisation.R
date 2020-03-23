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
# make scoring plots 
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




#============================================================== # 
# Look at correlation of scoring metrics 
# ============================================================= #
out <- list()
for (t in horizons) {
  correlation <- evaluations$scores %>% 
    dplyr::filter(horizon == t) %>%
    dplyr::select(metrics) %>% 
    dplyr::mutate(bias = 0.5 - bias) %>% 
    dplyr::filter_all(dplyr::all_vars(!is.infinite(.))) %>%
    cor() 
  
  title <- paste("horizon =", t)
  out[[as.character(t)]] <- ggplot(reshape2::melt(correlation), 
                                   aes(Var1, Var2, fill=value)) +
    geom_tile(height=0.8, width=0.8) +
    scale_fill_gradient2(low="blue", mid="white", high="red") +
    theme_minimal() +
    coord_equal() +
    labs(x="",y="",fill="Corr") +
    theme(axis.text.x=element_text(size=11, angle=45, vjust=1, hjust=1, 
                                   margin=margin(-3,0,0,0)),
          axis.text.y=element_text(size=11, margin=margin(0,-3,0,0)),
          panel.grid.major=element_blank()) +
    theme(text = element_text(family = 'Sans Serif'),
          legend.position = "bottom") +
    ggtitle(title)
}
out <- patchwork::wrap_plots(out)

filename <- paste("results/plots/correlation_metrics_different_horizons.png")
ggsave2(filename,
        plot = out, width = 15, height = 10)




#============================================================== # 
# Look at which countries perform good and bad
# ============================================================= #

metric = "crps"
horizon = t = 1

metrics <- c("crps", "logs", "dss")
horizons <- c(1, 3, 7, 14, 21)
scores <- summarise_scores(evaluations$scores, c("horizon", "region"))

for (metric in metrics) {
  for (t in horizons) {
    test <- scores %>% 
      dplyr::filter(horizon == t) %>% 
      dplyr::filter(score == metric) %>% 
      dplyr::select(-c(bottom, lower, mean, upper, top, sd, score)) %>%
      dplyr::mutate(!!metric := median)
    
    out <- ggplot(test, aes(x = reorder(region, median), y = .data[[metric]], color = model)) + 
      geom_point() + 
      geom_line(aes(group = model)) + 
      facet_grid(model ~ ., scales = "free") +  
      theme(text = element_text(family = 'Sans Serif'),
            legend.position = "bottom") + 
      theme(axis.text.x = element_text(angle=90, hjust = 1, 
                                       vjust = 0.5, margin = margin(5,0,0,0))) 
    
    filename <- paste("results/plots/regions_", metric, 
                      "_", t, "_ahead.png", sep = "")
    
    ggsave(filename = filename, plot = out, width = 15, height = 10)
  }
}



#============================================================== # 
# Look at scores vs predictions for each country
# ============================================================= #

scores <- summarise_scores(evaluations$scores, c("region", "horizon"))
horizons <- c(1, 3, 7, 14, 21)

for (t in horizons) {
  
  t = 7
  for (r in regions) {
    obs <- observations %>% 
      dplyr::filter(region == r) 
    max_date <- max(obs$date) 
    
    pred <- evaluations$forecasts %>% 
      dplyr::filter(region == r) %>% 
      dplyr::filter(date <= max_date)
    
    min_date <- pred %>% 
      dplyr::filter(horizon == t) %>%
      dplyr::select(date) %>%
      unlist %>%
      min() %>%
      as.Date()
  
    obs <- obs %>% dplyr::filter(!(date <= min_date))
    
    if (max_date <= min_date) {next()}
    
    ## make prediction plot
    out <- plot_forecast_evaluation(forecasts = pred, 
                                    observations = obs, c(t)) +
      ggplot2::facet_grid(~ model, scales = "free") +
      cowplot::panel_border() + 
      theme(text = element_text(family = 'Sans Serif'),
            legend.position = "bottom")    
    
    ## make metric plot
    tmp <- evaluations$scores %>% 
      dplyr::filter(region == r) %>%
      dplyr::filter(horizon == t) %>%
      tidyr::pivot_longer(cols = c(dss, crps, logs, bias, sharpness), 
                          names_to = "metric", 
                          values_to = "value")
      
    out2 <- ggplot(tmp, aes(x = date, group = model, color = metric)) + 
      geom_line(aes(y = value)) +
      facet_grid(metric ~ model, scales = "free") + 
      theme(text = element_text(family = 'Sans Serif'),
            legend.position = "bottom")  
    
  out <- patchwork::wrap_plots(out, out2, ncol = 1)
  filename <- paste("results/plots/tests/pred_", horizon, 
                    "_", r, "_vs_scores.png", sep = "")
  ggsave2(filename,
          plot = out, width = 15,height = 15)
  
  }
}




















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


