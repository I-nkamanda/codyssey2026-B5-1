# AI/SW 기초과정 B5-1: SQL로 만드는 나만의 데이터베이스

## 취지:
- 본 과제를 수행하면서, SQL이라는 언어를 활용해서 데이터베이스를 만들고, 다루는 역할을 해 본다.




## SQL이란?
SQL은 Structured Query Language, 곧 구조화된 쿼리(DB에 요청하는 명령)를 다루는 언어를 말한다.

SQL은 DDL, DML, DQL, DCL, TCL 총 다섯개의 명령어 그룹으로 분류된다.

### DDL (Data Definition Lanaguage)
우선 DDL부터 보자. DDL은 데이터(Data) 정의(Definition) 명령어(Language)로서, 데이터베이스의 뼈대/구조를 생성, 변경, 삭제하는 명령어 그룹이다. 쉽게 말하자면 데이터가 들어갈 테이블 구조 자체를 만들고, 뜯어고치고, 부수는 역할을 하는 명령어다. 주요 명령어로는
- 테이블이나 데이터베이스를 처음부터 만드는 `CREATE`
- 새로운 열을 추가하거나 열을 삭제하는 등, 기존에 있던 테이블의 구조를 변경하는 `ALTER`
- 테이블/데이터베이스를 통째로 삭제하는 `DROP`
등이 있다.


### DML (Data Manipulation Language)
DML은 Table "안"의 각각 데이터를 조작하는, 데이터(Data) 조작(Manipulation) 명령어(Language)이다. 만들어진 데이터베이스 안에 자료들을 입력하고, 바꾸고, 버리는 작업을 할 수 있다. 주요 명령어로는,
- 테이블에 새로운 데이터를 삽입하는 `INSERT`
- 기존 데이터를 수정하는`UPDATE`
- 특정 데이터를 선택해서 삭제하는`DELETE`
등이 있다.


### DQL (Data Query Language)
DQL은 데이터베이스 안에 저장된 데이터를(Data) 조회/검색(Query)하는 명령어(Language)이다. 엄밀히 따지면 DQL은 DML의 하위 분류로 본다고 하긴 하는데, 이전에 Google Cloud Study Jam을 할 때, SQL/BigQuery 관련 실습 레슨에서는 `SELECT` 이외의 명령어를 입력해 본 적이 많이 없던 것으로 기억한다. AI 시대가 다가온 만큼 특정한 조건을 만족하는 데이터를 "읽어오는" 것이 아주 중요해진 것이다. 주요 명령어로는,
- DB에서 원하는 조건의 데이터를 선택해서 불러오는 `SELECT`
가 대표적이다.

### DCL (Data Control Language)
DCL은 데이터(Data)를 제어(Control)하는 명령어(Language)이다. 작년에 처음으로 PostgreSQL을 설치하자마자 대표 계정 비밀번호를 만들고 로그인을 하는 과정을 거치면서 "와, 나밖에 건드릴 사람이 없는 상황에서도 관리가 빡세구나" 생각을 했었지만, 본디 DB라는 것이- 많은 사람들이 접근하고 귀중한 자료들이 저장되어있는 DB는 접근 권한을 제한하고, 인가된 사람들만 접근할 수 있게 권한의 선택적 부여가 필요한 것이다. 주요 명령어로는,
- 특정 사용자에게 데이터베이스 접근 및 작업 권한을 부여하는 `GRANT`
- 사용자에게 부여했던 권한을 회수하는 `REVOKE`
등이 대표적이다.

### TCL (Data/Transaction Control Language)
TCL은 데이터의 트랜잭션(Transaction) 제어(Control) 명령어(Language)이다. 상술한 DML(`INSERT`, `UPDATE`, `DELETE`등 테이블 안의 데이터를 작성 및 수정하는 명령어 뭉치들)로 데이터를 조작한 뒤에, 그 결과를 실제 데이터베이스에 최종 반영할지, 아님 취소하고 이전 상태로 되돌릴(롤백)지 결정하는 명령어이다. 마치 Git 등지에 commit하고 rebase하고 reset 하는 느낌이 많이 들었다. 주요 명령어로는,

- 방금 한 작업들을 디스크에 영구 저장하는 명령어인 `COMMIT` (commit을 해야 다른 작업자들에게도 반영된 결과물이 보인다)
- 바로 직전의 Commit 직후 상태로 작업을 전부 취소하고 되돌리는 `ROLLBACK`
- Query가 길 때, 중간에 체크포인트를 만들어 두고, 에러가 나면 맨 처음이 아니라 그 특정 지점으로 되돌릴 수 있게 만들어놓은 `SAVEPOINT`
등이 대표적이다.


## CRUD란?
Create, Read, Update, 

## SQL의 6대 명령어
### SELECT
- column(열)을 선택하는 명령어

### FROM
- table(표)를 선택하는 명령어
### WHERE
- rows(행)을 선택하는 명령어

### GROUP BY
- 데이터들을 모아서 특정한 방식으로 그룹화하는 명령어
### HAVING
- 그룹된 데이터를 필터링하는 명령어

### ORDER BY
- 데이터를 줄세우는 기준을 말해주는 명령어


### 이외의 명령어

### LIMIT
- LIMIT 5와 같이 상위 5개 등 출력하는 자료의 갯수를 제한한다
### COUNT
- 해당 쿼리를 만족하는 자료의 갯수를 반환한다
### DISTINCT
- 출력될 시에 중복되는 데이터를 없애줌 
- `SELECT DISTINCT` 등으로 활용


LEFT JOIN: 