# Bright-Motors-Car-Sales-Analysis

# Bright Motors – Car Sales Analysis (BRIGHTLEARN)

**Objective:** Deliver business insights for a new Head of Sales using historical car sales data from Bright Motors.  
**Files included:** Raw dataset (`car_sales.csv`) and the presentation/report.  

---

## 1. Problem Statement & Goals
Bright Motors appointed a **new Head of Sales** to expand the network, improve performance, and optimize inventory.  
This analysis aims to determine:
- **Top revenue drivers** by make & model  
- **Relationship** between price, mileage, and year of manufacture  
- **Regional/location performance**  
- **Emerging customer preferences**  
- **Actionable recommendations** to increase profitability and efficiency  

---

## 2. Data Data Overview
**Raw file:** (`car_sales.csv`)  
**Columns (sample):** `year, make, model, trim, body, transmission, vin, state, condition, odometer, color, interior, seller, mmr, sellingprice, saledate`  
The dataset contains daily transactions and pricing info per vehicle. 

**Basic definitions:**
- `mmr`: Industry price benchmark (Manheim Market Report)
t Report)
- `sellingprice`: Actual sale price
- `odometer`: Mileage at sale
- `condition`: Vehicle condition score (numeric; higher ≈ better)
- `saledate`: Date/time of sale  
---

## 3. Analytics Scope & KPIs
**Primary KPIs**
- Total Revenue = `sellingprice` (per row) → aggregated by **make/model/year/state**  
- Average Selling Price (ASP)  
- Average MMR vs. Selling Price (Discount/Premium %)  
- Avg Mileage by Year of Manufacture  
- Unit Volume by Region/State  

**Secondary Metrics**
- **Margin Proxy** (since `Cost_Price` is unavailable): `sellingprice - mmr` as an indicative premium/discount  
- **Price-Mileage Elasticity** (exploratory correlation)  
- **Age-of-Vehicle distribution** by `year`  

---

## 4. Project Plan & Architecture
**Workflow**
1. **Plan & Architecture** – Data flow diagram (Miro)  
2. **Data Loading** – Import CSV to Snowflake   
3. **Cleaning & Transformation** – normalize price fields, cast types, create derived columns  
4. **Analysis & Visualization** – export for Power BI/Looker/Excel  
5. **Presentation** – executive summary, insights, and recommendations  

**Data Flow (Miro/Figma)**
- Source → ETL → Storage (Snowflake/SQL) → Analysis (SQL/BI) → Presentation (PPT/PDF)  
---
## 5. Setup & Reproducibility

### 5.1. Environment
- PowerPower BI / Google Looker Studio / Excel (for visuals)
- SQL engine: Snowflake / SQL Server / BigQuery  

## 6. Findings
### ✅ 1. Business Context
- Bright Motors operates in the used car resale market, handling 558,799 transactions across 38 U.S. states.
- Inventory spans 34 years, 96 makes, and 973 models, indicating a highly diverse product offering.
### Strategic goal: expand dealership network and boost sales performance using data-driven insights.

### ✅ 2. Sales Trends
Seasonality observed:
- Q1 dominates: January and February 2015 peak (Feb > $2B revenue).
- April & July extremely low → possible inventory or marketing gaps.
- Year-end (December) shows moderate performance.
Indicates strong early-year demand and fluctuating mid-year performance.

### ✅ 3. Regional Performance
Top states by revenue:
- Florida (20%) and California (18.4%) → combined 38.5% of total revenue.
- Pennsylvania (15%), Texas (10.5%), Georgia (7.8%) follow.
- Top 3 states = 53% of revenue → highly concentrated market.
Lower-performing states:
- Missouri, Ohio, Illinois → consider targeted campaigns or cost-benefit review.

### ✅ 4. Brand Performance
- Ford leads with 26.08% of revenue, followed by: Chevrolet (13.85%) and Nissan (12.13%)
- These three account for >52% of revenue → critical for inventory and marketing.
- Toyota (9.35%) and BMW (8.55%) strong but secondary.
- Luxury brands (BMW, Mercedes-Benz, Infiniti) dominate CA & FL → high-income demographics.

### ✅ 5. Profitability
- California most profitable (75% contribution from high/medium margin sales).
- Florida strong but more low-margin sales → mixed profitability.
- PA and TX moderate (~30–35% contribution).
- GA leans toward low-margin → lower profitability.

### ✅ 6. Customer Preferences
Transmission:
- Automatic dominates (84.72% revenue).
- Manual minimal (2.59%) → niche or declining.
- Null category (12.69%) → data quality issue or EV sales.

Price vs Mileage:
- Strong negative correlation: higher mileage → lower price.
- Post-2014 cars have mileage <30,000 and price >$20,000 → newer models command premium.

### ✅ 7. Strategic Recommendations
- Focus on FL & CA for dealership expansion and marketing.
- Prioritize automatic transmission vehicles; minimize manual stock.
- Core brands: Ford, Chevrolet, Nissan, Toyota, BMW → maintain strong inventory.
- Investigate Null transmission category for data quality or EV strategy.
- Target Illinois & Tennessee for growth campaigns.
- Highlight convenience of automatic transmission in marketing.
- Offer luxury options in high-income states to boost margins.
