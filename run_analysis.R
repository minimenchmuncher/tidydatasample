library(dplyr)
library(readr)
library(magrittr)
library(tidyr)

# Universal Constants
data_dir <- '~/Downloads/UCI HAR Dataset'

# 1. Merge data sets
mergeDataSets <- function(data_dir = '.') {
  test_dir <- file.path(data_dir, 'test')
  train_dir <- file.path(data_dir, 'train')

  #check to see if these directories exist
  if (!dir.exists(test_dir) | !dir.exists(train_dir)) {
    stop('That directory does not contain the necessary data')
  }

  # read activities and features labels
  activities <- read.table(file.path(data_dir, 'activity_labels.txt'), stringsAsFactors = FALSE)
  colnames(activities) <- c('id', 'activity')
  features <- read.table(file.path(data_dir, 'features.txt'), stringsAsFactors = FALSE)
  colnames(features) <- c('id', 'feature')
  if (nrow(features) != nrow(unique(features))) {
    warning('The features provided are not unique')
  }

  # load test_data and associated labels
  test_data <- read_table(file.path(test_dir, 'X_test.txt'), col_names = as.character(features$id))  # use numeric ids here
  test_labels <- read_table(file.path(test_dir, 'Y_test.txt'), col_names = c('activity'))

  # add in the labels
  test_data$activity <- factor(test_labels$activity, levels = activities$id, labels = activities$activity)
  #test_data$personId <- 1:nrow(test_data)
  #test_data %<>% gather('feature', 'measurement', -activity, -personId) %>%
  #  mutate(feature = factor(as.numeric(feature), levels = features$id, labels = features$feature))

  train_data <- read_table(file.path(train_dir, 'X_train.txt'), col_names = as.character(features$id))
  train_labels <- read_table(file.path(train_dir, 'Y_train.txt'), col_names = c('activity'))
  train_data$activity = factor(train_labels$activity, levels = activities$id, labels = activities$activity)

  # add in source labels
  train_data$source <- factor(1, levels = c(1,2), labels = c('training', 'testing'))
  test_data$source <- factor(2, levels = c(1,2), labels = c('training', 'testing'))

  completeData <- rbind(train_data, test_data) %>%
    mutate(personId = 1:nrow(.)) %>%
    gather('feature', 'measurement', -activity, -personId, -source) %>%
    mutate(feature = as.numeric(feature)) %>%
    inner_join(features, by = c('feature' = 'id')) %>%
    rename(featureName = feature.y, featureID = feature)  # could make feature a factor too. There are duplicated feature names, which could be an issue

  # subset to have only the mean() and std() elements
  subsetData <- completeData %>%
    filter(grepl('(mean()|std())', featureName)) %>%
    mutate(signalType = factor(featureID, levels = features$id, labels = features$feature)) %>%
    select(-featureID, -featureName)

  return(subsetData)

}

averageOfVariables <- function(full_dataset) {
  res <- full_dataset %>%
    group_by(personId, activity) %>%
    summarise(meanMeasurement = mean(measurement))
  return(res)
}


allData <- mergeDataSets(data_dir)
variableAverages <- averageOfVariables(allData)