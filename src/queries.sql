use meas;

-- Display all transactions involving a particular account. 
-- Here the account considered is 'Cash Account'
SELECT DISTINCT vno, vdate, amount, auth, prep, debit, credit, narration
FROM voucher AS v, accounts AS a
WHERE 
    a.acc_code IN (SELECT acc_code FROM accounts WHERE acc_name = 'Cash Account') AND
    (v.credit = a.acc_code OR v.debit = a.acc_code);

-- Display all transactions in which a particular employee is involved.
-- Here the employee is named 'Agarwal'
SELECT DISTINCT vno, vdate, amount, auth, prep, debit, credit, narration
FROM voucher AS v, employee AS e
WHERE (
    v.auth IN (SELECT empid FROM employee WHERE
        fname = 'Agarwal' OR
        minit = 'Agarwal' OR
        lname = 'Agarwal'
    ) OR
    v.prep IN (SELECT empid FROM employee WHERE
        fname = 'Agarwal' OR
        minit = 'Agarwal' OR
        lname = 'Agarwal'
    )
);

-- Produce the Bird-Eye Balance Sheet of the firm
SELECT acc_cat_name "Category Name", COUNT(*) "# of accounts associated", SUM(acc_bal) "Total Sum"
FROM acc_type, accounts
WHERE acc_type.acc_cat_id = accounts.acc_cat_id
GROUP BY acc_type.acc_cat_id
HAVING COUNT(*) > 0;

-- Display all external parties who maintain non-zero balance
SELECT DISTINCT acc_code, acc_name, acc_bal, acc_cat_name
FROM accounts, acc_type
WHERE accounts.acc_cat_id = acc_type.acc_cat_id
    AND is_internal = 0
    AND acc_bal != 0
ORDER BY acc_bal ASC;

-- Display all employees who comes from Bengaluru
SELECT DISTINCT *
FROM employee
INNER JOIN address        
USING (pincode)
WHERE address.city="Bengaluru";


-- SELECT DISTINCT *
-- FROM employee
-- NATURAL JOIN address;