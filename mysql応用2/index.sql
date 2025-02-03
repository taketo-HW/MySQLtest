--HAVING: グループ条件
--問題: 各JOBごとの社員数を取得し、社員数が2人以上のJOBだけを表示してください。
SELECT JOB, COUNT(*) AS EMP_COUNT FROM EMPLOYEE GROUP BY JOB HAVING COUNT(*) >= 2;
-- mysql> SELECT JOB, COUNT(*) AS EMP_COUNT FROM EMPLOYEE GROUP BY JOB HAVING COUNT(*) >= 2;
-- +----------+-----------+
-- | JOB      | EMP_COUNT |
-- +----------+-----------+
-- | engineer |         2 |
-- +----------+-----------+
-- 1 row in set (0.00 sec)

--INNER JOIN: テーブルの結合
--問題: EMPLOYEEテーブルとDEPARTMENTテーブルをdepartment_idで結合し、社員名と所属部署名を取得してください。
SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.department_id = D.id;
-- mysql> SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E INNER JOIN DEPARTMENT D ON E.department_id = D.id;
-- +---------------+-----------------+
-- | EMPLOYEE_NAME | DEPARTMENT_NAME |
-- +---------------+-----------------+
-- | matuda        | keieikanribu    |
-- | yamada        | gijutubu        |
-- | sato          | gijutubu        |
-- | suzuki        | gijutubu        |
-- +---------------+-----------------+
-- 4 rows in set (0.00 sec)

--LEFT JOIN: 左結合
--問題: EMPLOYEEテーブルのすべての社員と、その部署を左結合で取得してください。
SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.department_id = D.id;
-- mysql> SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.department_id = D.id;
-- +---------------+-----------------+
-- | EMPLOYEE_NAME | DEPARTMENT_NAME |
-- +---------------+-----------------+
-- | matuda        | keieikanribu    |
-- | yamada        | gijutubu        |
-- | sato          | gijutubu        |
-- | suzuki        | gijutubu        |
-- | sato          | NULL            |
-- +---------------+-----------------+
-- 5 rows in set (0.00 sec)

--サブクエリ: 条件の入れ子
--問題: 月給が全社員の平均月給より高い社員を取得してください。
SELECT * FROM EMPLOYEE WHERE SAL > (SELECT AVG(SAL) FROM EMPLOYEE);
-- mysql> SELECT * FROM EMPLOYEE WHERE SAL > (SELECT AVG(SAL) FROM EMPLOYEE);
-- +----+--------+-----+--------+---------+---------------+
-- | id | name   | age | job    | sal     | department_id |
-- +----+--------+-----+--------+---------+---------------+
-- |  1 | matuda |  65 | shatyo | 1000000 |             1 |
-- |  2 | yamada |  43 | butyo  |  680000 |             2 |
-- +----+--------+-----+--------+---------+---------------+
-- 2 rows in set (0.00 sec)

--ORDER BYとLIMITの組み合わせ
--問題: EMPLOYEEテーブルから月給の高い順に3人を取得してください。
SELECT * FROM EMPLOYEE ORDER BY SAL DESC LIMIT 3;
-- mysql> SELECT * FROM EMPLOYEE ORDER BY SAL DESC LIMIT 3;
-- +----+--------+-----+----------+---------+---------------+
-- | id | name   | age | job      | sal     | department_id |
-- +----+--------+-----+----------+---------+---------------+
-- |  1 | matuda |  65 | shatyo   | 1000000 |             1 |
-- |  2 | yamada |  43 | butyo    |  680000 |             2 |
-- |  5 | suzuki |  35 | engineer |  550000 |             2 |
-- +----+--------+-----+----------+---------+---------------+
-- 3 rows in set (0.00 sec)

