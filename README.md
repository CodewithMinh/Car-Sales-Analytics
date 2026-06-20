# Car-Sales-Analytics
<img width="1918" height="995" alt="image" src="https://github.com/user-attachments/assets/9af94738-f115-4608-819e-05fe12d6ce79" />

Cleaning and exploring vehicle sales data with Python, analyzing sales, pricing and market performance using SQL, and building an interactive Power BI dashboard.

## Project Overview

This project analyzes historical vehicle sales data to understand sales volume, pricing, vehicle characteristics, market value, and seller performance.

The analysis combines:

* **Python** for data cleaning and exploratory data analysis
* **SQL** for business-oriented analysis
* **Power BI** for interactive dashboard development

The project follows a business-driven workflow:

**Data Preparation → EDA → SQL Analysis → KPI Development → Power BI Dashboard → Insights & Actions**

---

## Business Problem

Vehicle sales data contains information about vehicle characteristics, selling prices, market values, mileage, condition, sellers, and sales locations.

The objective is to transform this raw transactional data into useful insights that can support questions such as:

* How does vehicle sales value change over time?
* Which vehicle makes generate the highest sales value?
* Which makes have the highest sales volume?
* How does vehicle condition relate to selling price?
* How does mileage relate to vehicle price?
* Which models are the best-selling within each make?
* How does actual selling price compare with market value (MMR)?
* Which markets and sellers contribute most to sales performance?

---

## Business Questions

The project focuses on the following questions:

1. How do average selling price and total vehicle sales value change by year?
2. Which are the top 10 makes by total sales value?
3. Which are the top 10 makes by number of vehicles sold?
4. Which make has the highest average selling price in each year?
5. How does vehicle condition relate to average selling price?
6. How does mileage relate to average selling price across vehicle makes?
7. What is the best-selling model within each make?
8. Among makes with at least 500 vehicles sold, which have the highest average selling prices?

These questions are implemented in `car_sales.sql`.

---

## Dataset

### Raw Dataset

The original dataset contains:

* **558,837 observations**
* **16 variables**

Main fields include:

| Variable       | Description                   |
| -------------- | ----------------------------- |
| `year`         | Vehicle model year            |
| `make`         | Vehicle manufacturer          |
| `model`        | Vehicle model                 |
| `trim`         | Vehicle trim/version          |
| `body`         | Vehicle body type             |
| `transmission` | Transmission type             |
| `vin`          | Vehicle identification number |
| `state`        | Sales state                   |
| `condition`    | Vehicle condition score       |
| `odometer`     | Vehicle mileage               |
| `color`        | Exterior color                |
| `interior`     | Interior color                |
| `seller`       | Seller name                   |
| `mmr`          | Manheim Market Report value   |
| `sellingprice` | Actual selling price          |
| `saledate`     | Sale date                     |

The raw dataset is stored as `car_prices.csv`.

---

## Data Preparation & EDA

Data preparation was performed using Python and Pandas.

### 1. Data Inspection

The dataset was inspected using:

* Data types
* Number of observations and variables
* Descriptive statistics
* Sample records
* Missing values
* Duplicate records
* Distribution and outlier checks

### 2. Duplicate Check

A full-row duplicate check was performed.

Result:

* **0 duplicate rows**

### 3. Missing Values

Missing values were examined across all variables.

The dataset contains missing values in 13 of the 16 original columns.

The highest missing-value rate was found in `transmission` at approximately **11.69%**.

### 4. Missing Value Treatment

The cleaning process included:

* `transmission`: missing values replaced with `unknown`
* `body`: missing values replaced with `other`
* `condition`: missing values replaced using the median
* `color`: missing values replaced with `unknown`
* `trim`: missing values replaced with `unknown`
* `model`: missing values replaced with `unknown`
* `make`: missing values replaced with `unknown`
* Rows with missing values in important analytical fields such as `interior`, `odometer`, `mmr`, `sellingprice`, and `saledate` were removed

### 5. Standardization

Categorical values were standardized using lowercase conversion and whitespace trimming.

Vehicle body types were also grouped into broader categories such as:

* Sedan
* Coupe
* Wagon
* Convertible
* Truck
* Van
* Hatchback
* Other

### 6. Unnecessary Column Removal

The `vin` column was removed from the cleaned dataset because it was not required for the business analysis.

The cleaned dataset therefore contains **15 variables**.

### 7. Outlier Detection

The Interquartile Range (IQR) method was used to identify potential outliers in:

* `sellingprice`
* `odometer`
* `year`

The analysis identified:

* 16,204 potential outliers in `sellingprice`
* 10,340 potential outliers in `odometer`
* 4,008 potential outliers in `year`

A business-oriented filtering step was then applied to constrain the analytical dataset to reasonable ranges for selling price and vehicle year.

For mileage, the value `999999` was treated as invalid and replaced before median imputation.

### Cleaned Dataset

The resulting cleaned dataset contains:

* **557,963 observations**
* **15 variables**

The cleaned data is stored as `cleaned_data.csv`.

---

## SQL Analysis

SQL was used to answer business questions related to sales performance, pricing, vehicle characteristics, and market performance.

Key SQL techniques used include:

* `GROUP BY`
* Aggregate functions such as `COUNT()`, `SUM()`, and `AVG()`
* `HAVING`
* `ORDER BY`
* `LIMIT`
* Common Table Expressions (CTEs)
* Window functions
* `RANK()`
* `ROW_NUMBER()`
* `PARTITION BY`

