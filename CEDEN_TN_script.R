# Hiram Sarabia, MS 
# San Diego Water Board
# June 2022
start.time <- Sys.time()
library(tidyr)
library(dplyr)
setwd('C:\\R\\IGIS\\')
TN_df <- read.csv("ceden_data_20220629113817.csv", stringsAsFactors = F, header = T)

# Filter for sites with more than 3 obs
TN_count_df <- TN_df %>% count(StationCode) %>% filter(n > 2)
sites <- as.vector(TN_count_df$StationCode)
test <- TN_df %>% rowwise() %>% filter(StationCode %in% sites)
#Calculate mean per site
t <- as.data.frame(test %>% group_by(StationCode) %>% summarise_at(vars(Result),list(TN_mean = mean)))
#Add coordinates and n obs to final output
t$latitude <- TN_df[match(t$StationCode, TN_df$StationCode),37]
t$longitude <- TN_df[match(t$StationCode, TN_df$StationCode),38]
t$n <- TN_count_df[match(t$StationCode, TN_count_df$StationCode),2]
t <- t %>% filter(!is.na(TN_mean))
#Write CSV
write.csv(t, paste0(format(Sys.time(), "%d-%b-%Y %H.%M"), "_TN_Mean_522.csv"))

end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
























