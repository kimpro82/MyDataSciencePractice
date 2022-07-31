# 1. Read, Skim and Pre-process data


# 1.0 Initial Codes given from Kaggle

# This Python 3 environment comes with many helpful analytics libraries installed
# It is defined by the kaggle/python Docker image: https://github.com/kaggle/docker-python
# For example, here's several helpful packages to load

import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)

# Input data files are available in the read-only "../input/" directory
# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory

# import os
# for dirname, _, filenames in os.walk('/kaggle/input'):
#     for filename in filenames:
#         print(os.path.join(dirname, filename))

# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using "Save & Run All" 
# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session


from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_validate
from sklearn.ensemble import HistGradientBoostingClassifier
from sklearn.inspection import permutation_importance


# 1.1 Read and Skim data

df = pd.read_csv('Data/Train.csv')

print(df.head())
df.info()
df.describe()


# 1.2 Find where to pre-processing

print(df["Embarked"].unique())                                       # ['S' 'C' 'Q' nan]
print(df["Embarked"].value_counts())                                 # mode : 'S' (644/891)

# Remove : 1 PassengerId, 3 Name, 8 Ticket (useless) / 10 Cabin (too many NaN)
# Replace : 4 Sex(categorical) 5 Age(fill NaN) 11 Embarked(some NaN, categorical)


# 1.3 Pre-processing : Remove or replace NaN

# Remove : 1 PassengerId, 3 Name, 8 Ticket (useless) / 10 Cabin (too many NaN)
# Replace : 4 Sex (categorical) 5 Age (fill NaN) 11 Embarked (some NaN, categorical)
#           + 2 Pclass (categorical) - added since Version 3

df.drop(["PassengerId", "Name", "Ticket", "Cabin"], axis=1, inplace=True)
df["Age"].fillna(df.Age.mean(), inplace=True)
df["Embarked"].fillna("S", inplace=True)                  # "S" : mode
df = pd.get_dummies(df, columns=["Pclass", "Embarked", "Sex"])
# df["Sex"].replace(to_replace="male", value=1, inplace=True)
# df["Sex"].replace(to_replace="female", value=0, inplace=True)

print(df.head())
df.info()
df.describe()



# 2. HGB


# 2.1 Split input and target data

data = df.iloc[:,1:].to_numpy()                   # except 0 : Survived (target)
target = df.iloc[:,0].to_numpy()

print(len(data))                                  # 891
print(len(target))                                # 891

print(data[:5,])
print(target[:5])


# 2.2 HGB

train_input, valid_input, train_target, valid_target = train_test_split(data, target, test_size=0.2, random_state=604)

hgb = HistGradientBoostingClassifier(max_leaf_nodes=5, learning_rate=0.01, max_iter=3000, random_state=604)
hgb.fit(train_input, train_target)

print(hgb.score(valid_input, valid_target))



# 3. Submit


# 3.1 Read and pre-process the test data

test = pd.read_csv('Data/Test.csv')

# print(test.head())
test.drop(["Name", "Ticket", "Cabin"], axis=1, inplace=True)            # "PassengerId" should be remained
test["Age"].fillna(test.Age.mean(), inplace=True)
test["Fare"].fillna(test.Fare.mean(), inplace=True)
test["Embarked"].fillna("S", inplace=True)
test = pd.get_dummies(test, columns=["Pclass", "Embarked", "Sex"])

print(test.head())
test.info()

test_input = test.iloc[:,1:].to_numpy() 


# 3.2 Generate the submission file

test_id = test["PassengerId"]
test_output = hgb.predict(test_input)
submission = pd.DataFrame({"PassengerId": test_id, "Survived": test_output})
submission.to_csv("Submission/Submission_HGB_3.csv", index=False)

submission.head()