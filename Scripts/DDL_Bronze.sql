CREATE OR ALTER PROCEDURE bronze.load_bronze as

Begin
	
	Declare @start_time DATETIME, @end_time DATETIME, @BATCH_START_TIME DATETIME, @BATCH_End_TIME datetime
	SET @BATCH_START_TIME = GETDATE();
	Begin Try
		Print '============================='
		print 'Loading the bronze Layer'
		Print '============================='

		Print '----------------------------------'
		print 'Loading the CRM SYSTEMS'
		Print '----------------------------------'
		
		SET @start_time = GETDATE();
		TRUNCATE Table bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info 
		FROM 'C:\SQL2022\Data_Warehouse\datasets\source_crm\cust_info.csv' 
		WITH
		(
			FIRSTROW = 2,           
			FIELDTERMINATOR = ',',  
			TABLOCK                 
		);
		SET @end_time = GETDATE();
		Print'-------------------------------------------------------------------------------------------'
		Print '>> Loading data : '+ cast(Datediff(second,@start_time,@end_time)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE Table bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info 
		FROM 'C:\SQL2022\Data_Warehouse\datasets\source_crm\prd_info.csv' 
		WITH
		(
			FIRSTROW = 2,           
			FIELDTERMINATOR = ',',  
			TABLOCK                 
		);
		SET @end_time = GETDATE();
		Print'-------------------------------------------------------------------------------------------'
		Print '>> Loading data : '+ cast(Datediff(second,@start_time,@end_time)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE Table bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details 
		FROM 'C:\SQL2022\Data_Warehouse\datasets\source_crm\sales_details.csv' 
		WITH
		(
			FIRSTROW = 2,           
			FIELDTERMINATOR = ',',  
			TABLOCK                 
		);
		SET @end_time = GETDATE();
		Print'-------------------------------------------------------------------------------------------'
		Print '>> Loading data : '+ cast(Datediff(second,@start_time,@end_time)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'

		Print '----------------------------------'
		print 'Loading the ERP SYSTEMS'
		Print '----------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE Table bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\SQL2022\Data_Warehouse\datasets\source_erp\cust_az12.csv' 
		WITH
		(
			FIRSTROW = 2,           
			FIELDTERMINATOR = ',',  
			TABLOCK                 
		);
		SET @end_time = GETDATE();
		Print'-------------------------------------------------------------------------------------------'
		Print '>> Loading data : '+ cast(Datediff(second,@start_time,@end_time)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE Table bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\SQL2022\Data_Warehouse\datasets\source_erp\loc_a101.csv' 
		WITH
		(
			FIRSTROW = 2,           
			FIELDTERMINATOR = ',',  
			TABLOCK                 
		);
		SET @end_time = GETDATE();
		Print'-------------------------------------------------------------------------------------------'
		Print '>> Loading data : '+ cast(Datediff(second,@start_time,@end_time)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE Table bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\SQL2022\Data_Warehouse\datasets\source_erp\px_cat_g1v2.csv' 
		WITH
		(
			FIRSTROW = 2,           
			FIELDTERMINATOR = ',',  
			TABLOCK                 
		);
		SET @end_time = GETDATE();
		Print'-------------------------------------------------------------------------------------------'
		Print '>> Loading data : '+ cast(Datediff(second,@start_time,@end_time)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'

	End Try
	Begin Catch
		Print '============================================='
		print 'Error occured during Loading the bronze Layer'
		print 'Error Message' + Error_message();
		print 'Error Number' + Cast(Error_Number() as NVARCHAR);
		print 'Error Number' + Cast(Error_State() as NVARCHAR);
		Print '============================================='
	End Catch
	SET @BATCH_End_TIME = GETDATE();
	Print'-------------------------------------------------------------------------------------------'
		Print '>> Batch Loading data : '+ cast(Datediff(second,@BATCH_START_TIME,@BATCH_End_TIME)  as NVARCHAR) + ' Seconds';
		Print'-------------------------------------------------------------------------------------------'
END
