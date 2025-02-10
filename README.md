# Deep Learning Approaches for Heart Disease Detection

**By:** Nirmal Dev Aravind  
**Mentor:** Beklaryan Armen Levonovich  
**Faculty:** Computer Science (Компьютерных наук)

---

## Project Overview

This project aims to apply deep learning techniques to predict heart disease using clinical data such as ECG signals, cholesterol levels, heart rate, and glucose levels.
The dataset was obtained from AO CELT https://www.celt.ru/

---

## Table of Contents

1. **[Project Setup](#project-setup)**
2. **[Libraries and Dependencies](#libraries-and-dependencies)**
3. **[Data Collection and Preprocessing](#data-collection-and-preprocessing)**
4. **[Model Development](#model-development)**
5. **[Model Evaluation](#model-evaluation)**
6. **[Results and Discussion](#results-and-discussion)**
7. **[Conclusion and Future Work](#conclusion-and-future-work)**

---

## 1. Project Setup

This section covers the necessary Python libraries that are used for data analysis, text preprocessing, machine learning, and deep learning tasks.

---

## 2. Libraries and Dependencies

The project depends on several libraries, including:
- `deep_translator`
- `googletrans`
- `spacy`
- `huggingface_hub`
- `catboost`

---

## 3.Data Collection and Preprocessing

The dataset used in this project is sourced from the AO CELT Clinic and contains clinical data such as ECG signals, cholesterol, glucose, heart rate, and patient demographics. The dataset has 146,552 entries and 26 features.

---

## 4. Model Development

The following models were developed and trained:

- XGBoost: A powerful gradient boosting algorithm suitable for both categorical and numerical features.
- CatBoost: A gradient boosting model optimized for handling categorical features.

Both models were trained to predict the risk of heart disease, and techniques like SMOTE and class weighting were applied to mitigate class imbalance.

---

## 5. Model Evaluation

Models are evaluated using the following metrics:

- AUC-ROC
- F1-Score
- Classification Report

---
## 6. Results and Discussion

Both XGBoost and CatBoost demonstrated strong performance, achieving high AUC-ROC scores. However, challenges were encountered with the minority class (deceased patients) due to class imbalance.

---
## 7. Conclusion and Future Work

Conclusion:
 - XGBoost and CatBoost are effective models for predicting heart disease risk from clinical data.
Future Work:
 - Implement more advanced deep learning models like LSTM and CNN for better handling of sequential ECG signal data.


---
