## Kaggle > Competitions

# Titanic - Machine Learning from Disaster

https://www.kaggle.com/competitions/titanic


## \<List>

- [Version 2 : HGB 2 (2022.07.28)](#version-2--hgb-2-20220728)
- [Version 1 : HGB (2022.07.27)](#version-1--hgb-20220727)


## [Version 2 : HGB 2 (2022.07.28)](#list)

- Use **HGB(Histogram-based Gradient Boosting)** with some parameters' change
```python
hgb = HistGradientBoostingClassifier(max_leaf_nodes=5, learning_rate=0.01, max_iter=1000, random_state=604)
```
- Scores
  - Test (in `train.csv`) : `0.8435754189944135`
  - Submission : `0.76555` (somewhat improved but I'm still thirsty!)
- Kaggle Code : [HGB(Histogram-based Gradient Boosting) in Titanic (Version 2)](https://www.kaggle.com/code/kangrokkim/hgb-histogram-based-gradient-boosting-in-titanic/notebook?scriptVersionId=101936628)


## [Version 1 : HGB (2022.07.27)](#list)

- Use **HGB(Histogram-based Gradient Boosting)** with default parameters
- Pre-processing
  - Remove 4 variables  : 1 PassengerId, 3 Name, 8 Ticket (useless) / 10 Cabin (too many NaN)
  - Replace 3 variables : 4 Sex(categorical) 5 Age(fill NaN) 11 Embarked(fill NaN, categorical)
- Scores
  - Trainning : `0.9459309962075663`
  - Validation : `0.8217275682064414`
  - Test (in `train.csv`) : `0.8324022346368715`
  - Submission : `0.75598` (disappointed ……)
- Kaggle Code : [HGB(Histogram-based Gradient Boosting) in Titanic (Version 1)](https://www.kaggle.com/code/kangrokkim/hgb-histogram-based-gradient-boosting-in-titanic?scriptVersionId=101897526)