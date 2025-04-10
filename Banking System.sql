CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    DOB DATE,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address VARCHAR(255)
);
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(50),
    amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
INSERT INTO Customers VALUES
(1, 'Amit', 'Sharma', '1985-04-12', 'amit.sharma@example.com', '9876543210', 'Mumbai'),
(2, 'Neha', 'Patel', '1990-07-21', 'neha.patel@example.com', '9123456789', 'Delhi'),
(3, 'Raj', 'Verma', '1988-11-03', 'raj.verma@example.com', '9988776655', 'Pune'),
(4, 'Sneha', 'Rao', '1993-06-10', 'sneha.rao@example.com', '9011223344', 'Bangalore'),
(5, 'Karan', 'Singh', '1980-02-25', 'karan.singh@example.com', '9871234567', 'Chennai'),
(6, 'Meera', 'Iyer', '1995-09-14', 'meera.iyer@example.com', '9765432100', 'Hyderabad'),
(7, 'Yash', 'Desai', '1987-03-28', 'yash.desai@example.com', '9887766554', 'Ahmedabad'),
(8, 'Ritu', 'Nair', '1991-12-17', 'ritu.nair@example.com', '9933445566', 'Kochi'),
(9, 'Arjun', 'Kapoor', '1986-05-09', 'arjun.kapoor@example.com', '9988771122', 'Jaipur'),
(10, 'Tanya', 'Bose', '1989-10-08', 'tanya.bose@example.com', '9445566778', 'Kolkata');

INSERT INTO Accounts VALUES
(101, 1, 'savings', 50000.00),
(102, 2, 'current', 150000.00),
(103, 3, 'savings', 20000.00),
(104, 4, 'zero_balance', 1000.00),
(105, 5, 'current', 75000.00),
(106, 6, 'savings', 32000.00),
(107, 7, 'current', 88000.00),
(108, 8, 'zero_balance', 500.00),
(109, 9, 'savings', 100000.00),
(110, 10, 'current', 42000.00);

INSERT INTO Transactions VALUES
(201, 101, 'deposit', 10000.00, '2024-03-01'),
(202, 102, 'withdrawal', 5000.00, '2024-03-02'),
(203, 103, 'deposit', 2000.00, '2024-03-03'),
(204, 104, 'deposit', 1500.00, '2024-03-04'),
(205, 105, 'transfer', 25000.00, '2024-03-05'),
(206, 106, 'withdrawal', 7000.00, '2024-03-06'),
(207, 107, 'deposit', 18000.00, '2024-03-07'),
(208, 108, 'deposit', 500.00, '2024-03-08'),
(209, 109, 'withdrawal', 15000.00, '2024-03-09'),
(210, 110, 'transfer', 12000.00, '2024-03-10');

----------------------TASK2-----------------------
----------------Q1 to retrieve the name, account type and email of all customers----------
SELECT 
    c.first_name, 
    c.last_name, 
    a.account_type, 
    c.email
FROM 
    Customers c
JOIN 
    Accounts a ON c.customer_id = a.customer_id;

----------Q2 List all transactions with corresponding customer details----------------------------
SELECT 
    t.transaction_id, 
    t.transaction_type, 
    t.amount, 
    t.transaction_date, 
    c.first_name, 
    c.last_name
FROM 
    Transactions t
JOIN 
    Accounts a ON t.account_id = a.account_id
JOIN 
    Customers c ON a.customer_id = c.customer_id;

----------------------Q3 Increase the balance of a specific account -------------------
UPDATE Accounts
SET balance = balance + 500
WHERE account_id = 101;
SELECT * FROM Accounts;
--------------------Q4 Combine first and last names of customers ------------------------
SELECT 
    CONCAT(first_name, last_name) AS full_name
FROM 
    Customers;

---------------------Q5 . Remove accounts with a balance of zero where the account type is 'savings'-----------------------
DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';
SELECT * FROM Accounts;

---------------------Q6  Find customers living in a specific city -----------------------
SELECT * 
FROM Customers
WHERE address = 'Mumbai';

----------------------------Q7 Get the account balance for a specific account----------------------
SELECT balance 
FROM Accounts
WHERE account_id = 102;

------------------------------------------Q8 List all current accounts with a balance greater than 1,000-------------
SELECT * 
FROM Accounts
WHERE account_type = 'current' AND balance > 1000;

---------------------------------------Q9 Retrieve all transactions for a specific account--------------
SELECT * 
FROM Transactions
WHERE account_id = 105;

-------------------Q10 . Calculate the interest accrued on savings accounts based on a given interest rate ---------------------------------------
SELECT 
    account_id,
    balance,
    balance * 0.07 AS interest
FROM 
    Accounts
WHERE 
    account_type = 'savings';

