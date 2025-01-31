INSERT INTO employees (name, position, salary, created_at, updated_at)
VALUES 
    ('山田太郎', 'マネージャー', 700000, NOW(), NOW()),
    ('佐藤花子', 'エンジニア', 500000, NOW(), NOW()),
    ('鈴木次郎', 'エンジニア', 500000, NOW(), NOW());

INSERT INTO projects (name, budget, created_at, updated_at)
VALUES 
    ('新製品開発', 10000000, NOW(), NOW()),
    ('マーケティング戦略', 5000000, NOW(), NOW());

INSERT INTO assignments (employee_id, project_id, hours, created_at, updated_at)
VALUES 
    ((SELECT id FROM employees WHERE name = '山田太郎'), 
     (SELECT id FROM projects WHERE name = '新製品開発'), 100, NOW(), NOW()),

    ((SELECT id FROM employees WHERE name = '佐藤花子'), 
     (SELECT id FROM projects WHERE name = '新製品開発'), 150, NOW(), NOW()),

    ((SELECT id FROM employees WHERE name = '鈴木次郎'), 
     (SELECT id FROM projects WHERE name = 'マーケティング戦略'), 200, NOW(), NOW());
