
CREATE DATABASE Restaurant_System;
USE Restaurant_System;
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    contact_no VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Menu (
    menu_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(8,2) NOT NULL
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (menu_id) REFERENCES Menu(menu_id)
);

CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    bill_date DATE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id)
);
INSERT INTO Customer (customer_name, contact_no) VALUES
('Amit Sharma','9123456789'),
('Priya Verma','9234567890'),
('Rahul Mehta','9345678901'),
('Sneha Patil','9456789012'),
('Karan Singh','9567890123');
SELECT * FROM Customer;
INSERT INTO Menu (item_name, price) VALUES
('Veg Burger',80),
('Cheese Pizza',200),
('Pasta',150),
('Paneer Thali',180),
('Masala Dosa',90);
SELECT * FROM Menu;
INSERT INTO Orders (customer_id, order_date) VALUES
(1,'2026-02-20'),
(2,'2026-02-21'),
(3,'2026-02-22'),
(4,'2026-02-23'),
(5,'2026-02-24');
SELECT * FROM Orders;
INSERT INTO Order_Details (order_id, menu_id, quantity) VALUES
(1,1,2),
(2,2,1),
(3,3,3),
(4,4,2),
(5,5,1);
SELECT * FROM Order_Details;
INSERT INTO Billing (order_id, total_amount, bill_date)
SELECT 
    od.order_id,
    SUM(m.price * od.quantity),
    '2026-03-05'
FROM Order_Details od
JOIN Menu m ON od.menu_id = m.menu_id
GROUP BY od.order_id;
SELECT * FROM Billing;
INSERT INTO Payment (bill_id, payment_method, payment_status) VALUES
(1,'Cash','Paid'),
(2,'Online','Paid'),
(3,'Card','Paid'),
(4,'Cash','Paid'),
(5,'Online','Paid');
SELECT * FROM Payment;
SELECT 
    b.bill_id,
    c.customer_name,
    m.item_name,
    od.quantity,
    m.price,
    b.total_amount,
    p.payment_method
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Menu m ON od.menu_id = m.menu_id
JOIN Billing b ON o.order_id = b.order_id
JOIN Payment p ON b.bill_id = p.bill_id;

