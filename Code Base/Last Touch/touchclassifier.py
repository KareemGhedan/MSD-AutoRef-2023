# -*- coding: utf-8 -*-
"""TouchClassifier.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/126Z1Nma9ek6geVx96CyUdZG_fxxkjoE7
"""

# I need to use this version because Matlab has this version as well
!pip install scikit-learn==1.3.0

!pip show scikit-learn

import warnings
warnings.filterwarnings('ignore')

# This library is needed to save RF model
import joblib
import statistics
import numpy as np
import pandas as pd
import seaborn as sn
from sklearn.svm import SVC
import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve
from sklearn.metrics import roc_auc_score
from sklearn.tree import DecisionTreeClassifier
from sklearn.neural_network import MLPClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix

dataset = pd.read_csv('/content/Dataset.csv')

dataset = dataset
dataset.head(5)

"""# **Data Preprocessing**

"""

row_number, col_number = dataset.shape
print(f'The dataset contains {row_number} rows and {col_number} columns.')

dataset.info()

# Check for duplicate values
dataset[dataset.duplicated()]
# or  dataset[dataset.duplicated()].sum()

"""As we can see above, there isn't any duplicated record in the dataset."""

# Check missing values
null_columns = dataset.columns[dataset.isnull().any()]

print('List of columns consisting null values and their quantity:')
print(dataset[null_columns].isnull().sum())

"""There is no missing values in this dataset.

**Data Distribution**

Here, the distribution of the values in each column of the dataset is shown.
"""

fig=plt.figure(figsize=(20,25))

for index, column in enumerate(dataset.columns):
    ax = fig.add_subplot(6,3,index+1)
    dataset[column].hist(bins = 20, ax = ax, facecolor = 'LightSeaGreen')
    ax.set_title(column + " distribution",color = 'darkred')

fig.tight_layout()
plt.show()

"""**Check Correlation**

Showing the correlation between the features using a heatmap.
"""

sn.pairplot(dataset, hue='Touch')

# This function given the dataset and its target value will produce
# a heatmap which shows the correlation between each column parwise
# and also the target value.
def corr(dataframe,target_variable):

    fig, ax = plt.subplots(figsize=(17,17))
    correlation_matrix = dataframe.corr().round(2)
    sn.heatmap(data=correlation_matrix, annot=True)

    correlation = dataset.corr()[target_variable].abs().sort_values(ascending = False)
    return correlation

corr(dataset,"Touch")

"""**Checking Balancing**"""

dataset.Touch.value_counts()

sn.countplot(x='Touch',data=dataset,palette=["#eb383b","#3853eb"])

"""#**Learning and Model Selection**

##**Dataset Spliting**
"""

# Separating target feature from the features
y = dataset['Touch']
X = dataset.drop(columns=['Touch'], axis=1)

from sklearn.model_selection import train_test_split
import random

X_, X_test, y_, y_test = train_test_split(X, y, test_size = 0.20, random_state= 21)
X_train, X_validation, y_train, y_validation = train_test_split(X_, y_, test_size = 0.20, random_state= 21)

X_train.shape

X_validation.shape

X_test.shape

"""##**Model Selection**

###**Support Vector Machine**
"""

# SVM
classifierSVM = SVC(probability=True)
classifierSVM.fit(X_train, y_train)
y_pred_val_SVM = classifierSVM.predict(X_validation)
print("************Results for SVM*************")
print("Confusion Matrix for Validation Set\n")
print(classification_report(y_validation, y_pred_val_SVM))

y_pred_test_SVM = classifierSVM.predict(X_test)
print("************Results for SVM*************")
print("Confusion Matrix for Test Set\n")
print(classification_report(y_test, y_pred_test_SVM))

y_SVM_pred_prob=classifierSVM.predict_proba(X_test)[::,1]

