### [Kaggle > Notebook](/README.md#analysis)

# Data Splitting Practice in R

(2023.08.05)

- [Kaggle Notebook : Data Splitting Practice in R](https://www.kaggle.com/code/kangrokkim/data-splitting-practice-in-r)

- References : [R Documentation > createDataPartition {caret} > Data Splitting functions](https://search.r-project.org/CRAN/refmans/caret/html/createDataPartition.html)

- Codes and Outputs

  - caret 패키지 로드
    ```r
    # caret 패키지 로드
    library(caret)
    ```

  - sample data 호출(oil)
    ```r
    data(oil)
    ls()                                                        # "fattyAcids" "oilType"
    str(fattyAcids)
    ```
    <details>
      <summary>Output</summary>

    ```txt
    [1] "fattyAcids" "oilType"
    ```
    ```txt
    'data.frame':	96 obs. of  7 variables:
    $ Palmitic  : num  9.7 11.1 11.5 10 12.2 9.8 10.5 10.5 11.5 10 ...
    $ Stearic   : num  5.2 5 5.2 4.8 5 4.2 5 5 5.2 4.8 ...
    $ Oleic     : num  31 32.9 35 30.4 31.1 43 31.8 31.8 35 30.4 ...
    $ Linoleic  : num  52.7 49.8 47.2 53.5 50.5 39.2 51.3 51.3 47.2 53.5 ...
    $ Linolenic : num  0.4 0.3 0.2 0.3 0.3 2.4 0.4 0.4 0.2 0.3 ...
    $ Eicosanoic: num  0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4 0.4 ...
    $ Eicosenoic: num  0.1 0.1 0.1 0.1 0.1 0.5 0.1 0.1 0.1 0.1 ...
    ```
    </details>
  - createDataPartition 함수 사용
    ```r
    createDataPartition(oilType, 2)                             # oilType 변수를 기반으로 데이터 분할
    ```
    <details>
      <summary>Output</summary>

    ```txt
    $Resample1
    [1]  1  2  3  5  7  8  9 11 13 14 15 16 19 20 23 26 27 28 29 31 34 35 36 37 38 42 44 45 47 50 51 52 53 56 59 60 61 65 69 70 74 76 77 78 84 86 88
    [48] 89 91 94

    $Resample2
    [1]  1  4  6  9 11 12 13 14 16 19 22 23 25 26 28 29 30 32 34 36 37 39 42 45 48 50 51 52 53 56 57 60 62 64 65 67 68 70 71 74 77 80 82 84 86 88 89
    [48] 92 93 95
    ```
    </details>

  - createFolds 함수 사용

    ```r
    createFolds(oilType, 3)                                     # oilType 변수를 기반으로 3개의 fold 생성
    createFolds(oilType, 3, list = FALSE)
    createFolds(oilType, 3, returnTrain = TRUE)
    ```
    <details>
      <summary>Output</summary>

    ```txt
    $Fold1
    [1]  1  2  4  7  8 12 13 14 15 23 24 25 28 33 43 45 48 53 54 57 59 62 63 72 73 76 81 82 83 84 96

    $Fold2
    [1]  6  9 16 17 18 22 26 27 29 30 35 36 40 42 47 50 55 60 64 65 67 68 75 77 78 79 80 86 87 90 93 95

    $Fold3
    [1]  3  5 10 11 19 20 21 31 32 34 37 38 39 41 44 46 49 51 52 56 58 61 66 69 70 71 74 85 88 89 91 92 94
    ```
    ```txt
    [1] 3 2 1 1 1 2 3 3 2 2 1 2 3 1 3 2 3 1 3 3 3 1 1 2 2 1 2 3 1 3 2 2 1 2 3 2 1 2 1 1 3 1 2 3 3 2 3 2 1 1 2 2 3 1 2 3 1 2 1 2 3 2 2 2 3 3 3 3 2 1 2
    [72] 3 1 1 2 1 3 1 2 2 3 3 1 2 1 3 2 1 2 2 3 3 2 1 3 1
    ```
    ```txt
    $Fold1
    [1]  4  5  6  8  9 10 11 12 13 14 16 18 19 20 22 23 25 26 27 29 30 31 34 36 37 39 41 42 43 46 47 49 50 53 55 56 57 58 60 61 64 66 67 69 71 72 73
    [48] 75 77 78 80 81 82 83 84 85 86 88 91 93 94 95 96

    $Fold2
    [1]  1  2  3  6  7  9 10 12 13 14 15 16 17 18 20 21 22 23 24 28 29 31 32 33 35 37 38 40 41 42 43 44 45 46 47 48 49 51 52 54 57 58 59 60 62 63 65
    [48] 68 70 72 74 75 76 77 79 82 83 85 87 88 89 90 92 93

    $Fold3
    [1]  1  2  3  4  5  7  8 11 15 17 19 21 24 25 26 27 28 30 32 33 34 35 36 38 39 40 44 45 48 50 51 52 53 54 55 56 59 61 62 63 64 65 66 67 68 69 70
    [48] 71 73 74 76 78 79 80 81 84 86 87 89 90 91 92 94 95 96
    ```
    </details>

  - createTimeSlices 함수 사용
    ```r
    createTimeSlices(1:9, 5, 3, fixedWindow = TRUE)             # 1부터 9까지의 값으로 5개의 시계열 분할 생성
    createTimeSlices(1:9, 5, 3, fixedWindow = FALSE)
    createTimeSlices(1:9, 5, 3)                                 # fixedWindow : FALSE (기본값)
    ```
    <details>
      <summary>Output</summary>

    ```txt
    $train
    $train$Training5
    [1] 1 2 3 4 5

    $train$Training6
    [1] 2 3 4 5 6


    $test
    $test$Testing5
    [1] 6 7 8

    $test$Testing6
    [1] 7 8 9
    ```
    ```txt
    $train
    $train$Training5
    [1] 1 2 3 4 5

    $train$Training6
    [1] 1 2 3 4 5 6


    $test
    $test$Testing5
    [1] 6 7 8

    $test$Testing6
    [1] 7 8 9
    ```
    </details>

    ```r
    createTimeSlices(1:15, 5, 3, skip = 2)                      # 1부터 15까지의 값으로 5개의 시계열 분할 생성하며, 2번째 값을 스킵
    createTimeSlices(1:15, 5, 3, skip = 3)
    ```
    <details>
      <summary>Output</summary>

    ```txt
    $train
    $train$Training05
    [1] 1 2 3 4 5

    $train$Training08
    [1] 4 5 6 7 8

    $train$Training11
    [1]  7  8  9 10 11


    $test
    $test$Testing05
    [1] 6 7 8

    $test$Testing08
    [1]  9 10 11

    $test$Testing11
    [1] 12 13 14
    ```
    ```txt
    $train
    $train$Training5
    [1] 1 2 3 4 5

    $train$Training9
    [1] 5 6 7 8 9


    $test
    $test$Testing5
    [1] 6 7 8

    $test$Testing9
    [1] 10 11 12
    ```
    </details>
