INSERT INTO Silver.crm_sales_details (
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)

SELECT
    sls_ord_num, -- Order Number (copied as is)
    sls_prd_key, -- Product Key (copied as is)
    sls_cust_id, -- Customer ID (copied as is)

    -- Data transformation logic for sls_order_dt: Converts source data (INT/VARCHAR) to DATE type.
    CASE WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
         -- Set to NULL if date is 0 or not exactly 8 characters (assuming YYYYMMDD format)
         ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
         -- Otherwise, cast to VARCHAR and then to DATE
    END AS sls_order_dt,

    -- Data transformation logic for sls_ship_dt: Converts source data (INT/VARCHAR) to DATE type.
    CASE WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
         -- Set to NULL if date is 0 or not exactly 8 characters
         ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
    END AS sls_ship_dt,

    -- Data transformation logic for sls_due_dt: Converts source data (INT/VARCHAR) to DATE type.
    CASE WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
         -- Set to NULL if date is 0 or not exactly 8 characters
         ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
    END AS sls_due_
