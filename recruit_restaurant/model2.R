require(lubridate)
require(forecast)
require(dplyr)

ts_data2 <- ts_data %>%
  group_by(visit_date) %>%
  summarise(visitors = sum(visitors)) %>%
  ungroup()

tsd <- ts(data = ts_data2$visitors, 
          start=c(year(min(ts_data2$visit_date)), 
                  as.numeric(format(min(ts_data2$visit_date), "%j"))), 
          frequency = 365)

fc_mod2 <- arima(tsd, order = c(7,0,3))

fc2 <- forecast(fc_mod2, h = M)

