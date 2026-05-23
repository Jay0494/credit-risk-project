CREATE DATABASE credit_analytics;
USE credit_analytics;


CREATE TABLE staging_loan AS
SELECT
    TRIM(application_id) AS application_id,
    TRIM(customer_id) AS customer_id,
    CAST(age AS UNSIGNED) AS age,
    TRIM(employment_status) AS employment_status,
    TRIM(region_uk) AS region_uk,
    CAST(annual_income AS DECIMAL(18,2)) AS annual_income,
    CAST(monthly_income AS DECIMAL(18,2)) AS monthly_income,
    CAST(monthly_expenses AS DECIMAL(18,2)) AS monthly_expenses,
    CAST(existing_debt AS DECIMAL(18,2)) AS existing_debt,
    CAST(debt_to_income_ratio AS DECIMAL(10,4)) AS debt_to_income_ratio,
    CAST(credit_score AS UNSIGNED) AS credit_score,
    CAST(credit_utilisation AS DECIMAL(10,4)) AS credit_utilisation,
    CAST(recent_hard_searches AS UNSIGNED) AS recent_hard_searches,
    CAST(customer_tenure_months AS UNSIGNED) AS customer_tenure_months,
    CAST(affordability_score AS DECIMAL(10,4)) AS affordability_score,
    CAST(fraud_risk_score AS DECIMAL(10,4)) AS fraud_risk_score,
    TRIM(application_channel) AS application_channel,
    TRIM(loan_purpose) AS loan_purpose,
    CAST(requested_loan_amount AS DECIMAL(18,2)) AS requested_loan_amount,
    CAST(approved_loan_amount AS DECIMAL(18,2)) AS approved_loan_amount,
    TRIM(approval_decision) AS approval_decision,
    CAST(term_months AS UNSIGNED) AS term_months,
    CAST(apr AS DECIMAL(10,4)) AS apr,
    TRIM(risk_band) AS risk_band,
    application_date,
    origination_date,
    maturity_date,
    CAST(probability_of_default AS DECIMAL(10,6)) AS probability_of_default,
    CAST(lgd AS DECIMAL(10,6)) AS lgd,
    CAST(ead AS DECIMAL(18,2)) AS ead,
    CAST(expected_loss AS DECIMAL(18,2)) AS expected_loss,
    CAST(default_flag AS UNSIGNED) AS default_flag,
    CAST(days_past_due AS UNSIGNED) AS days_past_due,
    TRIM(delinquency_bucket) AS delinquency_bucket,
    CAST(missed_payments AS UNSIGNED) AS missed_payments,
    TRIM(loan_status) AS loan_status,
    CAST(interest_income AS DECIMAL(18,2)) AS interest_income,
    CAST(cost_of_funds AS DECIMAL(18,2)) AS cost_of_funds,
    CAST(provision_cost AS DECIMAL(18,2)) AS provision_cost,
    CAST(net_revenue AS DECIMAL(18,2)) AS net_revenue,
    CAST(npv AS DECIMAL(18,2)) AS npv,
    CAST(risk_adjusted_return AS DECIMAL(18,4)) AS risk_adjusted_return
FROM enhanced_unsecured_lending_dataset_v2_clean_dates;


SELECT * FROM staging_loan;


SELECT 'Total Records' AS check_name, COUNT(*) AS issue_count
FROM staging_loan

UNION ALL

SELECT 'Duplicate Application IDs', COUNT(*)
FROM (
    SELECT application_id
    FROM staging_loan
    GROUP BY application_id
    HAVING COUNT(*) > 1
) dup

UNION ALL

SELECT 'Duplicate Customer IDs', COUNT(*)
FROM (
    SELECT customer_id
    FROM staging_loan
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) dup

UNION ALL

SELECT 'Missing Application ID', COUNT(*)
FROM staging_loan
WHERE application_id IS NULL OR application_id = ''

UNION ALL

SELECT 'Missing Customer ID', COUNT(*)
FROM staging_loan
WHERE customer_id IS NULL OR customer_id = ''

