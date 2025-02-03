-- 1. 全社員の情報を取得する。
SELECT * FROM employees;
-- +----+--------------+--------------------+--------+---------------------+---------------------+
-- | id | name         | position           | salary | created_at          | updated_at          |
-- +----+--------------+--------------------+--------+---------------------+---------------------+
-- |  1 | 山田太郎     | マネージャー       | 700000 | 2025-01-31 05:08:30 | 2025-01-31 05:08:30 |
-- |  2 | 佐藤花子     | エンジニア         | 500000 | 2025-01-31 05:08:30 | 2025-01-31 05:08:30 |
-- |  3 | 鈴木次郎     | エンジニア         | 500000 | 2025-01-31 05:08:30 | 2025-01-31 05:08:30 |
-- +----+--------------+--------------------+--------+---------------------+---------------------+
-- 3 rows in set (0.00 sec)
-- 2. プロジェクトごとの割り当て時間の合計を取得する。
SELECT 
    p.name AS プロジェクト名, 
    SUM(a.hours) AS 合計作業時間
FROM assignments a
JOIN projects p ON a.project_id = p.id
GROUP BY p.name;
-- +-----------------------------+--------------------+
-- | プロジェクト名              | 合計作業時間       |
-- +-----------------------------+--------------------+
-- | 新製品開発                  |                250 |
-- | マーケティング戦略          |                200 |
-- +-----------------------------+--------------------+cd
-- 2 rows in set (0.00 sec)

-- 3. 社員ごとの担当プロジェクト名と作業時間を取得する。
SELECT 
    e.name AS 社員名, 
    p.name AS プロジェクト名, 
    a.hours AS 作業時間
FROM assignments a
JOIN employees e ON a.employee_id = e.id
JOIN projects p ON a.project_id = p.id;
-- +--------------+-----------------------------+--------------+
-- | 社員名       | プロジェクト名              | 作業時間     |
-- +--------------+-----------------------------+--------------+
-- | 山田太郎     | 新製品開発                  |          100 |
-- | 佐藤花子     | 新製品開発                  |          150 |
-- | 鈴木次郎     | マーケティング戦略          |          200 |
-- +--------------+-----------------------------+--------------+
-- 3 rows in set (0.00 sec)

-- 4. 作業時間が100時間以上の割り当てを取得する。
SELECT 
    e.name AS 社員名, 
    p.name AS プロジェクト名, 
    a.hours AS 作業時間
FROM assignments a
JOIN employees e ON a.employee_id = e.id
JOIN projects p ON a.project_id = p.id
WHERE a.hours >= 100;
-- +--------------+-----------------------------+--------------+
-- | 社員名       | プロジェクト名              | 作業時間     |
-- +--------------+-----------------------------+--------------+
-- | 山田太郎     | 新製品開発                  |          100 |
-- | 佐藤花子     | 新製品開発                  |          150 |
-- | 鈴木次郎     | マーケティング戦略          |          200 |
-- +--------------+-----------------------------+--------------+
-- 3 rows in set (0.00 sec)

-- 5. 各プロジェクトの予算に対する作業時間あたりのコストを計算して取得する。
SELECT 
    p.name AS プロジェクト名, 
    p.budget AS 予算, 
    SUM(a.hours) AS 合計作業時間, 
    (p.budget / SUM(a.hours)) AS 時間あたりのコスト
FROM assignments a
JOIN projects p ON a.project_id = p.id
GROUP BY p.name, p.budget;
-- +-----------------------------+----------+--------------------+-----------------------------+
-- | プロジェクト名              | 予算     | 合計作業時間       | 時間あたりのコスト          |
-- +-----------------------------+----------+--------------------+-----------------------------+
-- | 新製品開発                  | 10000000 |                250 |                  40000.0000 |
-- | マーケティング戦略          |  5000000 |                200 |                  25000.0000 |
-- +-----------------------------+----------+--------------------+-----------------------------+
-- 2 rows in set (0.00 sec)
