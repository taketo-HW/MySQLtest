-- usersテーブル
INSERT INTO users (name, email) VALUES
('Taro Tanaka', 'tanaka@example.com'),
('Hanako Sato', 'sato@example.com'),
('Jiro Yamamoto', 'yamamoto@example.com');

-- Query OK, 3 rows affected (0.02 sec)
-- Records: 3  Duplicates: 0  Warnings: 0

-- productsテーブル
INSERT INTO products (name, price, stock) VALUES
('Laptop', 120000, 20),
('Smartphone', 80000, 15),
('Tablet', 60000, 30);

-- Query OK, 3 rows affected (0.02 sec)
-- Records: 3  Duplicates: 0  Warnings: 0

-- ordersテーブル
INSERT INTO orders (user_id, product_id, quantity)
VALUES
((SELECT id FROM users WHERE name = 'Taro Tanaka'), (SELECT id FROM products WHERE name = 'Laptop'), 2),
((SELECT id FROM users WHERE name = 'Hanako Sato'), (SELECT id FROM products WHERE name = 'Smartphone'), 1),
((SELECT id FROM users WHERE name = 'Jiro Yamamoto'), (SELECT id FROM products WHERE name = 'Tablet'), 3);

-- Query OK, 3 rows affected (0.01 sec)
-- Records: 3  Duplicates: 0  Warnings: 0