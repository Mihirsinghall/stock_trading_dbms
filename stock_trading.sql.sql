-- Database Creation
CREATE DATABASE IF NOT EXISTS stock_trading;
USE stock_trading;

-- USERS TABLE
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ACCOUNTS TABLE
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- STOCKS TABLE
CREATE TABLE stocks (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    ticker_symbol VARCHAR(10) NOT NULL UNIQUE,
    current_price DECIMAL(10,2) NOT NULL,
    market_cap BIGINT
);

-- TRADES TABLE
CREATE TABLE trades (
    trade_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    stock_id INT NOT NULL,
    trade_type ENUM('BUY','SELL') NOT NULL,
    quantity INT NOT NULL,
    trade_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id) ON DELETE CASCADE
);

-- PORTFOLIOS TABLE
CREATE TABLE portfolios (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    stock_id INT NOT NULL,
    quantity INT DEFAULT 0,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (stock_id) REFERENCES stocks(stock_id) ON DELETE CASCADE,
    UNIQUE (account_id, stock_id)
);

-- Sample Data
INSERT INTO users (name, email, phone)
VALUES 
('Rahul Sharma', 'rahul@example.com', '9876543210'),
('Amit Verma', 'amit@example.com', '9123456780');

INSERT INTO accounts (user_id, balance)
VALUES
(1, 100000),
(2, 50000);

INSERT INTO stocks (company_name, ticker_symbol, current_price, market_cap)
VALUES
('Tata Consultancy Services', 'TCS', 3500, 1200000000000),
('Infosys', 'INFY', 1500, 600000000000);

INSERT INTO trades (account_id, stock_id, trade_type, quantity)
VALUES (1, 1, 'BUY', 10),
       (1, 2, 'BUY', 5);

INSERT INTO portfolios (account_id, stock_id, quantity)
VALUES (1, 1, 10),
       (1, 2, 5);