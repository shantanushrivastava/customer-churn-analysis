# Customer Churn Analysis

An end-to-end data analytics project focused on understanding customer churn, identifying key retention patterns, and predicting customers who are likely to leave.

The project combines **MySQL, Python, Machine Learning, and Power BI** to transform raw customer data into actionable business insights through data preparation, exploratory analysis, interactive dashboards, and churn prediction.

## Dashboard Preview

### 1. Customer Churn Analysis

![Customer Churn Summary Dashboard](assets/summary_dashboard.png)

The summary dashboard explores customer distribution, churn rate, service usage, contract types, payment methods, and customer segments associated with churn.

### 2. Customer Churn Prediction

![Customer Churn Prediction Dashboard](assets/prediction_dashboard.png)

The prediction dashboard presents customer-level churn predictions generated using a Random Forest classification model, helping identify customers who may require retention-focused attention.

## Project Overview

Customer churn is a key business metric for subscription-based companies. Understanding why customers leave can help businesses identify at-risk segments and improve customer retention strategies.

This project analyzes customer data to answer questions such as:

- What proportion of customers have churned?
- Which contract types and services are associated with higher churn?
- How do customer tenure and payment methods relate to churn?
- Which customer segments may require greater retention attention?
- Can a machine learning model identify customers who may be likely to churn?

## Key Findings

- **6,418 customers** analyzed in the dataset.
- **Approximately 27% churn rate** observed in the analyzed customer data.
- Month-to-month customers show a substantially higher churn rate than customers on longer-term contracts.
- Fiber Optic customers represent a segment worth examining for churn-related patterns.
- A Random Forest classification model generates customer-level churn predictions for further analysis in Power BI.

*These findings describe patterns in the available dataset and should not be interpreted as proof of causation.*

## Tech Stack

| Tool | Purpose |
|---|---|
| MySQL | Data exploration, querying, transformation, and analysis |
| Python | Data cleaning, exploratory analysis, feature preparation, and prediction |
| Pandas & NumPy | Data manipulation and preprocessing |
| Matplotlib & Seaborn | Exploratory data visualization |
| Scikit-learn | Machine learning and model evaluation |
| Power BI | Interactive dashboards and business insights |
| Jupyter Notebook | Analysis workflow and model development |
| Git & GitHub | Version control and project documentation |

## Project Workflow

1. **Data preparation:** Inspect and prepare the customer dataset for analysis.
2. **SQL analysis:** Query customer data, create analytical views, and investigate churn patterns.
3. **Exploratory data analysis:** Use Python to examine customer characteristics and relationships with churn.
4. **Feature preparation:** Encode categorical variables and prepare the data for machine learning.
5. **Churn prediction:** Train a Random Forest classifier and generate customer-level predictions.
6. **Dashboard development:** Present summary insights and prediction results in Power BI.
7. **Business interpretation:** Identify customer segments that may benefit from further retention analysis.

## Repository Structure

```text
customer-churn-analysis/
│
├── assets/
│   ├── summary_dashboard.png
│   └── prediction_dashboard.png
│
├── data/
│   ├── Customer_Churn_Data.csv
│   └── Predictions.csv
│
├── notebooks/
│   └── Jupyter notebooks for analysis and prediction
│
├── powerbi/
│   └── Power BI dashboard files
│
├── sql/
│   └── SQL scripts for data analysis
│
└── README.md
```

*The structure above describes the main project components. Keep the actual notebook, SQL script, and Power BI filenames consistent with the files in the repository.*

## Dataset

The project uses customer-level data containing demographic details, account information, subscribed services, billing information, and churn status.

- **`Customer_Churn_Data.csv`** — Customer dataset used for data analysis and model development.
- **`Predictions.csv`** — Customer-level churn prediction results used to support the Power BI prediction dashboard.

The dataset contains **6,418 records and 32 columns** in the version analyzed for this project.

## SQL Analysis

MySQL is used to explore and prepare the data for analysis.

Key activities include:

