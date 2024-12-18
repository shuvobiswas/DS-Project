const express = require('express');
const bodyParser = require('body-parser');
const oracledb = require('oracledb');
const cors = require('cors');

const app = express();
const port = 5000;

app.use(bodyParser.json());
app.use(cors());

// Oracle DB connection config
const dbConfig = {
    user: 'sys',
    password: 'admin',  
    connectString: 'localhost/XE',
    privilege: oracledb.SYSDBA 
};

// API: Get all authors
app.get('/authors', async (req, res) => {
    try {
        const connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(`SELECT * FROM Authors`);
        res.json(result.rows);
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching authors');
    }
});

// API: Add an author
app.post('/authors', async (req, res) => {
    const { AuthorID, Name, Contact } = req.body;
    try {
        const connection = await oracledb.getConnection(dbConfig);
        await connection.execute(
            `INSERT INTO Authors (AuthorID, Name, Contact) VALUES (:AuthorID, :Name, :Contact)`,
            [AuthorID, Name, Contact],
            { autoCommit: true }
        );
        res.send('Author added successfully');
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error adding author');
    }
});

// API: Get all books
app.get('/books', async (req, res) => {
    try {
        const connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(`SELECT * FROM Books`);
        res.json(result.rows);
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching books');
    }
});

// API: Add a book
app.post('/books', async (req, res) => {
    const { BookID, Title, Genre, PublicationDate, StockQuantity, AuthorName, AuthorContact } = req.body;

    if (!BookID || !Title || !PublicationDate || !StockQuantity || !AuthorName) {
        return res.status(400).send('Missing required fields');
    }

    try {
        const connection = await oracledb.getConnection(dbConfig);

        // Check if AuthorName exists in the Authors table
        const authorCheck = await connection.execute(
            `SELECT AuthorID FROM Authors WHERE Name = :AuthorName`,
            [AuthorName]
        );

        let AuthorID;

        if (authorCheck.rows.length > 0) {
            // Author exists, get the AuthorID
            AuthorID = authorCheck.rows[0][0];
        } else {
            // Author does not exist, generate a new AuthorID
            const newAuthorIDResult = await connection.execute(
                `SELECT NVL(MAX(AuthorID), 0) + 1 AS NewAuthorID FROM Authors`
            );
            AuthorID = newAuthorIDResult.rows[0][0];

            // Insert the new author into the Authors table
            await connection.execute(
                `INSERT INTO Authors (AuthorID, Name, Contact) VALUES (:AuthorID, :AuthorName, :AuthorContact)`,
                [AuthorID, AuthorName, AuthorContact || null],
                { autoCommit: true }
            );
        }

        // Insert the book into the Books table
        await connection.execute(
            `INSERT INTO Books (BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID) 
             VALUES (:BookID, :Title, :Genre, TO_DATE(:PublicationDate, 'YYYY-MM-DD'), :StockQuantity, :AuthorID)`,
            [BookID, Title, Genre, PublicationDate, StockQuantity, AuthorID],
            { autoCommit: true }
        );

        res.send('Book and author added successfully');
        await connection.close();
    } catch (err) {
        console.error('Error details:', err);
        res.status(500).send(err.message);
    }
});


// API: Get all customers
app.get('/customers', async (req, res) => {
    try {
        const connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(`SELECT * FROM Customers`);
        res.json(result.rows);
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching customers');
    }
});

// API: Add a customer
app.post('/customers', async (req, res) => {
    const { CustomerID, Name, Email, Phone } = req.body;
    try {
        const connection = await oracledb.getConnection(dbConfig);
        await connection.execute(
            `INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES (:CustomerID, :Name, :Email, :Phone)`,
            [CustomerID, Name, Email, Phone],
            { autoCommit: true }
        );
        res.send('Customer added successfully');
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error adding customer');
    }
});

// API: Get all purchases
app.get('/purchases', async (req, res) => {
    try {
        const connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(`SELECT * FROM Purchases`);
        res.json(result.rows);
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching purchases');
    }
});

// API: Add a purchase
app.post('/purchases', async (req, res) => {
    const { PurchaseID, CustomerID, PurchaseDate } = req.body;
    try {
        const connection = await oracledb.getConnection(dbConfig);
        await connection.execute(
            `INSERT INTO Purchases (PurchaseID, CustomerID, PurchaseDate) 
             VALUES (:PurchaseID, :CustomerID, TO_DATE(:PurchaseDate, 'YYYY-MM-DD'))`,
            [PurchaseID, CustomerID, PurchaseDate],
            { autoCommit: true }
        );
        res.send('Purchase added successfully');
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error adding purchase');
    }
});

// API: Get all purchase items
app.get('/purchase-items', async (req, res) => {
    try {
        const connection = await oracledb.getConnection(dbConfig);
        const result = await connection.execute(`SELECT * FROM PurchaseItems`);
        res.json(result.rows);
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error fetching purchase items');
    }
});

// API: Add a purchase item
app.post('/purchase-items', async (req, res) => {
    const { PurchaseItemID, PurchaseID, BookID } = req.body;
    try {
        const connection = await oracledb.getConnection(dbConfig);
        await connection.execute(
            `INSERT INTO PurchaseItems (PurchaseItemID, PurchaseID, BookID) 
             VALUES (:PurchaseItemID, :PurchaseID, :BookID)`,
            [PurchaseItemID, PurchaseID, BookID],
            { autoCommit: true }
        );
        res.send('Purchase item added successfully');
        await connection.close();
    } catch (err) {
        console.error(err);
        res.status(500).send('Error adding purchase item');
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});