UNION ALL

SELECT 'Invalid Age', COUNT(*)
FROM staging_loan
WHERE age < 18 OR age > 100

UNION ALL

SELECT 'Negative Annual Income', COUNT(*)
FROM staging_loan
WHERE annual_income < 0

UNION ALL

SELECT 'Negative Monthly Income', COUNT(*)
FROM staging_loan
WHERE monthly_income < 0

UNION ALL

SELECT 'Negative Monthly Expenses', COUNT(*)
FROM staging_loan
WHERE monthly_expenses < 0

UNION ALL

SELECT 'Negative Existing Debt', COUNT(*)
FROM staging_loan
WHERE existing_debt < 0

UNION ALL

SELECT 'Invalid Debt-to-Income Ratio', COUNT(*)
FROM staging_loan
WHERE debt_to_income_ratio < 0 OR debt_to_income_ratio > 1

UNION ALL

SELECT 'Invalid Credit Score', COUNT(*)
FROM staging_loan
WHERE credit_score < 300 OR credit_score > 850

UNION ALL

SELECT 'Invalid Credit Utilisation', COUNT(*)
FROM staging_loan
WHERE credit_utilisation < 0 OR credit_utilisation > 1

UNION ALL

SELECT 'Negative Hard Searches', COUNT(*)
FROM staging_loan
WHERE recent_hard_searches < 0

UNION ALL

SELECT 'Negative Customer Tenure', COUNT(*)
FROM staging_loan
WHERE customer_tenure_months < 0

UNION ALL

SELECT 'Invalid Affordability Score', COUNT(*)
FROM staging_loan
WHERE affordability_score < 0 OR affordability_score > 1

UNION ALL

SELECT 'Invalid Fraud Risk Score', COUNT(*)
FROM staging_loan
WHERE fraud_risk_score < 0 OR fraud_risk_score > 1

UNION ALL

SELECT 'Approved Amount Greater Than Requested', COUNT(*)
FROM staging_loan
WHERE approved_loan_amount > requested_loan_amount

UNION ALL

SELECT 'Invalid APR', COUNT(*)
FROM staging_loan
WHERE apr < 0

UNION ALL

SELECT 'Missing Application Date', COUNT(*)
FROM staging_loan
WHERE application_date IS NULL

UNION ALL

SELECT 'Missing Origination Date', COUNT(*)
FROM staging_loan
WHERE origination_date IS NULL

UNION ALL

SELECT 'Missing Maturity Date', COUNT(*)
FROM staging_loan
WHERE maturity_date IS NULL

UNION ALL

SELECT 'Origination Before Application Date', COUNT(*)
FROM staging_loan
WHERE origination_date < application_date

UNION ALL

SELECT 'Maturity Before Origination', COUNT(*)
FROM staging_loan
WHERE maturity_date < origination_date

UNION ALL

SELECT 'Invalid Probability of Default', COUNT(*)
FROM staging_loan
WHERE probability_of_default < 0 OR probability_of_default > 1

UNION ALL

SELECT 'Invalid LGD', COUNT(*)
FROM staging_loan
WHERE lgd < 0 OR lgd > 1

UNION ALL

SELECT 'Negative EAD', COUNT(*)
FROM staging_loan
WHERE ead < 0

UNION ALL

SELECT 'Expected Loss Mismatch', COUNT(*)
FROM staging_loan
WHERE ROUND(expected_loss,2) <> ROUND(probability_of_default * lgd * ead,2)

UNION ALL

SELECT 'Invalid Default Flag', COUNT(*)
FROM staging_loan
WHERE default_flag NOT IN (0,1)

UNION ALL

SELECT 'Negative Days Past Due', COUNT(*)
FROM staging_loan
WHERE days_past_due < 0

UNION ALL

SELECT 'Negative Missed Payments', COUNT(*)
FROM staging_loan
WHERE missed_payments < 0

UNION ALL

SELECT 'Negative Interest Income', COUNT(*)
FROM staging_loan
WHERE interest_income < 0

UNION ALL

