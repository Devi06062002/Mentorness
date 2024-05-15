use Corona;

select * from Corona_Virus;

SELECT 
    COUNT(*) AS Null_Count
FROM 
    Corona_Virus
WHERE 
    Province IS NULL
    OR "Country Region" IS NULL
    OR Latitude IS NULL
    OR Longitude IS NULL
    OR Date IS NULL
    OR Confirmed IS NULL
    OR Deaths IS NULL
    OR Recovered IS NULL;

	UPDATE 
    Corona_Virus
SET 
    Province = COALESCE(Province, ''),
    [Country Region] = COALESCE([Country Region], ''),
    Latitude = COALESCE(Latitude, '0'),
    Longitude = COALESCE(Longitude,'0'),
    Date = COALESCE(Date, ''),
    Confirmed = COALESCE(Confirmed, '0'),
    Deaths = COALESCE(Deaths, '0'),
    Recovered = COALESCE(Recovered, '0');


	select count(1) AS Total_Rows
FROM 
    Corona_Virus;



	SELECT MIN(Date) AS Start_date,
    MAX(Date) AS End_date
FROM 
    Corona_Virus;

	SELECT 
    COUNT(DISTINCT LEFT(Date,10)) AS Num_Months
FROM 
    Corona_Virus;

	 SELECT left(Date,15) AS Month,
    AVG(TRY_CONVERT(FLOAT,[Confirmed])) AS Avg_Confirmed,
    AVG(TRY_CONVERT(FLOAT,[Deaths])) AS Avg_Deaths,
    AVG(TRY_CONVERT(FLOAT,[Recovered]))AS Avg_Recovered
FROM 
    Corona_Virus
GROUP BY 
         left(Date,15);



		 WITH MonthlyCounts AS (
    SELECT 
        LEFT(Date, 7) AS Month_Year,
        Confirmed,
        Deaths,
        Recovered,
        ROW_NUMBER() OVER(PARTITION BY LEFT(Date, 7) ORDER BY COUNT(*) DESC) AS Rank
    FROM Corona_Virus
    GROUP BY LEFT(Date, 7), Confirmed, Deaths, Recovered
)
SELECT 
    Month_Year,
    (SELECT TOP 1 Confirmed 
     FROM MonthlyCounts 
     WHERE Month_Year = MC.Month_Year 
     GROUP BY Confirmed 
     ORDER BY COUNT(*) DESC) AS Most_Frequent_Confirmed,
    (SELECT TOP 1 Deaths 
     FROM MonthlyCounts 
     WHERE Month_Year = MC.Month_Year 
     GROUP BY Deaths 
     ORDER BY COUNT(*) DESC) AS Most_Frequent_Deaths,
    (SELECT TOP 1 Recovered 
     FROM MonthlyCounts 
     WHERE Month_Year = MC.Month_Year 
     GROUP BY Recovered 
	 ORDER BY COUNT(*) DESC) AS Most_Frequent_Recovered
FROM (SELECT DISTINCT LEFT(Date , 7) AS Month_Year FROM Corona_Virus) As MC;







SELECT 
    LEFT(Date,4) as Year,
    MIN(Confirmed) AS Min_Confirmed,
    MIN(Deaths) AS Min_Deaths,
    MIN(Recovered) AS Min_Recovered
FROM 
    Corona_Virus
GROUP BY 
   LEFT(Date,4);

 SELECT 
    LEFT(Date,4) as Year,
    MAX(Confirmed) AS Max_Confirmed,
    MAX(Deaths) AS Max_Deaths,
    MAX(Recovered) AS Max_Recovered
FROM 
    Corona_Virus
GROUP BY 
   LEFT(Date,4);


SELECT
    LEFT(Date, 7) AS Month_Year,
    SUM(CAST(Confirmed AS bigint)) AS Total_Confirmed,
    SUM(CAST(Deaths AS bigint)) AS Total_Deaths,
    SUM(CAST(Recovered AS bigint)) AS Total_Recovered
FROM
    Corona_Virus
GROUP BY
    LEFT(Date, 7);


	SELECT 
	LEFT(Date,7) AS Month_Year,
    SUM(Confirmed) AS Total_Confirmed_Cases,
    AVG(Confirmed) AS Avg_Confirmed_Cases,
    VAR(Confirmed) AS Variance_Confirmed_Cases,
    STDEV(Confirmed) AS StdDev_Confirmed_Cases
FROM 
    Corona_Virus
GROUP BY
  LEFT(Date,7);

SELECT 
    LEFT(Date, 7) AS Month_Year,
    SUM(Deaths) AS Total_Deaths,
    AVG(Deaths) AS Average_Deaths,
    VAR(Deaths) AS Variance_Deaths,
    STDEV(Deaths) AS Stdev_Deaths
FROM 
    Corona_Virus
GROUP BY 
    LEFT(Date, 7);

	SELECT 
    LEFT(Date, 7) AS Month_Year,
    SUM(CAST(Recovered AS bigint))AS Total_Recovered,
    AVG(CAST(Recovered AS bigint))AS Average_Recovered,
    VAR(CAST(Recovered AS bigint))AS Variance_Recovered,
    STDEV(CAST(Recovered AS bigint))AS Stdev_Recovered
FROM 
    Corona_Virus
GROUP BY 
    LEFT(Date, 7);

	SELECT TOP 1
    [Country Region],
    MAX(Confirmed) AS Highest_Confirmed_Cases
FROM 
    Corona_Virus
GROUP BY 
    [Country Region]
ORDER BY 
    MAX(Confirmed) DESC;

	SELECT TOP 1
    [Country Region],
    MIN(Deaths) AS Lowest_Death_Cases
FROM 
    Corona_Virus
GROUP BY 
    [Country Region]
ORDER BY 
    MIN(Deaths) ASC;

	SELECT TOP 5
    [Country Region],
    MAX(Recovered) AS Highest_Recovered_Cases
FROM 
    Corona_Virus
GROUP BY 
    [Country Region]
ORDER BY 
    MAX(Recovered) DESC;