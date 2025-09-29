DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS bank;
DROP TABLE IF EXISTS account;

create TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    admin BOOLEAN DEFAULT 0
);

create TABLE bank(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

create TABLE account(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    bank_id INTEGER NOT NULL,
    balance REAL DEFAULT 0,
    name TEXT,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (bank_id) REFERENCES bank(id)
);

INSERT INTO user (username, password, admin) 
VALUES ('ADMIN', 'scrypt:32768:8:1$Wreg2E6JfYdPmXAh$0c01b1acc08bf78c48e6c2f6ce1bdbb974d280580f3ebab244be2f17338c57190c9f217ae1fbcc070c3bb3829729634a1301b1fa051d39d111dfd48e71de6b43', 1);

INSERT INTO bank (name) 
VALUES ('Tangerine'), ('RBC'), ('Desjardins'), ('Scotiabank'), ('BMO'), ('TD'), ('HSBC'), ('National Bank');

INSERT INTO account (user_id, bank_id, balance, name)
VALUES (1, 1, 1000.00, 'Savings'), (1, 2, 500.00, 'Checking');