SELECT 'Negative Cost of Funds', COUNT(*)
FROM staging_loan
WHERE cost_of_funds < 0

UNION ALL

SELECT 'Negative Provision Cost', COUNT(*)
FROM staging_loan
WHERE provision_cost < 0

UNION ALL

SELECT 'Net Revenue Mismatch', COUNT(*)
FROM staging_loan
WHERE ROUND(net_revenue,2) <>
      ROUND(interest_income - cost_of_funds - provision_cost, 2);


/*Transform the staging loan dataset into a clean analytical layer by resolving issues identified
during data quality assessment. Corrections include normalising out-of-range risk metrics,
fixing invalid application lifecycle dates, and recalculating derived financial measures such as
expected loss and net revenue to align with business rules.
This clean table serves as the trusted source for credit risk analysis and dashboard reporting.*/

CREATE TABLE clean_loan_data AS
SELECT
    application_id,
    customer_id,
    age,
    employment_status,
    region_uk,
    annual_income,
    monthly_income,
    monthly_expenses,
    existing_debt,

    /* Fix invalid debt-to-income ratio */
    CASE
        WHEN debt_to_income_ratio < 0 THEN 0
        WHEN debt_to_income_ratio > 1 THEN 1
        ELSE debt_to_income_ratio
    END AS debt_to_income_ratio,

    credit_score,

    /* Fix invalid credit utilisation */
    CASE
        WHEN credit_utilisation < 0 THEN 0
        WHEN credit_utilisation > 1 THEN 1
        ELSE credit_utilisation
    END AS credit_utilisation,

    recent_hard_searches,
    customer_tenure_months,

    /* Fix invalid affordability score */
    CASE
        WHEN affordability_score < 0 THEN 0
        WHEN affordability_score > 1 THEN 1
        ELSE affordability_score
    END AS affordability_score,

    /* Fix invalid fraud risk score */
    CASE
        WHEN fraud_risk_score < 0 THEN 0
        WHEN fraud_risk_score > 1 THEN 1
        ELSE fraud_risk_score
    END AS fraud_risk_score,

    application_channel,
    loan_purpose,
    requested_loan_amount,
    approved_loan_amount,
    approval_decision,
    term_months,
    apr,
    risk_band,
    application_date,

    /* Fix origination date */
    CASE
        WHEN origination_date < application_date
        THEN application_date
        ELSE origination_date
    END AS origination_date,

    /* Fix maturity date using corrected origination logic */
    CASE
        WHEN maturity_date <
            CASE
                WHEN origination_date < application_date
                THEN application_date
                ELSE origination_date
            END
        THEN DATE_ADD(
            CASE
                WHEN origination_date < application_date
                THEN application_date
                ELSE origination_date
            END,
            INTERVAL term_months MONTH
        )
        ELSE maturity_date
    END AS maturity_date,

    probability_of_default,
    lgd,
    ead,

    /* Fix expected loss */
    ROUND(probability_of_default * lgd * ead, 2) AS expected_loss,

    default_flag,
    days_past_due,
    delinquency_bucket,
    missed_payments,
    loan_status,

    interest_income,
    cost_of_funds,
    provision_cost,

    /* Fix net revenue */
    ROUND(interest_income - cost_of_funds - provision_cost, 2) AS net_revenue,

    npv,
    risk_adjusted_return

FROM staging_loan;




SELECT 'Total Records' AS check_name, COUNT(*) AS issue_count
FROM clean_loan_data

UNION ALL

SELECT 'Duplicate Application IDs', COUNT(*)
FROM (
    SELECT application_id
    FROM clean_loan_data
    GROUP BY application_id
    HAVING COUNT(*) > 1
) dup

UNION ALL

SELECT 'Duplicate Customer IDs', COUNT(*)
FROM (
    SELECT customer_id
    FROM clean_loan_data
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) dup

UNION ALL

SELECT 'Missing Application ID', COUNT(*)
FROM clean_loan_data
WHERE application_id IS NULL OR application_id = ''

UNION ALL

