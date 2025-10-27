# 🚴 CUSTOMER PURCHASE PREDICTION SYSTEM - MULTI-PLOT VERSION
# -----------------------------------------------------------

# 📦 Step 1: Load Libraries
library(readr)
library(dplyr)
library(caret)
library(randomForest)
library(e1071)
library(ggplot2)
library(reshape2)
library(gridExtra)

# 📂 Step 2: Load and Clean Data
data <- read.csv("C:/Users/kartheeswaran/Downloads/Bike/bike_buyers.csv")
data <- distinct(data)
data <- na.omit(data)
names(data) <- gsub("\\.", "_", names(data))

# Convert categorical to factors
cat_cols <- c("Marital_Status", "Gender", "Education", "Occupation", 
              "Home_Owner", "Commute_Distance", "Region", "Purchased_Bike")
data[cat_cols] <- lapply(data[cat_cols], as.factor)

# 🧮 Step 3: Split Data
set.seed(123)
trainIndex <- createDataPartition(data$Purchased_Bike, p = 0.7, list = FALSE)
train <- data[trainIndex, ]
test <- data[-trainIndex, ]

# 🎯 Step 4: Train Models
# Logistic Regression
log_model <- glm(Purchased_Bike ~ . - ID, data = train, family = binomial)
log_pred <- predict(log_model, test, type = "response")
log_pred_class <- ifelse(log_pred > 0.5, "Yes", "No")
log_accuracy <- mean(log_pred_class == test$Purchased_Bike)

# Random Forest
rf_model <- randomForest(Purchased_Bike ~ . - ID, data = train, ntree = 100, importance = TRUE)
rf_pred <- predict(rf_model, test)
rf_accuracy <- mean(rf_pred == test$Purchased_Bike)

# Naive Bayes
nb_model <- naiveBayes(Purchased_Bike ~ . - ID, data = train)
nb_pred <- predict(nb_model, test)
nb_accuracy <- mean(nb_pred == test$Purchased_Bike)

# 🧠 Step 5: Accuracy Comparison Plot
accuracy_df <- data.frame(
  Model = c("Logistic Regression", "Random Forest", "Naive Bayes"),
  Accuracy = c(log_accuracy, rf_accuracy, nb_accuracy)
)

p1 <- ggplot(accuracy_df, aes(x = Model, y = Accuracy, fill = Model)) +
  geom_bar(stat = "identity", width = 0.6) +
  geom_text(aes(label = paste0(round(Accuracy * 100, 1), "%")), vjust = -0.5, size = 4) +
  labs(title = "Model Accuracy Comparison", y = "Accuracy", x = "Model") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 15, face = "bold", hjust = 0.5),
    axis.text = element_text(size = 11),
    legend.position = "none"
  )

# 🌲 Step 6: Feature Importance Plot
imp <- data.frame(importance(rf_model))
imp$Feature <- rownames(imp)
imp <- imp[order(imp$MeanDecreaseGini, decreasing = TRUE), ]

p2 <- ggplot(imp[1:8, ], aes(x = reorder(Feature, MeanDecreaseGini), y = MeanDecreaseGini, fill = Feature)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Feature Importance - Random Forest", x = "Features", y = "Importance") +
  theme_minimal() +
  theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5),
        legend.position = "none")

# 📊 Step 7: Confusion Matrix Heatmap
cm <- confusionMatrix(rf_pred, test$Purchased_Bike)
cm_table <- as.data.frame(cm$table)
colnames(cm_table) <- c("Prediction", "Reference", "Freq")

p3 <- ggplot(cm_table, aes(x = Reference, y = Prediction, fill = Freq)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Freq), size = 6, color = "black") +
  scale_fill_gradient(low = "#a1c4fd", high = "#004080") +
  labs(title = "Confusion Matrix - Random Forest", x = "Actual", y = "Predicted") +
  theme_minimal() +
  theme(plot.title = element_text(size = 15, face = "bold", hjust = 0.5))

# 🧩 Step 8: Combine All 3 Plots
grid.arrange(p1, p2, p3, ncol = 2)

# ✅ Step 9: Predict for New Customer
new_customer <- data.frame(
  Gender = factor("Male", levels = levels(data$Gender)),
  Marital_Status = factor("Married", levels = levels(data$Marital_Status)),
  Income = 55000,
  Children = 2,
  Education = factor("Bachelors", levels = levels(data$Education)),
  Occupation = factor("Professional", levels = levels(data$Occupation)),
  Home_Owner = factor("Yes", levels = levels(data$Home_Owner)),
  Cars = 1,
  Commute_Distance = factor("5-10 Miles", levels = levels(data$Commute_Distance)),
  Region = factor("Europe", levels = levels(data$Region)),
  Age = 35,
  ID = 99999
)

cat("\n🧾 Prediction for New Customer:\n")
print(predict(rf_model, new_customer))
