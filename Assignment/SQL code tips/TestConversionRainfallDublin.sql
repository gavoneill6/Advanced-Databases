SELECT 	
	Location_Code 						
	,Location							
	,Year_Month
	,CAST(SUBSTRING(Year_Month, 1, 4) AS INT)
	,CASE SUBSTRING(Year_Month, 5, 3)
         WHEN  'M01' THEN 1
         WHEN  'M02' THEN 2
         WHEN  'M03' THEN 3
         WHEN  'M04' THEN 4
         WHEN  'M05' THEN 5
         WHEN  'M06' THEN 6
         WHEN  'M07' THEN 7
         WHEN  'M08' THEN 8
         WHEN  'M09' THEN 9
         WHEN  'M10' THEN 10
         WHEN  'M11' THEN 11
         WHEN  'M12' THEN 12   
         ELSE NULL
      END					
	,Total_Rainfall_Millimetres			
	,Most_Rainfall_in_a_Day_Millimetres	
	,Number_of_Raindays
FROM RAINFALL_000_DataTakeOn.dbo.r_RainFallDublin; 