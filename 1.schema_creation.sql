CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    room_number VARCHAR(10)
);


CREATE TABLE categories(
    id INT PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    warning_days INT DEFAULT 3
);



CREATE TABLE ingredients (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    expiration_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT '정상',
    user_id INT,
    category_id INT,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KET (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);


CREATE TABLE refrigerator_logs(
    id INT PRIMARY KEY,
    ingredient_id INT,
    user_id INT,
    action_type VARCHAR(20) NOT NULL,
    logged_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);