SELECT 'Missing Customer ID', COUNT(*)
FROM clean_loan_data
WHERE customer_id IS NULL OR customer_id = ''

UNION ALL

SELECT 'Invalid Age', COUNT(*)
FROM clean_loan_data
WHERE age < 18 OR age > 100

UNION ALL

SELECT 'Negative Annual Income', COUNT(*)
FROM clean_loan_data
WHERE annual_income < 0

UNION ALL

SELECT 'Negative Monthly Income', COUNT(*)
FROM clean_loan_data
WHERE monthly_income < 0

UNION ALL

SELECT 'Negative Monthly Expenses', COUNT(*)
FROM clean_loan_data
WHERE monthly_expenses < 0

UNION ALL

SELECT 'Negative Existing Debt', COUNT(*)
FROM clean_loan_data
WHERE existing_debt < 0

UNION ALL

SELECT 'Invalid Debt-to-Income Ratio', COUNT(*)
FROM clean_loan_data
WHERE debt_to_income_ratio < 0 OR debt_to_income_ratio > 1

UNION ALL

SELECT 'Invalid Credit Score', COUNT(*)
FROM clean_loan_data
WHERE credit_score < 300 OR credit_score > 850

UNION ALL

SELECT 'Invalid Credit Utilisation', COUNT(*)
FROM clean_loan_data
WHERE credit_utilisation < 0 OR credit_utilisation > 1

UNION ALL

SELECT 'Negative Hard Searches', COUNT(*)
FROM clean_loan_data
WHERE recent_hard_searches < 0

UNION ALL

SELECT 'Negative Customer Tenure', COUNT(*)
FROM clean_loan_data
WHERE customer_tenure_months < 0

UNION ALL

SELECT 'Invalid Affordability Score', COUNT(*)
FROM clean_loan_data
WHERE affordability_score < 0 OR affordability_score > 1

UNION ALL

SELECT 'Invalid Fraud Risk Score', COUNT(*)
FROM clean_loan_data
WHERE fraud_risk_score < 0 OR fraud_risk_score > 1

UNION ALL

SELECT 'Approved Amount Greater Than Requested', COUNT(*)
FROM clean_loan_data
WHERE approved_loan_amount > requested_loan_amount

UNION ALL

SELECT 'Invalid APR', COUNT(*)
FROM clean_loan_data
WHERE apr < 0

UNION ALL

SELECT 'Missing Application Date', COUNT(*)
FROM clean_loan_data
WHERE application_date IS NULL

UNION ALL

SELECT 'Missing Origination Date', COUNT(*)
FROM clean_loan_data
WHERE origination_date IS NULL

UNION ALL

SELECT 'Missing Maturity Date', COUNT(*)
FROM clean_loan_data
WHERE maturity_date IS NULL

UNION ALL

SELECT 'Origination Before Application Date', COUNT(*)
FROM clean_loan_data
WHERE origination_date < application_date

UNION ALL

SELECT 'Maturity Before Origination', COUNT(*)
FROM clean_loan_data
WHERE maturity_date < origination_date

UNION ALL

SELECT 'Invalid Probability of Default', COUNT(*)
FROM clean_loan_data
WHERE probability_of_default < 0 OR probability_of_default > 1

UNION ALL

SELECT 'Invalid LGD', COUNT(*)
FROM clean_loan_data
WHERE lgd < 0 OR lgd > 1

UNION ALL

SELECT 'Negative EAD', COUNT(*)
FROM clean_loan_data
WHERE ead < 0

UNION ALL

SELECT 'Expected Loss Mismatch', COUNT(*)
FROM clean_loan_data
WHERE ROUND(expected_loss,2) <> ROUND(probability_of_default * lgd * ead,2)

UNION ALL

SELECT 'Invalid Default Flag', COUNT(*)
FROM clean_loan_data
WHERE default_flag NOT IN (0,1)

UNION ALL

SELECT 'Negative Days Past Due', COUNT(*)
FROM clean_loan_data
WHERE days_past_due < 0

UNION ALL

