use meas;

DELETE FROM address;
INSERT INTO address VALUES ('600020', 'Chennai');
INSERT INTO address VALUES ('560003', 'Bengaluru');
INSERT INTO address VALUES ('500001', 'Hyderabad');

DELETE FROM employee;
INSERT INTO employee VALUES (12345, 'Sunil', 'M', 'Hedge', 24, '9988776655', '560003');
INSERT INTO employee VALUES (14589, 'Ramya', 'R', 'Agarwal', 30, '7122334455', '500001');
INSERT INTO employee VALUES (NULL, 'Anil', 'H',NULL, 36, '6234567890', '560003');

DELETE FROM acc_type;
INSERT INTO acc_type VALUES (NULL, 'Assets');
INSERT INTO acc_type VALUES (NULL, 'Liabilites');
INSERT INTO acc_type VALUES (NULL, 'Equity');

DELETE FROM accounts;
INSERT INTO accounts VALUES(00001, 'Capital Account', 0, 1, 2);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00002, 'Cash Account', 1, 1);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00003, 'Bank Account', 1, 1);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00004, 'Puchases', 1, 1);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00005, 'Carriage In', 1, 2);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00006, 'Wages', 1, 2);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00007, 'Rent', 1, 2);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00008, 'Sales', 1, 1);
INSERT INTO accounts (acc_code, acc_name, is_internal, acc_cat_id) VALUES(00009, 'Expenses', 1, 2);
INSERT INTO accounts VALUES (99901, 'Seller-1',0.0, 0, 2);
INSERT INTO accounts VALUES (99902, 'Buyer-1',0.0, 0, 1);


DELETE FROM voucher;
INSERT INTO voucher VALUES(1, NULL, 25000, 1, 2, 12345, NULL, 'Pro-Input');
INSERT INTO voucher VALUES(2, NULL, 50000, 1, 3, 12345, NULL, 'Pro-Input');
INSERT INTO voucher VALUES(3, NULL, 500, 99901, 00004, 12345, NULL, 'Purchase-1');  
INSERT INTO voucher VALUES(4, NULL, 500, 00003, 99901, 12345, NULL, 'P-OUT for Purchase-1');
INSERT INTO voucher VALUES(5, NULL, 600, 00008, 99902, 14589, NULL, 'Sale-1');
INSERT INTO voucher VALUES(NULL, NULL, 50, 00002, 00005, 12345, NULL, 'Transport-P1');
INSERT INTO voucher VALUES(NULL, NULL, 600, 99902, 00002, 14590, NULL, 'P-IN for Sale-1');
INSERT INTO voucher VALUES(NULL, NULL, 1500, 00003, 00006, 14589, NULL, 'Wages - March');
INSERT INTO voucher VALUES(NULL, NULL, 100, 00003, 00007, 14590, NULL, 'Rent - March');
INSERT INTO voucher VALUES(NULL, NULL, 50, 00002, 00009, 14589, NULL, 'Post Charges');
INSERT INTO voucher VALUES(NULL, NULL, 1000, 00003, 00001, 12345, NULL, 'Income-Transfer');
INSERT INTO voucher VALUES(NULL, NULL, 800, 00008, 99902, 14590, 12345, 'Second-Pur');

DELETE FROM supdoc;
INSERT INTO supdoc VALUES(25,'Bill for Purchase-1',3);
