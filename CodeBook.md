# Code Book #

From the 2 data sets presented, the following categories exist:

| Column Name | Type   | Description |
| ------------|--------|-------------|
| activity    | factor | which activity the subject was doing |
| source      | factor | from which data each observation originates |
| personId    | int    | unique identifier for each subject |
| signalType  | factor | type of signal |
| measurement | double | value of the measurement |
| meanMeasurement | double | average of measurements taken for each person and activity |

* `activity` refers to which activity the person was doing at the time of the measurement. It is one of 'STANDING', 'SITTING', 'LAYING', 'WALKING', 'WALKING_DOWNSTAIRS' or 'WALKING_UPSTAIRS'. These are all listed in `activity_labels.txt`.
* `source` one of 'training' or 'testing'.
* `signalType` is one of the signals listed in `features_info.txt`. The data presented have been cleaned to only contain mean and standard deviation values. Each code is comprised of the following individual codes:
  * f/t
    * __f__ frequency domain signals
    * __t__ time, caputred at 50 Hz
  * Body/Gravity
    * __Gravity__ the constant accelerometer signal from gravity
    * __Body__ the variable accelerometer signal from the subject's movement
  * Gyro/Acc
    * __Gyro__ the phone's gyroscope signal
    * __Acc__ the phone's accelerometer signal
  * Jerk
  * X/Y/Z, Mag
    * Magnitude of measurement along each axis
    * Magnitude of sum of vector components
  * mean() and std()
    * the mean and the standard deviation, respectively.
  