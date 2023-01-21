
#THE CODE MIGHT RUN SLOW IN SOME COMPUTERS, SINCE IT USES
#MACHINE LEARNING ALGORITHMS ~ 30 SECONDS ON A GOOD LAPTOP

#Erin Kumala Aliwarga - 2502003775
#Glory Daniella - 2502003895
#Jason Adriel - 2501985451
# Reynaldi Joely - 2540124356

#<----------------- 1. Library Loading ----------------->
library(tidymodels)
library(naniar)
library(randomForest)
library(vip)
library(dials)
library(doParallel)
library(kknn)
#Functions
seeTargetProportion <- function(args) {
   args %>%
      count(stroke) %>%
      mutate(prop = n/sum(n))
}
#<------------------------------------------------------>




#<------------------ 2. Data Loading ------------------->
setwd("C:/Users/Admin/Desktop/Coding/R/Datasets/")
df <- read.csv("stroke_data.csv")
glimpse(df)
summary(df)

seeTargetProportion(df) #The data is balanced.

#Initial data inference, no duplicates
df <- df %>% replace_with_na(replace = list(bmi = "N/A"))
nrow(df[duplicated(df),])

#Normalizing the data types
df$bmi <- as.numeric(df$bmi)
factorColumns <- c("sex", "ever_married", "work_type", "Residence_type",
                   "hypertension", "smoking_status", "heart_disease", "stroke")
df[, factorColumns] <- lapply(df[, factorColumns], as.factor)
df$stroke <- relevel(df$stroke, ref = 2)

summary(df)

#Remove impossible data
df <- df[!(df$age < 0),]
#<------------------------------------------------------>




#<----------------- 3. Data Splitting ------------------>
set.seed(97661259)
sdf <- initial_split(df, strata = stroke)
df_train <- training(sdf)
df_test <- testing(sdf)

seeTargetProportion(df_train)
seeTargetProportion(df_test)
#<------------------------------------------------------>


#<-------------- 4. Data Pre-processing ---------------->
colSums(is.na(df_train))
colSums(is.na(df_test))

#Drop the missing values
df_train <- drop_na(df_train)
df_test <- drop_na(df_test)
colSums(is.na(df_train))
colSums(is.na(df_test))
#<------------------------------------------------------>


#<------------- 5. Logistic Model Creation ------------->
df_recipe <- recipe(stroke ~ ., data = df_train) %>%
   step_normalize(all_numeric()) %>%
   step_dummy(all_nominal_predictors())

logistic_model <- logistic_reg()

logistic_wf <- workflow() %>%
   add_model(logistic_model) %>%
   add_recipe(df_recipe)

fitted_result_logistic <- logistic_wf %>%
   fit(data = df_train)
#<------------------------------------------------------>


#<------------ 6. Logistic Model Testing --------------->
fitted_result_logistic %>%
   extract_fit_parsnip() %>%
   tidy()

fitted_result_logistic %>%
   extract_fit_parsnip() %>%
   tidy(exponentiate = T)

prediction_logistic <- augment(fitted_result_logistic, df_test)
prediction_logistic %>%
   roc_curve(stroke, .pred_1) %>%
   autoplot()


evaluate_metrics <- metric_set(accuracy, ppv, recall, f_meas)
evaluate_metrics(data = prediction_logistic, truth = stroke, estimate = .pred_class)
roc_auc(prediction_logistic, stroke, .pred_1)
#<------------------------------------------------------>



#<----------- 7. Random Forest Model Creation ----------->
rf_model <- rand_forest(mode = "classification") %>%
   set_engine("randomForest")

rf_wf <- workflow() %>%
   add_model(rf_model) %>%
   add_recipe(df_recipe)

fitted_result_rf <- rf_wf %>%
   fit(data = df_train)
#<------------------------------------------------------>



#<---------- 8. RandomForest Model Testing ------------->
prediction_rf <- augment(fitted_result_rf, df_test)
prediction_rf %>%
   roc_curve(stroke, .pred_1) %>%
   autoplot()

evaluate_metrics <- metric_set(accuracy, ppv, recall, f_meas)
evaluate_metrics(data = prediction_rf, truth = stroke, estimate = .pred_class)
roc_auc(prediction_rf, stroke, .pred_1)

fitted_result_rf %>%
   extract_fit_parsnip() %>%
   vip()
#<------------------------------------------------------>



#<---------------- 10. KNN Model Creation -------------->
knn_model <- nearest_neighbor(mode = "classification") %>%
   set_engine("kknn")

knn_wf <- workflow() %>%
   add_model(knn_model) %>%
   add_recipe(df_recipe)

fitted_result_knn <- knn_wf %>%
   fit(data = df_train)
#<------------------------------------------------------>



#<---------------- 11. KNN Model Testing --------------->
prediction_knn <- augment(fitted_result_knn, df_test)
prediction_knn %>%
   roc_curve(stroke, .pred_1) %>%
   autoplot()

evaluate_metrics <- metric_set(accuracy, ppv, recall, f_meas)
evaluate_metrics(data = prediction_knn, truth = stroke, estimate = .pred_class)
roc_auc(prediction_knn, stroke, .pred_1)
#<------------------------------------------------------>