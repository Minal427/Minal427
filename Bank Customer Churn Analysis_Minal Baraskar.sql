-- Bank Customer Churn Analysis

Create database Capstone;
use Capstone;
show tables;
select * from `customer-churn-records`;

-- 1.What is the total number of customers in the dataset?
select count(*) as Total_Customers from `customer-churn-records`;
select count(distinct RowNumber) from `customer-churn-records`;

-- 2.How many customers have churned vs. not churned?
select
case
when Exited = "1" then "churned"
else "notchurned"
end
as churnstatus,
count(*) as cust_count from `customer-churn-records` group by Exited;

-- 3.What is the average credit score of all customers?
select avg(creditscore) as Avg_creditscore from `customer-churn-records`;

-- 4.List the number of customers from each country (Geography).
select distinct geography from `customer-churn-records`;
select geography, count(*) as listofcustbycountry from `customer-churn-records` group by Geography;

-- 5.Find the number of male vs. female customers.
select gender, count(customerid) as Total_cust from `customer-churn-records` group by Gender;

-- 6.How many customers have zero account balance?
select count(*) as zero_account_balance from `customer-churn-records` where balance = "0";

-- 7.What is the average balance of customers who have churned?
select avg(balance) as Avg_balance_churned from `customer-churn-records` where exited = "1";

-- 8.Which country has the highest churn rate?
SELECT geography,
    (COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRatePercent
FROM `customer-churn-records` group by geography order by ChurnRatePercent desc;

-- 9.What is the average tenure of customers who have not churned?
select avg(tenure) as Avg_tenure_churned from `customer-churn-records` where exited = "0";

-- 10.Find the top 5 customers with the highest estimated salary who churned.
select customerid, surname, EstimatedSalary from `customer-churn-records` where exited = "1" order by estimatedsalary desc;

-- 11.How many active members have more than 2 products?
select count(*) as activemember_products from `customer-churn-records` where IsActiveMember = 1 and NumOfProducts > 2;

-- 12.Compare the average balance between active and inactive customers.
select isactivemember, avg(balance) from `customer-churn-records` group by isactivemember;

-- 13.What is the average estimated salary per gender?
select gender, avg(estimatedsalary) from `customer-churn-records` group by gender;

-- 14.List the count of churned customers per tenure year.
select tenure, count(exited = 1) as churned_cust from `customer-churn-records` group by tenure;

-- 15.Identify the churn rate for each product count.
SELECT NumOfProducts,
    (COUNT(CASE WHEN Exited = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRatePercent
FROM `customer-churn-records` group by NumOfProducts;

-- 16.What is the churn rate segmented by age groups (e.g., 18–30, 31–45, etc.)?
select
case
when age between 18 and 30 then "18-30"
when age between 31 and 45 then "31-45"
when age between 46 and 60 then "46-60"
else "61+"
end as Age_group,
(sum(CASE WHEN Exited = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRatePercent
from `customer-churn-records` group by Age_group order by Age_group;

-- 17.Which combinations of Geography and Gender have the highest churn rate?
select geography, gender, (sum(CASE WHEN Exited = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRatePercent
from `customer-churn-records` group by geography, gender order by ChurnRatePercent desc;

-- 18.Find the average credit score and balance for churned customers per country.
select geography, avg(creditscore) as avg_creditscore, avg(balance) as avg_balance from `customer-churn-records`
where exited = "1" group by geography order by geography;

-- 19.List the 10 most at-risk customer profiles based on high balance and churned.
select customerId, surname, balance from `customer-churn-records` where exited = "1" order by balance desc limit 10;

--  20.What percentage of customers with no credit card have churned?
select (sum(case when exited = "1" and hascrcard = "0" then 1 else 0 end) *100 / sum(case when hascrcard = 0 then 1 else 0 end)) as nocrcard_churned
from `customer-churn-records`;

-- 21.Which customers have a balance higher than the average balance of all churned customers?
select customerId, surname, balance from `customer-churn-records`
where balance > (select avg(balance) from `customer-churn-records` where exited = 1) order by balance desc;

-- 22.Which countries have a churn rate higher than the overall churn rate?
select geography, (sum(CASE WHEN Exited = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRatePercent
from `customer-churn-records`group by geography;
WITH OverallChurn AS (SELECT (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS OverallChurnRate FROM `customer-churn-records`)
SELECT Geography,
(SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS CountryChurnRate
FROM `customer-churn-records`, OverallChurn
GROUP BY Geography, OverallChurn.OverallChurnRate
HAVING (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > OverallChurn.OverallChurnRate
ORDER BY CountryChurnRate DESC;



























