-- -------------------------------------------------------------------------------
--                             Dashboard 2: Overview                              |
-- This script file has SQL queries that generates the results that will be used  |
-- to test the results of the Dashboard 2: Overview as per the problem statements |
-- Metrics to be shown: Total Loan Applications, Total Funded Amount, and         |
-- Total Amount Received for all the results                                      |
-- -------------------------------------------------------------------------------

-- use the new database created bank_loan_analysis
use bank_loan_analysis;

select * from bank_loan_data limit 5;

-- 1. Monthly Trends by Issue Date 
select 
extract(year from issue_date) as year,
extract(month from issue_date) as mon,
count(id) as total_loan_application,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by extract(year from issue_date),
extract(month from issue_date)
order by extract(year from issue_date),
extract(month from issue_date);

-- 2. Regional Analysis by State
select 
address_state as state,
count(id) as total_loan_application,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by address_state
order by sum(loan_amount) desc;

-- 3. Loan Term Analysis
select 
term,
count(id) as total_loan_application,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by term;

-- 4. Employee Length Analysis
select 
emp_length as employee_length,
count(id) as total_loan_application,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by emp_length
order by sum(loan_amount) desc, count(id) desc, sum(total_payment) desc;

-- 5. Loan Purpose Breakdown 
select 
purpose as loan_purpose,
count(id) as total_loan_application,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by purpose
order by sum(loan_amount) desc, count(id) desc, sum(total_payment) desc;

-- 6. Home Ownership Analysis
select 
home_ownership,
count(id) as total_loan_application,
sum(loan_amount) as total_funded_amount,
sum(total_payment) as total_amount_received
from bank_loan_data
group by home_ownership
order by sum(loan_amount) desc, count(id) desc, sum(total_payment) desc;