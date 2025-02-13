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


### 8) Retrieve all orders where the total amount exceeds $20:
```sql
SELECT * FROM Orders 
WHERE total_amount > 20;
```
### 9) List all genres available in the Books table:
```sql
SELECT DISTINCT genre
FROM Books;
```
### 10) Show the top 3 most expensive books of 'Fantasy' Genre :
```sql
SELECT * FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3
```

### 11) Calculate the total revenue generated from all orders:
```sql
SELECT 
   SUM(total_amount)as Revenue
FROM orders;
```


### 12) Retrieve the total number of books sold for each genre:
```sql
SELECT b.genre,SUM(o.quantity)AS no_of_books_sold
FROM Orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;
```
### 13) Find the average price of books in the "Fantasy" genre:
```sql
SELECT
    AVG(price)AS avg_price
FROM books
WHERE genre = 'Fantasy';
```
### 14) List customers who have placed at least 2 orders:
```sql
SELECT
    c.customer_id,
	c.name, 
	COUNT(o.order_id)AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.name
HAVING COUNT(order_id)>=2;
```

### 15) Find the most frequently ordered book:
```sql
WITH CTE AS
(SELECT 
    o.book_id,
	b.title,
	COUNT(o.order_id)as order_count,
	DENSE_RANK()OVER (ORDER BY COUNT(o.order_id)DESC)AS dense_rank
FROM books b
JOIN orders o
ON b.book_id =o.book_id
GROUP BY o.book_id,b.title)
SELECT
   book_id,
   title,
   order_count
FROM CTE
WHERE dense_rank = 1
```
### 16) Find the book with the lowest stock:
```sql
SELECT book_id, title, stock
FROM
  (SELECT *,
   dense_rank()over(order by stock)AS dense_rank
   FROM Books )
WHERE dense_rank = 1;
```


### 17) Retrieve the total quantity of books sold by each author:
```sql
SELECT 
    b.author,
	SUM(o.quantity)AS Total_books_sold
FROM books b
JOIN orders o ON o.book_id= b.book_id
GROUP BY b.author
```

### 18) List the cities where customers who spent over $30 are located:
```sql
SELECT 
    c.city ,
    o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE total_amount>30 
```

### 19) Find the customer who spent the most on orders:
```sql
SELECT
     c.customer_id ,
     c.name, 
     SUM(o.total_amount)AS Total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id ,c.name
ORDER BY Total_spent DESC
LIMIT 1;
```

### 20) Calculate the stock remaining after fulfilling all orders:
```sql
SELECT
   b.book_id,  
   b.title, 
   b.stock,
   COALESCE(SUM(o.quantity),0)AS order_quantity,
   b.stock-COALESCE(SUM(o.quantity),0)AS remaining_quantity
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;
```

 ## Key Takeaways
 
✔ Hands-on experience with SQL database design and query writing.

✔ Real-world application in an e-commerce environment.

✔ Uses essential SQL functions like JOIN, AGGREGATE FUNCTIONS, ORDER BY, GROUP BY, and CTEs.

✔ Helps in inventory management, revenue analysis, and customer behavior tracking.