-------------Q11 Identify accounts where the balance is less than a specified overdraft limit-------------------
SELECT * 
FROM Accounts
WHERE balance < 1000;

------------Q12 Find customers not living in a specific city----------------
SELECT * 
FROM Customers
WHERE address <> 'Delhi';

-----------------------------TASK3-------------------------------------------

-------------------------Q1  Find the average account balance for all customers------------------
SELECT AVG(balance)FROM Accounts;

-------------------------Q2 Retrieve the top 10 highest account balances------------------
SELECT TOP 10 *
FROM Accounts
ORDER BY balance DESC;

------------------------Q3 Calculate total deposits for all customers on a specific date----------
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit'
  AND transaction_date = '2024-03-03';

  ---------------------------------Q4 Find the oldest and newest customers-------------------
SELECT TOP 1 * 
FROM Customers
ORDER BY DOB ASC;


SELECT TOP 1 * 
FROM Customers
ORDER BY DOB DESC;

-----------------------------------Q5 Retrieve transaction details along with the account type
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id;

-----------------------------------Q6 Get a list of customers along with their account details
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_id,
    a.account_type,
    a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

----------------------------------Q7 Retrieve transaction details along with customer information for a specific account 
SELECT 
    t.transaction_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    c.first_name,
    c.last_name
   
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
WHERE t.account_id = 105;

----------------------------Q8 Identify customers who have more than one account
SELECT 
    customer_id,
    COUNT(account_id) AS totalaccounts
FROM Accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1;

-------------------------------Q9 Difference in transaction amounts between deposits and withdrawals
select account_id, 
sum(case
when transaction_type = 'deposit' then amount
else 0 
end) -
sum(case
when transaction_type = 'withdrawal' then amount 
else 0
end) as diff
from  transactions
group by account_id;

--------------------------------Q10  Average daily balance for each account over a specified period----------------
SELECT account_id,AVG(balance) AS avgdailybalance
FROM Accounts
WHERE account_id IN (
    SELECT account_id
    FROM Transactions
    WHERE transaction_date BETWEEN '2024-03-01' AND '2024-03-04'
)
GROUP BY account_id;

--------------------------------Q11 Total balance for each account type----------------
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

------------------------------------Q12 Accounts with the highest number of transactions ----
SELECT 
    account_id,
    COUNT(*) AS transaction_count
FROM Transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

-----------------------------------Q13 Customers with high aggregate account balances, along with account types
SELECT 
    c.customer_id,
    a.account_type,
    SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, a.account_type
HAVING SUM(a.balance) > 10000; 

-------------------------------------------TASK 4---------------------------------------

-----------------------------------Q1 Retrieve the customer(s) with the highest account balance.
SELECT TOP 1 max(balance)AS highest_account_balance FROM Accounts;


----------------------------------Q2 Calculate the average account balance for customers who have more than one account.
SELECT customer_id,avg(balance)AS average_account_balance
FROM Accounts
group by customer_id
HAVING COUNT(*)>1;


-----------------------------------Q3  Retrieve accounts with transactions whose amounts exceed the average transaction amount.------
SELECT DISTINCT t.account_id, a.account_type, t.amount
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE t.amount > (
    SELECT AVG(amount) FROM Transactions
);

-----------------------------------Q4 Identify customers who have no recorded transactions.---------------------------
SELECT  c.customer_id, c.first_name, c.last_name
FROM Customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT a.customer_id
    FROM Accounts a
    JOIN Transactions t ON a.account_id = t.account_id
);

-----------------------------------Q5 Calculate the total balance of accounts with no recorded transactions.----
SELECT SUM(a.balance) AS total_balance_without_transactions
FROM Accounts a
WHERE a.account_id NOT IN (
    SELECT  account_id FROM Transactions
);

---------------------------------Q6 Retrieve transactions for accounts with the lowest balance.---------------------
SELECT transaction_id,transaction_type
FROM Transactions t
WHERE t.account_id IN (
    SELECT account_id
    FROM Accounts
    WHERE balance = (
        SELECT MIN(balance) FROM Accounts)
);

--------------------------------Q7  Identify customers who have accounts of multiple types.---------------
SELECT customer_id, COUNT(DISTINCT account_type) AS type_count
FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type) > 1;

---------------------------Q8 Calculate the percentage of each account type out of the total number of accounts.----------------
SELECT 
    account_type,
    COUNT(*) AS account_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Accounts), 2) AS percentage
FROM Accounts
GROUP BY account_type;

---------------------Q9 Retrieve all transactions for a customer with a given customer_id.------------------------

SELECT transaction_id,transaction_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.customer_id = 101;  


---------------------- Q10  Calculate the total balance for each account type------------------------------------ SELECT 
    account_type,
    SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;