FPRate_SVM, TPRate_SVM, Threshold_SVM = roc_curve(y_test, y_SVM_pred_prob)
AUC = roc_auc_score(y_test, y_SVM_pred_prob)
plt.plot(FPRate_SVM,TPRate_SVM,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve SVM')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

"""###**MLP**"""

# MLP
classifierMLP = MLPClassifier((100,100))
classifierMLP.fit(X_train, y_train)
y_pred_val_MLP = classifierMLP.predict(X_validation)
print("************Results for MLP*************")
print("Confusion Matrix for Validation Set\n")
print(classification_report(y_validation, y_pred_val_MLP))
# classifierMLP.get_params()

y_pred_test_MLP = classifierMLP.predict(X_test)
print("************Results for MLP*************")
print("Confusion Matrix for Test Set\n")
print(classification_report(y_test, y_pred_test_MLP))

y_MLP_pred_prob=classifierMLP.predict_proba(X_test)[::,1]

FPRate, TPRate, Threshold = roc_curve(y_test, y_MLP_pred_prob)
AUC = roc_auc_score(y_test, y_MLP_pred_prob)
plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve MLP')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

"""### **Dicision Tree**"""

# Decision Tree
classifierDT = DecisionTreeClassifier()
classifierDT.fit(X_train, y_train)
y_pred_val_DT = classifierDT.predict(X_validation)
print("************Results for Decision Tree*************")
print("Confusion Matrix for Validation Set\n")
print(classification_report(y_validation, y_pred_val_DT))

y_pred_test_DT = classifierDT.predict(X_test)
print("************Results for Decision Tree*************")
print("Confusion Matrix for Test Set\n")
print(classification_report(y_test, y_pred_test_DT))

y_DT_pred_prob=classifierDT.predict_proba(X_test)[::,1]

FPRate, TPRate, Threshold = roc_curve(y_test, y_DT_pred_prob)
AUC = roc_auc_score(y_test, y_DT_pred_prob)
plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve DT')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

"""###**Random Forest**"""

# Random Forest
classifierRF = RandomForestClassifier(max_depth= 15,n_estimators=80)
classifierRF.fit(X_train, y_train)
y_pred_val_RF = classifierRF.predict(X_validation)
print("************Results for Random Forest*************")
print("Confusion Matrix for Validation Set\n")
print(classification_report(y_validation, y_pred_val_RF))

# per_tree_pred_val = [tree.predict(X_validation) for tree in classifierRF.estimators_]

# FPRate, TPRate, not_imp = roc_curve(y_validation, mean_validation)
# AUC = roc_auc_score(y_test, mean)
# plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
# plt.legend(loc=4)
# plt.title ('ROC Curve Validation Set')
# plt.show()

# print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

y_pred_test_RF = classifierRF.predict(X_test)
print("************Results for Random Forest*************")
print("Confusion Matrix for Test Set\n")
print(classification_report(y_test, y_pred_test_RF))

y_RF_pred_prob=classifierRF.predict_proba(X_test)[::,1]

FPRate, TPRate, Threshold = roc_curve(y_test, y_RF_pred_prob)
AUC = roc_auc_score(y_test, y_RF_pred_prob)
plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve RF')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

"""First Model"""

# Random Forest
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
classifierRF2 = RandomForestClassifier(max_depth= 15,n_estimators=25)
classifierRF2.fit(X_train, y_train)
y_pred_val_RF = classifierRF2.predict(X_validation)
print("************Results for Random Forest*************")
print("Confusion Matrix for Validation Set\n")
print(classification_report(y_validation, y_pred_val_RF))

y_RF_pred_prob_val=classifierRF2.predict_proba(X_validation)[::,1]

FPRate, TPRate, Threshold = roc_curve(y_validation, y_RF_pred_prob_val)
AUC = roc_auc_score(y_validation, y_RF_pred_prob_val)
plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve RF - Validation Set')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

# Random Forest
y_pred_test_RF = classifierRF2.predict(X_test)
print("************Results for Random Forest*************")
print("Confusion Matrix for test Set\n")
print(classification_report(y_test, y_pred_test_RF))



y_RF_pred_prob=classifierRF2.predict_proba(X_test)[::,1]

FPRate, TPRate, Threshold = roc_curve(y_test, y_RF_pred_prob)
AUC = roc_auc_score(y_test, y_RF_pred_prob)
plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve RF - Test Set')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

#Plotting Confusion Matrix
confusion_matrix_RF = confusion_matrix(y_test,y_pred_test_RF)
sn.heatmap(confusion_matrix_RF , annot=True,cmap="BuGn" , fmt='g')
plt.tight_layout()
plt.title('Confusion matrix RF\n')

FPRate, TPRate, not_imp = roc_curve(y_test, mean)
AUC = roc_auc_score(y_test, mean)
plt.plot(FPRate,TPRate,label="data, AUC="+str(AUC))
plt.legend(loc=4)
plt.title ('ROC Curve Test Set')
plt.show()

print(f"The score for the AUC ROC Curve is: {round(AUC,2)*100}%")

"""###**Performance Comparision**"""

from sklearn import metrics
models=['Support Vector Machine', 'Melti Layer Perceptron', 'Decision Tree', 'Random Forest Classifier']
accuracy=[y_pred_test_SVM, y_pred_test_MLP, y_pred_test_DT,y_pred_test_RF]

for i,j in zip(models,accuracy):
  print("Accuracy for {} : {}".format(i,round(metrics.accuracy_score(y_test,j),2)))

FPRate_SVM, TPRate_SVM, Threshold_SVM = roc_curve(y_test, y_SVM_pred_prob)
FPRate_MLP, TPRate_MLP, Threshold_MLP = roc_curve(y_test, y_MLP_pred_prob)
FPRate_DT, TPRate_DT, Threshold_DT = roc_curve(y_test, y_DT_pred_prob)
FPRate_RF, TPRate_RF, Threshold_RF = roc_curve(y_test, y_RF_pred_prob)

import matplotlib.pyplot as plt

plt.figure(figsize=(12,6))

plt.plot(FPRate_SVM, TPRate_SVM,label="Support Vector Machine")
plt.plot(FPRate_MLP, TPRate_MLP,label="Multi Layer Perceptron")
plt.plot(FPRate_DT, TPRate_DT,label="Decision Tree")
plt.plot(FPRate_RF, TPRate_RF,label="Random Forest")

# Calculate AUC for each classifier
auc_svm = metrics.auc(FPRate_SVM, TPRate_SVM)
auc_mlp = metrics.auc(FPRate_MLP, TPRate_MLP)
auc_dt = metrics.auc(FPRate_DT, TPRate_DT)
auc_rf = metrics.auc(FPRate_RF, TPRate_RF)

# Display AUC values in legend
plt.legend(loc=4)
plt.grid(color='b', ls = '-.', lw = 0.25)
# Add AUC values to legend
plt.text(0.63, 0.06, f"AUC_SVM: {auc_svm:.2f}\nAUC_MLP: {auc_mlp:.2f}\nAUC_DT: {auc_dt:.2f}\nAUC_RF: {auc_rf:.2f}", transform=plt.gca().transAxes)
plt.show()

"""Based on evaluation metrics **Random Forest** has been chosen as the **best model**.

**Check the performance of the best model for some real_time data.**
"""

# Ground Truth: No_Touch
data = {'X_dist': [0.0477],	'Y_dist':[-0.5307],	'Z_dist': [-0.4818],	'distance':[0.7184] }
sample = pd.DataFrame.from_dict(data)
sample

classifierRF.predict(sample)

# 2.0576	0.5674	-0.0068	2.5077	0.7825	-0.1793	-0.4500	-0.2151	0.1725	0.5278
# Ground Truth: No_Touch

data = {'X_dist': [-0.4500],	'Y_dist':[-0.2151],	'Z_dist': [0.1725],	'distance':[0.5278] }
sample = pd.DataFrame.from_dict(data)
sample

y_predRF_test = classifierRF.predict(sample)
y_predRF_test

# 2.0821	0.5607	-0.2054	2.5076	0.7827	-0.1792	-0.4255	-0.2219	-0.0261	0.4807
# Ground Truth: No_Touch

data = {'X_dist': [-0.4255],'Y_dist':[-0.2219],	'Z_dist': [-0.0261],	'distance':[0.4807] }
sample = pd.DataFrame.from_dict(data)
sample

y_predRF_test = classifierRF.predict(sample)
y_predRF_test

# 2.6064	0.5590	-0.7042	2.5072	0.7827	-0.1795	0.0991	-0.2236	-0.5247	0.5789
# Ground Truth: No_Touch

data = {'X_Ball':[2.6064],'Y_Ball':[0.5590],'Z_Ball':[-0.7042],'X_Turtle':[2.5072],'Y_Turtle': [0.7827],'Z_Turtle': [-0.1795],	'X_dist': [0.0991],'Y_dist':[-0.2236],	'Z_dist': [-0.5247],	'distance':[0.5789] }
sample = pd.DataFrame.from_dict(data)
sample

y_predRF_test = classifierRF.predict(sample)
y_predRF_test

#Ground Truth: No Touch
# 5.0089	0.1061	-2.3813	2.1083	0.7874	-1.2885	2.9005	-0.6813	-1.0927	3.1735

data = {'X_dist': [2.9005],'Y_dist':[-0.6813],	'Z_dist': [-1.0927],	'distance':[3.1735] }
sample = pd.DataFrame.from_dict(data)
sample

y_predRF_test = classifierRF.predict(sample)
y_predRF_test

# We don't need to use it anymore because this part now is done in Matlab
#  Define a function for feature extracting
# def feature_extractor(file):
#     # Reading Data
#     data = pd.read_csv(file)
#     # Choosing the ball and the turtle positions
#     targeted_columns = data.iloc[1:, [5,6,7,12,13,14]][4:]
#     # Define a header
#     targeted_columns.columns=['X_Ball', 'Y_Ball', 'Z_Ball', 'X_Turtle', 'Y_Turtle', 'Z_Turtle']
#     # Delete missing Values
#     targeted_columns = targeted_columns.dropna()
#     # Reset the index of the DataFrame
#     targeted_columns = targeted_columns.reset_index(drop=True)
#     cleaned_data = targeted_columns
#     cleaned_data = cleaned_data.apply(pd.to_numeric)
#     cleaned_data['X_dist']= cleaned_data['X_Ball'] - cleaned_data['X_Turtle']
#     cleaned_data['Y_dist']= cleaned_data['Y_Ball'] - cleaned_data['Y_Turtle']
#     cleaned_data['Z_dist']= cleaned_data['Z_Ball'] - cleaned_data['Z_Turtle']
#     cleaned_data['distance'] =  np.sqrt(cleaned_data['X_dist']**2 + cleaned_data['Y_dist']**2 + cleaned_data['Z_dist']**2)
#     return cleaned_data.iloc[:,6:]

"""**Saving RF Model**"""

joblib.dump(classifierRF, "RFClassifier")

RF_Classifier = joblib.load("RFClassifier")