CREATE DATABASE LibraryDB;

USE LibraryDB;

-- Authors table (One author can write many books)
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    UNIQUE(FirstName, LastName)
);

-- Books table (Each book has one author, assuming simplified model)
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorID INT NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    PublishedYear YEAR,
    CopiesAvailable INT DEFAULT 0,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Members table (Library members who borrow books)
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    MembershipDate DATE NOT NULL
);

-- Loans table (Many-to-many relationship between Members and Books through Loans)
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnedDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CONSTRAINT UC_Loan UNIQUE (MemberID, BookID, LoanDate) -- prevent double loans of same book on same date by same member
);

-- Optional: Categories table (Books can belong to multiple categories, many-to-many relationships)
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);

-- BookCategory join table for many-to-many between Books and Categories
CREATE TABLE BookCategories (
    BookID INT NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);






