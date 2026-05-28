-- 1. 현재 냉장고에 등록된 모든 식재료의 이름과 유통기한을 조회한다.
SELECT name, expiration_date 
FROM ingredients;



-- 2. 사용자 ID가 1번(이진걸)인 회원이 냉장고에 넣어둔 식재료 목록을 조회한다.
SELECT name, status 
FROM ingredients 
WHERE user_id = 1;



-- 3. 냉장고 안의 모든 식재료를 유통기한이 임박한 순서(과거순)로 정렬하여 조회한다.
SELECT name, expiration_date, status 
FROM ingredients 
ORDER BY expiration_date ASC;


-- 4. 유통기한이 가장 많이 지난(또는 임박한) 식재료 딱 3개만 뽑아서 조회한다.
SELECT name, expiration_date 
FROM ingredients 
ORDER BY expiration_date ASC 
LIMIT 3;



-- 5. 식재료 목록을 조회하면서, 해당 식재료를 등록한 사용자의 이름과 방 번호를 함께 표시한다.
SELECT i.name AS 식재료명, u.name AS 등록자, u.room_number AS 방번호
FROM ingredients i
INNER JOIN users u ON i.user_id = u.id;


-- 6. 식재료명, 등록자 이름, 그리고 해당 식재료의 카테고리명까지 결합하여 조회한다.
SELECT i.name AS 식재료명, u.name AS 등록자, c.category_name AS 카테고리
FROM ingredients i
INNER JOIN users u ON i.user_id = u.id
INNER JOIN categories c ON i.category_id = c.id;



-- 7. 등록자가 없는(NULL) 식재료를 포함하여, 냉장고 안의 모든 식재료와 등록자 이름을 조회한다.
SELECT i.name AS 식재료명, u.name AS 등록자
FROM ingredients i
LEFT JOIN users u ON i.user_id = u.id;



-- 8. 냉장고 반출/폐기 로그를 조회하며, 어떤 사용자가 어떤 식재료에 어떤 행동을 했는지 확인한다.
SELECT l.logged_at AS 시간, u.name AS 사용자, i.name AS 식재료명, l.action_type AS 행동
FROM refrigerator_logs l
INNER JOIN users u ON l.user_id = u.id
INNER JOIN ingredients i ON l.ingredient_id = i.id;



-- 9. 사용자별로 현재 냉장고에 보관 중인 식재료의 총 개수를 집계하여 조회한다.
SELECT u.name AS 사용자, COUNT(i.id) AS 보관중인_재료수
FROM users u
INNER JOIN ingredients i ON u.id = i.user_id
GROUP BY u.name;


-- 10. 냉장고 안의 식재료 상태('정상', '위험', '폐기대상')별로 각각 몇 개씩 존재하는지 집계한다.
SELECT status AS 상태, COUNT(*) AS 개수
FROM ingredients
GROUP BY status;


-- 11. 등록된 모든 카테고리의 평균 유통기한 임박 경고일(warning_days)을 계산한다.
SELECT AVG(warning_days) AS 평균_경고기준일
FROM categories;

-- 12. 현재 냉장고에 있는 식재료 중 유통기한이 가장 많이 남은(가장 신선한) 식재료의 정보를 조회한다.
SELECT name, expiration_date
FROM ingredients
WHERE expiration_date = (SELECT MAX(expiration_date) FROM ingredients);



-- 13. 유통기한이 현재 날짜(2026-05-28) 기준 이미 지나버린 식재료들의 상태를 '폐기대상'으로 변경한다.
UPDATE ingredients
SET status = '폐기대상'
WHERE expiration_date < '2026-05-28';


-- 14. 상태가 '폐기대상'으로 분류된 식재료 데이터를 테이블에서 영구 삭제한다.
DELETE FROM ingredients
WHERE status = '폐기대상';


-- 15. 식재료의 유통기한(expiration_date) 컬럼에 인덱스를 생성한다.
CREATE INDEX idx_ingredients_expiration ON ingredients(expiration_date);


