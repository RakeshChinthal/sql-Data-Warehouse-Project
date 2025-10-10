Create or alter Procedure Data_loading_from_Bronze_Silver AS
Begin

	if OBJECT_ID('Silver.crm_cust_info','u') is not null
	Drop table Silver.crm_cust_info
	SELECT *
	INTO Silver.crm_cust_info
	FROM Bronze.crm_cust_info
	ALTER TABLE silver.crm_cust_info
	ADD dwh_create_date DATETIME2 DEFAULT GETDATE();
	

	if OBJECT_ID('Silver.crm_prd_info','u') is not null
	Drop table Silver.crm_prd_info
	SELECT *
	INTO Silver.crm_prd_info
	FROM Bronze.crm_prd_info
	ALTER TABLE silver.crm_prd_info
	ADD dwh_create_date DATETIME2 DEFAULT GETDATE();
	

	if OBJECT_ID('Silver.crm_sales_details','u') is not null
	Drop table Silver.crm_sales_details
	SELECT *
	INTO Silver.crm_sales_details
	FROM Bronze.crm_sales_details
	ALTER TABLE silver.crm_sales_details
	ADD dwh_create_date DATETIME2 DEFAULT GETDATE();
	

	if OBJECT_ID('Silver.erp_cust_az12','u') is not null
	Drop table Silver.erp_cust_az12
	SELECT *
	INTO Silver.erp_cust_az12
	FROM Bronze.erp_cust_az12
	ALTER TABLE silver.erp_cust_az12
	ADD dwh_create_date DATETIME2 DEFAULT GETDATE();
	

	if OBJECT_ID('Silver.erp_loc_a101','u') is not null
	Drop table Silver.erp_loc_a101
	SELECT *
	INTO Silver.erp_loc_a101
	FROM Bronze.erp_loc_a101
	ALTER TABLE silver.erp_loc_a101
	ADD dwh_create_date DATETIME2 DEFAULT GETDATE();

	if OBJECT_ID('Silver.erp_px_cat_g1v2','u') is not null
	Drop table Silver.erp_px_cat_g1v2
	SELECT *
	INTO Silver.erp_px_cat_g1v2
	FROM Bronze.erp_px_cat_g1v2
	ALTER TABLE silver.erp_px_cat_g1v2
	ADD dwh_create_date DATETIME2 DEFAULT GETDATE();
	
End
