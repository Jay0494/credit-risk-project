# Credit Risk Portfolio Performance Analysis

## Project Overview

This project delivers an end-to-end credit risk and lending portfolio analytics solution designed to investigate the drivers of weak profitability within an unsecured lending portfolio.

Despite relatively stable lending demand and improving default performance, the portfolio continued to generate negative financial returns. The objective of this analysis was to identify the structural causes of underperformance and provide strategic, data-driven recommendations to improve risk-adjusted profitability.

The project was developed using **MySQL for data engineering and Power BI for analytical reporting**, covering the full analytics lifecycle from raw data preparation to executive decision-support reporting.

---

## Business Problem

The lending portfolio exhibited an apparent contradiction:

* Borrower default performance improved year-over-year
* Lending activity remained commercially active
* Yet overall portfolio profitability remained negative

This raised critical business questions:

* Why is the lending portfolio underperforming financially despite relatively controlled default behaviour?
* Which borrower segments are driving weak profitability?
* Is the issue caused by credit defaults, provisioning pressure, pricing inefficiency, or exposure concentration?
* What strategic portfolio actions can improve profitability while maintaining responsible lending practices?

---

## Project Objectives

This project aimed to:

* Build a trusted analytics-ready lending dataset
* Assess portfolio performance across risk, profitability, and underwriting dimensions
* Identify the structural drivers of weak lending economics
* Develop executive dashboards for portfolio monitoring and strategic decision support
* Recommend actionable credit risk optimisation strategies

---

## Tools & Technologies

* MySQL
* SQL
* Power BI
* DAX
* Dimensional Data Modelling
* Credit Risk Analytics
* Portfolio Performance Analysis

---

## Methodology

This analysis followed a structured **DMAIC (Define – Measure – Analyze – Improve – Control)** framework.

### Define

Established the business problem around persistent portfolio underperformance despite improving borrower credit performance.

### Measure

#### Data Engineering & Validation

A structured SQL transformation pipeline was developed, including:

* Raw data staging
* Data type standardisation
* SQL data quality auditing using `UNION ALL`
* Business rule validation
* Lifecycle date correction
* Financial metric recalculation

Validation checks included:

* Null completeness checks
* Duplicate application detection
* Debt-to-income ratio validation
* Credit utilisation validation
* Affordability score checks
* Fraud risk score validation
* Expected loss formula validation
* Net revenue calculation validation
* Loan lifecycle date integrity checks

Expected loss formula:

`Expected Loss = PD × LGD × EAD`

Net revenue formula:

`Net Revenue = Interest Income − Funding Cost − Provision Cost`

#### Dimensional Modelling
The cleaned dataset was remodelled into a dimensional star schema for scalable analytics.
<img width="1182" height="1003" alt="MODEL" src="https://github.com/user-attachments/assets/8f253204-30b7-4017-a545-c5709241c39b" />

**Fact Table**

* fact_loan_performance

**Dimension Tables**

* dim_employment
* dim_region
* dim_channel
* dim_loan_reason
* dim_approval
* dim_risk
* dim_delinquency
* dim_loan_status
* dim_date

---

### Analyze

A structured Power BI analytical layer was developed using DAX.

