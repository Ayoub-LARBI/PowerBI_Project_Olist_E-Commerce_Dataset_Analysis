# 📊 Olist E-Commerce Executive Performance & Business Intelligence Dashboard

## 📌 Project Overview

This project delivers an enterprise-grade, interactive business intelligence solution built using **Power BI Desktop** and fueled by an optimized **PostgreSQL** data pipeline. It expands on the foundational deep-dive queries from the Olist SQL analysis repo by synthesizing macro financial trends and intricate customer satisfaction dynamics into a polished, executive-ready dashboard tool.

The dashboard consists of two high-impact visual tracking layouts designed for instant stakeholder interpretation:
1. **Page 1: Revenue & Sales Overview** – Focusing on financial trends, customer order volumes, cumulative marketplace growth, and critical revenue channels.
2. **Page 2: Logistics & Customer Satisfaction** – Focusing on performance metrics, isolating fulfillment timelines, and evaluating the exact correlation between shipping performance and public feedback.

---

## 📸 Dashboard Previews

### 🔹 Page 1: Revenue & Sales Overview
![Revenue & Sales Overview](images/Revenue%20&%20Sales%20Overview%20ss.png)

### 🔹 Page 2: Logistics & Customer Satisfaction
![Logistics & Customer Satisfaction](images/Logistics%20&%20Customer%20Satisfaction%20ss.png)

---

## 🎯 Dashboard Objectives & Tracked Analytics

### 💰 Revenue & Macro Sales View
* **Financial Velocity:** Track cumulative marketplace scaling metrics directly across the 2016–2018 operating window.
* **Volume Analysis:** Evaluate the health of monthly transaction trends against shifting average order values.
* **Seasonal Demand:** Identify high-volume transaction shifts to assist logistics planning groups.

### 🚚 Logistics & Customer Review Diagnostics
* **Operational Impact:** Isolate the score difference between on-time fulfillments vs. late deliveries to quantify the business cost of carrier delays.
* **Sentiment Spreading:** Monitor real-time shifts in the global satisfaction trend index over a strict chronological timeline.
* **Feedback Deep-Dive:** Audit raw text feedback distribution rates to calculate how heavily delivery frictions spark customer commentary.
* **Product Segments:** Uncover structural product flaws by grouping exact average review scores directly across individual categories.

---

## 🛠️ Data Pipeline: Extracting from PostgreSQL

To ensure ultra-fast, direct data processing and preserve local computing memory inside the BI layout, all analytical business logic was explicitly pushed upstream to the relational database layer. The frontend application ingests data via highly targeted, production-ready extraction queries:

1. **`01_executive_sales_performance.sql`**: Houses advanced analytical window partitions that calculate strict, deduplicated monthly billing aggregates and continuous running totals.
2. **`02_logistics_satisfaction_deepdive.sql`**: Dynamically ties item categorization translations with feedback metrics while computing isolated performance baselines for logistics delays.
3. **`03_global_satisfaction_kpis.sql`**: Bypasses heavy tabular row duplication entirely to feed distinct executive totals to visual high-level cards.

### 🔌 How to Connect and Load the Data
1. Launch **Power BI Desktop**.
2. Go to the home ribbon, click **Get Data ➔ PostgreSQL database**.
3. Provide your server connection properties and expand the **Advanced options** statement box.
4. Open any query inside the `sql_queries/` file folder, copy the script text, paste it into the box, and click **Load**.
5. *Pro Tip:* Once the data finishes loading, select the text-based `month` column in the Data pane, navigate to **Column tools**, and click **Sort by column ➔ `month_date`** to guarantee a perfectly sequential chronological chart timeline!

---

## 🧠 Core BI & UI/UX Skills Demonstrated

This portfolio piece highlights an advanced engineering and design skillset engineered to deliver professional data products:

* **Advanced Upstream Modeling:** Eliminating chaotic DAX dependencies by constructing pre-calculated, weighted database aggregates natively inside multi-layered Common Table Expressions (CTEs).
* **Granularity Control:** Overcoming structural row-expansion bugs (the classic multi-item order fan-out issue) to present clean, distinct data volumes.
* **Executive UI/UX Alignment:** Enforcing high-contrast canvas spacing using floating card architectures, hidden grid guidelines, and standardized warning color palettes to direct a user's eyes to critical issues.
* **De-cluttered Design:** Ruthlessly stripping axis titles, redundant borders, and label noise to protect empty whitespace and keep visual look simple.

---

## 📁 Project Structure

```text
📦 POWERBI_PROJECT
│
├── 📁 dashboard
│   └── 📊 Olist_E-Commerce_Dataset_Dashboard.pbix
│
├── 📁 data
│   └── 📄 [Raw Olist CSV dataset source files]
│
├── 📁 images
│   ├── 📸 Logistics & Customer Satisfaction ss.png
│   └── 📸 Revenue & Sales Overview ss.png
│
├── 📁 sql_queries
│   ├── 📄 01_executive_sales_performance.sql
│   ├── 📄 02_logistics_satisfaction_deepdive.sql
│   └── 📄 03_global_satisfaction_kpis.sql
│
└── 📘 README.md