-- Insert data into Authors table
INSERT INTO Authors (AuthorID, Name, Contact) VALUES (1, 'Mohammad Ali', 'mohammad.ali@example.com');
INSERT INTO Authors (AuthorID, Name, Contact) VALUES (2, 'John Doe', 'john.doe@example.com');
INSERT INTO Authors (AuthorID, Name, Contact) VALUES (3, 'Jane Smith', 'jane.smith@example.com');
INSERT INTO Authors (AuthorID, Name, Contact) VALUES (4, 'MD Salman', 'md.salman@example.com');
INSERT INTO Authors (AuthorID, Name, Contact) VALUES (5, 'MD Rupom', 'md.Rupom@example.com');

SELECT * FROM Authors;

-- Insert data into Books table
INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) VALUES (1, 'Book One', 'Fiction', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 10, 1);
INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) VALUES (2, 'Book Two', 'Non-Fiction', TO_DATE('2023-12-10', 'YYYY-MM-DD'), 5, 2);
INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) VALUES (3, 'Book Three', 'Fantasy', TO_DATE('2024-05-20', 'YYYY-MM-DD'), 3, 3);
INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) VALUES (4, 'Book Four', 'Science Fiction', TO_DATE('2024-01-10', 'YYYY-MM-DD'), 7, 4);
INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) VALUES (5, 'Book Five', 'Mystery', TO_DATE('2022-11-05', 'YYYY-MM-DD'), 7, 1);
INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) VALUES (6, 'Book Five', 'Mystery', TO_DATE('2022-09-05', 'YYYY-MM-DD'), 2, 1);

SELECT * FROM Books;

-- Insert data into Customers table
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES(1, 'Alice Johnson', 'alice.johnson@example.com', '018-3456-7890');
INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES(2, 'Returaj Proshad', 'returajsumon0808@gmail.com', '017-9760-2810');

SELECT * FROM Customers;

-- Insert data into Purchases table
INSERT INTO Purchases (PurchaseID, CustomerID, PurchaseDate) VALUES (1, 1, TO_DATE ('2024-02-15','YYYY-MM-DD'));
INSERT INTO Purchases (PurchaseID, CustomerID, PurchaseDate) VALUES (2, 2,TO_DATE ('2024-03-10','YYYY-MM-DD') );

SELECT * FROM Purchases;


-- Insert data into PurchaseItems table
INSERT INTO PurchaseItems (PurchaseItemID, PurchaseID, BookID) VALUES (1, 1, 1);
INSERT INTO PurchaseItems (PurchaseItemID, PurchaseID, BookID) VALUES (2, 2, 3);

SELECT * FROM PurchaseItems;