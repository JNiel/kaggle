#Load data:
list_data <- list.files(path = "recruit_restaurant/data")
inp_data <- list()
for(i in length(list_data)) {
  inp_data[[i]] <- read.csv(paste("~/Desktop/Kaggle/recruit_restaurant/data/", list_data[i], sep = ""))
}


air_reserve <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/air_reserve.csv")
air_store_info <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/air_store_info.csv")
air_visit_data <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/air_visit_data.csv")
date_info <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/date_info.csv")
hpg_reserve <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/hpg_reserve.csv")
hpg_store_info <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/hpg_store_info.csv")
sample_submission <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/sample_submission.csv")
store_id_relation <- read_csv("~/Desktop/Kaggle/recruit_restaurant/data/store_id_relation.csv")

inp_data <- list(air_reserve, air_store_info, air_visit_data, date_info, hpg_reserve, hpg_store_info, sample_submission, store_id_relation)
save(inp_data, file = "~/Desktop/Kaggle/recruit_restaurant/data/inp_data.rda")