SELECT 'Negative Missed Payments', COUNT(*)
FROM clean_loan_data
WHERE missed_payments < 0

UNION ALL

SELECT 'Negative Interest Income', COUNT(*)
FROM clean_loan_data
WHERE interest_income < 0

UNION ALL

SELECT 'Negative Cost of Funds', COUNT(*)
FROM clean_loan_data
WHERE cost_of_funds < 0

UNION ALL

SELECT 'Negative Provision Cost', COUNT(*)
FROM clean_loan_data
WHERE provision_cost < 0

UNION ALL

SELECT 'Net Revenue Mismatch', COUNT(*)
FROM clean_loan_data
WHERE ROUND(net_revenue,2) <>
      ROUND(interest_income - cost_of_funds - provision_cost, 2);
      
      
      
      
SELECT * FROM clean_loan_data;


-- DATA MODELLING 
CREATE  TABLE dim_employment ( 
		employment_key INT PRIMARY KEY AUTO_INCREMENT,
		employment_status VARCHAR(50)
 );       
 
INSERT INTO dim_employment (
	employment_status)
    SELECT DISTINCT
		employment_status
			FROM clean_loan_data;
            
            
CREATE  TABLE dim_region ( 
		region_key INT PRIMARY KEY AUTO_INCREMENT,
		region_uk VARCHAR(70)
 );       
 
INSERT INTO dim_region (
	region_uk)
    SELECT DISTINCT
		region_uk
			FROM clean_loan_data; 
            
            
CREATE  TABLE dim_channel ( 
		channel_key INT PRIMARY KEY AUTO_INCREMENT,
		application_channel VARCHAR(50)
 );       
 
INSERT INTO dim_channel (
	application_channel)
    SELECT DISTINCT
		application_channel
			FROM clean_loan_data;    
            
CREATE  TABLE dim_loan_reason ( 
		loan_purpose_key INT PRIMARY KEY AUTO_INCREMENT,
		loan_purpose VARCHAR(50)
 );       
 
INSERT INTO dim_loan_reason (
	loan_purpose)
    SELECT DISTINCT
		loan_purpose
			FROM clean_loan_data;        
            
CREATE  TABLE dim_approval ( 
		approval_key INT PRIMARY KEY AUTO_INCREMENT,
		approval_decision VARCHAR(50)
 );       
 
INSERT INTO dim_approval (
	approval_decision)
    SELECT DISTINCT
		approval_decision
			FROM clean_loan_data;    
            
CREATE  TABLE dim_risk ( 
		risk_key INT PRIMARY KEY AUTO_INCREMENT,
		risk_band VARCHAR(50)
 );       
 
INSERT INTO dim_risk (
	risk_band)
    SELECT DISTINCT
		risk_band
			FROM clean_loan_data;
            
CREATE  TABLE dim_delinquency ( 
		delinquency_key INT PRIMARY KEY AUTO_INCREMENT,
		delinquency_bucket VARCHAR(50)
 );       
 
INSERT INTO dim_delinquency (
	delinquency_bucket)
    SELECT DISTINCT
		delinquency_bucket
			FROM clean_loan_data;       
            
            
CREATE  TABLE dim_loan_status ( 
		loan_key INT PRIMARY KEY AUTO_INCREMENT,
		loan_status VARCHAR(50)
 );       
 
INSERT INTO dim_loan_status (
	loan_status)
    SELECT DISTINCT
		loan_status
			FROM clean_loan_data;         
            
            
