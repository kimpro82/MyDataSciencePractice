## [Kaggle > Competitions](/README.md#competitions)


# Titanic - Machine Learning from Disaster

https://www.kaggle.com/competitions/titanic


## \<List>

- [R : Random Forest (2023.12.02)](#r--random-forest-20231202)
- [Python : HGB 1.2 (2022.07.31)](#python--hgb-12-20220731)
- [Python : HGB 1.1 (2022.07.28)](#python--hgb-11-20220728)
- [Python : HGB 1.0 (2022.07.27)](#python--hgb-10-20220727)


## [R : Random Forest (2023.12.02)](#list)

- 1st attempt to apply the **Random Forest** method in **R**
  - Pre-processing : Performed *label encoding* for `Sex` `Embarked`
    ```r
    df$Sex <- as.numeric(factor(df$Sex), level=levels(df$Sex))
    df$Embarked <- as.numeric(factor(df$Embarked), level=levels(df$Embarked))
    ```
  - Utilized the `randomForest()` function without specific options
    ```r
    md <- randomForest(Survived ~ ., data = df_train)
    pred <- predict(md, newdata = df_valid, type = "class")
    ```
- Performance Scores (Accuracy) : Not so different from the previous trials with *HGB*
  - Test (`train.csv`) : `0.8379888`
  - Submission : `0.76794`
- Kaggle Code : [Random Forest in Titanic (Version 6)](https://www.kaggle.com/code/kangrokkim/random-forest-in-titanic?scriptVersionId=153351599)
  - `Titanic_RandomForest.r` is executable in a local environment


## [Python : HGB 1.2 (2022.07.31)](#list)

- More advanced **HGB(Histogram-based Gradient Boosting)**
  - Convert `Pclass` as a categorical variable additionally
    ```python
    df = pd.get_dummies(df, columns=["Pclass", "Embarked", "Sex"])
    ```
  - Change the parameter `max_iter` value from 1000 to 3000
    ```python
    hgb = HistGradientBoostingClassifier(max_leaf_nodes=5, learning_rate=0.01, max_iter=3000, random_state=604)
    ```
- Performance Scores (Accuracy)
  - Test (`train.csv`) : `0.8547486033519553`
  - Submission : `0.74641` (rather stepped back??)
- Kaggle Code : [HGB(Histogram-based Gradient Boosting) in Titanic (Version 1.21)](https://www.kaggle.com/code/kangrokkim/hgb-histogram-based-gradient-boosting-in-titanic?scriptVersionId=102157325)


## [Python : HGB 1.1 (2022.07.28)](#list)

- **HGB(Histogram-based Gradient Boosting)** with some parameters' change  
  I set `max_iter=1000` in my dream last night …… omg
    ```python
    hgb = HistGradientBoostingClassifier(max_leaf_nodes=5, learning_rate=0.01, max_iter=1000, random_state=604)
    ```
- Performance Scores (Accuracy)
  - Test (in `train.csv`) : `0.8435754189944135`
  - Submission : `0.76555` (somewhat improved but I'm still thirsty!)
- Kaggle Code : [HGB(Histogram-based Gradient Boosting) in Titanic (Version 1.1)](https://www.kaggle.com/code/kangrokkim/hgb-histogram-based-gradient-boosting-in-titanic?scriptVersionId=101936628)


## [Python : HGB 1.0 (2022.07.27)](#list)

- **HGB(Histogram-based Gradient Boosting)** with default parameters
- Use `HistGradientBoostingClassifier()` from `sklearn`
- Pre-processing
  - Remove 4 variables  : 1 PassengerId, 3 Name, 8 Ticket (useless) / 10 Cabin (too many NaN)
  - Replace 3 variables : 4 Sex(categorical) 5 Age(fill NaN) 11 Embarked(fill NaN, categorical)
- Performance Scores (Accuracy)
  - Trainning : `0.9459309962075663`
  - Validation : `0.8217275682064414`
  - Test (in `train.csv`) : `0.8324022346368715`
  - Submission : `0.75598` (disappointed ……)
- Kaggle Code : [HGB(Histogram-based Gradient Boosting) in Titanic (Version 1.0)](https://www.kaggle.com/code/kangrokkim/hgb-histogram-based-gradient-boosting-in-titanic?scriptVersionId=101897526)
