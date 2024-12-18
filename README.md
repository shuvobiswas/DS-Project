### Project Documentation: Online Bookstore App

This is an online bookstore application that integrates a Flutter frontend with a Node.js backend to interact with an Oracle database. The system is designed to manage authors, books, customers, purchases, and purchase items.

### Database Schema

The application uses the following database schema with Oracle for data storage:

#### **ER Diagram**
![ERD](https://github.com/user-attachments/assets/afbe7cf9-6978-4bd9-a17a-20432bab622b)


#### 1. **Authors Table**

- **Table Name**: `Authors`
- **Fields**:
  - `AuthorID` (Primary Key): Unique identifier for each author (Integer)
  - `Name`: Author's name (String, 255 characters max)
  - `Contact`: Author's contact details (String, 255 characters max)

```sql
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Contact VARCHAR2(255)
);
```

#### 2. **Books Table**

- **Table Name**: `Books`
- **Fields**:
  - `BookID` (Primary Key): Unique identifier for each book (Integer)
  - `Title`: Title of the book (String, 255 characters max)
  - `Genre`: Genre of the book (String, 100 characters max)
  - `PublicationDate`: Date when the book was published (Date)
  - `StockQuantity`: Quantity of the book in stock (Integer)
  - `AuthorID` (Foreign Key): Links to `Authors` table (Integer)

```sql
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR2(255) NOT NULL,
    Genre VARCHAR2(100),
    PublicationDate DATE,
    StockQuantity INT,
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);
```

#### 3. **Customers Table**

- **Table Name**: `Customers`
- **Fields**:
  - `CustomerID` (Primary Key): Unique identifier for each customer (Integer)
  - `Name`: Customer's name (String, 255 characters max)
  - `Email`: Customer's email (String, 255 characters max, unique)
  - `Phone`: Customer's phone number (String, 20 characters max)

```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR2(255) NOT NULL,
    Email VARCHAR2(255) NOT NULL UNIQUE,
    Phone VARCHAR2(20)
);
```

#### 4. **Purchases Table**

- **Table Name**: `Purchases`
- **Fields**:
  - `PurchaseID` (Primary Key): Unique identifier for each purchase (Integer)
  - `CustomerID` (Foreign Key): Links to `Customers` table (Integer)
  - `PurchaseDate`: Date when the purchase was made (Date)

```sql
CREATE TABLE Purchases (
    PurchaseID INT PRIMARY KEY,
    CustomerID INT,
    PurchaseDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

#### 5. **PurchaseItems Table**

- **Table Name**: `PurchaseItems`
- **Fields**:
  - `PurchaseItemID` (Primary Key): Unique identifier for each purchase item (Integer)
  - `PurchaseID` (Foreign Key): Links to `Purchases` table (Integer)
  - `BookID` (Foreign Key): Links to `Books` table (Integer)

```sql
CREATE TABLE PurchaseItems (
    PurchaseItemID INT PRIMARY KEY,
    PurchaseID INT,
    BookID INT,
    FOREIGN KEY (PurchaseID) REFERENCES Purchases(PurchaseID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);
```

### Backend Implementation with Node.js

The backend of the application is built using Node.js, which serves as a middleware to interact with the Oracle database. Node.js is responsible for handling HTTP requests, processing data, and interacting with the database.

#### Setup

1. **Install Dependencies**: 
   To interact with Oracle, we use the `oracledb` Node.js module.
   
   ```bash
   npm install oracledb
   ```

2. **Database Connection**:
   Configure the database connection in Node.js by providing the connection credentials.

   ```js
   const oracledb = require('oracledb');

   async function connectToDB() {
     let connection;
     try {
       connection = await oracledb.getConnection({
         user: "your_username",
         password: "your_password",
         connectString: "localhost:1521/ORCL"
       });
       console.log('Connected to Oracle DB');
     } catch (err) {
       console.error('Error connecting to Oracle DB:', err);
     }
     return connection;
   }
   ```

3. **API Endpoints**:
   Create routes to handle CRUD operations for authors, books, customers, purchases, and purchase items.

   ```js
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/authors', async (req, res) => {
     const connection = await connectToDB();
     const result = await connection.execute('SELECT * FROM Authors');
     res.send(result.rows);
   });

   app.get('/books', async (req, res) => {
     const connection = await connectToDB();
     const result = await connection.execute('SELECT * FROM Books');
     res.send(result.rows);
   });

   app.listen(port, () => {
     console.log(`Server running on http://localhost:${port}`);
   });
   ```

4. **Fetch Data from Database**:
   Use the `oracledb` connection to fetch data from the database in response to API requests.

### Flutter Frontend Implementation

The frontend is built using Flutter to interact with the Node.js backend. The app displays authors, books, and allows customers to make purchases.

1. **Fetching Data**:
   Use the `http` package to fetch data from the Node.js backend.

   ```dart
   import 'package:http/http.dart' as http;
   import 'dart:convert';

   Future<List<Author>> fetchAuthors() async {
     final response = await http.get(Uri.parse('http://localhost:3000/authors'));
     if (response.statusCode == 200) {
       List<dynamic> data = jsonDecode(response.body);
       return data.map((author) => Author.fromJson(author)).toList();
     } else {
       throw Exception('Failed to load authors');
     }
   }
   ```

2. **Displaying Authors**:
   Use `FutureBuilder` to display authors when the data is fetched.

   ```dart
   class AuthorListScreen extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return FutureBuilder<List<Author>>(
         future: fetchAuthors(),
         builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return Center(child: CircularProgressIndicator());
           } else if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
             return Center(child: Text('No authors found'));
           } else {
             return ListView.builder(
               itemCount: snapshot.data!.length,
               itemBuilder: (context, index) {
                 final author = snapshot.data![index];
                 return ListTile(
                   title: Text(author.name),
                   subtitle: Text(author.contact),
                 );
               },
             );
           }
         },
       );
     }
   }
   ```

3. **Making Purchases**:
   Add functionality for customers to place orders and purchase books, which updates the `Purchases` and `PurchaseItems` tables in the database.

### Conclusion

This application allows users to browse books, view author details, and place orders. The frontend in Flutter communicates with the Node.js backend, which manages CRUD operations for authors, books, customers, and purchases using Oracle as the database. This architecture provides a full-stack solution for an online bookstore.

### overview of the Project

![authors with oracle](https://github.com/user-attachments/assets/01eff0b0-fcfa-4e94-88da-85df759b83ce)

![book with oracle](https://github.com/user-attachments/assets/8dc26b70-2dbf-43e0-b71f-077eab6a3a6e)


![nodejsandflutter](https://github.com/user-attachments/assets/4facd02e-b1cc-4710-b17f-a9a25f3f28cd)

