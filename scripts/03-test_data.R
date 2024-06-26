#### Preamble ####
# Purpose: Tests for the dataset of "Wheels of Misfortune: Exploring Auto Theft Trends in Ottawa"
# Author: Catherine Punnoose
# Date: 24 April 2024
# Contact: catherine.punnoose@mail.utoronto.ca
# License: MIT
# Pre-requisites: reload 02-data_cleaning.R


#### Workspace setup ####
library(arrow)
library(tidyverse)
library(testthat)
library(ggplot2)

#### Reload Cleaned Data ####

auto_Data <- read_parquet(here::here("data/analysis_data/analysis_data.parquet"))

#### Test data ####

# Code generated by Chat GPT 3.5 (See usage.txt.)
# Testing Average Theft Year Histogram
plot_theft_year_histogram <- function(data) {
  data %>%
    ggplot(aes(x = theft_year)) + 
    labs(x = "Year", y = "Count") + 
    theme_minimal() +
    geom_histogram(stat = "count")
}

# Write test cases
test_that("Theft year histogram plot is generated correctly", {
  # Simulated Data Generation
  set.seed(123)
  auto_Data <- tibble(
    theft_year = sample(2018:2023, 1000, replace = TRUE)
  )
  
  # Generate the plot
  plot <- plot_theft_year_histogram(auto_Data)
  
  # Check if the plot is of class ggplot
  expect_true("ggplot" %in% class(plot))
  
  # Check if the x-axis label is correct
  expect_equal(ggplot2:::ggtitle_string(plot$labels$x), "Year")
  
  # Check if the y-axis label is correct
  expect_equal(ggplot2:::ggtitle_string(plot$labels$y), "Count")
  
  # Check if the plot contains geom_histogram
  expect_true("GeomHistogram" %in% class(plot$layers[[1]]$geom))
})

