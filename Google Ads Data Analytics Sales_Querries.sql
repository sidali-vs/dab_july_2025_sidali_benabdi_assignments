--- 6. Exploratory Query Analysis : 

--- Average number of cliks per month :(Sum or average of numeric fields with grouping)
--- how many imprerssions and clicks on average do we get per month ? 
/*
SELECT
				round(avg(impressions),2) as average_number_of_impressions,
				round(avg(clicks), 2) as average_number_of_clicks,
				strftime('%m_%Y', ad_date) as month
FROM records
GROUP BY month
ORDER BY average_number_of_clicks DESC;
*/

--- MAX and Min cliks and impressions : (Identification of minimum/maximum values)
--- what is the most and least amount of impressions and cliks did we get each month   and which ad was it ?
/*
SELECT	
				ad_id,
				Max(impressions) as Max_impressions,
				Min (impressions) as Min_impressions,
				Max(clicks) as Max_clicks,
				Min(clicks) as Min_clicks,
				strftime('%m_%Y', Ad_Date) as month
FROM records
GROUP BY month;
*/
--- Count of ads ( Count of records meeting specific criteria)
--- How many ads did we launch in november that were seen on  desktop
/*
SELECT
				Count(*)
From records
where ad_Date BETWEEN '2024-11-01' and '2024-11-30' 
			AND device = 'Desktop';
*/ 

--- 7. Business Query Analysis

---- which month did the campaign spend the most
/*
SELECT 	
				sum(cost) as Total_expenditure,
				strftime('%m_%Y', ad_date) as month
FROM records
group by month
order by total_expenditure DESC;
*/

---- what is the gross profit for each month 
/*
SELECT	
				sum(sale_Amount) - sum(Cost)  as gross_profit,
				strftime('%m_%Y', ad_date) as month
FROM records
GROUP BY	 month
order by gross_profit DESC;
*/

--- what is the overall gross profit :
/*
SELECT 
				sum(sale_amount) - sum(cost)  as overall_gross_profit
from records;
*/

---- which keywords in which month performed the best by conversation rate  ,
/*
SELECT		
				keyword,
				strftime('%m_%Y', ad_date) as month,
				conversion_rate
FROM records
GROUP BY keyword
ORDER BY 	conversion_rate desc;
*/
				
