# Install all necessary libraries
install.packages("tidyverse")
install.packages("readxl")
install.packages("here")
install.packages("glue")
install.packages("ggrepel")

# Loading the libraries
library(tidyverse)
library(readxl)
library(here)
library(glue)
library(ggrepel)

# Loading raw dataset
data <- dir(here("week1", "data"), full.names = TRUE, pattern = "us_avg") %>%
  read_excel()

# tidying data

tidy_data <- data %>%
  gather(year, avg_tuition , -State) %>%
  rename(state = State)

# calculate the average national tuition for the years 2004-05 and 2015-16

nat_avg <- tidy_data %>%
  filter(year %in% c("2004-05", "2015-16")) %>%
  group_by(year) %>%
  summarize(avg_tuition = mean(avg_tuition)) %>%
  mutate(state = "National Average")

# extracting the years 2004-2005 and 2015-2016 from tidy_data and adding
# the National Average

plot_data <- tidy_data %>%
  filter(year %in% c("2004-05", "2015-16")) %>%
  group_by(year) %>%
  left_join(select(nat_avg, year, nat_avg = avg_tuition), by = "year") %>%
  bind_rows(nat_avg)


