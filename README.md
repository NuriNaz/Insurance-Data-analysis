# Insurance-Data-analysis

# Insurance Data Analysis Project – Power BI & SQL

##  Project Overview  
This project focuses on analyzing **insurance data** using **Power BI** for visualization and **SQL** for data exploration.  
The goal was to understand **customer demographics, premiums, claims, and policy performance** while comparing the results between **Power BI dashboards** and **SQL queries**.  

---

## Dataset Description  
- **Rows:** ~10,004  
- **Columns:**  
  - `PolicyNumber` – Unique ID for each policy  
  - `CustomerID` – Unique customer reference  
  - `Gender` – Male/Female  
  - `Age` – Customer age  
  - `PolicyType` – Travel, Health, Auto, Life, Home  
  - `PolicyStartDate` / `PolicyEndDate` – Policy duration  
  - `PremiumAmount` – Premium paid by customer  
  - `CoverageAmount` – Coverage offered under the policy  
  - `ClaimNumber` – Claim reference ID  
  - `ClaimDate` – Date of claim request  
  - `ClaimAmount` – Amount claimed by customer  
  - `ClaimStatus` – Pending / Settled / Rejected  
  - `AgeGroup` – Young Adult, Adult, Elder (derived column)  
  - `ActiveInactive` – Status of policy  

---

##  Data Profiling (Power Query Editor)  
- Checked for **missing values** and nulls in claims.  
- Verified **data types** (Dates, Numbers, Text).  
- Removed duplicates in `PolicyNumber` and `CustomerID`.  
- Created derived columns:  
  - `Age Group` (Young Adult, Adult, Elder).  
  - `Active/Inactive` status for policies.  

---

##  Data Modeling  
- **Single table model** (`InsuranceData`).  
- **DAX Measures** created:  
  - `Total Premium = SUM(PremiumAmount)`  
  - `Total Coverage = SUM(CoverageAmount)`  
  - `Total Claim = SUM(ClaimAmount)`  
  - `Claim Ratio = ClaimAmount / CoverageAmount`  

---

##  Dashboard Highlights (Power BI)  
- **KPIs:**  
  - Total Premium: **5.98M**  
  - Total Coverage: **600.55M**  
  - Total Claim Amount: **16.91M**  
- **Visuals:**  
  - Bar Chart → Premium by Policy Type  
  - Pie Chart → Active vs Inactive Policies  
  - Column Chart → Claims by Status (Rejected, Settled, Pending)  
  - Line Chart → Claim Amount by Age Group  
  - Matrix → Claim distribution by Policy Type  
   Displayed Claim distribution by Policy Type and Claim Status.

  Enabled Drill-through functionality to navigate from summary-level policy data to individual claim-level details.

  Used dynamic measures to show KPIs contextually during drill-through (e.g., Total Premium, Total Claim).
---

## SQL Queries for the Same Analysis  

### 1. **Total Premium, Coverage, and Claim Amount**
```sql
SELECT 
    SUM(PremiumAmount) AS TotalPremium,
    SUM(CoverageAmount) AS TotalCoverage,
    SUM(ClaimAmount) AS TotalClaimAmount
FROM InsuranceData;
```

### 2. **Gender Distribution**
```sql
SELECT Gender, COUNT(*) AS TotalCustomers
FROM InsuranceData
GROUP BY Gender;
```

### 3. **Premium by Policy Type**
```sql
SELECT PolicyType, SUM(PremiumAmount) AS TotalPremium
FROM InsuranceData
GROUP BY PolicyType
ORDER BY TotalPremium DESC;
```

### 4. **Active vs Inactive Policies**
```sql
SELECT 
    CASE 
        WHEN PolicyEndDate <= '2024-12-10' THEN 'Inactive'
        ELSE 'Active'
    END AS PolicyStatus,
    COUNT(*) AS TotalPolicies
FROM InsuranceData
GROUP BY 
    CASE 
        WHEN PolicyEndDate <= '2024-12-10' THEN 'Inactive'
        ELSE 'Active'
    END;
```

### 5. **Claims by Status**
```sql
SELECT ClaimStatus, COUNT(*) AS NumberOfClaims
FROM InsuranceData
GROUP BY ClaimStatus;
```

### 6. **Claim Amount by Age Group**
```sql
SELECT 
    CASE
        WHEN Age <= 24 THEN 'Young Adult'
        WHEN Age <= 60 THEN 'Adult'
        ELSE 'Elder'
    END AS AgeGroup,
    SUM(ClaimAmount) AS TotalClaimAmount
FROM InsuranceData
GROUP BY 
    CASE
        WHEN Age <= 24 THEN 'Young Adult'
        WHEN Age <= 60 THEN 'Adult'
        ELSE 'Elder'
    END
ORDER BY TotalClaimAmount DESC;
```

### 7. **Policy Type vs Claim Status Amount**
```sql
SELECT 
    PolicyType,
    SUM(CASE WHEN ClaimStatus = 'Pending' THEN CoverageAmount ELSE 0 END) AS Pending,
    SUM(CASE WHEN ClaimStatus = 'Rejected' THEN CoverageAmount ELSE 0 END) AS Rejected,
    SUM(CASE WHEN ClaimStatus = 'Settled' THEN CoverageAmount ELSE 0 END) AS Settled,
    SUM(CoverageAmount) AS TotalCoverage
FROM InsuranceData
GROUP BY PolicyType;
```

---

## Key Insights  
- **Gender distribution** is balanced: ~50% Male, 50% Female.  
- **Travel Insurance** generates the highest premium (~2.5M).  
- **Claim Status:**  
  - Rejected → 4.4K claims  
  - Settled → 3.4K claims  
  - Pending → 2.3K claims  
- **Age Groups:**  
  - Adults claim the most (~8.8M).  
  - Elders (~6.4M).  
  - Young Adults (~1.7M).  
- **Policy Status:** ~75% inactive, 25% active.  

---

##  Conclusion  
- **Travel & Health policies** contribute the maximum revenue.  
- **Claim rejections** are high → insurers need to improve claim processes.  
- **Adults** are the highest-risk segment but also bring the most business.  
- High **inactive policies** → need for better customer engagement & retention.  

---

##  How to Use This Project  
1.  download the .pbit file Open the **`.pbit` file** in Power BI Desktop.  
2. Use slicers (Policy Number, Claim Number, Customer ID) to filter insights.  
3. Run the **SQL queries** on your database to validate results.
4. screenshot:https://screenrec.com/share/RzG3OjlSps
5. screenrecording:https://screenrec.com/share/uVIfWBkgZw

---

## Future Scope  
- Add **predictive models** for claim forecasting (Python/R with Power BI).  
- Include **geographical analysis** of policies.  
- Automate **alerts for claim fraud detection**.  

