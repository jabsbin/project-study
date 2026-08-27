-- 주석
-- C(insert), R(select), U(update), D(delete) 연습

--- 테이블 생성
CREATE TABLE good(nO INT PRIMARY key, name VARCHAR(10) NOT NULL, tel VARCHAR(10),
inwon INT, addr TEXT);

DESC good;

-- 자료추가
-- 형식 : insert into 테이블명(컬럼명 타입, ...) values(자료,...)
INSERT INTO good(no, name, tel, inwon, addr) VALUES(1, '인사과', '1234-1234', 5, '삼성1동');
INSERT INTO good VALUES(2, '영업과', '123-1222', 12, '역삼2동');
INSERT INTO good(no, name, inwon) VALUE('3', '자재과', '7');
INSERT INTO good(addr, no, name, inwon) VALUE('역삼3동', '4', '자재2과', '7');

SELECT * FROM good;

-- 오류인 경우
INSERT INTO good(no, name) VALUES(3, '자재3과'); -- no(PRIMARY key)중복에러
INSERT INTO good(no, tel) VALUES(5, '자재3과'); -- name은 not null이라 반드시 입력
INSERT INTO good(name, no) VALUES(5, '자재3과'); -- 입력자료와 컬럼의 순서 불일치
INSERT INTO good(no, name) VALUES('오', '자재3과'); -- 입력자료 타입이 불일치
INSERT INTO good(no, name) VALUES(5, '우리 회사에서 가장 매출이 좋은 부러운 부서'); -- 입력자료 크기 오류

-- 자료 수정
-- 형식 : update 테이블명 set 칼럼명=수정값, ...where 조건
UPDATE good SET inwon=100 WHERE NO=1;
UPDATE good SET inwon=70, tel='777-7777' WHERE NO=2;
UPDATE good SET inwon=70, tel=null WHERE NO=2;

SELECT * FROM good;

-- 오류인 경우
UPDATE good SET NAME=null WHERE NO=2; -- name은 not null
UPDATE good SET NO=2 WHERE NO=1; -- no 중복 오류

-- 자료 삭제
-- 형식 : delete from 테이블명 where 조건
DELETE FROM good WHERE NO=2; -- 부분적으로 행 삭제
SELECT * FROM good;

-- 형식2 : truncate table 테이블명  - where 조건 없음. 행 모두 삭제. 구조만 남음
TRUNCATE TABLE good;
SELECT*FROM good;

DROP TABLE good; -- 테이블 삭제

SHOW TABLES;