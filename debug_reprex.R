library(EpiSoon)

n_tries <- 20
obs <- readRDS("rts_netherlands.rds")
obs

models <- list("Sparse AR" = function(ss, y){bsts::AddAutoAr(ss, y = y, lags = 7)},
               "Semi-local linear trend" = function(ss, y){bsts::AddSemilocalLinearTrend(ss, y = y)}, 
               "Student local linear trend" = function(ss, y){bsts::AddStudentLocalLinearTrend(ss, y = y)}, 
               "AR 1" = function(ss, y){bsts::AddAr(ss, y = y, lags = 1)})

for (i in 1:n_tries) {
  compare_models(obs, models = models, samples = 10)
  cat("run", as.character(i), "of", as.character(n_tries), "successful \n")
}