- Inspecting customer records and data quality.
- Analyzing churn across contract types, services, and customer segments.
- Creating analytical tables and views for downstream analysis.
- Writing queries to identify patterns relevant to customer retention.

The SQL workflow includes objects such as `stg_churn`, `prod_churn`, `vw_ChurnData`, and `vw_JoinData`, where applicable in the supplied SQL scripts.

## Python & Machine Learning

Python is used for exploratory data analysis, preprocessing, and churn prediction.

### Analysis and preprocessing

- Data inspection and preparation using Pandas and NumPy.
- Exploratory analysis and visualization.
- Encoding categorical variables using `LabelEncoder` where appropriate.
- Preparing features and the target variable for model training.

### Model development

A **Random Forest Classifier** is used to classify customers according to their churn status.

The workflow includes:

- Splitting the data into training and testing sets.
- Training the classification model.
- Generating customer-level predictions.
- Exporting prediction results to `Predictions.csv` for dashboard analysis.

The project demonstrates a practical classification workflow. Model performance should be assessed using appropriate metrics such as precision, recall, F1-score, and confusion matrix results rather than predictions alone.

## Power BI Dashboards

### Customer Churn Summary

The summary dashboard presents an overview of customer churn and enables exploration of churn patterns across relevant customer and service categories.

### Customer Churn Prediction

The prediction dashboard uses the exported prediction results to explore customers identified as potential churn risks.

Together, the dashboards connect analytical findings with a business-focused view of customer retention.

## How to Run the Project

### Prerequisites

Install or set up the following:

- MySQL Server and MySQL Workbench
- Python 3
- Jupyter Notebook
- Power BI Desktop

### 1. Clone the repository

```bash
git clone https://github.com/shantanushrivastava/customer-churn-analysis.git
cd customer-churn-analysis
```

### 2. Set up Python

Create and activate a virtual environment if desired:

```bash
python -m venv .venv
```

On Windows:

```bash
.venv\Scripts\activate
```

Install the required libraries:

```bash
pip install pandas numpy matplotlib seaborn scikit-learn jupyter
```

### 3. Run the SQL analysis

1. Start MySQL Server and open MySQL Workbench.
2. Create or select the database required by the SQL scripts.
3. Import or load the customer dataset as required by the project.
4. Execute the SQL scripts in the `sql/` directory in the appropriate order.

Update database connection settings locally before running any notebook that connects to MySQL.

### 4. Run the Python notebooks

Launch Jupyter Notebook:

```bash
jupyter notebook
```

Open the relevant notebooks in `notebooks/` and execute the cells in sequence. Ensure the dataset paths and database connection settings match your local environment.

### 5. Open the Power BI dashboards

Open the Power BI project file in `powerbi/` using Power BI Desktop. If prompted, update the data source paths to match your local setup.

## Business Value

This project demonstrates how SQL, Python, machine learning, and business intelligence can be combined to support customer retention analysis.

Potential business applications include:

- Identifying customer segments with elevated churn rates.
- Understanding relationships between customer characteristics and churn.
- Prioritizing customers for further investigation and retention campaigns.
- Presenting analytical findings through interactive dashboards.
- Supporting data-informed customer retention decisions.

Model predictions should be validated before being used to make operational or customer-level decisions.

## Skills Demonstrated

`SQL` · `Python` · `MySQL` · `Pandas` · `NumPy` · `Exploratory Data Analysis` · `Data Cleaning` · `Feature Engineering` · `Scikit-learn` · `Random Forest` · `Power BI` · `Data Visualization` · `Business Intelligence`

## Author

**Shantanu Shrivastava**

B.Tech — Computer Science Engineering (Artificial Intelligence & Data Science)

- GitHub: [shantanushrivastava](https://github.com/shantanushrivastava)
- Project Repository: [Customer Churn Analysis](https://github.com/shantanushrivastava/customer-churn-analysis)

---

*This project was developed for hands-on learning and portfolio demonstration in data analytics and machine learning.*