CREATE TABLE fact_loan_performance (
			loan_fact_key INT PRIMARY KEY AUTO_INCREMENT,
            delinquency_key INT,
            risk_key INT,
            region_key INT,
            loan_key INT,
            loan_purpose_key INT,
            employment_key INT,
            channel_key INT,
            approval_key INT,
            application_id VARCHAR(50),
            customer_id VARCHAR(50),
            age INT,
            annual_income DECIMAL(18,2),
            monthly_income DECIMAL(18,2),
            monthly_expenses DECIMAL(18,2),
            existing_debt DECIMAL(18,2),
            debt_to_income_ratio DECIMAL(18,2),
            credit_score INT,
            credit_utilisation DECIMAL(10,2),
		    recent_hard_searches INT,
            customer_tenure_months INT,
            affordability_score DECIMAL(10,2),
            fraud_risk_score DECIMAL(10,2),
            requested_loan_amount DECIMAL(18,2),
            approved_loan_amount DECIMAL(18,2),
            term_months INT,
            apr DECIMAL(10,2),
            application_date TEXT,
            origination_date TEXT,
            maturity_date TEXT,
            probability_of_default DECIMAL(10,2),
            lgd DECIMAL(10,2),
            ead DECIMAL(10,2),
            expected_loss DECIMAL(10,2),
            default_flag INT,
            days_past_due INT,
            missed_payments INT,
            interest_income DECIMAL(10,2),
            cost_of_funds DECIMAL(10,2),
            provision_cost DECIMAL(10,2),
            net_revenue DECIMAL(10,2),
            npv DECIMAL(10,2),
            risk_adjusted_return DECIMAL(10,2)
);            
            
            
            
INSERT INTO fact_loan_performance (
    delinquency_key,
    risk_key,
    region_key,
    loan_key,
    loan_purpose_key,
    employment_key,
    channel_key,
    approval_key,
    application_id,
    customer_id,
    age,
    annual_income,
    monthly_income,
    monthly_expenses,
    existing_debt,
    debt_to_income_ratio,
    credit_score,
    credit_utilisation,
    recent_hard_searches,
    customer_tenure_months,
    affordability_score,
    fraud_risk_score,
    requested_loan_amount,
    approved_loan_amount,
    term_months,
    apr,
    application_date,
    origination_date,
    maturity_date,
    probability_of_default,
    lgd,
    ead,
    expected_loss,
    default_flag,
    days_past_due,
    missed_payments,
    interest_income,
    cost_of_funds,
    provision_cost,
    net_revenue,
    npv,
    risk_adjusted_return
)

SELECT
    dd.delinquency_key,
    dr.risk_key,
    rg.region_key,
    dls.loan_key,
    dlr.loan_purpose_key,
    de.employment_key,
    dc.channel_key,
    da.approval_key,

    cl.application_id,
    cl.customer_id,
    cl.age,
    cl.annual_income,
    cl.monthly_income,
    cl.monthly_expenses,
    cl.existing_debt,
    cl.debt_to_income_ratio,
    cl.credit_score,
    cl.credit_utilisation,
    cl.recent_hard_searches,
    cl.customer_tenure_months,
    cl.affordability_score,
    cl.fraud_risk_score,
    cl.requested_loan_amount,
    cl.approved_loan_amount,
    cl.term_months,
    cl.apr,
    cl.application_date,
    cl.origination_date,
    cl.maturity_date,
    cl.probability_of_default,
    cl.lgd,
    cl.ead,
    cl.expected_loss,
    cl.default_flag,
    cl.days_past_due,
    cl.missed_payments,
    cl.interest_income,
    cl.cost_of_funds,
    cl.provision_cost,
    cl.net_revenue,
    cl.npv,
    cl.risk_adjusted_return

FROM clean_loan_data cl

INNER JOIN dim_delinquency dd
    ON cl.delinquency_bucket = dd.delinquency_bucket

INNER JOIN dim_risk dr
    ON cl.risk_band = dr.risk_band

INNER JOIN dim_region rg
    ON cl.region_uk = rg.region_uk

INNER JOIN dim_loan_status dls
    ON cl.loan_status = dls.loan_status

INNER JOIN dim_loan_reason dlr
    ON cl.loan_purpose = dlr.loan_purpose

INNER JOIN dim_employment de
    ON cl.employment_status = de.employment_status

INNER JOIN dim_channel dc
    ON cl.application_channel = dc.application_channel

INNER JOIN dim_approval da
    ON cl.approval_decision = da.approval_decision;            
            
      select * from fact_loan_performance;      
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            