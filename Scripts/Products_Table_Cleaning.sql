-- Check if the Silver table already exists
IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
-- If it exists, delete the table to start fresh
DROP TABLE silver.crm_prd_info;

-- Create the final Silver table structure for cleaned product data
CREATE TABLE silver.crm_prd_info (
    prd_id INT,
    cat_id NVARCHAR(50),      -- Standardized Product Category ID
    prd_key NVARCHAR(50),     -- Cleaned Product Key
    prd_nm NVARCHAR(50),
    prd_cost INT,             -- Standardized Cost (no NULLs)
    prd_line NVARCHAR(50),    -- Full Product Line Name
    prd_start_dt DATE,        -- Start Date (time component removed)
    prd_end_dt DATE,          -- Calculated End Date
    dwh_create_date DATETIME2 DEFAULT GETDATE() -- Audit column, automatically set to current time
);

-- Begin inserting cleaned and calculated data into the Silver table
INSERT into Silver.crm_prd_info
(
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
SELECT 
    prd_id,
    -- Extracts the first 5 characters and standardizes the Category ID
    -- e.g., 'AC-HE-HL-U509-R' -> 'AC-HE' -> 'AC_HE'
    Replace(SUBSTRING(prd_key,1,5),'-','_') as Cat_id,
    -- Extracts the remaining part of the key after the first 6 characters
    -- LEN(prd_key) ensures it is dynamic for any string length
    Substring(prd_key,7,LEN(prd_key)) as prd_key,
    prd_nm,
    -- Standardizes product cost: if NULL, replace with 0
    ISNULL(prd_cost,0) AS prd_cost,
    -- Clean and standardize the Product Line code into a full description
    CASE Upper(Trim(prd_line)) 
        WHEN 'R' THEN 'Road'   
        WHEN 'S' THEN 'Other Sales'
        WHEN 'm' THEN 'Mountain'
        WHEN 'T' THEN 'Touring'
        ELSE 'N/A' -- Default value for unmapped codes
    END AS prd_line, 
    -- Ensures the start date is strictly a DATE format (removes time)
    CAST(prd_start_dt as DATE) AS prd_start_dt,
    -- Calculate the Product End Date:
    -- 1. LEAD(prd_start_dt) OVER (...) looks ahead to the START DATE of the NEXT record
    -- 2. PARTITION BY prd_key ensures it only looks ahead within the same product group
    -- 3. ORDER BY prd_start_dt sorts the records chronologically
    -- 4. DATEADD(DAY,-1, ...) subtracts one day from the next start date, setting the end date for the current record
    DATEADD(DAY,-1,CAST(LEAD(prd_start_dt) over(partition by prd_key order by prd_start_dt) as date)) as prd_end_dt

-- Source the data from the raw Bronze table
FROM Bronze.crm_prd_info
