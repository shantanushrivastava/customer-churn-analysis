# Customer Churn Analysis

An end-to-end telecom customer churn analytics project built using **MySQL, Python, Power BI, and Machine Learning**. The project explores historical churn patterns and uses a Random Forest classifier to identify newly joined customers who may be at risk of churning.

## Project Overview

This project combines data loading, SQL-based ETL, data quality checks, machine learning, and interactive Power BI dashboards to analyze customer churn and identify potential churn risks.

- Load raw telecom customer data into MySQL.
- Perform data quality checks and SQL-based data transformation.
- Create views for historical customers and newly joined customers.
- Train a Random Forest model using customers whose status is Stayed or Churned.
- Generate churn predictions for newly joined customers.
- Visualize churn patterns and predicted customer risk in Power BI.

## Dashboard Preview

### 1. Churn Analysis — Summary

![Customer Churn Summary Dashboard](assets/summary_dashboard.png)

The Summary dashboard provides an overview of customer churn through key metrics and visualizations, including customer demographics, age groups, tenure, contract types, internet services, churn categories, and service usage. Interactive filters allow users to explore the data across different customer segments.

### 2. Churn Analysis — Prediction

![Customer Churn Prediction Dashboard](assets/prediction_dashboard.png)

The Prediction dashboard highlights customers identified as potential churn risks. It includes customer profile breakdowns, distributions across different customer attributes, and a detailed table of predicted churners with their Customer IDs.

The screenshots above are available in the `assets/` folder. The interactive Power BI report is available in `powerbi/`.

## Tools and Technologies

| Category | Tools |
|---|---|
| Database | MySQL 8.0 |
| Programming | Python, SQL, DAX |
| Data Analysis | pandas, NumPy |
| Machine Learning | scikit-learn, Random Forest Classifier |
| Visualization | Power BI Desktop, Matplotlib, Seaborn |
| Database Connectivity | mysql-connector-python |
| Model Persistence | joblib |

## Dataset

- **Records:** 6,418 customers
- **Features:** 32 columns covering customer demographics, services, contract and payment details, charges, and churn information
- **Source:** Telecom Customer Churn Dataset
- **File:** `data/Customer_Churn_Data.csv`

## Project Structure

```text
customer-churn-analysis/
├── assets/
│   ├── summary_dashboard.png
│   └── prediction_dashboard.png
├── data/
│   └── Customer_Churn_Data.csv
├── notebooks/
│   ├── churn_data_import.ipynb
│   └── churn_ml_model.ipynb
├── powerbi/
│   └── Customer_Churn_Analysis.pbix
├── sql/
│   └── churn_etl_queries.sql
└── README.md
```

## Data Pipeline

```text
Raw Customer Data (CSV)
          ↓
Python Data Import
          ↓
MySQL Staging Table (stg_churn)
          ↓
SQL Data Cleaning and ETL
          ↓
Production Table (prod_churn)
          ↓
SQL Views (vw_ChurnData, vw_JoinData)
          ↓
Random Forest Model
          ↓
Predicted Churners (CSV)
          ↓
Power BI Dashboard
```

## SQL ETL Pipeline

The SQL script `sql/churn_etl_queries.sql` handles database setup, data quality checks, transformation, and view creation.

- **Staging table:** Raw customer data is loaded into `stg_churn` using Python.
- **Data cleaning:** Selected missing service values are replaced with `No`, `Value_Deal` and `Internet_Type` values with `None`, and missing churn category or reason values with `Others`.
- **Production table:** Cleaned data is stored in `prod_churn`.
- **`vw_ChurnData`:** Provides historical customers whose status is Stayed or Churned for analysis and model training.
- **`vw_JoinData`:** Provides newly joined customers as input for churn prediction.

## Machine Learning Model

**Algorithm:** Random Forest Classifier

The notebook `notebooks/churn_ml_model.ipynb` performs the following steps:

1. Retrieves historical customer data from `vw_ChurnData`.
2. Preprocesses the data and removes selected identifiers and fields that could cause target leakage.
3. Encodes categorical variables using `LabelEncoder`.
4. Encodes the target variable as Stayed = 0 and Churned = 1.
5. Splits the data into training and testing sets using an 80/20 split.
6. Trains a Random Forest classifier and evaluates its performance using a confusion matrix and classification report.
7. Generates predictions for newly joined customers from `vw_JoinData`.
8. Exports predicted churners to a CSV file for use in Power BI.

The model's evaluation metrics can be obtained by running the notebook. Predictions indicate potential churn risk and should not be interpreted as guaranteed customer outcomes.

## Key Insights

The current dashboard highlights the following patterns:

- **Overall churn rate:** 27%
- **Month-to-Month contracts:** Approximately 77.16% churn rate
- **Fiber Optic customers:** 41% churn rate
- **Competitor:** The largest displayed churn category, with 761 customers
- **Predicted churners:** 129 customers displayed on the Prediction dashboard

These figures reflect the dashboard screenshots included in this repository and may change when the data or report is refreshed.

## How to Run

### 1. MySQL Setup

1. Open `sql/churn_etl_queries.sql` in MySQL Workbench.
2. Run Section 1 to create the database and staging table.
3. Configure your local MySQL connection details in the data-import notebook.
4. Run `notebooks/churn_data_import.ipynb` to load `data/Customer_Churn_Data.csv` into the staging table.
5. Run the remaining SQL sections to perform data quality checks, populate the production table, and create the views.

### 2. Install Python Dependencies

```bash
pip install pandas numpy mysql-connector-python scikit-learn matplotlib seaborn joblib
```

Run the notebooks using Jupyter Notebook or JupyterLab from the project directory.

### 3. Generate Predictions

Run `notebooks/churn_ml_model.ipynb` after the required SQL views have been created. Configure the local MySQL connection and prediction output path as needed. The generated predictions CSV can then be used as a data source for the Power BI Prediction dashboard.

### 4. Open Power BI

Open `powerbi/Customer_Churn_Analysis.pbix` in Power BI Desktop. Update the MySQL connection credentials and data source settings for your local environment, then refresh the report if required.

**Note:** Use your own local database credentials. Never commit passwords, tokens, or other secrets to a public GitHub repository.

## Author

**Shantanu Shrivastava**  
B.Tech CSE (AI/DS) | AKS University, Satna

[LinkedIn](https://www.linkedin.com/in/shantanushrivastava/) · [GitHub](https://github.com/shantanushrivastava)
