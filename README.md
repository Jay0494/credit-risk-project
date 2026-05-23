Here’s a professional **README.md** for your GitHub repository.

Copy this directly into your `README.md`.

````markdown
# Credit Risk Portfolio Performance Analysis

## Project Overview

This project presents an end-to-end credit risk and lending portfolio analytics solution developed to investigate the drivers of weak profitability within an unsecured lending portfolio.

Despite relatively stable lending demand and improving default performance, the portfolio continued to generate negative financial returns. The objective of this analysis was to identify the structural causes of underperformance and provide strategic, data-driven recommendations to improve risk-adjusted profitability.

The project was delivered using **MySQL for data engineering and Power BI for analytical reporting**, following a structured analytics workflow from raw data ingestion through executive decision-support reporting.

---

## Business Problem

The portfolio exhibited an apparent contradiction:

- borrower default performance improved year-over-year
- lending activity remained commercially active
- yet overall portfolio profitability remained negative

This raised key business questions:

- Why is the lending portfolio underperforming financially despite relatively controlled default behaviour?
- Which borrower segments are driving weak profitability?
- Is the issue caused by credit defaults, provisioning pressure, pricing inefficiency, or exposure concentration?
- What strategic portfolio actions can improve profitability while maintaining responsible lending practices?

---

## Objectives

The objectives of this project were to:

- build a trusted analytics-ready lending dataset
- assess portfolio performance across risk, profitability, and underwriting dimensions
- identify the structural drivers of weak lending economics
- develop executive dashboards for monitoring and strategic decision support
- recommend actionable credit risk optimisation strategies

---

## Tools & Technologies

- **MySQL**
- **SQL**
- **Power BI**
- **DAX**
- **Dimensional Data Modelling**
- **Credit Risk Analytics**
- **Portfolio Performance Analysis**

---

## Methodology

This project followed a structured **DMAIC (Define – Measure – Analyze – Improve – Control)** framework.

### 1. Define
Established the business problem around persistent portfolio underperformance despite improving default behaviour.

---

### 2. Measure

#### Data Engineering & Validation
Built a structured SQL transformation pipeline including:

- raw data staging
- data type standardisation
- SQL data quality auditing using `UNION ALL`
- remediation of invalid business logic
- lifecycle date correction
- financial metric recalculation

Validation checks included:

- null completeness checks
- duplicate application detection
- debt-to-income ratio validation
- credit utilisation validation
- affordability score checks
- fraud risk score validation
- expected loss formula validation
- net revenue calculation validation
- loan lifecycle date integrity checks

Expected loss formula:

```sql
Expected Loss = PD × LGD × EAD
````

Net revenue logic:

```sql
Net Revenue = Interest Income - Funding Cost - Provision Cost
```

---

#### Dimensional Modelling

The cleansed operational dataset was remodelled into a dimensional star schema for scalable analytics.

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

### 3. Analyze

A structured Power BI analytical layer was developed using DAX.

Core KPIs included:

#### Portfolio KPIs

* Total Applications
* Approved Loans
* Approval Rate
* Default Rate
* Portfolio Exposure
* Expected Credit Loss
* Net Revenue
* Portfolio NPV

#### Profitability KPIs

* Interest Income
* Funding Cost
* Provision Cost
* Net Margin
* Provision Burden %
* Cost of Funds Ratio %
* Avg Net Revenue per Approved Loan

#### Risk KPIs

* Average PD
* Average LGD
* Days Past Due
* Missed Payments
* Exposure Concentration

---

### Dashboard 1 — Lending Portfolio Performance Overview

Descriptive analytics focused on:

* lending demand trends
* approval performance
* default behaviour
* portfolio exposure
* expected credit loss
* profitability trends
* NPV
* loan purpose profitability
* exposure by loan tenor

---

### Dashboard 2 — Portfolio Risk Diagnostics & Strategic Actions

Diagnostic and prescriptive analytics focused on:

* profitability breakdown
* provision burden analysis
* segment-level unit economics
* exposure concentration by risk segment
* strategic risk opportunity matrix
* management action recommendations

---

## Key Findings

### 1. Default performance improved, but profitability remained weak

* Default Rate: **9.7%**
* YoY Default Improvement: **-3.9%**
* Net Revenue: **-£351K**
* Portfolio NPV: **-£339K**

Despite better realised repayment behaviour, profitability remained negative.

---

### 2. Expected credit loss remained elevated

* Portfolio Exposure: **£50.29M**
* Expected Credit Loss: **£9.95M**
* Exposure YoY: **+1.0%**
* Expected Loss YoY: **+1.0%**

Risk exposure remained elevated despite lower defaults.

---

### 3. Provisioning pressure was the primary profitability driver

* Interest Income: **£11.1M**
* Provision Cost: **£10.0M**
* Funding Cost: **£1.5M**
* Provision Burden: **89.6%**
* Net Margin: **-3.2%**

For every £1 earned:

* ~90p consumed by provisioning
* ~14p consumed by funding costs

Portfolio economics were structurally unsustainable.

---

### 4. High-risk borrowers were not the profitability problem

Avg Net Revenue per Approved Loan:

* High Risk: **+£1,355**
* Subprime: **+£344**
* Prime: **-£232**
* Near Prime: **-£245**

Higher-risk segments delivered stronger unit economics.

---

### 5. Capital allocation was inefficient

Exposure mix:

* Near Prime: **39.9%**
* Prime: **36.5%**
* Subprime: **21.6%**
* High Risk: **2.0%**

Over 76% of exposure sat in economically weak segments.

---

## Strategic Recommendations

Based on the analysis:

### Tighten Near Prime Underwriting

Because:

* highest exposure
* weakest economics
* highest provision burden

---

### Reprice Prime Borrowers

Because:

* negative unit profitability
* weak risk-adjusted economics

---

### Selective Subprime Growth

Because:

* positive returns
* manageable risk burden

---

### Cautious High-Risk Expansion

Because:

* strongest unit economics
* currently under-allocated

---

### Product Pricing Review

Because:
all loan purposes showed negative profitability.

---

## Repository Structure

```text
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

(Add screenshot here)

### Portfolio Risk Diagnostics & Strategic Actions

(Add screenshot here)

---

## Business Outcome

This analysis showed that portfolio underperformance was not primarily caused by worsening borrower default behaviour.

The root causes were:

* excessive provisioning pressure
* inefficient exposure allocation
* weak economics in dominant borrower segments
* pricing inadequacy relative to embedded risk

The project demonstrates a full end-to-end credit analytics workflow spanning data engineering, dimensional modelling, credit risk analysis, executive reporting, and strategic portfolio optimisation.

```

Next step after this: **embed your dashboard screenshots into the README so the repo looks visually strong.**
```
