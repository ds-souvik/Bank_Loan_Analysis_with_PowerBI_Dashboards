-- -------------------------------------------------------------------------------
--                             Dashboard 1: Summary                               |
-- This script file has SQL queries that generates the results that will be used  |
-- to test the results of the Dashboard 1: Summary as per the problem statements  |
-- -------------------------------------------------------------------------------

-- use the new database created bank_loan_analysis
use bank_loan_analysis;

select * from bank_loan_data limit 5;

-- 1.1 Total Loan Applications
select count(id) as Total_applications from bank_loan_data;

-- 1.2 MTD Loan Applications
select count(id) as MTD from bank_loan_data where 
extract(month from issue_date) = (select max(extract(month from issue_date)) from bank_loan_data)
and extract(year from issue_date) = (select max(extract(year from issue_date)) from bank_loan_data);

-- 1.3 Track Changes month over month
with monthly_application_table as(
select 
	extract(year from issue_date) as year, extract(month from issue_date) as mon, count(id) as total_applications
	from bank_loan_data
	group by extract(year from issue_date), extract(month from issue_date)
	order by extract(year from issue_date), extract(month from issue_date))
select 
year, 
mon, 
100*((total_applications - (lag(total_applications) over()))/(lag(total_applications) over())) 
as percent_difference from monthly_application_table;


-- 2.1 Total Funded Amount
select sum(loan_amount) as total_funded_amount from bank_loan_data;

-- 2.2 MTD Funded Amount
select sum(loan_amount) as MTD_funded_amount from bank_loan_data
where extract(year from issue_date)= (select extract(year from max(issue_date)) from bank_loan_data) and
extract(month from issue_date)= (select extract(month from max(issue_date)) from bank_loan_data);

-- 2.3 Track funded amount Changes month over month
with monthly_funded_amt_data as(
	select extract(year from issue_date) as year,
    extract(month from issue_date) as mon,
    sum(loan_amount) as total_funded_amount
    from bank_loan_data
    group by extract(year from issue_date),
    extract(month from issue_date)
    order by extract(year from issue_date),
    extract(month from issue_date))
select year, 
mon, 
100*((total_funded_amount - (lag(total_funded_amount) over()))/(lag(total_funded_amount) over())) as percent_difference
from monthly_funded_amt_data;

-- 3.1 Total Amount Received
select sum(total_payment) as total_amount_received from bank_loan_data;

-- 3.2 MTD Amount Received
select sum(total_payment) as MTD_amount_received from bank_loan_data
where extract(year from issue_date)= (select extract(year from max(issue_date)) from bank_loan_data) and
extract(month from issue_date)= (select extract(month from max(issue_date)) from bank_loan_data);

-- 3.3 Track total amount received Changes month over month
with monthly_amt_received_data as(
	select extract(year from issue_date) as year,
    extract(month from issue_date) as mon,
    sum(total_payment) as total_amount_received
    from bank_loan_data
    group by extract(year from issue_date),
    extract(month from issue_date)
    order by extract(year from issue_date),
    extract(month from issue_date))
select year, 
mon, 
100*((total_amount_received - (lag(total_amount_received) over()))/(lag(total_amount_received) over())) 
as percent_difference
from monthly_amt_received_data;

-- 4.1 Average interest rates
select avg(int_rate) as average_interest_rate from bank_loan_data;

-- 4.2 MTD average interest rates
select avg(int_rate) as MTD_avg_int_rate from bank_loan_data
where extract(year from issue_date)= (select extract(year from max(issue_date)) from bank_loan_data) and
extract(month from issue_date)= (select extract(month from max(issue_date)) from bank_loan_data);

-- 3.3 Track average interest rate Changes month over month
with monthly_avg_int_rates_data as(
	select extract(year from issue_date) as year,
    extract(month from issue_date) as mon,
    avg(int_rate) as avg_interest_rates
    from bank_loan_data
    group by extract(year from issue_date),
    extract(month from issue_date)
    order by extract(year from issue_date),
    extract(month from issue_date))
select year, 
mon, 
100*((avg_interest_rates - (lag(avg_interest_rates) over()))/(lag(avg_interest_rates) over())) 
as percent_difference
from monthly_avg_int_rates_data;


-- 5.1 Average dti
select avg(dti) as average_dti from bank_loan_data;

-- 5.2 MTD average dti
select avg(dti) as MTD_avg_dti from bank_loan_data
where extract(year from issue_date)= (select extract(year from max(issue_date)) from bank_loan_data) and
extract(month from issue_date)= (select extract(month from max(issue_date)) from bank_loan_data);

