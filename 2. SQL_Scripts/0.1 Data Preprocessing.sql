-- ----------------------------------------------------------------------------
--                             Data Preprocessing                            --
-- ----------------------------------------------------------------------------

use bank_loan_analysis;

select * from bank_loan_data limit 5;

-- ----------------------------------------------------------------------------
--                       Changing the datatype of the columns                --
-- ----------------------------------------------------------------------------
-- Disable safe update mode
SET SQL_SAFE_UPDATES = 0;

-- Update the date format
UPDATE bank_loan_data 
SET 
    issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y'),
    last_credit_pull_date = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y'),
    last_payment_date = STR_TO_DATE(last_payment_date, '%d-%m-%Y'),
    next_payment_date = STR_TO_DATE(next_payment_date, '%d-%m-%Y');

-- Alter the column type to DATE
ALTER TABLE bank_loan_data 
MODIFY COLUMN issue_date DATE,
MODIFY COLUMN last_credit_pull_date DATE,
MODIFY COLUMN last_payment_date DATE,
MODIFY COLUMN next_payment_date DATE;

-- Re-enable safe update mode (optional)
SET SQL_SAFE_UPDATES = 1;
  