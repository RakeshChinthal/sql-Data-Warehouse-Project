CREATE VIEW gold.dim_Customers
AS

/*
DESCRIPTION: This dimension view consolidates customer information from CRM (silver.crm_cust_info) 
and supplements it with data from ERP (silver.erp_cust_az12) and location data (silver.erp_loc_a101).

KEY LOGIC:
1. Generates a unique, non-natural key (Customer_Key) using ROW_NUMBER().
2. Uses a CASE statement to prioritize Gender from the CRM source, falling back to ERP gender or 'N/A' if missing (using COALESCE).
3. Joins are performed on the customer key (cst_key/cid) across all three silver tables.
*/

SELECT
    ROW_NUMBER() OVER(ORDER BY cst_id) AS Customer_Key,
    ci.cst_id AS Customer_ID,
    ci.cst_key AS Customer_Number,
    ci.cst_firstname AS First_Name,
    ci.cst_lastname AS Last_name,
    ci.cst_marital_status AS Marital_Status,
    CASE 
        WHEN ci.cst_gndr != 'N/A' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'N/A') 
    END AS Gender,
    ci.cst_create_date AS create_date,
    ca.bdate AS Birth_Date
FROM 
    silver.crm_cust_info AS ci
LEFT JOIN 
    silver.erp_cust_az12 AS ca
    ON ci.cst_key = ca.cid
LEFT JOIN 
    silver.erp_loc_a101 AS la
    ON ci.cst_key = la.cid;
