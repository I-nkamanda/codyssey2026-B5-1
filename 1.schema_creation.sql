CREATE TABLE users (  -- 사용자 테이블을 만들어 줍니다.
    id INT PRIMARY KEY, -- 사용자 ID를 기본 키(PrimaryKey)로 설정합니다.
    name VARCHAR(50) NOT NULL, -- 사용자 이름을 저장하는 컬럼입니다. 최대 50자까지 입력 가능하며, NULL 값을 허용하지 않습니다.
    room_number VARCHAR(10) -- 방 번호를 저장하는 컬럼입니다.
);
-- 이 테이블의 형식은  | id | name | room_number | 입니다. | #1 | 콩설탕 | 101호 | 식으로 저장이 딥니다.

CREATE TABLE categories(  -- 식재료의 카테고리 테이블을 만들어 줍니다.
    id INT PRIMARY KEY, -- 역시 카테고리 ID를 PrimaryKey로 설정합니다.
    category_name VARCHAR(50) UNIQUE NOT NULL, -- 식재료 이름이 비어있으면 안되도록 NOT NULL 제약조건을 걸어줍니다. 또한, UNIQUE 제약조건을 걸어서 중복된 카테고리 이름이 입력되지 않도록 합니다.
    warning_days INT DEFAULT 3 --기본적으로 냉장고에 들어가 있는 건 3일 안에 먹는 것을 권장하기 때문에, warning_days의 기본값을 3으로 설정합니다. 이 값은 사용자가 필요에 따라 변경할 수 있습니다.
);

-- 이 테이블의 형식은  | id | category_name | warning_days | 입니다. | #1 | 채소 | 3 | 식으로 저장이 됩니다.

CREATE TABLE ingredients (  -- 이제는 실제로 냉장고에 들어가는 식재료 품목 테이블을 만들어 줍니다.
    id INT PRIMARY KEY,-- 식재료 ID를 PrimaryKey로 설정합니다.
    name VARCHAR(100) NOT NULL, --  식재료 이름을 저장하는 컬럼입니다. 최대 100자까지 입력 가능하며, NULL 값을 허용하지 않습니다.
    expiration_date DATE NOT NULL, -- 식재료의 유통기한을 저장하는 컬럼입니다. DATE 타입으로 설정하여 날짜 형식으로 입력받도록 합니다. NULL 값을 허용하지 않습니다.
    status VARCHAR(20) DEFAULT '정상', -- 식재료의 상태를 저장하는 컬럼입니다. 기본값은 '정상'으로 설정합니다. 사용자가 필요에 따라 '위험' 등으로 변경할 수 있습니다.
    user_id INT, -- 식재료를 냉장고에 넣은 사용자의 ID를 저장하는 컬럼입니다. 이는 users 테이블의 id와 외래 키 관계를 맺습니다.
    category_id INT, -- 식재료의 카테고리를 저장하는 컬럼입니다. 이는 categories 테이블의 id와 외래 키 관계를 맺습니다.
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL, -- 사용자가 삭제될 때 해당 사용자가 넣은 식재료의 user_id를 NULL로 설정하여 참조 무결성을 유지합니다.
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT --   카테고리가 삭제될 때 해당 카테고리를 참조하는 식재료가 있으면 삭제를 제한하여 참조 무결성을 유지합니다.
);
-- 이 테이블의 형식은  | id | name | expiration_date | status | user_id | category_id | 입니다. | #1 | 콩설탕 | 2024-12-31 | 정상 | #1(콩설탕을 넣은 사용자) | #1(콩설탕의 카테고리) | 식으로 저장이 됩니다.

CREATE TABLE refrigerator_logs( -- 냉장고 사용 로그 테이블을 만들어 줍니다.
    id INT PRIMARY KEY, -- 로그 ID를 PrimaryKey로 설정합니다.
    ingredient_id INT, -- 로그에 기록되는 식재료의 ID를 저장하는 컬럼입니다. 이는 ingredients 테이블의 id와 외래 키 관계를 맺습니다.
    user_id INT, -- 로그에 기록되는 사용자의 ID를 저장하는 컬럼입니다. 이는 users 테이블의 id와 외래 키 관계를 맺습니다.
    action_type VARCHAR(20) NOT NULL, -- 로그에 기록되는 행동 유형을 저장하는 컬럼입니다. 예를 들어, '추가', '제거', '상태 변경' 등이 될 수 있습니다. NULL 값을 허용하지 않습니다.
    logged_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 로그가 기록된 시간을 저장하는 컬럼입니다. 기본값은 현재 시간으로 설정하여 로그가 생성될 때 자동으로 기록되도록 합니다.

    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id) ON DELETE CASCADE, -- 식재료가 삭제될 때 해당 식재료와 관련된 로그도 함께 삭제하여 참조 무결성을 유지합니다.
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL -- 사용자가 삭제될 때 해당 사용자가 생성한 로그의 user_id를 NULL로 설정하여 참조 무결성을 유지합니다.
);

-- 이 테이블의 형식은  | id | ingredient_id | user_id | action_type | logged_at | 입니다. | #1 | #1(로그에 기록되는 식재료) | #1(로그에 기록되는 사용자) | 추가 | 2024-06-01 12:00:00 | 식으로 저장이 됩니다.