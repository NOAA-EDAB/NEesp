# risk over time

`%>%` <- magrittr::`%>%`
library(NEesp)

# remove survey data outside stock areas
survey <- NEesp::survey %>%
  dplyr::filter(Region != "Outside stock area")

# calculate running risks ----

# avg & max lengths of past 5 years compared to mean of all years previous (fall and spring) ----
length <- survey %>% get_len_data_risk()
length$YEAR <- as.numeric(length$YEAR)

avg_len_f <- NEesp::get_running_risk(
  data = length %>%
    dplyr::filter(SEASON == "FALL", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "mean_len",
  high = "low_risk",
  indicator_name = "avg_length_fall",
  n_run = 5
)
avg_len_s <- NEesp::get_running_risk(
  data = length %>%
    dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "mean_len",
  high = "low_risk",
  indicator_name = "avg_length_spring",
  n_run = 5
)

max_len_f <- NEesp::get_running_risk(
  data = length %>%
    dplyr::filter(SEASON == "FALL", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "max_len",
  high = "low_risk",
  indicator_name = "max_length_fall",
  n_run = 5
)
max_len_s <- NEesp::get_running_risk(
  data = length %>%
    dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "max_len",
  high = "low_risk",
  indicator_name = "max_length_spring",
  n_run = 5
)

# survey abundance of past 5 years compared to mean of all years previous (fall and spring) ----
abun_survey <- survey %>%
  dplyr::select(Species, Region, YEAR, SEASON, ABUNDANCE, fish_id) %>%
  dplyr::distinct()
abun_survey$YEAR <- as.numeric(abun_survey$YEAR)

abun_f <- NEesp::get_running_risk(
  data = abun_survey %>%
    dplyr::filter(SEASON == "FALL", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "ABUNDANCE",
  high = "low_risk",
  indicator_name = "abundance_fall",
  n_run = 5
)
abun_s <- NEesp::get_running_risk(
  data = abun_survey %>%
    dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "ABUNDANCE",
  high = "low_risk",
  indicator_name = "abundance_spring",
  n_run = 5
)

# survey biomass of past 5 years compared to mean of all years previous (fall and spring) ----
biomass_surv <- survey %>%
  dplyr::select(Species, Region, YEAR, SEASON, BIOMASS, fish_id) %>%
  dplyr::distinct()
biomass_surv$YEAR <- as.numeric(biomass_surv$YEAR)

biomass_f <- NEesp::get_running_risk(
  data = biomass_surv %>%
    dplyr::filter(SEASON == "FALL", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "BIOMASS",
  high = "low_risk",
  indicator_name = "biomass_fall",
  n_run = 5
)
biomass_s <- NEesp::get_running_risk(
  data = biomass_surv %>%
    dplyr::filter(SEASON == "SPRING", Region != "Outside stock area"),
  year_source = "YEAR",
  value_source = "BIOMASS",
  high = "low_risk",
  indicator_name = "biomass_spring",
  n_run = 5
)

# asmt recruitment of past 5 years compared to mean of all years previous ----
dat <- NEesp::asmt %>% dplyr::filter(Metric == "Recruitment")
recruit <- NEesp::get_running_risk(
  data = dat,
  year_source = "Year",
  value_source = "Value",
  high = "low_risk",
  indicator_name = "recruitment",
  n_run = 5
)

# asmt abundance of past 5 years compared to mean of all years previous ----
dat <- NEesp::asmt %>% dplyr::filter(Metric == "Abundance")
abun <- NEesp::get_running_risk(
  data = dat,
  year_source = "Year",
  value_source = "Value",
  high = "low_risk",
  indicator_name = "asmt_abundance",
  n_run = 5
)

# asmt biomass of past 5 years compared to mean of all years previous ----
dat <- NEesp::asmt %>% dplyr::filter(Metric == "Biomass")
biomass <- NEesp::get_running_risk(
  data = dat,
  year_source = "Year",
  value_source = "Value",
  high = "low_risk",
  indicator_name = "asmt_biomass",
  n_run = 5
)

# asmt catch of past 5 years compared to mean of all years previous ----
dat <- NEesp::asmt %>% dplyr::filter(
  Metric == "Catch",
  Units == "Metric Tons"
)
catch <- NEesp::get_running_risk(
  data = dat,
  year_source = "Year",
  value_source = "Value",
  high = "high_risk",
  indicator_name = "asmt_catch",
  n_run = 5
)

# com catch & revenue of past 5 years compared to mean of all years previous ----
com_sum <- NEesp::com_catch %>%
  dplyr::group_by(Species, Year) %>%
  dplyr::summarise(
    total_catch = sum(Pounds),
    total_dollars = sum(Dollars_adj)
  )
com_sum$Region <- NA

com_run <- NEesp::get_running_risk(
  data = com_sum,
  year_source = "Year",
  value_source = "total_catch",
  high = "high_risk",
  indicator_name = "com_catch",
  n_run = 5
)

rev_run <- NEesp::get_running_risk(
  data = com_sum,
  year_source = "Year",
  value_source = "total_dollars",
  high = "high_risk",
  indicator_name = "revenue",
  n_run = 5
)

# rec catch of past 5 years compared to mean of all years previous ----
rec_sum <- NEesp::rec_catch %>%
  dplyr::group_by(Species, year) %>%
  dplyr::summarise(total_catch = sum(lbs_ab1))
rec_sum$Region <- NA

rec <- NEesp::get_running_risk(
  data = rec_sum,
  year_source = "year",
  value_source = "total_catch",
  high = "high_risk",
  indicator_name = "rec_catch",
  n_run = 5
)

# bbmsy compared to mean of all years previous ----
b <- NEesp::get_running_risk(
  data = NEesp::asmt_sum,
  year_source = "Assessment Year",
  value_source = "B/Bmsy",
  high = "low_risk",
  indicator_name = "bbmsy",
  n_run = 5
)

# ffmsy compared to mean of all years previous ----
f <- NEesp::get_running_risk(
  data = NEesp::asmt_sum,
  year_source = "Assessment Year",
  value_source = "F/Fmsy",
  high = "high_risk",
  indicator_name = "ffmsy",
  n_run = 5
)

# * merge everything except rec and com ----
all_ind <- rbind(
  b, f, catch, recruit, abun, biomass, biomass_f, biomass_s,
  abun_f, abun_s, avg_len_f, avg_len_s, max_len_f, max_len_s
)

# data wrangling -----

# * standardize region names ----
# all_ind$Region %>% unique() %>% stringr::str_sort() %>% View

all_ind$Region <- all_ind$Region %>%
  stringr::str_replace("Atlantic Coast", "Atlantic") %>%
  stringr::str_replace("Northwestern Atlantic Coast", "Atlantic") %>%
  stringr::str_replace("Northwestern Atlantic", "Atlantic") %>%
  stringr::str_replace("Mid-Atlantic Coast", "Mid-Atlantic") %>%
  stringr::str_replace(
    "Southern New England / Mid-Atlantic",
    "Southern New England / Mid"
  ) %>%
  stringr::str_replace(
    "Southern Georges Bank / Mid-Atlantic",
    "Southern Georges Bank / Mid"
  )

all_ind$Region %>%
  unique() %>%
  stringr::str_sort() %>%
  View()

# * replace "all" with region name ----
missing_names <- all_ind %>%
  dplyr::filter(Region == "all") %>%
  dplyr::select(-Region)

has_names <- all_ind %>%
  dplyr::filter(Region != "all")

region_key <- has_names %>%
  dplyr::select(Species, Region) %>%
  dplyr::distinct()

names_added <- dplyr::left_join(missing_names, region_key,
  by = "Species"
) %>%
  dplyr::select(Species, Region, Indicator, Year, Value, rank, norm_rank)

fixed_data <- rbind(has_names, names_added)

# replace any NA Region with "Unknown"
fixed_data$Region <- fixed_data$Region %>%
  tidyr::replace_na("Unknown")

# * create dummy rec and com regions and add rec and com to the rest of the data ----
all_catch <- rbind(rec, com_run, rev_run)

regions <- fixed_data %>%
  dplyr::ungroup() %>%
  dplyr::select(Species, Region) %>%
  dplyr::distinct()

all_catch_new <- dplyr::left_join(regions,
  all_catch,
  by = "Species"
) %>%
  dplyr::select(-Region.y) %>%
  dplyr::filter(Value > 0, is.na(Region.x) == FALSE) %>%
  dplyr::rename("Region" = "Region.x")

fixed_data <- rbind(fixed_data, all_catch_new)
head(fixed_data)

fixed_data <- fixed_data %>%
  dplyr::group_by(Indicator, Year) %>%
  dplyr::mutate(n_stocks_per_indicator = max(rank))

# * fill in missing values with 0.5, add total risk and overall rank ----
fixed_data$Indicator <- paste("break", fixed_data$Indicator)
data <- fixed_data %>%
  dplyr::select(Species, Region, Indicator, Year, norm_rank) %>%
  tidyr::pivot_wider(
    names_from = c("Year", "Indicator"),
    values_from = "norm_rank"
  )
data[is.na(data)] <- 0.5

data <- data %>% tidyr::pivot_longer(
  cols = colnames(data[3:ncol(data)]),
  names_to = "Indicator",
  values_to = "norm_rank"
)

info <- stringr::str_split_fixed(data$Indicator, "_break ", n = 2)
data$Indicator <- info[, 2]
data$Year <- info[, 1]

data <- data %>%
  dplyr::group_by(Species, Region, Year) %>%
  dplyr::mutate(
    total_risk = sum(norm_rank),
    stock = paste(Species, Region, sep = " - "),
    label = paste(Species,
      total_risk %>% round(digits = 2),
      sep = ", "
    )
  ) %>%
  dplyr::ungroup() %>%
  dplyr::group_by(Year) %>%
  dplyr::mutate(
    overall_rank = dplyr::dense_rank(total_risk),
    overall_stocks = stock %>% unique() %>% length()
  )

# categorize indicators
data$Indicator %>% unique()

category <- c()
for (i in 1:nrow(data)) {
  if (data$Indicator[i] %>% stringr::str_detect("length") == TRUE |
    data$Indicator[i] %>% stringr::str_detect("diet") == TRUE
  ) {
    category[i] <- "Biological"
  }
  if (data$Indicator[i] %>% stringr::str_detect("abundance") == TRUE |
    data$Indicator[i] %>% stringr::str_detect("biomass") == TRUE |
    data$Indicator[i] %>% stringr::str_detect("bbmsy") == TRUE |
    data$Indicator[i] %>% stringr::str_detect("recruitment") == TRUE
  ) {
    category[i] <- "Population"
  }
  if (data$Indicator[i] %>% stringr::str_detect("catch") == TRUE |
    data$Indicator[i] %>% stringr::str_detect("ffmsy") == TRUE |
    data$Indicator[i] %>% stringr::str_detect("revenue") == TRUE
  ) {
    category[i] <- "Socioeconomic"
  }
}

data$category <- category

# join fixed_data (with values and years) to data (with total ranks and labels)
fixed_data$Indicator <- fixed_data$Indicator %>% stringr::str_replace("break ", "")

new_data <- dplyr::full_join(data, fixed_data,
  by = c("Species", "Region", "Indicator", "Year", "norm_rank")
) %>%
  dplyr::group_by(Region, Year) %>%
  dplyr::mutate(n_stocks_per_region = Species %>% unique() %>% length()) %>%
  dplyr::select(
    Species, Region, Indicator, category, Year, Value, rank,
    n_stocks_per_indicator, n_stocks_per_region, norm_rank,
    total_risk, overall_rank, overall_stocks, stock, label
  )

new_data

write.csv(new_data,
  file = here::here("data-raw/risk_ranking", "full_historical_risk_data_over_time.csv")
)

risk_year_hist <- new_data

usethis::use_data(risk_year_hist, overwrite = TRUE)