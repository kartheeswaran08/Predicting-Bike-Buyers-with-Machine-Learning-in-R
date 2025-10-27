# 🚴 Bike Purchase Prediction Using Machine Learning in R

## 📌 Project Overview
This project aims to **predict which customers are likely to buy a bike** using machine learning algorithms in **R programming**.  
The dataset includes customer demographics, income, commute distance, and lifestyle details.  
By analyzing these features, the model helps businesses **target potential buyers more effectively**.

---

## 🎯 Objective
To build a **data-driven prediction model** that classifies customers based on their likelihood to purchase a bike.

---

## 🧠 Machine Learning Algorithms Used
1. **Logistic Regression** – For binary classification (Yes/No purchase).  
2. **Random Forest** – For accurate, feature-based decision making.  
3. **Naive Bayes** – For probabilistic customer prediction.

---

## 📊 Dataset Information
**File:** `bike_buyers.csv`  
**Total Records:** 1000  
**Key Features:**
- Marital.Status  
- Gender  
- Income  
- Education  
- Occupation  
- Home.Owner  
- Cars  
- Commute.Distance  
- Region  
- Age  
- Purchased.Bike (Target)

---

## ⚙️ Steps Performed
1. **Data Loading & Cleaning**
   - Removed duplicates and missing values.
2. **Data Transformation**
   - Converted categorical variables to factors.
3. **Model Training**
   - Trained Logistic Regression, Random Forest, and Naive Bayes models.
4. **Model Evaluation**
   - Compared accuracy and confusion matrices.
5. **Visualization**
   - Created plots for feature importance, age vs. income, and commute patterns.

---

## 📈 Visualizations
- **Feature Importance (Random Forest)**
- **Age vs. Income (by Purchase Status)**
- **Commute Distance vs. Bike Purchase**

---

## 🏁 Results
- Random Forest achieved the **highest prediction accuracy**.  
- Income, Age, and Commute Distance were the most influential factors in predicting bike purchases.

---

## 💻 Technologies Used
- **Language:** R  
- **Libraries:** `caret`, `randomForest`, `e1071`, `ggplot2`, `dplyr`, `readr`  
- **IDE:** RStudio  

---
