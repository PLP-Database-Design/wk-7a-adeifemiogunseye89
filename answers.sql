Question 
-- An SQL query that normalise productDetails table into 1NF

WITH SplitProducts AS (
    SELECT 
        OrderID, 
        CustomerName, 
        TRIM(value) AS Product
    FROM ProductDetail
    CROSS APPLY STRING_SPLIT(Products, ',')
)
SELECT * FROM SplitProducts;

Question 2
-- An SQL query to transform partially 1Nf table into 2NF by removing partial dependencies. Ensure that each non-key column fully depends on the entire primary key.

-- create a table for Order with order deatails
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL
);

-- insert properties and values into the distinct order and customerName tables 
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- create the OrderDetails distinct and independent from the customersNames table
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- insert values into the OrderDetails in the 2 normalised form (2NF)
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
