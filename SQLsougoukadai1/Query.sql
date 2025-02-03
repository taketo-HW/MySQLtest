-- 1. 全ユーザーの情報を取得する
SELECT * FROM users;
-- mysql> SELECT * FROM users;
-- +----+---------------+----------------------+---------------------+---------------------+
-- | id | name          | email                | created_at          | updated_at          |
-- +----+---------------+----------------------+---------------------+---------------------+
-- |  1 | Taro Tanaka   | tanaka@example.com   | 2025-01-30 15:13:24 | 2025-01-30 15:13:24 |
-- |  2 | Hanako Sato   | sato@example.com     | 2025-01-30 15:13:24 | 2025-01-30 15:13:24 |
-- |  3 | Jiro Yamamoto | yamamoto@example.com | 2025-01-30 15:13:24 | 2025-01-30 15:13:24 |
-- +----+---------------+----------------------+---------------------+---------------------+
-- 3 rows in set (0.00 sec)

-- 2. すべての商品とその在庫を取得する
SELECT name, stock FROM products;
-- mysql> SELECT name, stock FROM products;
-- +------------+-------+
-- | name       | stock |
-- +------------+-------+
-- | Laptop     |    20 |
-- | Smartphone |    15 |
-- | Tablet     |    30 |
-- | Laptop     |    20 |
-- | Smartphone |    15 |
-- | Tablet     |    30 |
-- +------------+-------+
-- 6 rows in set (0.00 sec)

-- 3. 注文履歴をユーザー名, 商品名, 購入数量の形式で取得する
SELECT 
    u.name AS user_name, 
    p.name AS product_name, 
    o.quantity 
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN products p ON o.product_id = p.id;
-- mysql> SELECT u.name AS user_name, p.name AS product_name, o.quantity FROM orders o JOIN users u ON o.user_id = u.id JOIN products p ON o.product_id = p.id;
-- +---------------+--------------+----------+
-- | user_name     | product_name | quantity |
-- +---------------+--------------+----------+
-- | Taro Tanaka   | Laptop       |        2 |
-- | Hanako Sato   | Smartphone   |        1 |
-- | Jiro Yamamoto | Tablet       |        3 |
-- +---------------+--------------+----------+
-- 3 rows in set (0.00 sec)

-- 4. 在庫が不足している商品を取得する（在庫が10以下）
SELECT * FROM products WHERE stock <= 10;
-- mysql> SELECT * FROM products WHERE stock <= 10;
-- Empty set (0.00 sec)

-- 5. 各商品の累計売上を計算して取得する
SELECT 
    p.name AS product_name, 
    SUM(o.quantity) AS total_sold, 
    SUM(o.quantity * p.price) AS total_revenue 
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.name;
-- mysql> SELECT p.name AS product_name, SUM(o.quantity) AS total_sold, SUM(o.quantity * p.price) AS total_revenue FROM orders o JOIN products p ON o.product_id = p.id GROUP BY p.name;
-- +--------------+------------+---------------+
-- | product_name | total_sold | total_revenue |
-- +--------------+------------+---------------+
-- | Laptop       |          2 |        240000 |
-- | Smartphone   |          1 |         80000 |
-- | Tablet       |          3 |        180000 |
-- +--------------+------------+---------------+
-- 3 rows in set (0.00 sec)