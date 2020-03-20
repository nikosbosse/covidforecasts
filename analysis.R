library(EpiSoon)
library(bsts)
library(cowplot)
library(ggplot2)

#devtools::install_github("epiforecasts/EpiSoon", auth_token = "440ff71f086c5447a71b3a938ec3429fa20f55b4")

results_dir <- NULL
date <- NULL

data <- EpiSoon::get_timeseries(results_dir = results_dir, 
                        date = date)

regions <- unique(data$rt$region)

observations <- lapply(seq_along(regions),
                       function (i) {
                         data[[1]] %>% 
                           dplyr::filter(region == regions[i]) %>%
                           dplyr::select("median", "date") %>%
                           dplyr::rename(rt = median)
                       })
names(observations) <- regions


## delete regions with too few observations
max_n_obs = 5
check_n_obs <- lapply(observations, nrow)
too_few <- (sapply(check_n_obs, function(x) { x < max_n_obs}))
observations[] <- NULL

models <- list("Sparse AR" = function(ss, y){bsts::AddAutoAr(ss, y = y, lags = 2)},
               "Semi-local linear trend" = function(ss, y){bsts::AddSemilocalLinearTrend(ss, y = y)}, 
               "Student local linear trend" = function(ss, y){bsts::AddStudentLocalLinearTrend(ss, y = y)}, 
               "AR 1" = function(ss, y){bsts::AddAr(ss, y = y, lags = 1)})


future::plan("multiprocess", workers = future::availableCores() / 2)

forecast_eval <- compare_timeseries(observations, models,
                                    horizon = 7, samples = 50)

saveRDS(forecast_eval, "forecast_evaluation.rds")








# evaluations <- compare_models(observations, models)

# plot_forecast_evaluation(evaluations$forecast, observations, c(1, 3, 7)) +
#   ggplot2::facet_grid(model ~ horizon) +
#   cowplot::panel_border() + 
#   theme(text = element_text(family = 'Sans Serif'))

# summarise_scores(evaluations$scores)

# timeseries <- list(observations, observations)
# names(timeseries) <- c("Region 1", "Region 2")
# evaluations <- compare_timeseries(timeseries, models,
#                                   horizon = 7, samples = 10)


# plot_forecast_evaluation(evaluations$forecast, observations, c(1, 3, 7)) +
#   ggplot2::facet_grid(model ~ region + horizon) +
#   cowplot::panel_border() + 
#   theme(text = element_text(family = 'Sans Serif'))

# summarised_scores <- summarise_scores(evaluations$scores)

# EpiSoon::plot_scores


# ?EpiSoon::plot_scores



