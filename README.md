# 🏨 AtliQ Hospitality Data Pipeline & Analytics

## 📌 Project Overview
AtliQ Grands, a leading chain of luxury and business hotels in India, has been facing declining market share and revenue due to intense competition and poor decision-making.  
To address this, the company decided to adopt **Business & Data Intelligence** to make informed strategic decisions.  

This project demonstrates an **end-to-end data engineering and analytics solution** using **SQL Server, Snowflake, dbt, and Power BI**.

---

## 🚀 Tech Stack
- **SQL Server** → Local staging of raw CSV data  
- **Python (pandas, pyodbc, snowflake-connector)** → Data ingestion & transfer  
- **Snowflake** → Cloud data warehouse  
- **dbt** → Data modeling & transformations (staging → intermediate → marts)  
- **Power BI** → Dashboard & business insights  

---

## 🔄 Data Pipeline Architecture
![Pipeline Architecture](https://github.com/YunusKhan13/AtliQ-Hospitality-Data-Engineering-Analytics-Pipeline/blob/main/diagrams/Pipeline%20Architecture.gif)

**Workflow:**
1. **CSV → SQL Server**  
   Load raw datasets into SQL Server using Python.  

2. **SQL Server → Snowflake (Raw Zone)**  
   Transfer data from SQL Server into Snowflake Raw Zone.  

3. **Transformations in dbt**  
   - **Staging Layer:** Clean & standardize raw data  
   - **Intermediate Layer:** Apply business logic (occupancy, revenue, cancellations)  
   - **Marts Layer:** Curated fact & dimension tables for BI tools  

4. **Snowflake → Power BI**  
   Final marts tables are connected to Power BI for visualization & insights.  

---

## 📂 Project Structure

├── data/                     # Raw CSV files

├── data_ingestion/            # Python scripts to load into SQL Server & Snowflake

├── dbt_atliq_hospitality/     # dbt project (staging, intermediate, marts)

├── logs/                      # Execution logs

└── diagrams/                  # Pipeline/architecture diagrams 


---

## 🗄️ Snowflake Schemas
The project uses a **multi-layered schema approach** inside Snowflake:

- **raw_zone** → stores raw ingested tables (from SQL Server)  
- **staging** → standardized and cleaned versions of raw data  
- **intermediate** → business logic transformations (occupancy, revenue, cancellations)  
- **analytics/marts** → final curated tables for BI consumption  

### 🔹 Schema Screenshots
Here is a screenshot of Snowflake objects after dbt transformations:  

<img src="https://github.com/YunusKhan13/AtliQ-Hospitality-Data-Engineering-Analytics-Pipeline/blob/main/diagrams/Snowflake%20Schemas.png" alt="Snowflake Schemas" width="600"/>

---

## 🔗 dbt Lineage Graph
The following lineage graph shows how data flows from **Raw Zone → Staging → Intermediate → Marts** using dbt:  

![dbt Lineage Graph](https://github.com/YunusKhan13/AtliQ-Hospitality-Data-Engineering-Analytics-Pipeline/blob/main/diagrams/Lineage%20graph.png)

---


## 📊 Business Metrics & KPIs
- **Revenue Analysis**  
  - Revenue Generated vs Revenue Realized  
  - Monthly Revenue Trends  
- **Occupancy Insights**  
  - Daily Occupancy % by hotel category  
  - Weekend vs Weekday occupancy  
- **Customer Behavior**  
  - Average Ratings  
  - Cancellation & No-show analysis  
- **Platform Insights**  
  - Booking % by platform  
  - Unrealized revenue by platform  
- **City/Property Performance**  
  - City-level demand  
  - Property/category performance  

---

## 📅 Current Status
- ✅ Data loaded into SQL Server  
- ✅ Data transferred to Snowflake Raw Zone  
- ✅ dbt project created with staging, intermediate, and marts models  
- ✅ Validated marts views/tables in Snowflake  
- 🔄 Power BI dashboards (in progress — will be added soon with screenshots)  

---

## 📅 Next Steps
- Build & publish **Power BI dashboards**  
- Add **dbt tests** for data quality (unique, not null, accepted values)  
- Automate dbt runs with **Airflow / dbt Cloud**  
- Publish final project report with business insights  

---

## 👤 Author
**Khan Yunus**  
_Data Engineer | SQL | Python | Snowflake | dbt | Power BI_  


