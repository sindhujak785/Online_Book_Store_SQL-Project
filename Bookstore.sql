--Create Tables
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
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
     Customer_ID INT PRIMARY KEY,
	 Name VARCHAR(100),
	 Email VARCHAR(100),
	 Phone VARCHAR (15),
	 City VARCHAR(50),
	 Country VARCHAR(150)
);
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
     Order_ID INT PRIMARY KEY,
	 Customer_ID INT REFERENCES Customers(Customer_ID),
	 Book_ID INT REFERENCES Books(Book_ID),
	 Order_Date	DATE,
	 Quantity INT,
	 Total_Amount FLOAT
);


-- 1) Retrieve all books in the "Fiction" genre:
SELECT * FROM Books
WHERE genre = 'Fiction';

-- 2) Find books published after the year 1950:
SELECT * FROM Books
WHERE published_year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM Customers
WHERE country = 'Canada';

-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'


-- 5) Retrieve the total stock of books available:
SELECT
SUM(stock) as total_stock
FROM Books

-- 6) Find the details of the most expensive book:

SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders
WHERE quantity >1;


-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders 
WHERE total_amount > 20;


-- 9) List all genres available in the Books table:
SELECT DISTINCT genre
FROM Books;


-- 10) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3


-- 11) Calculate the total revenue generated from all orders:
SELECT 
   SUM(total_amount)as Revenue
FROM orders;


-- 12) Retrieve the total number of books sold for each genre:
SELECT b.genre,SUM(o.quantity)AS no_of_books_sold
FROM Orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;


-- 13) Find the average price of books in the "Fantasy" genre:
SELECT
    AVG(price)AS avg_price
FROM books
WHERE genre = 'Fantasy';

-- 14) List customers who have placed at least 2 orders:
SELECT
    c.customer_id,
	c.name, 
	COUNT(o.order_id)AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.name
HAVING COUNT(order_id)>=2;


-- 15) Find the most frequently ordered book:
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

-- 16) Find the book with the lowest stock:
SELECT book_id, title, stock
FROM
  (SELECT *,
   dense_rank()over(order by stock)AS dense_rank
   FROM Books )
WHERE dense_rank = 1;


-- 17) Retrieve the total quantity of books sold by each author:
SELECT 
    b.author,
	SUM(o.quantity)AS Total_books_sold
FROM books b
JOIN orders o ON o.book_id= b.book_id
GROUP BY b.author
	

-- 18) List the cities where customers who spent over $30 are located:
SELECT 
    c.city ,
    o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE total_amount>30 


-- 19) Find the customer who spent the most on orders:
SELECT
     c.customer_id ,
     c.name, 
     SUM(o.total_amount)AS Total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id ,c.name
ORDER BY Total_spent DESC
LIMIT 1;


--20) Calculate the stock remaining after fulfilling all orders:
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












