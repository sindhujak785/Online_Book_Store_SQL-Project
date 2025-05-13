# Online_Book_Store - SQL Project

## Project Overview
The Online Book Store is a SQL-based database project designed to manage book inventory, customer details, and order transactions. This project helps in tracking book sales, customer orders, and inventory management using SQL queries.

## Objectives
✅ Efficiently store and manage books, customers, and orders.

✅ Perform data analysis using SQL queries to extract meaningful insights.

✅ Retrieve key business metrics such as revenue, book sales, and customer behavior.

✅ Use advanced SQL functions like JOIN, GROUP BY, HAVING, DENSE_RANK(), and CTE.

## Database Schema

1️⃣ **Books Table**

Stores information about books available in the store.

```sql
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
     Book_ID INT PRIMARY KEY,
	 Title VARCHAR(100),
	 Author VARCHAR (100),
	 Genre VARCHAR(50),
	 Published_Year INT,
	 Price FLOAT,
	 Stock INT
);
```
2️⃣ **Customers Table**

Stores customer details, including their contact and location information.

```sql
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
     Customer_ID INT PRIMARY KEY,
	 Name VARCHAR(100),
	 Email VARCHAR(100),
	 Phone VARCHAR (15),
	 City VARCHAR(50),
	 Country VARCHAR(150)
);
```
3️⃣ **Orders Table**

Stores details of book purchases, linking books and customers through foreign keys.
```sql

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
     Order_ID INT PRIMARY KEY,
	 Customer_ID INT REFERENCES Customers(Customer_ID),
	 Book_ID INT REFERENCES Books(Book_ID),
	 Order_Date	DATE,
	 Quantity INT,
	 Total_Amount FLOAT
);
```

## SQL Queries and Insights

 ### 1) Retrieve all books in the "Fiction" genre:
 ```sql
SELECT * FROM Books
WHERE genre = 'Fiction';
```

### 2) Find books published after the year 1950:
```sql
SELECT * FROM Books
WHERE published_year > 1950;
```

### 3) List all customers from the Canada:
```sql
SELECT * FROM Customers
WHERE country = 'Canada';
```

### 4) Show orders placed in November 2023:
```sql
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'
```


### 5) Retrieve the total stock of books available:
```sql
SELECT
SUM(stock) as total_stock
FROM Books
```

### 6) Find the details of the most expensive book:
```sql
SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;
 ```
### 7) Show all customers who ordered more than 1 quantity of a book:
```sql
SELECT * FROM Orders
WHERE quantity >1;
```



### 8) Show the top 3 most expensive books of 'Fantasy' Genre :
```sql
SELECT * FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3
```
[click here to see complete SQL queries](https://github.com/sindhujak785/Online_Book_Store_SQL-Project/blob/main/Bookstore.sql)

 ## Key Takeaways
 
✔ Hands-on experience with SQL database design and query writing.

✔ Real-world application in an e-commerce environment.

✔ Uses essential SQL functions like JOIN, AGGREGATE FUNCTIONS, ORDER BY, GROUP BY, and CTEs.

✔ Helps in inventory management, revenue analysis, and customer behavior tracking.















