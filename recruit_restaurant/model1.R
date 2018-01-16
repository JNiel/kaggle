#load data

if(!exists("inp_data")) {
  load("~/Desktop/Kaggle/recruit_restaurant/data/inp_data.rda")
}

library(tidyverse)
stores <- unique(air_visit_data$air_store_id)
N_stores <- length(stores)

visit_dates <- seq.Date(from = min(air_visit_data$visit_date), to = max(air_visit_data$visit_date), by = "days")
ts_data <- merge(stores, visit_dates, all = TRUE)

names(ts_data) <- c("air_store_id", "visit_date")

ts_data <- left_join(ts_data, air_visit_data, by = c("air_store_id", "visit_date"))

ts_data$visitors[is.na(ts_data$visitors)] <- 0

library(forecast)
fct_end_date <- as.Date("2017-05-31", format = "%Y-%m-%d")
fct_start_date <- as.Date("2017-04-23", format = "%Y-%m-%d")
fct_date_range <- seq.Date(from = fct_start_date, to = fct_end_date, by = "days")
outp_data <- list()
M <- length(fct_date_range)

for(i in 1:N_stores) {
  indat <- filter(ts_data, air_store_id == stores[i])
  tsd <- ts(data = indat$visitors, 
            start=c(year(min(indat$visit_date)), 
                    as.numeric(format(min(indat$visit_date), "%j"))), 
            frequency = 365)
  
  fct_mod <- auto.arima(tsd)
  fct_fc <- forecast(fct_mod, h = M)
  outp_data[[i]] <- data_frame(air_store_id = rep(stores[i], M), 
                               visit_date = fct_date_range,
                               visitors = round(as.numeric(fct_fc$mean)))
}


tot_result <- do.call(rbind, lapply(outp_data, data.frame, stringsAsFactors=FALSE))

tot_outp <- data_frame(id = paste(tot_result$air_store_id, tot_result$visit_date, sep="_"),
                       visitors = tot_result$visitors)

sample_id <- unique(sample_submission$id)
tot_outp_filt <- filter(tot_outp, id %in% sample_id)
tot_outp_filt$visitors[tot_outp_filt$visitors<0] = 0


