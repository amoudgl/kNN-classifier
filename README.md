# kNN-Classifier
kNN classifier built in MATLAB. Classifier is build and tested on five datasets with various classes and features.
Datasets are taken from [UCI Machine Learning Repository][l1]. 

### Structure of repository

Repository contains five folders for each dataset. Each folder further contains two files: 
- Main index file 'main.m'
- KNN Classifier function 'knnclassifier.m'

Accuracy plots are also included in the folder of each dataset. 

### Implementation

First data is stored and divided into y​equal parts (y​­​fold). One part is declared as test data and
rest is training data. This completes the training phase. During test phase, a test sample is picked 
and all the training samples are sorted according to normal or (weighted) euclidean distance from test sample. For first k​data points (in sorted list) polling is done. The class with maximum frequency is allotted to test data sample. Same procedure is repeated for all the test data points.
For a particular dataset, k is varied from 1 to 5 and y is varied from 2 to 5.
 

**Tie break:**
It may happen when k is even. Two classes may have same frequency during polling. In this case, sum of distances for both the classes is calculated. Class with minimum sum is allotted to test data sample.
 
[l1]: <http://archive.ics.uci.edu/ml/> 

