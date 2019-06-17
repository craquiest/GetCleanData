---
Title       : Summary of UCI HAR Data Set
Subtitle    : The codebook
Author      : Amadou Lamine Gaye
---

# Summary of UCI HAR Data Set: The codebook

This document is the codebook for data set **"SummaryData_Samsung.txt"**. This data set is the result of processing, tidying and summarizing the data from  UCI's "Human Activity Recognition Using Smartphones Data Set".

The goal of this document is to describe the procedure for extracting this data, with background on the original UCI experiment, and to describe all the variables of the output dataset "SummaryData_Samsung.txt".

The script used to produce this data is called run_analysis.R, written in R language.
A detailed description of what this script does is provided in a separate attached document called README.md.


## Study design
This project's aim was to tidy and summarize the extensive dataset for UCI's ["Human Activity Recognition Using Smartphones Data Set."](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
The original dataset can be downloaded [here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Our script has performed the following tasks to produce  "SummaryData_Samsung.txt".
- Merge the training and the test sets from original experiment to create one data set.
- Extract only the measurements of the mean and standard deviation for each variable/feature.
- Descriptively label the activity names in the data set
- Appropriately label the data set with descriptive variable names.
- Create an independent tidy data set with the average of each variable for each activity and each subject.

The output is one single txt file, with a single summary table
- 180 rows corresponding to each of the observations that have been summarized, that the 180 combinations for each of 30 subjects and each of the 6 possible recorded activities.
- 68 columns with the subject identifier, the activity labele, and the mean and standard for 33 different features measured by devices and/or calculated in the original experiment.
- the values in the table represent the mean averages of the for each of the 66 measurements above, per subject and per activity.


#### Original experiment and data used as input

Human Activity Recognition Using Smartphones Dataset Version 1.0
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit� degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.


## Codebook
The variables present in the data are listed below in this section.
Each variable, apart from (1) subject and  (2) activity represent the average per subject, and per activity of the Mean or of the Standard Deviation of measurements recorded by the accelerometer and gyroscope on the wearable devices.


#### The identifier variables

  1. **subject** : the integer code representing the subject whose activity was recorded. Range 1-30
  2. **activity** : the activity recorded on the the observation. Values = WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### Time domain signals
the time domain were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into **tri-axial body acceleration (Variables 3 through 8)** and **triaxial gravity acceleration (Variables 8 through 14)** signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

The gyroscope also captured the time domain **tri-axial angular velocity (Variables 21 through 26)**.

Each feature was normalized and bounded within [-1,1]. Then the average per subject, and per activity of either the Mean or the Standard Deviation of these acceleration were calculated.


3. "Time Body Acceleration Mean X axis"
4. "Time Body Acceleration Mean Y axis"
5. "Time Body Acceleration Mean Z axis"
6. "Time Body Acceleration Standard Deviation X axis"
7. "Time Body Acceleration Standard Deviation Y axis"
8. "Time Body Acceleration Standard Deviation Z axis"
9. "Time Gravity Acceleration Mean X axis"
10. "Time Gravity Acceleration Mean Y axis"
11. "Time Gravity Acceleration Mean Z axis"
12. "Time Gravity Acceleration Standard Deviation X axis"
13. "Time Gravity Acceleration Standard Deviation Y axis"
14. "Time Gravity Acceleration Standard Deviation Z axis"


21. "Time Body Angular Velocity Mean X axis"
22. "Time Body Angular Velocity Mean Y axis"
23. "Time Body Angular Velocity Mean Z axis"
24. "Time Body Angular Velocity Standard Deviation X axis"
25. "Time Body Angular Velocity Standard Deviation Y axis"
26. "Time Body Angular Velocity Standard Deviation Z axis"

#### Jerks signals
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals **tri-axial Time Body Acceleration Jerk signals (Variables 15 through 20)** and **Time Body Angular Velocity Jerk signals (Variables 27 through 32)**.

Each feature was normalized and bounded within [-1,1]. Then the average per subject, and per activity of either the Mean or the Standard Deviation of these acceleration were calculated.

15. "Time Body Acceleration Jerk Mean X axis"
16. "Time Body Acceleration Jerk Mean Y axis"
17. "Time Body Acceleration Jerk Mean Z axis"
18. "Time Body Acceleration Jerk Standard Deviation X axis"
19. "Time Body Acceleration Jerk Standard Deviation Y axis"
20. "Time Body Acceleration Jerk Standard Deviation Z axis"


27. "Time Body Angular Velocity Jerk Mean X axis"
28. "Time Body Angular Velocity Jerk Mean Y axis"
29. "Time Body Angular Velocity Jerk Mean Z axis"
30. "Time Body Angular Velocity Jerk Standard Deviation X axis"
31. "Time Body Angular Velocity Jerk Standard Deviation Y axis"
32. "Time Body Angular Velocity Jerk Standard Deviation Z axis"


#### Magnitude
Also the **magnitude** of these three-dimensional signals were calculated using the Euclidean norm.

Each feature was normalized and bounded within [-1,1]. Then the average per subject, and per activity of either the Mean or the Standard Deviation of these acceleration were calculated.

33. "Time Body Acceleration Magnitude Mean"
34. "Time Body Acceleration Magnitude Standard Deviation"
35. "Time Gravity Acceleration Magnitude Mean"
36. "Time Gravity Acceleration Magnitude Standard Deviation"
37. "Time Body Acceleration Jerk Magnitude Mean"
38. "Time Body Acceleration Jerk Magnitude Standard Deviation"
39. "Time Body Angular Velocity Magnitude Mean"
40. "Time Body Angular Velocity Magnitude Standard Deviation"
41. "Time Body Angular Velocity Jerk Magnitude Mean"
42. "Time Body Angular Velocity Jerk Magnitude Standard Deviation"


#### Frequency domain signals
Finally a **Fast Fourier Transform** (FFT) was applied to some of these signals producing
  - triaxial Frequency Body Acceleration, 43-48
  - triaxial Frequency Body Acceleration Jerk, 49-54
  - triaxial Frequency Body Angular Velocity, 55-60
  - Frequency Body Acceleration Magnitude, 61-62
  - Frequency Body Acceleration Jerk Magnitude, 63-64
  - Frequency Body Angular Velocity Magnitude, 65-66
  - Frequency Body Angular Velocity Jerk Magnitude, 67-68.


  Each feature was normalized and bounded within [-1,1]. Then the average per subject, and per activity of either the Mean or the Standard Deviation of these acceleration were calculated.


43. "Frequency Body Acceleration Mean X axis"
44. "Frequency Body Acceleration Mean Y axis"
45. "Frequency Body Acceleration Mean Z axis"
46. "Frequency Body Acceleration Standard Deviation X axis"
47. "Frequency Body Acceleration Standard Deviation Y axis"
48. "Frequency Body Acceleration Standard Deviation Z axis"
49. "Frequency Body Acceleration Jerk Mean X axis"
50. "Frequency Body Acceleration Jerk Mean Y axis"
51. "Frequency Body Acceleration Jerk Mean Z axis"
52. "Frequency Body Acceleration Jerk Standard Deviation X axis"
53. "Frequency Body Acceleration Jerk Standard Deviation Y axis"
54. "Frequency Body Acceleration Jerk Standard Deviation Z axis"
55. "Frequency Body Angular Velocity Mean X axis"
56. "Frequency Body Angular Velocity Mean Y axis"
57. "Frequency Body Angular Velocity Mean Z axis"
58. "Frequency Body Angular Velocity Standard Deviation X axis"
59. "Frequency Body Angular Velocity Standard Deviation Y axis"
60. "Frequency Body Angular Velocity Standard Deviation Z axis"
61. "Frequency Body Acceleration Magnitude Mean"
62. "Frequency Body Acceleration Magnitude Standard Deviation"
63. "Frequency Body Acceleration Jerk Magnitude Mean"
64. "Frequency Body Acceleration Jerk Magnitude Standard Deviation"
65. "Frequency Body Angular Velocity Magnitude Mean"
66. "Frequency Body Angular Velocity Magnitude Standard Deviation"
67. "Frequency Body Angular Velocity Jerk Magnitude Mean"
68. "Frequency Body Angular Velocity Jerk Magnitude Standard Deviation"