-- 5.3 Track average interest rate Changes month over month
with monthly_avg_dti_data as(
	select extract(year from issue_date) as year,
    extract(month from issue_date) as mon,
    avg(dti) as avg_dti
    from bank_loan_data
    group by extract(year from issue_date),
    extract(month from issue_date)
    order by extract(year from issue_date),
    extract(month from issue_date))
select year, 
mon, 
100*((avg_dti - (lag(avg_dti) over()))/(lag(avg_dti) over())) 
as percent_difference
from monthly_avg_dti_data;


-- 6.1 Good and Bad Loan Application
select 
	case
		when loan_status='Fully Paid' then 'Good Loan'
        when loan_status='Current' then 'Good Loan'
        when loan_status='Charged Off' then 'Bad Loan'
        else 'Bad Loan' end as updated_loan_status,
        count(id) 
        from bank_loan_data
        group by updated_loan_status;

-- 6.2 Good and Bad Loan Application Percentage
SELECT 
    CASE
        WHEN loan_status = 'Fully Paid' THEN 'Good Loan'
        WHEN loan_status = 'Current' THEN 'Good Loan'
        WHEN loan_status = 'Charged Off' THEN 'Bad Loan'
        ELSE 'Bad Loan'
    END AS updated_loan_status,
    COUNT(id) * 100.0 / SUM(COUNT(id)) OVER () AS percent_applications
FROM bank_loan_data
GROUP BY updated_loan_status;

-- 6.3 Good and Bad Loan Funded amount
select 
	case
		when loan_status='Fully Paid' then 'Good Loan'
        when loan_status='Current' then 'Good Loan'
        when loan_status='Charged Off' then 'Bad Loan'
        else 'Bad Loan' end as updated_loan_status,
        sum(loan_amount) 
        from bank_loan_data
        group by updated_loan_status;

-- 6.4 Good and Bad Loan Funded amount Percentage
SELECT 
    CASE
        WHEN loan_status = 'Fully Paid' THEN 'Good Loan'
        WHEN loan_status = 'Current' THEN 'Good Loan'
        WHEN loan_status = 'Charged Off' THEN 'Bad Loan'
        ELSE 'Bad Loan'
    END AS updated_loan_status,
    sum(loan_amount) * 100.0 / SUM(sum(loan_amount)) OVER () AS percent_funded_amount
FROM bank_loan_data
GROUP BY updated_loan_status;

-- 6.5 Good and Bad Loan total received amount
select 
	case
		when loan_status='Fully Paid' then 'Good Loan'
        when loan_status='Current' then 'Good Loan'
        when loan_status='Charged Off' then 'Bad Loan'
        else 'Bad Loan' end as updated_loan_status,
        sum(total_payment) 
        from bank_loan_data
        group by updated_loan_status;

-- 6.6 Good and Bad Loan total received amount Percentage
SELECT 
    CASE
        WHEN loan_status = 'Fully Paid' THEN 'Good Loan'
        WHEN loan_status = 'Current' THEN 'Good Loan'
        WHEN loan_status = 'Charged Off' THEN 'Bad Loan'
        ELSE 'Bad Loan'
    END AS updated_loan_status,
    sum(total_payment) * 100.0 / SUM(sum(total_payment)) OVER () AS percent_funded_amount
FROM bank_loan_data
GROUP BY updated_loan_status;

-- 7.1 Loan Status Grid View
with aggregated_data as(
	select loan_status, 
	count(id) as total_loan_application,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received,
	avg(int_rate) as average_interest_rate,
	avg(dti) as average_dti
	from bank_loan_data
	group by loan_status),
aggregated_MTD_data as(
	select loan_status, 
	sum(loan_amount) as MTD_funded_amount,
	sum(total_payment) as MTD_amount_received
	from bank_loan_data
	where extract(month from issue_date)=(select extract(month from max(issue_date)) from bank_loan_data)
	and extract(year from issue_date)=(select extract(year from max(issue_date)) from bank_loan_data)
	group by loan_status)
select a.loan_status, 
a.total_loan_application,
a.total_funded_amount,
a.total_amount_received,
b.MTD_funded_amount,
b.MTD_amount_received,
a.average_interest_rate,
a.average_dti
from aggregated_data a
inner join
aggregated_MTD_data b
on a.loan_status=b.loan_status;