[Interact With Dashboard](https://app.powerbi.com/view?r=eyJrIjoiODJkOWUwNzktZDhjNC00ODlkLTkxNjAtMjA0NjE2ZWMxNWU4IiwidCI6ImIyMTFiMjkwLWFkNzUtNGJlNC1iZDk3LWI5Y2MxZDlmMzdlZCJ9)

#### Core KPIs

* Total Applications
* Approved Loans
* Approval Rate
* Default Rate
* Portfolio Exposure
* Expected Credit Loss
* Net Revenue
* Portfolio NPV
* Interest Income
* Funding Cost
* Provision Cost
* Net Margin
* Provision Burden %
* Cost of Funds Ratio %
* Average Net Revenue per Approved Loan

#### Dashboard 1 — Lending Portfolio Performance Overview

Descriptive analytics focused on:

* Lending demand trends
* Approval performance
* Default behaviour
* Portfolio exposure
* Expected credit loss
* Profitability trends
* Net present value
* Loan purpose profitability
* Exposure by loan tenor

#### Dashboard 2 — Portfolio Risk Diagnostics & Strategic Actions

Diagnostic and prescriptive analytics focused on:

* Profitability breakdown
* Provision burden analysis
* Segment-level unit economics
* Exposure concentration by risk segment
* Strategic risk opportunity matrix
* Management action recommendations

---

## Key Findings

### Portfolio Performance

* Total Applications: **6,314**
* Approved Loans: **4,279**
* Approval Rate: **67.8%**
* Default Rate: **9.7%**
* Portfolio Exposure: **£50.29M**
* Expected Credit Loss: **£9.95M**
* Net Revenue: **-£351K**
* Portfolio NPV: **-£339K**

---

### Key Business Insights

#### 1. Default performance improved, but profitability remained weak

Default rates improved by **3.9% year-over-year**, indicating stronger realised borrower repayment behaviour.

However, the portfolio remained financially unprofitable, suggesting that default deterioration was not the primary issue.

---

#### 2. Expected credit loss remained elevated

Portfolio exposure increased by **1.0% year-over-year**, with expected credit loss increasing at the same rate.

This indicates that overall credit risk exposure remained elevated despite lower realised defaults.

---

#### 3. Provisioning pressure was the primary profitability driver

Portfolio profitability analysis showed:

* Interest Income: **£11.1M**
* Provision Cost: **£10.0M**
* Funding Cost: **£1.5M**
* Provision Burden: **89.6%**
* Net Margin: **-3.2%**

For every £1 earned:

* approximately 90p was consumed by provisioning
* approximately 14p was consumed by funding costs

This created structurally unsustainable lending economics.

---

#### 4. High-risk borrowers were not the profitability problem
<img width="241" height="129" alt="image (4)" src="https://github.com/user-attachments/assets/3526caed-a297-401a-bd27-1df31821f09c" />

Average net revenue per approved loan:

* High Risk: **+£1,355**
* Subprime: **+£344**
* Prime: **-£232**
* Near Prime: **-£245**

Contrary to traditional assumptions, higher-risk borrowers delivered stronger unit economics.

---

#### 5. Capital allocation was inefficient
<img width="248" height="138" alt="image (3)" src="https://github.com/user-attachments/assets/92af91de-c714-4d75-ac8e-6330ee524752" />

Exposure concentration by segment:

* Near Prime: **39.9%**
* Prime: **36.5%**
* Subprime: **21.6%**
* High Risk: **2.0%**

Over 76% of portfolio exposure sat within economically weak segments, creating significant profitability pressure.

---

## Strategic Recommendations

Based on the analysis:

### Tighten Near Prime Underwriting

Because this segment had:

* highest portfolio exposure
* negative unit economics
* highest provisioning burden

Recommended actions:

* stricter affordability thresholds
* tighter scorecard cut-offs
* reduced approval appetite

---

### Reprice Prime Borrowers

Because this segment generated negative economic returns despite lower perceived risk.

Recommended actions:

* APR recalibration
* pricing segmentation review
* risk-adjusted repricing

---

### Selective Subprime Growth

Because this segment demonstrated positive returns with manageable risk burden.

Recommended actions:

* controlled expansion
* continued performance monitoring

---

### Cautious High-Risk Expansion

Because this segment demonstrated the strongest unit profitability but currently represents minimal exposure.

Recommended actions:

* controlled expansion
* close profitability validation
* enhanced monitoring

---

### Product Pricing Review

Because all loan purposes generated negative profitability.

Recommended actions:

* reassess product pricing adequacy
* align pricing with embedded risk exposure

---

## Repository Structure

```bash
credit-risk-portfolio-analysis/
│
├── sql/
│   └── credit_risk_end_to_end.sql
│
├── powerbi/
│   └── credit_risk_dashboard.pbix
│
├── documentation/
│   └── dmaic_project_documentation.docx
│
├── screenshots/
│   ├── dashboard_1.png
│   └── dashboard_2.png
│
└── README.md
```

---

## Dashboard Screenshots

### Lending Portfolio Performance Overview
<img width="764" height="458" alt="image (2)" src="https://github.com/user-attachments/assets/30e416c2-b916-4c06-b9f4-999a24fbb07d" />

### Portfolio Risk Diagnostics & Strategic Actions
<img width="764" height="459" alt="image (1)" src="https://github.com/user-attachments/assets/a87c0a62-d506-4e00-862b-af4f003c541f" />


## Business Outcome

This analysis showed that portfolio underperformance was not primarily caused by worsening borrower default behaviour.

The core drivers were:

* Excessive provisioning pressure
* Inefficient capital allocation
* Weak economics in dominant borrower segments
* Pricing inadequacy relative to embedded credit risk

The analysis demonstrates a full end-to-end credit analytics workflow spanning data engineering, dimensional modelling, credit risk analysis, executive reporting, and strategic portfolio optimisation.
