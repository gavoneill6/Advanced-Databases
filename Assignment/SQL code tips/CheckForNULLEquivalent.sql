SELECT TOP 1000 [Location_Code]
      ,[Location]
      ,[Year_Month]
      ,[Total_Rainfall_Millimetres]
      ,[Most_Rainfall_in_a_Day_Millimetres]
      ,[Number_of_Raindays]
  FROM [RAINFALL_000_DataTakeOn].[dbo].[r_RainFallDublin]
  WHERE [Total_Rainfall_Millimetres] = '..'
  OR [Most_Rainfall_in_a_Day_Millimetres] = '..'
  OR [Number_of_Raindays] = '..'; 