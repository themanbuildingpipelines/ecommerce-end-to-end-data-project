*
===========================================================================================================

This stored procedure loads data into the ''bronze schema from external CSV files

It performs the following functions:
-Truncates the bronze tables before loading the data
-Uses the BULK INSERT command to load the CSV Files to Bronze Tables

Parameters: None
This stored procedure does not accept any parameters or return any values.

Usage Example: EXEC Bronze.load_bronze

===========================================================================================================
*/
CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
--Create a start time and end time operator to calculate load times for each table and the entire bronze layer
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	--Try
	BEGIN TRY
		
		SET @batch_start_time = GETDATE();
		PRINT '==============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================================';

		PRINT '--------------------------------------------------------------';
		PRINT 'Loading all tables';
		PRINT '--------------------------------------------------------------';
		
		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>>Truncating advertisment spend table';
		TRUNCATE TABLE Bronze.ad_spend;
		--Full Load
		PRINT 'Loading advertisment spend table ';
		BULK INSERT Bronze.ad_spend
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\ad_spend_daily.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>-----------------';
		
		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating the crm sales table';
		TRUNCATE TABLE Bronze.crm_sales;
		--Full Load
		PRINT '>> Loading the crm sales table';
		BULK INSERT Bronze.crm_sales
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\crm_sales_01.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>-----------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating customer details table';
		TRUNCATE TABLE Bronze.customer_details;
		--Full Load
		PRINT '>> Loading customer details table';
		BULK INSERT Bronze.customer_details
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\customer_master_db.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>-----------------';
		
		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating raw ecommerce orders tables';
		TRUNCATE TABLE Bronze.ecommerce_orders_raw;
		--Full Load
		PRINT '>> Loading raw ecommerce orders table';
		BULK INSERT Bronze.ecommerce_orders_raw
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\ecom_orders_raw.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>----------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating product inventory table';
		TRUNCATE TABLE Bronze.product_inventory;
		--Full Load
		PRINT '>> Loading product inventory table';
		BULK INSERT Bronze.product_inventory
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\inventory_master.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>---------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating payment_gateway_log table';
		TRUNCATE TABLE Bronze.payment_gateway_logs;
		--Full Load
		PRINT '>> Loading payment_gateway_log table';
		BULK INSERT Bronze.payment_gateway_logs
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\payment_gateway_log.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating promotional campaigns table';
		TRUNCATE TABLE Bronze.promotional_campaigns;
		--Full Load
		PRINT '>> Loading promotional campaigns table';
		BULK INSERT Bronze.prmotional_campaigns
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\promo_campaigns.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating customer returns table';
		TRUNCATE TABLE Bronze.customer_returns;
		--Full Load
		PRINT '>> Loading customer returns table';
		BULK INSERT Bronze.customer_returns
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\returns_log.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating sales team roster table';
		TRUNCATE TABLE Bronze.sales_team;
		--Full Load
		PRINT '>> Loading sales team roster table';
		BULK INSERT Bronze.sales_team
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\sales_team_roster.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating shipment tracking table';
		TRUNCATE TABLE Bronze.shipment_tracking;
		--Full Load
		PRINT '>> Loading shipment tracking table';
		BULK INSERT Bronze.shipment_tracking
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\shipment_tracking.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating customer support tickets table';
		TRUNCATE TABLE Bronze.customer_support_tickets;
		--Full Load
		PRINT '>> Loading customer support tickets table';
		BULK INSERT Bronze.customer_support_tickets
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\support_tickets_raw.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';

		SET @start_time = GETDATE();
		--Make the table empty
		PRINT '>> Truncating web sessions table';
		TRUNCATE TABLE Bronze.web_sessions;
		--Full Load
		PRINT '>> Loading web sessions table';
		BULK INSERT Bronze.web_sessions
		FROM "C:\Users\JIMMY OKOTH\Desktop\E-Commerce Project\all_data_csvs\web_sessions_export.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' ' + 'seconds';
		PRINT '>>--------------------------';


	--get the entire batch load time
	PRINT '=============================================================================================================';
	PRINT 'Loading Bronze Layer is Complete';
	SET @batch_end_time = GETDATE();
	PRINT 'Batch Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' ' + 'seconds';
	PRINT '=============================================================================================================';
	END TRY
	
	--catch
	BEGIN CATCH
		PRINT '==========================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================================';
	END CATCH
END

--Usage example
EXEC Bronze.load_bronze
