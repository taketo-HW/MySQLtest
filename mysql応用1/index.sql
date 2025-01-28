
--SELECT文: 全データ取得
SELECT *FROM EMPLOYEE;
-- mysql> SELECT *FROM EMPLOYEE;
-- +----+---------+-----+---------------+--------+---------------+
-- | id | name    | age | job           | sal    | department_id |
-- +----+---------+-----+---------------+--------+---------------+
-- |  1 | matuda  |  65 | shatyo        | 950000 |             1 |
-- |  2 | yamada  |  43 | butyo         | 680000 |             2 |
-- |  3 | kitajou |  30 | eigyoumanager | 600000 |             3 |
-- |  4 | sato    |  28 | engineer      | 500000 |             2 |
-- |  5 | suzuki  |  35 | engineer      | 550000 |             2 |
-- +----+---------+-----+---------------+--------+---------------+

--特定の列を取得
SELECT NAME, SAL FROM EMPLOYEE;
-- mysql> SELECT NAME, SAL FROM EMPLOYEE;
-- +---------+--------+
-- | NAME    | SAL    |
-- +---------+--------+
-- | matuda  | 950000 |
-- | yamada  | 680000 |
-- | kitajou | 600000 |
-- | sato    | 500000 |
-- | suzuki  | 550000 |
-- +---------+--------+
-- 5 rows in set (0.00 sec)

--WHERE句: 条件付き取得
SELECT * FROM EMPLOYEE WHERE SAL >= 500000;
-- mysql> SELECT * FROM EMPLOYEE WHERE SAL >= 500000;
-- +----+---------+-----+---------------+--------+---------------+
-- | id | name    | age | job           | sal    | department_id |
-- +----+---------+-----+---------------+--------+---------------+
-- |  1 | matuda  |  65 | shatyo        | 950000 |             1 |
-- |  2 | yamada  |  43 | butyo         | 680000 |             2 |
-- |  3 | kitajou |  30 | eigyoumanager | 600000 |             3 |
-- |  4 | sato    |  28 | engineer      | 500000 |             2 |
-- |  5 | suzuki  |  35 | engineer      | 550000 |             2 |
-- +----+---------+-----+---------------+--------+---------------+
-- 5 rows in set (0.00 sec)

--ORDER BY句: 並び替え
SELECT * FROM EMPLOYEE ORDER BY SAL DESC;
-- mysql> SELECT * FROM EMPLOYEE ORDER BY SAL DESC;
-- +----+---------+-----+---------------+--------+---------------+
-- | id | name    | age | job           | sal    | department_id |
-- +----+---------+-----+---------------+--------+---------------+
-- |  1 | matuda  |  65 | shatyo        | 950000 |             1 |
-- |  2 | yamada  |  43 | butyo         | 680000 |             2 |
-- |  3 | kitajou |  30 | eigyoumanager | 600000 |             3 |
-- |  5 | suzuki  |  35 | engineer      | 550000 |             2 |
-- |  4 | sato    |  28 | engineer      | 500000 |             2 |
-- +----+---------+-----+---------------+--------+---------------+
-- 5 rows in set (0.00 sec)

--INSERT文: データの追加
INSERT INTO EMPLOYEE (NAME, AGE, JOB, SAL) VALUES ('佐藤', 35, '営業', 550000);
-- mysql> INSERT INTO EMPLOYEE (NAME, AGE, JOB, SAL) VALUES ('sato', 35, 'eigyou', 550000);
-- Query OK, 1 row affected (0.01 sec)

--UPDATE文: データの更新
UPDATE EMPLOYEE SET SAL = 1000000 WHERE NAME = 'matuda';
-- mysql> UPDATE EMPLOYEE SET SAL = 1000000 WHERE NAME = 'matuda';
-- Query OK, 1 row affected (0.01 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

--DELETE文: データの削除
DELETE FROM EMPLOYEE WHERE NAME = 'kitajou';
-- mysql> UPDATE EMPLOYEE SET SAL = 1000000 WHERE NAME = 'matuda';
-- Query OK, 1 row affected (0.01 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

-- mysql> DELETE FROM EMPLOYEE WHERE NAME = 'kitajou';
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`demo`.`PROJECT`, CONSTRAINT `PROJECT_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `EMPLOYEE` (`id`))

-- 上記でエラーが起きたため、下記を実施
-- mysql> SELECT * FROM PROJECT WHERE employee_id = (SELECT id FROM EMPLOYEE WHERE NAME = 'kitajou');
-- +----+--------------------+-------------+
-- | id | project_name       | employee_id |
-- +----+--------------------+-------------+
-- |  2 | marketing_campaign |           3 |
-- +----+--------------------+-------------+
-- 1 row in set (0.00 sec)

-- mysql> DELETE FROM PROJECT WHERE employee_id = (SELECT id FROM EMPLOYEE WHERE NAME = 'kitajou');
-- Query OK, 1 row affected (0.03 sec)

-- mysql> DELETE FROM EMPLOYEE WHERE NAME = 'kitajou';
-- Query OK, 1 row affected (0.01 sec)
--COUNT関数: データ件数の取得
SELECT COUNT(*) AS EMPLOYEE_COUNT FROM EMPLOYEE;
-- mysql> SELECT COUNT(*) AS EMPLOYEE_COUNT FROM EMPLOYEE;
-- +----------------+
-- | EMPLOYEE_COUNT |
-- +----------------+
-- |              5 |
-- +----------------+
-- 1 row in set (0.00 sec)

--DISTINCT: 重複の排除
SELECT DISTINCT JOB FROM EMPLOYEE;
-- mysql> SELECT DISTINCT JOB FROM EMPLOYEE;
-- +----------+
-- | JOB      |
-- +----------+
-- | shatyo   |
-- | butyo    |
-- | engineer |
-- | eigyou   |
-- +----------+
-- 4 rows in set (0.00 sec)
--GROUP BY: データのグループ化
SELECT JOB, COUNT(*) AS EMPLOYEE_COUNT FROM EMPLOYEE GROUP BY JOB;
-- mysql> SELECT JOB, COUNT(*) AS EMPLOYEE_COUNT FROM EMPLOYEE GROUP BY JOB;
-- +----------+----------------+
-- | JOB      | EMPLOYEE_COUNT |
-- +----------+----------------+
-- | shatyo   |              1 |
-- | butyo    |              1 |
-- | engineer |              2 |
-- | eigyou   |              1 |
-- +----------+----------------+
-- 4 rows in set (0.00 sec)