Examples of analysis include:

### Sales Performance by Year

Analyze average selling price and total selling value by year.

### Make Performance

Identify makes with the highest:

* Total sales value
* Number of vehicles sold
* Average selling price

### Vehicle Condition

Compare average selling prices across vehicle condition levels.

### Mileage Analysis

Group vehicles into mileage categories and compare their average selling prices across makes.

### Best-Selling Models

Use ranking functions to identify the best-selling model within each vehicle make.

The complete SQL analysis is available in:

`car_sales.sql`

---

## Key Metrics

The Power BI dashboard uses the following key metrics:

| Metric                      | Purpose                                           |
| --------------------------- | ------------------------------------------------- |
| Sales Transactions          | Number of vehicle sales transactions              |
| Total Revenue / Sales Value | Total value of vehicles sold                      |
| Average Selling Price       | Average actual selling price                      |
| Average MMR                 | Average market reference value                    |
| Average Market Gap          | Difference between selling price and MMR          |
| Market Gap %                | Relative difference between selling price and MMR |
| Average Odometer            | Average vehicle mileage                           |
| Average Condition           | Average vehicle condition                         |
| Total Sellers               | Number of sellers                                 |
| Sales Share %               | Contribution to total sales value                 |

These KPIs are used to evaluate sales volume, pricing, market positioning, and seller performance.

---

## Power BI Dashboard

The Power BI dashboard is organized into three pages.

### 1. Overview

Provides a high-level view of the vehicle sales market.

Key areas:

* Overall sales value
* Sales transactions
* Average selling price
* Average market value
* Sales trends
* Vehicle make performance
* Overall market gap

**Business question:**

> What is the overall performance of the vehicle sales market?

---

### 2. Vehicle Analysis

Focuses on vehicle-level characteristics and pricing.

Key areas:

* Sales volume by make
* Selling price by make and body type
* Vehicle condition
* Odometer / mileage
* MMR versus actual selling price
* Market gap

**Business question:**

> Which types of vehicles and vehicle characteristics are associated with stronger sales and pricing performance?

---

### 3. Market & Seller Analysis

Focuses on geographic and seller performance.

Key areas:

* Sales by state
* Sales contribution by market
* Seller performance
* Sales value distribution
* Market gap across markets and sellers

**Business question:**

> Which markets and sellers contribute most to overall vehicle sales performance?

---

## Key Insights & Actions

The analysis is designed to connect descriptive findings with business decisions.

### Pricing & Market Value

Comparing `sellingprice` with `mmr` allows the analysis to identify vehicles sold above or below their market reference value.

**Action:**

Sellers can use the market gap to identify pricing opportunities and review vehicles whose actual selling prices consistently differ from market expectations.

### Vehicle Condition

Vehicle condition is analyzed together with selling price to understand how vehicle quality relates to market value.

**Action:**

Sellers can use condition-based pricing analysis to improve pricing strategies and prioritize vehicles with stronger value potential.

### Mileage

Mileage is grouped into analytical categories to examine its relationship with selling price.

**Action:**

Mileage can be incorporated into pricing decisions alongside vehicle make, model, condition, and market value.

### Vehicle Make & Model

Sales volume and total sales value are used to identify important vehicle makes and their best-selling models.

**Action:**

Sellers can use this information to prioritize inventory around models that demonstrate stronger market demand.

### Market & Seller Performance

Sales are analyzed across states and sellers to identify differences in contribution to overall sales performance.

**Action:**

High-performing markets and sellers can be examined for successful pricing, inventory, or sales practices that could be replicated elsewhere.

---

## Tools & Technologies

* **Python**

  * Pandas
  * NumPy
  * Matplotlib
  * Seaborn

* **SQL**

  * Aggregations
  * CTEs
  * Window Functions
  * Ranking

* **Power BI**

  * Data modeling
  * DAX
  * Interactive dashboards
  * KPI development
  * Data visualization

* **Git / GitHub**

  * Version control
  * Project documentation
  * Git LFS for large datasets

---

## Repository Structure

```text
Car-Sales-Analytics/
│
├── README.md
├── car_prices.csv
├── cleaned_data.csv
├── car_project.ipynb
├── car_sales.sql
└── cardashboard.pbix
```

### File Description

| File                | Description                       |
| ------------------- | --------------------------------- |
| `README.md`         | Project documentation             |
| `car_prices.csv`    | Original vehicle sales dataset    |
| `cleaned_data.csv`  | Cleaned dataset used for analysis |
| `car_project.ipynb` | Python data cleaning and EDA      |
| `car_sales.sql`     | SQL business analysis             |
| `cardashboard.pbix` | Power BI dashboard                |

---

## Project Workflow

```text
Raw Data
   ↓
Data Inspection
   ↓
Data Cleaning & Standardization
   ↓
Exploratory Data Analysis
   ↓
SQL Business Analysis
   ↓
KPI Development
   ↓
Power BI Dashboard
   ↓
Business Insights & Actions
```

---

## Conclusion

This project demonstrates an end-to-end Data Analyst workflow using vehicle sales data.

The analysis combines Python for data preparation and EDA, SQL for business-oriented analysis, and Power BI for interactive reporting.

The final dashboard provides a structured view of:

* Sales performance
* Vehicle characteristics
* Pricing
* Market value
* Market gaps
* Vehicle makes and models
* Geographic performance
* Seller performance

The project focuses on transforming raw vehicle transaction data into actionable business information that can support pricing, inventory, market, and seller performance decisions.
