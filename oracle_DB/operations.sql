--a. Display a list of 20 latest published in-stock book titles of the store.
SELECT Title
FROM Books
WHERE StockQuantity > 0
ORDER BY PublicationDate DESC
FETCH FIRST 20 ROWS ONLY;

--b. Retrieve a list of all purchases since January 01, 2024.
SELECT PurchaseID, CustomerID, PurchaseDate
FROM Purchases
WHERE PurchaseDate >= TO_DATE('2024-01-01', 'YYYY-MM-DD');

--c. List down all the authors in the database who have “Mohammad” or “MD” at the beginning of their name, sorted by the names (alphabetically).
SELECT Name
FROM Authors
WHERE Name LIKE 'Mohammad%' OR Name LIKE 'MD%'
ORDER BY Name ASC;
