\* =========================================================
   Project: Customer Churn Reduction – Telecom
   Purpose: Identify churn drivers and high-risk segments
   ========================================================= */

/* -------------------------------
   1. Overall churn and revenue impact
-------------------------------- */

SELECT
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    SUM(CASE WHEN churn='Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2
  ) AS churn_rate_pct,
  SUM(CASE WHEN churn='Yes' THEN MonthlyCharges ELSE 0 END) AS revenue_at_risk
FROM telco_customers;

/* -------------------------------
   2. churn by contract type 
-------------------------------- */

SELECT
  Contract,
  COUNT(*) AS customers,
  ROUND(AVG(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)*100,2) AS churn_rate
FROM telco_customers
GROUP BY Contract;

/* -------------------------------
   3. Early life churn detection
-------------------------------- */
SELECT
  CASE
    WHEN tenure < 6 THEN '0–6 months'
    WHEN tenure < 12 THEN '6–12 months'
    ELSE '12+ months'
  END AS tenure_band,
  ROUND(AVG(CASE WHEN churn='Yes' THEN 1 ELSE 0 END)*100,2) AS churn_rate
FROM telco_customers
GROUP BY tenure_band;






