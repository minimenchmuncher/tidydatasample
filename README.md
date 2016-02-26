# Tidy Data Sample #

This is a sample of tidy data, along with a code book. These data come from a collected data set of Samsung phone accelerometer data to help determine which activity the subjects were doing. The data have been combined and put into long-format.

## Analysis Summary ##

`run_analysis.R` consists of 2 functions, `mergeDataSets()` and `averageOfVariables()`. Usage is

```R
allData <- mergeDataSets(data_dir)
```

and

```R
variableAverages <- averageOfVariables(allData)
```

`mergeDataSets()` accepts a single input, which is the path to the directory where the smartphone data set resides. The result of this function is a data.frame (`tbl_df`) in long format. The results are as follows:

| Column Name | Type   | Description |
| ------------|--------|-------------|
| activity    | factor | which activity the subject was doing |
| source      | factor | from which data each observation originates |
| personId    | int    | unique identifier for each subject |
| signalType  | factor | type of signal |
| measurement | double | value of the measurement |

A few notes:

* `activity` one of 'STANDING', 'SITTING', 'LAYING', 'WALKING', 'WALKING_DOWNSTAIRS' or 'WALKING_UPSTAIRS'. These are all listed in `activity_labels.txt`.
* `source` one of 'training' or 'testing'.
* `signalType` is one of the signals listed in `features_info.txt`. The data presented have been cleaned to only contain mean and standard deviation values.

`variableAverages()` summarizes the output of the above data set by taking the average of the above variables with respect to subject and activity (averaging over the `signalType` column). The resulting columns are:

| Column Name | Type   | Description |
| ------------|--------|-------------|
| personId    | int    | unique identifier for each subject |
| activity    | factor | which activity the subject was doing |
| meanMeasurement | double | average of measurements taken for each person and activity |

## Requirements ##
In order to source the r script, the user will need `dplyr`, `magrittr`, `readr` and `tidyr`.