--ウィンドウ関数: 行番号の付与
--問題: EMPLOYEEテーブルに対し、SALの降順で行番号を付与して表示してください。
SELECT *, ROW_NUMBER() OVER (ORDER BY SAL DESC) AS ROW_NUM FROM EMPLOYEE;
-- mysql> SELECT *, ROW_NUMBER() OVER (ORDER BY SAL DESC) AS ROW_NUM FROM EMPLOYEE;
-- +----+--------+-----+----------+---------+---------------+---------+
-- | id | name   | age | job      | sal     | department_id | ROW_NUM |
-- +----+--------+-----+----------+---------+---------------+---------+
-- |  1 | matuda |  65 | shatyo   | 1000000 |             1 |       1 |
-- |  2 | yamada |  43 | butyo    |  680000 |             2 |       2 |
-- |  5 | suzuki |  35 | engineer |  550000 |             2 |       3 |
-- |  6 | sato   |  35 | eigyou   |  550000 |          NULL |       4 |
-- |  4 | sato   |  28 | engineer |  500000 |             2 |       5 |
-- +----+--------+-----+----------+---------+---------------+---------+
-- 5 rows in set (0.00 sec)

--トランザクション: データ操作
--問題: 以下の操作をトランザクションで管理してください。
-- 社員山田の月給を50,000減額する。
-- 社員北條の月給を50,000増額する。
START TRANSACTION; UPDATE EMPLOYEE SET SAL = SAL - 50000 WHERE NAME = '山田'; UPDATE EMPLOYEE SET SAL = SAL + 50000 WHERE NAME = '北條'; COMMIT;
-- mysql> START TRANSACTION; UPDATE EMPLOYEE SET SAL = SAL - 50000 WHERE NAME = ''; UPDATE EMPLOYEE SET SAL = SAL + 50000 WHERE NAME = ''; COMMIT;
-- Query OK, 0 rows affected (0.00 sec)

-- Query OK, 0 rows affected (0.00 sec)
-- Rows matched: 0  Changed: 0  Warnings: 0

-- Query OK, 0 rows affected (0.00 sec)
-- Rows matched: 0  Changed: 0  Warnings: 0

-- Query OK, 0 rows affected (0.01 sec)

--CASE文: 条件による値の変更
--問題: EMPLOYEEテーブルのSALが500,000以上なら"高給", それ未満なら"普通"と表示してください。
SELECT NAME, SAL, CASE WHEN SAL >= 500000 THEN '' ELSE '' END AS SAL_CATEGORY FROM EMPLOYEE;
-- mysql> SELECT NAME, SAL, CASE WHEN SAL >= 500000 THEN '' ELSE '' END AS SAL_CATEGORY FROM EMPLOYEE;
-- +--------+---------+--------------+
-- | NAME   | SAL     | SAL_CATEGORY |
-- +--------+---------+--------------+
-- | matuda | 1000000 |              |
-- | yamada |  680000 |              |
-- | sato   |  500000 |              |
-- | suzuki |  550000 |              |
-- | sato   |  550000 |              |
-- +--------+---------+--------------+
-- 5 rows in set (0.00 sec)

--複雑なサブクエリ: 最大値の取得
--問題: 月給が各部署内で最大の社員を取得してください。
SELECT * FROM EMPLOYEE E WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);
-- mysql> SELECT * FROM EMPLOYEE E WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYEE WHERE DEPARTMENT_ID = E.DEPARTMENT_ID);
-- +----+--------+-----+--------+---------+---------------+
-- | id | name   | age | job    | sal     | department_id |
-- +----+--------+-----+--------+---------+---------------+
-- |  1 | matuda |  65 | shatyo | 1000000 |             1 |
-- |  2 | yamada |  43 | butyo  |  680000 |             2 |
-- +----+--------+-----+--------+---------+---------------+
-- 2 rows in set (0.00 sec)

--FULL OUTER JOIN: 全結合
--問題: EMPLOYEEテーブルとDEPARTMENTテーブルを全結合し、どちらかに存在しないデータをNULLで補完して取得してください。
SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.department_id = D.id UNION SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E RIGHT JOIN DEPARTMENT D ON E.department_id = D.id;
-- mysql> SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.department_id = D.id UNION SELECT E.NAME AS EMPLOYEE_NAME, D.department_name AS DEPARTMENT_NAME FROM EMPLOYEE E RIGHT JOIN DEPARTMENT D ON E.department_id = D.id;
-- +---------------+-----------------+
-- | EMPLOYEE_NAME | DEPARTMENT_NAME |
-- +---------------+-----------------+
-- | matuda        | keieikanribu    |
-- | yamada        | gijutubu        |
-- | sato          | gijutubu        |
-- | suzuki        | gijutubu        |
-- | sato          | NULL            |
-- | NULL          | eigyoubu        |
-- +---------------+-----------------+
-- 6 rows in set (0.00 sec)