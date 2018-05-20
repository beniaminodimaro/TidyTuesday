# Install all necessary libraries
install.packages("tidyverse")
install.packages("readxl")
install.packages("here")

# Loading the libraries
library(tidyverse)
library(readxl)
library(here)

# Loading raw dataset
data <- dir(here("week1", "data"), full.names = TRUE, pattern = "us_avg") %>%
  read_excel()

# tidying data

tidy_data <- data %>%
  gather(year, avg_tuition , -State)

