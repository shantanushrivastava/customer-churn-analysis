-- ============================================================
-- Customer Churn Analysis - SQL ETL Pipeline
-- Database : MySQL 8.0
-- Flow     : CSV -> stg_churn (Python import) -> prod_churn -> Views -> Power BI
--
-- HOW TO RUN (in this order):
--   1. Run Section 1 (creates database and empty staging table)
--   2. Run notebooks/churn_data_import.ipynb ONCE (loads 6,418 rows into stg_churn)
--   3. Run Sections 2, 3, 4 and 5
-- This script is safe to re-run: it never drops stg_churn,
-- so the imported data is not lost.
-- ============================================================


-- ============================================================
-- SECTION 1: Database and staging table
-- ============================================================
CREATE DATABASE IF NOT EXISTS db_Churn;
USE db_Churn;

CREATE TABLE IF NOT EXISTS stg_churn (
  Customer_ID TEXT,
  Gender TEXT,
  Age INT,
  Married TEXT,
  State TEXT,
  Number_of_Referrals INT,
  Tenure_in_Months INT,
  Value_Deal TEXT,
  Phone_Service TEXT,
  Multiple_Lines TEXT,
  Internet_Service TEXT,
  Internet_Type TEXT,
  Online_Security TEXT,
  Online_Backup TEXT,
  Device_Protection_Plan TEXT,
  Premium_Support TEXT,
  Streaming_TV TEXT,
  Streaming_Movies TEXT,
  Streaming_Music TEXT,
  Unlimited_Data TEXT,
  Contract TEXT,
  Paperless_Billing TEXT,
  Payment_Method TEXT,
  Monthly_Charge DOUBLE,
  Total_Charges DOUBLE,
  Total_Refunds DOUBLE,
  Total_Extra_Data_Charges INT,
  Total_Long_Distance_Charges DOUBLE,
  Total_Revenue DOUBLE,
  Customer_Status TEXT,
  Churn_Category TEXT,
  Churn_Reason TEXT
);

-- Sanity check after the Python import: must return 6418
SELECT COUNT(*) FROM stg_churn;


-- ============================================================
-- SECTION 2: Data Exploration - Distinct values
-- Purpose: Understand distribution of key columns
-- ============================================================

-- 1. Gender Distribution
SELECT Gender, COUNT(Gender) as TotalCount,
COUNT(Gender) * 1.0 / (SELECT COUNT(*) FROM stg_churn) as Percentage
FROM stg_churn
GROUP BY Gender;

-- 2. Contract Type Distribution
SELECT Contract, COUNT(Contract) as TotalCount,
COUNT(Contract) * 1.0 / (SELECT COUNT(*) FROM stg_churn) as Percentage
FROM stg_churn
GROUP BY Contract;

-- 3. Customer Status & Revenue Breakdown
SELECT Customer_Status, COUNT(Customer_Status) as TotalCount,
SUM(Total_Revenue) as TotalRev,
SUM(Total_Revenue) / (SELECT SUM(Total_Revenue) FROM stg_churn) * 100 as RevPercentage
FROM stg_churn
GROUP BY Customer_Status;

-- 4. State-wise Customer Distribution
SELECT State, COUNT(State) as TotalCount,
COUNT(State) * 1.0 / (SELECT COUNT(*) FROM stg_churn) as Percentage
FROM stg_churn
GROUP BY State
ORDER BY Percentage DESC;

-- 5. Distinct Internet Types Available
SELECT DISTINCT Internet_Type
FROM stg_churn;


-- ============================================================
-- SECTION 3: Data Quality Checks
-- Purpose: Identify duplicates, missing and invalid data
-- ============================================================

-- 3a. Duplicate check: total_rows must equal unique_customers (6418 = 6418)
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT Customer_ID) AS unique_customers
FROM stg_churn;

-- 3b. Invalid values: negative monthly charges (known issue in source data)
SELECT COUNT(*) AS negative_monthly_charge_rows
FROM stg_churn
WHERE Monthly_Charge < 0;

-- 3c. Null values in each column (before cleaning)
SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM stg_churn;


-- ============================================================
-- SECTION 4: Data Cleaning - Create production table
-- Purpose: Replace NULL values with defaults
-- ============================================================
DROP VIEW IF EXISTS vw_ChurnData;
DROP VIEW IF EXISTS vw_JoinData;
DROP TABLE IF EXISTS prod_churn;

CREATE TABLE prod_churn AS
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    COALESCE(Value_Deal, 'None') AS Value_Deal,
    Phone_Service,
    COALESCE(Multiple_Lines, 'No') AS Multiple_Lines,
    Internet_Service,
    COALESCE(Internet_Type, 'None') AS Internet_Type,
    COALESCE(Online_Security, 'No') AS Online_Security,
    COALESCE(Online_Backup, 'No') AS Online_Backup,
    COALESCE(Device_Protection_Plan, 'No') AS Device_Protection_Plan,
    COALESCE(Premium_Support, 'No') AS Premium_Support,
    COALESCE(Streaming_TV, 'No') AS Streaming_TV,
    COALESCE(Streaming_Movies, 'No') AS Streaming_Movies,
    COALESCE(Streaming_Music, 'No') AS Streaming_Music,
    COALESCE(Unlimited_Data, 'No') AS Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    COALESCE(Churn_Category, 'Others') AS Churn_Category,
    COALESCE(Churn_Reason, 'Others') AS Churn_Reason
FROM stg_churn;


-- ============================================================
-- SECTION 5: Views for Power BI and the ML model
-- Purpose: Separate churned/stayed customers and new joiners
-- ============================================================

-- View 1: Churned and Stayed customers (training data)
CREATE VIEW vw_ChurnData AS
    SELECT * FROM prod_churn 
    WHERE Customer_Status IN ('Churned', 'Stayed');

-- View 2: Newly joined customers (prediction data)
CREATE VIEW vw_JoinData AS
    SELECT * FROM prod_churn 
    WHERE Customer_Status = 'Joined';

-- Final validation: expected Stayed 4275, Churned 1732, Joined 411
SELECT Customer_Status, COUNT(*) AS TotalCount
FROM prod_churn
GROUP BY Customer_Status;
