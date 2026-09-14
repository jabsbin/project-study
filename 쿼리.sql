-- 주석
-- C(insert), R(select), U(update), D(delete) 연습

--- 테이블 생성
CREATE TABLE good(no INT PRIMARY key, name VARCHAR(10) NOT NULL, tel VARCHAR(10),
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

-- 
 -- -----------------------------------------------------
 -- 데이터베이스 무결성(Database Integrity)은 저장된 데이터가 정확하고 일관되며,
 -- 손상되지 않고 신뢰할 수 있는 상태를 유지하는 것을 뜻합니다.
 -- 잘못된 자료 입력 방지를 위한 제약 조건 부여.
 -- 데이터의 품질을 지키고 오류를 막기 위해 데이터베이스 관리 시스템(DBMS)이 지키는 핵심 규칙.
 -- 주요 무결성 제약조건
 -- - 개체 무결성(Entity Integrity): 모든 테이블은 기본 키(Primary Key)를 가져야 합니다.
   --
 --   기본 키는 빈 값(NULL)이나 중복 값을 가질 수 없습니다.
 -- - 도메인 무결성(Domain Integrity): 필드에 들어가는 값이 지정된 자료형, 범위, 조건(Check 등)에
 --   맞게 정의된 무결성 (User-Defined Integrity): 업무 규칙에 맞게 사용자가 직접 만든 조건이나 트리
 -- - 사용자 정의 무결성 (User-Defined Integrity): 업무 규칙에 맞게 사용자가 직접 만든 조건을 뜻합니다.
 -- - 참조 무결성(Referential Integrity): 테이블 간의 관계를 뜻합니다.
 --   외래 키(Foreign KEY)값은 참조하는 테이블의 기본 키와 일치하거나 빈 값이어야 합니다.
 -- 
 -- 무결성이 중요한 이유중에
 -- 데이터나 잘못된 입력 값을 막습니다.
 -- 부모와 자식 데이터의 연결이 끊어지지 않게 돕습니다.
 -- 시스템 오류를 줄이고 데이터 신뢰도를 높입니다.
 
 -- 기본키(ptimaty key, pk) 제약 조건 - Entity Integrity
 -- 기본 키는 빈 값(NULL)이나 중복 값을 가질 수 없다. 자동으로 인덱스가 생성됨
 
 -- 참고 : 테이블 작성시 칼럼의 이름, 타입은 중요. 순서는 마음대로.
 --        계산에의해 처리될 수 있는 값은 칼럼으로 작성 X  
 --        예) 국어, 영어 따위는 칼럼으로 작성. 총점, 평균은 칼럼으로 작성 X
 
 -- 방법1) 칼럼 레벨
 CREATE TABLE aa(bun INT PRIMARY KEY, irum CHAR(10));
 DESC aa;
 INSERT INTO aa VALUES(1, 'tom');
 INSERT INTO aa VALUES(2, 'tom');
 INSERT INTO aa VALUES(2, 'tom');      -- pk err : 중복 불가
 INSERT INTO aa(irum) VALUES('tom');   -- pk err : not null
 SELECT * FROM aa;
 SHOW CREATE TABLE aa;
 -- 제약조건 확인
 SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='aa';
 
 DROP TABLE aa;
 
 -- 방법2) 테이블 레벨
 CREATE TABLE aa(bun INT, irum CHAR(10), CONSTRAINT aa_bun_pk PRIMARY KEY(bun));
 -- 방법 1과 다르게 CONSTRAINT 하고 뒤에 프라이머리키 적어도 된다.
 DESC aa;
 SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='aa'; -- oracle용
 
 ALTER TABLE aa DROP CONSTRAINT aa_bun_pk;   -- pk 제약조건 삭제. oracle에서 유효
 ALTER TABLE aa DROP PRIMARY KEY;  -- pk 제약조건 삭제
 DROP TABLE aa;
 
 -- check 제약 조건 - Domain Integrity : 입력 값 조건 부여
 CREATE TABLE aa(bun INT, irum CHAR(10), nai INT CHECK(nai >= 20));
 SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_NAME='aa';
 INSERT INTO aa VALUES(1, 'tom', 25); 
 INSERT INTO aa VALUES(1, 'tom', 15);   -- 조건 불만족
 
 ALTER TABLE aa ADD CONSTRAINT ck_name CHECK(irum IN('tom','john')); -- CHECK 조건 추가
 -- 지정한 컬럼(irum)의 값이 특정 목록('tom', 'john') 중 하나일 때만
 -- 데이터 입력을 허용하는 체크(CHECK) 제약 조건을 테이블에 추가하는 명령어
 INSERT INTO aa VALUES(2, 'john', 25); -- 나이 조건 불만족
 INSERT INTO aa VALUES(2, 'james', 3); -- irum 조건 불만족
 SELECT * FROM aa;
 
 DROP TABLE aa;
 
 -- Unique 제약조건 - Domain Integrity : 동일 값 입력부여
 CREATE TABLE aa(bun INT, irum CHAR(10) unique);
 CREATE TABLE aa(bun INT, irum CHAR(10), CONSTRAINT aa_irum_uk UNIQUE(irum)); -- 얘도 가능
 INSERT INTO aa VALUES(1, 'john');
 INSERT INTO aa VALUES(2, 'tom');
 INSERT INTO aa VALUES(3, 'tom'); -- unique err: 중복 불가
 
 -- REferntial Integrity(참조키, 외래키) 제약 조건
 -- 다른 테이블의 칼럼 값을 참조 (fk의 대상은 다른 테이블의 pk 또는 unique 가능)
 
 -- 기본키 테이블의 정보를 참조하는 테이블의 키를 외부키, 참조키, foreign key라고 한다
 
 CREATE TABLE jikwon(bun INT PRIMARY KEY, irum VARCHAR(10) NOT NULL, buser CHAR(10));
 INSERT INTO jikwon VALUES(1, '한송이', '인사과');
 INSERT INTO jikwon VALUES(2, '박치기', '인사과');
 INSERT INTO jikwon VALUES(3, '한송이', '총무과');
 SELECT * FROM jikwon;
 
 -- 가족 테이블
 CREATE TABLE gajok(CODE INT PRIMARY KEY, NAME VARCHAR(10), birth DATETIME, jikwon_bun INT,
 foreign KEY(jikwon_bun) REFERENCES jikwon(bun));
 -- 부모 데이터를 자식이 참조하고 있으면 부모의 삭제나 키 변경을 막는다.
 
 CREATE TABLE gajok(CODE INT PRIMARY KEY, NAME VARCHAR(10), birth DATETIME, jikwon_bun INT,
 foreign KEY(jikwon_bun) REFERENCES jikwon(bun) ON DELETE RESTRICT ON UPDATE RESTRICT); -- 위와 동일
 
 CREATE TABLE gajok(CODE INT PRIMARY KEY, NAME VARCHAR(10), birth DATETIME, jikwon_bun INT,
 foreign KEY(jikwon_bun) REFERENCES jikwon(bun) ON DELETE CASCADE ON UPDATE SET null);
 -- CASCADE : 부모 삭제시 자식도 삭제
 -- SET NULL : 부모 참조키 변경시 자식의 FK 칼럼 값은 null이 됨.
 -- 대개의 경우 부모의 pk는 변경이 흔하지 않으므로 SET NULL은 자주 사용되지 않는다.
 
 DESC gajok;
 INSERT INTO gajok VALUES(10, '가나다', NOW(), 1);
 INSERT INTO gajok VALUES(20, '이겨라', '2000-5-5', 2);
 INSERT INTO gajok VALUES(30, '한국인', '2010-5-15', 1);
 SELECT * FROM gajok;
 
 INSERT INTO gajok VALUES(40, '지구인', '2010-5-15', 5);  -- fk err: 5번 직원은 없다.
 
 -- 직원 자료 삭제
 DELETE FROM jikwon WHERE bun = 3;
 DELETE FROM jikwon WHERE bun = 2;  -- err: 2번 직원의 가족이 있기 때문
 DELETE FROM gajok WHERE CODE=20;   -- 2번 직원의 가족 삭제
 DELETE FROM jikwon WHERE bun = 2;  -- 성공 : 가족이 없기 때문

 SELECT * FROM jikwon;
 
 DROP TABLE jikwon; -- err 테이블 삭제 불가 - 참조 되고있는 자식 테이블이 존재.
 DROP TABLE gajok;
 DROP TABLE jikwon;
 
 SHOW TABLES;
 
 
 -- default : 특정 칼럼에 초기값 부여 - null 방지 목적
 CREATE TABLE aa(bun INTNCREMENT primary KEY, irum CHAR(10),
 juso VARCHAR(50) DEFAULT '역삼동');  -- AUTO_INCREMENT : 번호 자동 증가
 -- Oracle은 AUTO_INCREMENT X : SEQUENCE 사용
 DESC aa;
 
 INSERT INTO aa(irum,juso) VALUES('길동이','서초동'); -- AUTO_INCREMENT 초기값 1
 INSERT INTO aa(irum,juso) VALUES('나라','익선동');
 INSERT INTO aa(irum,juso) VALUES('나라','익선동');
 INSERT INTO aa(irum) VALUES('국가');  -- juso는 DEFAULT 값으로 채움
 ALTER TABLE aa AUTO_INCREMENT=100;  -- AUTO_INCREMENT 값 변경
 INSERT INTO aa(irum,juso) VALUES('순신','필동');
 INSERT INTO aa(irum,juso) VALUES('철수','대치동');
 
 SELECT * FROM aa;
 
 DROP TABLE aa;
 
 CREATE TABLE 교수(교수코드 INT AUTO_INCREMENT PRIMARY KEY, 교수명 CHAR(10) NOT null, 연구실number int);
 DESC 교수;
 
 ALTER TABLE 교수 add CONSTRAINT num CHECK(연구실number BETWEEN 100 AND 500);
 DESC 교수;
 
 CREATE TABLE 과목(과목코드 INT AUTO_INCREMENT PRIMARY KEY, 과목명 CHAR(10) unique, 교재명 VARCHAR(10), 담당교수 INT,
 foreign KEY(담당교수) REFERENCES 교수(교수코드));
 DESC 과목;
 
 CREATE TABLE 학생(학번 INT PRIMARY KEY, 학생명 CHAR(10), 수강과목 int, 학년number INT DEFAULT 1,
 FOREIGN KEY(수강과목) REFERENCES 과목(과목코드));
 
 ALTER TABLE 학생 ADD CONSTRAINT haknum CHECK(학년number BETWEEN 1 AND 4);
 DESC 학생;
 
 SHOW TABLES;
 
 INSERT INTO 교수 VALUES(1, '홍길동', 100);
 INSERT INTO 교수 VALUES(2, '고길동', 110);
 INSERT INTO 교수 VALUES(3, '홍길동', 120);
 SELECT * FROM 교수;
 
 INSERT INTO 과목(과목명, 교재명, 담당교수) VALUES('SQL', 'SQL의 이해', 1);
 INSERT INTO 과목(과목명, 교재명, 담당교수) VALUES('파이썬', '실무 파이썬', 2);
 INSERT INTO 과목(과목명, 교재명, 담당교수) VALUES('파이썬2', '실무 파이썬2', 7);  -- fk err
 INSERT INTO 과목(과목명, 교재명, 담당교수) VALUES('파이썬', '실무 파이썬', 7);   -- fk err
 SELECT * FROM 과목;
 
 INSERT INTO 학생 VALUES('1111', '한국인', 1, 1);
 INSERT INTO 학생 VALUES('1112', '한송이', 2, 3);
 INSERT INTO 학생 VALUES('1113', '한국인', 20, 3);   -- fk err
 INSERT INTO 학생 VALUES('1113', '한국인', 2, 6); -- check err
 
 SELECT * FROM 학생;
 
 DELETE FROM 교수 WHERE 교수코드= 1;  -- 자식이 참조
 DELETE FROM 과목 WHERE 과목코드= 1;  -- 자식이 참조
 DELETE FROM 학생 WHERE 학번= 1111; -- 삭제 성공
 DELETE FROM 과목 WHERE 과목코드= 1; -- 삭제 성공
 DELETE FROM 교수 WHERE 교수코드= 1; -- 삭제 성공
 
 DROP TABLE 교수; -- err : 자식이 참조
 DROP TABLE 과목; -- err : 자식이 참조
 DROP TABLE 학생; -- 테이블 삭제 성공
 DROP TABLE 과목; -- 테이블 삭제 성공
 DROP TABLE 교수; -- 테이블 삭제 성공
 
 SHOW TABLES;
 
 -- 인덱스 : 쉽게 말하면 책의 목차나 색인과 비슷하다. 검색 속도 향상이 목표
 -- 인덱스 없음 -> 처음부터 끝까지 데이터 확인
 -- 인덱스 있음 -> 위치를 빠르게 찾아서 데이터 접근
 -- 색인을 만들면 검색 속도는 향상되지만 메모리를 많이 사용하고 insert,update,delete사용 시에도 계속 만들어야 한다는게 단점이다.
 
 CREATE TABLE aa (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(20),
 age INT, city VARCHAR(30));

INSERT INTO aa(name, age, city) VALUES
('홍길동', 25, '서울'),
('김철수', 30, '부산'),
('이영희', 27, '서울'),
('박민수', 35, '대구'),
('최영희', 23, '인천'),
('강호동', 40, '서울'),
('유재석', 38, '부산'),
('신동엽', 42, '서울'),
('홍길동', 29, '수원'),
('김민지', 31, '대구');

SELECT * FROM aa;

SELECT * FROM aa WHERE NAME='강호동'; -- 인덱스가 없으므로 전체 테이블 검색
-- 실행 계획 확인
EXPLAIN SELECT * FROM aa WHERE NAME='강호동'; -- type : ALL - Full Table Scan

-- 검색을 자주하는 name에 인덱스 생성 - 인덱스 테이블 별도 생성
CREATE INDEX idx_aa_name ON aa(NAME); -- 이미 테이블이 있는 경우
SHOW INDEX FROM aa;  -- idx_aa_name와 pk(인덱스 자동생성) 인덱스 확인 가능
SHOW KEYS FROM aa; -- 이 것도 가능

-- 테이블 생성시 인덱스 부여
CREATE TABLE aa (id INT AUTO_INCREMENT PRIMARY KEY, NAME VARCHAR(20),
age INT, city VARCHAR(30), INDEX idx_aa_name (NAME));

-- 참고 : 인덱스가 여러 개인 경우 '옵티마이저'가 적당한 인덱스를 선택해 실행

DESC aa;

-- idx_aa_name 테이블 생성
-- 강호동 -> 위치(pointer - pk값) pk값 없으면 내부적으로 ROW id를 만듦
-- 이영희 -> 위치

-- index 삭제
DROP INDEX idx_aa_name ON aa;
SHOW INDEX FROM aa;

-- index는 특정 칼럼의 검색 속도 증진이 목적이나 단점도 있다.
-- insert, update, delete 둥이 빈번한 경우에는 인덱스 재설정 비용이 든다.



-- 참고 : 내장함수 now(), sysdate()의 차이
SELECT NOW(), SLEEP(2), NOW();  -- 결과 값이 같다.
SELECT sysdate(), SLEEP(2), SYSDATE(); -- 결과 값이 다르다.
-- sysdate()는 동일 SQL 문장 내에서 호출되는 시점에 따라 결과 값을 바로 반환


-- 테이블 관련 명령
-- create table 테이블명 ~  생성
-- alter table 테이블명 ~   구조물 수정
-- drop table 테이블명 ~    삭제

CREATE TABLE aa(irum CHAR(10), juso VARCHAR(50));
ALTER TABLE aa RENAME kbs;   -- 테이블 이름 변경
SELECT * FROM aa;  -- X
SELECT * FROM kbs;  -- O
ALTER TABLE kbs RENAME aa;


-- 칼럼 관련 명령 
ALTER TABLE aa ADD (job_id INT DEFAULT 10);
DESC aa;
INSERT INTO aa VALUES('tom', 'seoul', 20);
INSERT INTO aa(irum, juso) VALUES('tom2', 'jeju');
SELECT * FROM aa;

ALTER TABLE aa CHANGE job_id job_number INT;  -- 칼럼명 변경
SELECT * FROM aa;

ALTER TABLE aa MODIFY job_id job_number VARCHAR(10); -- 칼럼 타입 변경
DESC aa;

ALTER TABLE aa DROP COLUMN job_number; -- 칼럼 삭제
DESC aa;
SELECT * FROM aa;

DROP TABLE aa;

-- 본격 실습 ----------------------------------------------------------

create table sangdata(code int primary key,sang varchar(20),su int,dan INT);
insert into sangdata values(1,'장갑',3,10000);
insert into sangdata values(2,'벙어리장갑',2,12000);
insert into sangdata values(3,'가죽장갑',10,50000);
insert into sangdata values(4,'가죽점퍼',5,650000);
select * from sangdata;

create table buser(
buserno int primary key, 
busername varchar(10) not null,
buserloc varchar(10),
busertel varchar(15));

insert into buser values(10,'총무부','서울','02-100-1111');
insert into buser values(20,'영업부','서울','02-100-2222');
insert into buser values(30,'전산부','서울','02-100-3333');
insert into buser values(40,'관리부','인천','032-200-4444');
select * from buser;

create table jikwon(
jikwonno int primary key,
jikwonname varchar(10) not null,
busernum int not null,
jikwonjik varchar(10) default '사원', 
jikwonpay int,
jikwonibsail date,
jikwongen varchar(4),
jikwonrating char(3),
CONSTRAINT ck_jikwongen check(jikwongen='남' or jikwongen='여'));

insert into jikwon values(1,'홍길동',10,'이사',9900,'2008-09-01','남','a');
insert into jikwon values(2,'한송이',20,'부장',8800,'2010-01-03','여','b');
insert into jikwon values(3,'이순신',20,'과장',7900,'2010-03-03','남','b');
insert into jikwon values(4,'이미라',30,'대리',4500,'2014-01-04','여','b');
insert into jikwon values(5,'이순라',20,'사원',3000,'2017-08-05','여','b');
insert into jikwon values(6,'김이화',20,'사원',2950,'2019-08-05','여','c');
insert into jikwon values(7,'김부만',40,'부장',8600,'2009-01-05','남','a');
insert into jikwon values(8,'김기만',20,'과장',7800,'2011-01-03','남','a');
insert into jikwon values(9,'채송화',30,'대리',5000,'2013-03-02','여','a');
insert into jikwon values(10,'박치기',10,'사원',3700,'2016-11-02','남','a');
insert into jikwon values(11,'김부해',30,'사원',3900,'2016-03-06','남','a');
insert into jikwon values(12,'박별나',40,'과장',7200,'2011-03-05','여','b');
insert into jikwon values(13,'박명화',10,'대리',4900,'2013-05-11','남','a');
insert into jikwon values(14,'박궁화',40,'사원',3400,'2016-01-15','여','b');
insert into jikwon values(15,'채미리',20,'사원',4000,'2016-11-03','여','a');
insert into jikwon values(16,'이유가',20,'사원',3000,'2016-02-01','여','c');
insert into jikwon values(17,'한국인',10,'부장',8000,'2006-01-13','남','c');
insert into jikwon values(18,'이순기',30,'과장',7800,'2011-11-03','남','a');
insert into jikwon values(19,'이유라',30,'대리',5500,'2014-03-04','여','a');
insert into jikwon values(20,'김유라',20,'사원',2900,'2019-12-05','여','b');
insert into jikwon values(21,'장비',20,'사원',2950,'2019-08-05','남','b');
insert into jikwon values(22,'김기욱',40,'대리',5850,'2013-02-05','남','a');
insert into jikwon values(23,'김기만',30,'과장',6600,'2015-01-09','남','a');
insert into jikwon values(24,'유비',20,'대리',4500,'2014-03-02','남','b');
insert into jikwon values(25,'박혁기',10,'사원',3800,'2016-11-02','남','a');
insert into jikwon values(26,'김나라',10,'사원',3500,'2016-06-06','남','b');
insert into jikwon values(27,'박하나',20,'과장',5900,'2012-06-05','여','c');
insert into jikwon values(28,'박명화',20,'대리',5200,'2013-06-01','여','a');
insert into jikwon values(29,'박가희',10,'사원',4100,'2016-08-05','여','a');
insert into jikwon values(30,'최미숙',30,'사원',4000,'2015-08-03','여','b');
select * from jikwon;

create table gogek(
gogekno int primary key,
gogekname varchar(10) not null,
gogektel varchar(20),
gogekjumin char(14),
gogekdamsano int,
CONSTRAINT FK_gogekdamsano foreign key(gogekdamsano) references jikwon(jikwonno));

insert into gogek values(1,'이나라','02-535-2580','850612-1156777',5);
insert into gogek values(2,'김혜순','02-375-6946','700101-1054777',3);
insert into gogek values(3,'최부자','02-692-8926','890305-1065777',3);
insert into gogek values(4,'김해자','032-393-6277','770412-2028777',13);
insert into gogek values(5,'차일호','02-294-2946','790509-1062777',2);
insert into gogek values(6,'박상운','032-631-1204','790623-1023777',6);
insert into gogek values(7,'이분','02-546-2372','880323-2558777',2);
insert into gogek values(8,'신영래','031-948-0283','790908-1063777',5);
insert into gogek values(9,'장도리','02-496-1204','870206-2063777',4);
insert into gogek values(10,'강나루','032-341-2867','780301-1070777',12);
insert into gogek values(11,'이영희','02-195-1764','810103-2070777',3);
insert into gogek values(12,'이소리','02-296-1066','810609-2046777',9);
insert into gogek values(13,'배용중','02-691-7692','820920-1052777',1);
insert into gogek values(14,'김현주','031-167-1884','800128-2062777',11);
insert into gogek values(15,'송운하','02-887-9344','830301-2013777',2);
select * from gogek;

SELECT * FROM sangdata;

DESC buser;
DESC jikwon;
DESC gogek;


-- select 출발 : 9월 7일 ~~~~~

-- SELECT [DISTINCT] db명.소유자명.테이블명.칼럼명 [AS 별명]... [INTO 테이블명]
-- FROM 테이블명 ...
-- WHERE 조건 ...
-- ORDER BY 기준키 ASC[DESC]

-- select 조회방법 
-- 행 단위 조회 : selection
-- 열 단위 조회 : projection

DESC jikwon;
SELECT * FROM jikwon;
SELECT jikwonno,jikwonname,jikwonpay FROM jikwon; -- 일부 컬럼만 읽기
SELECT jikwonpay,jikwonno,jikwonname FROM jikwon; -- 칼럼의 순서 동적으로 읽기
SELECT jikwonno AS 사번,jikwonname 직원명,jikwonpay '연 봉' FROM jikwon; -- 칼럼에 별명 부여

SELECT 10,'안녕',12 / 3 AS result FROM DUAL;  -- 가상의 테이블
SELECT 10,'안녕',12 / 3 AS result

SELECT jikwonname AS 직원명,jikwonpay AS 연봉,jikwonpay * 0.02 AS 세금 FROM jikwon;
SELECT CONCAT(jikwonname, '님') AS 이름, jikwongen AS 성별 FROM jikwon; -- 문자열 더하기

SELECT test.jikwon.jikwonname FROM jikwon; -- db명.데이블명.컬럼명
SELECT myjik.jikwonname FROM jikwon AS myjik; -- 테이블에 별명을 주고 별명.칼럼 가능

-- 정렬(sort)  - 그룹별 작업이 가능해짐
SELECT * from jikwon ORDER BY jikwonpay ASC; -- jikwonpay별 오름차순 정렬
SELECT * FROM jikwon ORDER BY jikwonpay;
SELECT jikwonno,jikwonname,jikwongen FROM jikwon ORDER BY jikwongen;
SELECT jikwonno,jikwonname,jikwongen FROM jikwon ORDER BY jikwongen DESC;
SELECT * FROM jikwon ORDER BY busernum ASC,jikwonjik DESC,jikwonpay ASC;
SELECT jikwonname,jikwonpay / 100 * 100 AS pay FROM jikwon ORDER BY pay DESC; -- 연산결과에 대한 정렬도 가능


SELECT distinct jikwonjik FROM jikwon; -- 중복 자료 배제(distinct)

-- 연산자 사용 : 우선순위 () > 산술> 관계(비교) > is null,like,in > between, not > and > or
-- 행단위 조회 : selection
SELECT * FROM jikwon WHERE jikwonjik='대리';  -- 행(레코드) 제한 
SELECT * FROM jikwon WHERE jikwonno <=5; -- int는 '' 둘러도 되고 안둘러도 됨 대신 문자나 날짜는 필수
SELECT * FROM jikwon WHERE jikwonibsail <='2010-01-03';
SELECT * FROM jikwon WHERE jikwonno=5 OR jikwonno=7;
SELECT * FROM jikwon WHERE jikwonjik='사원' AND jikwongen='남' AND jikwonpay <= 4500;
SELECT * FROM jikwon WHERE jikwonjik='사원' AND jikwongen='여' or jikwonibsail >= '2017-1-1'; 
-- 사원이면서  성별이 여 이거나  2017-1-1 일 입사일 이후에 들어온 사람
SELECT * FROM jikwon WHERE jikwonjik='사원' AND (jikwongen='여' or jikwonibsail >= '2017-1-1');
-- 사원 중에 성별이 여 이거나 2017-1-1 일 입사일 이후에 들어온 사람

SELECT * FROM jikwon WHERE jikwonno=5 and jikwonno <= 10;
SELECT * FROM jikwon WHERE jikwonno BETWEEN 5 AND 10; -- 결과 위와 동일
SELECT * FROM jikwon WHERE jikwonno < 5 or jikwonno > 10;
SELECT * FROM jikwon WHERE jikwonno NOT BETWEEN 5 AND 10; -- 결과 위와 동일
-- 참고 : 조건은 긍정적 형태일 경우 속도가 더 빠름

SELECT * FROM jikwon WHERE jikwonibsail BETWEEN '2015-1-1' AND '2016-12-31';

SELECT * FROM jikwon WHERE jikwonname='홍길동';
SELECT * FROM jikwon WHERE jikwonname >='박';
SELECT ASCII('a'),ASCII('A'),ASCII('가'),ASCII('나');  -- 이를 근거로 문자도 연산 가능
SELECT * FROM jikwon WHERE jikwonname >='김' AND jikwonname <='이';
SELECT * FROM jikwon WHERE jikwonname BETWEEN '김' AND '이';

-- in 멤버 조건 연산
SELECT * FROM jikwon WHERE jikwonjik ='대리' OR jikwonjik='과장' OR jikwonjik='부장';
SELECT * FROM jikwon WHERE jikwonjik IN ('대리''과장''부장');
SELECT * FROM jikwon WHERE busernum IN (10,30) ORDER BY busernum ASC;

-- like 조건 연산 : %(0개 이상의 문자열), _(한 개 문자)
SELECT * FROM jikwon WHERE jikwonname LIKE '이%';  -- 이로 시작
SELECT * FROM jikwon WHERE jikwonname LIKE '%라';  -- 라로 끝나는
SELECT * FROM jikwon WHERE jikwonname LIKE '%순%'; -- 순이 포함된
SELECT * FROM jikwon WHERE jikwonname LIKE '이%라'; -- 이로 시작 라로 끝나는

SELECT * FROM jikwon WHERE jikwonname LIKE '이_라'; -- 가운데 한 글자만 아무거나
SELECT * FROM jikwon WHERE jikwonname LIKE '__'; -- 이름 두 글자만

SELECT * FROM gogek;
SELECT * FROM gogek WHERE gogekname LIKE '__';
SELECT * FROM gogek WHERE gogekname LIKE '최%' OR gogekname LIKE '__라';

-- gogek 테이블에서 gogekjumin을 이용해 여성만 출력
SELECT * FROM gogek WHERE gogekjumin LIKE '%-2%' OR gogekjumin LIKE '%-4%';

SELECT * FROM jikwon WHERE jikwonpay LIKE '5%';

SELECT * FROM jikwon WHERE jikwonpay LIKE '5%' LIMIT 3;
SELECT * FROM jikwon WHERE jikwonpay LIMIT 5, 4;  -- 시작행, 행수 : 현재 경우 5개를 건너뛰고 4개 읽기

-- update, delete 에도 조건 연산자 사용 가능
UPDATE jikwon SET jikwonpay=NULL WHERE jikwonno=5; -- 5번 직원 연봉에 null
SELECT * FROM jikwon;
SELECT * FROM jikwon WHERE jikwonpay IS NULL;
SELECT * FROM jikwon WHERE jikwonpay IS not NULL;

-- 다양한 연산자 조합
SELECT jikwonno AS 직원번호, jikwonname 직원명, jikwonjik, jikwonpay /12 AS 보너스, mytab.jikwonibsail
FROM jikwon AS mytab
WHERE jikwonjik IN('과장','사원') AND
jikwonpay >= 4000 AND
jikwonibsail BETWEEN '2015-1-1' AND '2019-12-31'
ORDER BY jikwonjik ASC, jikwonpay DESC
LIMIT 3;

-- json 형식(key:value)으로 출력
SELECT JSON_OBJECT('no',jikwonno,'name',jikwonname,'pay',jikwonpay * 10000) AS 'json data' FROM jikwon
WHERE jikwonjik='대리';

-- CSV 형식으로 파일에 저장
SELECT jikwonno,jikwonname,jikwonpay * 10000 INTO OUTFILE 'c:/works/jikdata.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
FROM jikwon WHERE jikwonjik='대리'; 

-- html 형식으로 파일에 저장
SELECT CONCAT('<tr>','<td>',jikwonname,'<td>','<td>',jikwonpay * 10000,'<td>',
'<tr>','<table>'
) INTO OUTFILE 'c:/works/jikdata.html'
FROM jikwon WHERE jikwonjik='대리';

-- 내장 함수 호출

-- 단일 행 함수: 행 단위 처리
-- 문자 관련 함수
SELECT LOWER('Hello sql'), UPPER('Hello sql') FROM DUAL; -- 대, 소문자로 변환
SELECT CONCAT('Hello world');
SELECT SUBSTR('hello world',3), SUBSTR('hello world', 3,3), SUBSTR('hello world', -3,3); -- 문자열 읿부 추출
SELECT LENGTH('hello world'); -- 문자 길이 출력
SELECT INSTR('hello world', 'e'), INSTR('hello world', 'k'); -- 해당하는 문자 갯수
SELECT TRIM(' aabb bbaa '), LTRIM(' aabb bbaa '), RTRIM(' aabb bbaa ');  -- 앞 뒤로 공백제거, 앞 공백제거, 뒤 공백제거
SELECT REPLACE('011.1234.5678','.','-'), REPLACE('abc def abc','abc','ABC'); -- 문자열 치환(011-1234-5678)

SELECT jikwonname,jikwonjik,REPLACE(jikwonjik,'사원','평직원') FROM jikwon; -- 행 단위 처리(사원 이름을 평직원으로)

SELECT * FROM jikwon;
-- jikwon 테이블에서 이름에 '이'가 포함된 직원이 있다면 '이'부터 두 글자 출력
-- (마지막에 '이'가 있는 경우는 한 글자 출력)
SELECT jikwonname, SUBSTR(jikwonname, INSTR(jikwonname, '이'), 2) FROM jikwon
WHERE jikwonname LIKE '%이%';

-- 숫자 관련 함수 일부 체험
SELECT ROUND(12.3456),ROUND(12.5678, 0),ROUND(12.3456, 1),ROUND(12.3456, -1),ROUND(17.3456, -1);
SELECT ceil(12.3456),floor(12.5678);  -- 올림/버림
SELECT jikwonname,jikwonpay,ROUND(jikwonpay * 0.025) AS tax FROM jikwon LIMIT 5;

SELECT TRUNCATE(45.678, 0), TRUNCATE(45.678, 1), TRUNCATE(45.678, -1); -- 소숫점 기준으로 정수 취하고 나머지 버림

SELECT MOD(15,2);  -- 15/2

SELECT GREATEST(15.5,12,32), GREATEST(15.5,12,32), POW(2, 3), SQRT(4); -- 큰값,작은 값,루트

-- 날짜 함수(윤년 체크가 됨)
 SELECT CURDATE(), CURDATE() + 0;   -- 2026-09-07  20260907(1970년1월1일 기준 시간 계산)
 SELECT NOW(), NOW() +0;
 SELECT NOW(), SYSDATE(); -- 쿼리가 시작된 시간 고정, 쿼리문 실행할 때 마다 새로 시간 기록
 
 -- 날짜 더하기 빼기
 SELECT ADDDATE(DATE'2026-9-1', 3), SUBDATE(DATE'2026-9-1', 3);
 SELECT DATE_ADD(NOW(),INTERVAL 1 MINUTE), DATE_ADD(NOW(),INTERVAL 5 day), DATE_ADD(NOW(),INTERVAL 1 Month);
 SELECT DATE_sub(NOW(),INTERVAL 2 YEAR), DATE_ADD(NOW(),INTERVAL -2 YEAR);
 
 SELECT DATEDIFF('2026-9-1','2023-6-1'), DATEDIFF(NOW(),'2023-6-1');
 SELECT TIMEDIFF('2026-9-1','2023-6-1'), TIMEDIFF(NOW(),'2023-6-1'); -- 시간 관련
 
 -- 형 변환 함수 : DATE_FORMAT
 SELECT DATE_FORMAT(NOW(),'%Y%m%d'), DATE_FORMAT(NOW(),'%Y-%m-%d'), DATE_FORMAT(NOW(), '%년%월%일');
 SELECT DATE_FORMAT(NOW(),'%Y-%m-%d %H:%h:%S'), DATE_FORMAT(NOW(),'%y-%M-%D %h:%i:%S %W');
 -- date_format 서식 검색을 이용
 
 SELECT STR_TO_DATE('2026-9-7','%Y-%m-%d'); -- 문자열이 날짜 타입으로 변환
 
 
 SELECT FORMAT(1234.567, 2), ROUND(1234.567, 2); -- 타입이 문자열, 타입이 숫자
 
 -- 기타 함수
 -- rank(): 순위 결정 -동점 처리, dense_rank(): 동점 처리 안함
 SELECT jikwonno,jikwonname,jikwonpay,
 rank() OVER(ORDER BY jikwonpay),
 dense_rank() OVER(ORDER BY jikwonpay)
 FROM jikwon WHERE jikwonpay IS NOT NULL; -- 오름차순
 
 SELECT jikwonno,jikwonname,jikwonpay,
 rank() OVER(ORDER BY jikwonpay desc),
 dense_rank() OVER(ORDER BY jikwonpay desc)
 FROM jikwon WHERE jikwonpay IS NOT NULL; -- 내림차순
 
 SELECT jikwonno,jikwonname,jikwonibsail,
 rank() OVER(ORDER BY jikwonibsail),
 dense_rank() OVER(ORDER BY jikwonibsail)
 FROM jikwon WHERE jikwonibsail IS NOT NULL;  -- 입사 년도별
 
 -- nvl(value1, value2) : value1이 null이면 value2를 취함
 UPDATE jikwon SET jikwonjik=NULL WHERE jikwonno=5;
 SELECT * FROM jikwon WHERE jikwonno=5;
 SELECT jikwonname,nv1(jikwonjik,'임시직'),nv1(jikwonpay,0) FROM jikwon;
 
 -- nvl2(value1,value2,value3) : value1이 null이면 value3을 취하고 null이 아니면 value2를 취함
 SELECT jikwonname,NVL2(jikwonjik, '정규직','임시직') AS jik,jikwongen,
 NVL2(jikwonpay, jikwonpay, 0) AS pay
 FROM jikwon;
 
 -- nullif(value1, value2) : 두 개의 값이 일치하면 null을, 일치하지 않으면 valur1을 취함
 SELECT NULLIF(LENGTH('abcd'),LENGTH('123')); -- 4
 SELECT NULLIF(LENGTH('abc'),LENGTH('123')); -- null
 SELECT jikwonname,jikwonjik,NULLIF(jikwonjik,'사원') FROM jikwon WHERE jikwonjik IS NOT null;
 
 
 -- 조건 표현식(conditional Expressions)
 -- 형식 1) case 표현식 when 비교값1 then 결과값1 when 비교값2 then 결과값2 ...[else 결과값n] end as 별명
SELECT case 10/5 when 5 then '안녕' when 2 then '수고' ELSE '잘가' END AS 결과 FROM DUAL;	
SELECT jikwonname,jikwonpay
when 3000 then '연봉3000'
when 3500 then '연봉3500'
ELSE '기타연봉'
END AS result
FROM jikwon;

SELECT jikwonname,jikwonpay,jikwonjik,
case jikwonpay
when '이사' then jikwonpay * 0.05
when '부장' then jikwonpay * 0.04
when '과장' then jikwonpay * 0.03
ELSE jikwonpay * 0.02
END AS donation
FROM jikwon;

-- 형식 2)  case when 조건1 then 결과값1 when 조건2 then 결과값2 ...[else 결과값n] end as 별명
SELECT jikwonname,
case when jikwongen='남' then 'M' when jikwongen='여' then 'F' END AS jender
FROM jikwon;

SELECT jikwonname,jikwonpay,
case
when jikwonpay >= 7000 then '고액연봉'
when jikwonpay >= 5000 then '보통연봉'
ELSE '낮은연봉'
END AS result
FROM jikwon WHERE jikwonjik IN('대리','과장');


-- 조건 표현식(if (조건) 참값, 거짓값 as 별명)
SELECT jikwonname,jikwonpay,jikwonjik,
if(TRUNCATE(jikwonpay / 1000, 0) >= 5, 'good', 'normal') AS result
FROM jikwon;

SELECT * FROM jikwon;

-- 문제1) 10년 이상 근무하면 '감사합니다', 그 외는 '열심히' 라고 표현 ( 2010 년 이후 직원만 참여 )
-- 특별수당(pay를 기준) : 10년 이상 5%, 나머지 3% (정수로 표시:반올림)
SELECT jikwonname AS 직원명,
timestampDIFF(year,jikwonibsail,NOW()) AS 근무년수, -- year,시작일,종료일
case
when timestampDIFF(year,jikwonibsail,NOW()) >= 10 then '감사합니다'
ELSE '열심히' 
END AS 표현,

case
when timestampDIFF(year,jikwonibsail,NOW()) >= 10 then ROUND(jikwonpay * 0.05, 0)
ELSE round(jikwonpay * 0.03, 0)
END AS 특별수당
FROM jikwon
WHERE jikwonibsail >= '2010-1-1';

-- 문제2) 입사 후 10년 이상이면 왕고참, 8년 이상이면 고참, 5년 이상이면 보통, 나머지는 일반으로 표현
SELECT jikwonname AS 직원명, jikwonjik AS 직급, jikwonibsail AS 입사년월일,
case
when TIMESTAMPDIFF(YEAR,jikwonibsail,NOW()) >= 10 then '왕고참'
when TIMESTAMPDIFF(YEAR,jikwonibsail,NOW()) >= 8 then '고참'
when TIMESTAMPDIFF(YEAR,jikwonibsail,NOW()) >= 5 then '보통'
ELSE '일반'
END AS 구분,

case busernum
when 10 then '총무부'
when 20 then '영업부'
when 30 then '관리부'
when 40 then '기회부'
ELSE '기타'
END AS 부서

FROM jikwon;
 
-- 문제3) 각 부서번호별로 실적에 따라 급여를 다르게 인상하려 한다. 

-- pay를 기준으로 10번은 10%, 30번은 20% 인상하고 나머지 부서는 동결한다.

-- 10년 이상 장기근속을 O, X로 표시

-- 금액은 정수만 출력(반올림)

SELECT jikwonno AS 사번,jikwonname AS 직원명,busernum AS 부서,jikwonpay AS 연봉,
case
when busernum = 10 then ROUND(jikwonpay * 1.1)
when busernum = 30 then ROUND(jikwonpay * 1.2)
ELSE jikwonpay
END AS '인상연봉',

case
when TIMESTAMPDIFF(YEAR,jikwonibsail,NOW()) >= 10 then '0'
ELSE 'x'
END AS '장기근속'

FROM jikwon;


-- 9.8 복수행 함수 (집계 함수) : 전체 자료를 그룹별로 구분해 통계결과를 얻기 위한 함수
--                                NULL 값 무시 (count(*)는 제외)

SELECT SUM(jikwonpay) AS 합, AVG(jikwonpay) AS 평균  FROM jikwon;
SELECT max(jikwonpay) AS 최대값, min(jikwonpay) AS 최소값  FROM jikwon;
SELECT * FROM jikwon;
SELECT AVG(jikwonpay), AVG(nvl(jikwonpay,0)) FROM jikwon; -- 5384.4838   5205.0
SELECT SUM(jikwonpay) / 29, SUM(jikwonpay) / 30 FROM jikwon; -- 5384.4838   5205.0
SELECT COUNT(*), COUNT(jikwonno), COUNT(jikwonpay) FROM jikwon;
SELECT STDDEV(jikwonpay) AS 표준편차, VAR_SAMP(jikwonpay) AS 분산 FROM jikwon;

-- 과장은 몇 명?
SELECT COUNT(*) AS 인원수 FROM jikwon WHERE jikwonjik='과장';

-- 2010년 이전에 입사한 남직원은 몇 명?
SELECT COUNT(*) AS 인원수 FROM jikwon WHERE jikwonibsail < '2010-1-1' AND jikwongen='남';

-- 2015년 이후 입사한 여직원의 연봉합, 평균, 인원수?
SELECT SUM(jikwonpay) 연봉합, AVG(jikwonpay) 연봉평균, COUNT(*) AS 인원수
FROM jikwon WHERE jikwonibsail >= '2015-1-1' AND jikwongen='여';


-- 그룹 함수 - group by를 이용해 소계 출력
-- 형식 : select 그룹칼럼명, 계산함수 .. from 테이블명 where 조건
--        group by 그룹칼럼명 having 출력 결과에 대한 조건
-- group by에 order by 할 수 없다.(내장됨) 단, 출력 결과는 order by 가능함

-- 성별 연봉의 평균, 인원수 출력
SELECT jikwongen, AVG(jikwonpay), COUNT(*) FROM jikwon GROUP BY jikwongen;
SELECT jikwongen, AVG(jikwonpay), COUNT(jikwonpay) FROM jikwon GROUP BY jikwongen; -- NULL 제외
SELECT jikwongen, AVG(nvl(jikwonpay, 0)), COUNT(*) FROM jikwon GROUP BY jikwongen; -- NULL 처리

-- 부서별 연봉합
SELECT busernum, SUM(jikwonpay) FROM jikwon GROUP BY busernum;

-- 부서별 연봉합 - 연봉합이 35000 이상
SELECT busernum, SUM(jikwonpay) FROM jikwon GROUP BY busernum HAVING SUM(jikwonpay) >= 35000;
SELECT busernum bun, SUM(jikwonpay) hap FROM jikwon GROUP BY busernum HAVING hap >= 35000; -- 별명 사용(bun, hap)

-- 부서별 연봉합 - 연봉합이 15000 이상인 여직원이 대상
SELECT busernum, SUM(jikwonpay) FROM jikwon WHERE jikwongen='여'
GROUP BY busernum HAVING SUM(jikwonpay) >= 15000;

SELECT busernum, SUM(jikwonpay) FROM jikwon ORDER BY busernum DESC GROUP BY busernum; -- 에러
SELECT busernum, SUM(jikwonpay) FROM jikwon group BY busernum 
ORDER BY SUM(jikwonpay) DESC; -- group by 결과에 대한 정렬은 가능


SELECT * FROM jikwon;
-- 1번
SELECT jikwonjik, AVG(jikwonpay) FROM jikwon WHERE jikwonjik IS NOT NULL GROUP BY jikwonjik;
-- 2번
SELECT jikwonjik, sum(jikwonpay) FROM jikwon WHERE jikwonjik='부장' or jikwonjik='과장' GROUP BY jikwonjik;
-- 3번 
SELECT year(jikwonibsail) 년도, COUNT(*) 직원수 FROM jikwon WHERE jikwonibsail < '2015-1-1' GROUP BY year(jikwonibsail);
-- 4번
SELECT (nvl(jikwonjik, '임시직'))AS 직급, jikwongen 성별, COUNT(*) 인원수, sum(jikwonpay) AS 급여함 FROM jikwon GROUP BY jikwonjik, jikwongen;
-- 5번
SELECT busernum 부서번호, sum(jikwonpay) FROM jikwon WHERE busernum='10' OR busernum='20' GROUP BY busernum;
-- 6번
SELECT (nvl(jikwonjik, '임시직')) AS 직급,sum(jikwonpay) AS 급여함, jikwonjik 직급 FROM jikwon GROUP BY jikwonjik HAVING AVG(jikwonpay) >= 7000;
-- 7번
SELECT (nvl(jikwonjik, '임시직')) AS 직급,COUNT(*) AS 인원수,SUM(jikwonpay) AS 급여합계 FROM jikwon GROUP BY jikwonjik HAVING COUNT(*) >= 3;


-- join
-- 서로 다른 두 개 이상의 테이블에서 관련 있는 행을 연결해서 조회하는 기능
-- 서로 다른 테이블 간 공통 칼럼(성격이 같음)이 있어야 한다

SELECT * FROM buser;
INSERT INTO buser(buserno,busername) VALUE(50,'전략기획부');

SELECT * FROM jikwon;
DESC jikwon; -- busernum은 not null

-- 구조 변경
ALTER TABLE jikwon MODIFY busernum INT NULL;
UPDATE jikwon SET busernum=NULL WHERE jikwonno=5;
SELECT * FROM jikwon;

SELECT test.jikwon.jikwonname FROM jikwon;  -- db명.테이블명.칼럼명
SELECT jiktab.jikwonname FROM jikwon AS jiktab; -- 테이블명 별명 부여 후 별명테이블명.칼럼명

-- cross join : 두 테이블의 모든 행을 서로 한번씩 조합하는 조인
SELECT jikwonname,busername from jikwon,buser;
SELECT jikwonname,busername from jikwon cross join buser;
SELECT * FROM jikwon CROSS JOIN buser;
SELECT jikwon.jikwonname,buser.busername from jikwon cross join buser; -- 동일 칼럼명 테이블 구분
SELECT j.jikwonname,b.busername from jikwon AS j cross join buser as b; -- 별명 사용

-- self join : 한 개의 테이블로 cross join - 같은 테이블을 마치 다른 테이블처럼 별명을 붙여 연결
SELECT a.jikwonname, b.jikwonname FROM jikwon a, jikwon b;


-- EQUI join : 조인 조건식에 '='을 사용
SELECT jikwonname, busername FROM jikwon,buser
WHERE jikwon.busernum=buser.buserno;  -- 공통칼럼에 대해 '='을 사용

-- NON-EQUI join : 조인 조건식에 '=' 이외의 관계 연산자를 사용
CREATE TABLE paygrade (grade INT PRIMARY KEY, lpay INT, hpay INT);
INSERT INTO paygrade VALUES(1, 0, 1999);
INSERT INTO paygrade VALUES(2, 2000, 2999);
INSERT INTO paygrade VALUES(3, 3000, 3999);
INSERT INTO paygrade VALUES(4, 4000, 4999);
INSERT INTO paygrade VALUES(5, 5000, 9999);
SELECT * FROM paygrade;

SELECT * FROM jikwon;

-- 연봉이 lpay ~ hpay 범위에 포함되는 연봉등급과 연결하는 nin-equi join
-- 두 테이블을 같은 값으로 연결하지 않고, 범위나 크기 비교 조건으로 연결하는 조인
SELECT jikwonname, jikwonpay, grade
FROM jikwon, paygrade
WHERE jikwonpay >= lpay AND jikwonpay <= hpay;  -- jikwonpay에 등급을 표시

SELECT j.jikwonname, j.jikwonpay, p.grade
FROM jikwon j JOIN paygrade p 
ON j.jikwonpay >= p.lpay AND j.jikwonpay <= p.hpay; -- 결과 상동 (개량된 방법)

SELECT j.jikwonname, j.jikwonpay, p.grade
FROM jikwon j JOIN paygrade p 
ON j.jikwonpay between p.lpay AND p.hpay; -- 결과 상동

-- inner join : 두 테이블을 조인 할 때, 두 테이블에 모두 지정한 열의 데이터가 있어야 한다.
-- 조인 조건에 일치하는 데이터가 양쪽 테이블에 모두 존재하는 행만 조회하는 방식
-- 방식1 : 테이블을 콤마로 구분
SELECT jikwonno,jikwonname,busername FROM jikwon,buser
WHERE busernum = buserno;

SELECT jikwon.jikwonno,jikwon.jikwonname,buser.busername FROM jikwon,buser
WHERE jikwon.busernum = buser.buserno;

SELECT jtab.jikwonno,jtab.jikwonname,btab.busername FROM jikwon jtab,buser btab
WHERE jtab.busernum = btab.buserno;  -- 별명 사용

SELECT jikwonno,jikwonname,busername FROM jikwon,buser
WHERE busernum = buserno AND jikwongen='남'; -- where에 '조인 조건'과 '헹 제한 조건'이 함께 기술

-- 방법2 : ANSI join 문법 - 조인 조건과 행 검색 조건을 분리
SELECT jikwonno,jikwonname,busername
FROM jikwon inner join buser ON busernum = buserno;

SELECT jikwonno,jikwonname,busername
FROM jikwon inner join buser ON busernum = buserno
WHERE jikwongen='남';

-- outer join : 두 테이블을 조인 할 때, 조인 조건에 맞는 데이터 뿐 아니라 한쪽 테이블에만 있는 데이터도 조회
-- left outer join : 왼쪽 테이블의 데이터는 모두 출력
SELECT jikwon.jikwonno,jikwon.jikwonname,buser.busername FROM jikwon,buser
WHERE jikwonbusernum = buser.buserno(+);  -- 대응 안된 오른쪽 테이블에 null 허용. oracle에서 가능

SELECT jikwonno,jikwonname,busername
FROM jikwon LEFT OUTER join buser ON jikwon.busernum = buser.buserno;  -- ANSI SQL(표준 SQL문법)


-- right outer join : 왼쪽 테이블의 데이터는 모두 출력
SELECT jikwon.jikwonno,jikwon.jikwonname,buser.busername FROM jikwon,buser
WHERE jikwonbusernum = buser.buserno(+);  -- 대응 안된 오른쪽 테이블에 null 허용. oracle에서 가능

SELECT jikwonno,jikwonname,busername
FROM jikwon right OUTER join buser ON jikwon.busernum = buser.buserno;  -- ANSI SQL(표준 SQL문법)


-- full outer join : 양쪽 테이블의 모든 행을 조회하되 일치하지 않는 쪽의 컬럼은 null로 표시
SELECT jikwonno,jikwonname,busername
FROM jikwon FULL outer join buser ON jikwon.busernum = buser.buserno; -- 오라클에서만 동작

-- maria db 에서 가능한 것
SELECT jikwonno,jikwonname,busername
FROM jikwon LEFT OUTER join buser ON jikwon.busernum = buser.buserno
UNION
SELECT jikwonno,jikwonname,busername
FROM jikwon RIGHT OUTER join buser ON jikwon.busernum = buser.buserno;


SELECT jikwonno,jikwonname,busername,busertel
FROM jikwon inner join buser ON jikwon.busernum = buser.buserno
WHERE jikwonname LIKE '김%';  -- 테이블이 복 수 일 뿐 그전 작업은 그대로 사용하게 된다.

SELECT SUM(jikwonpay) AS hap, COUNT(*) AS count
FROM jikwon inner join buser ON jikwon.busernum = buser.buserno
WHERE jikwonname LIKE '김%';

DESC buser;
DESC jikwon; -- buser.buserno, jikwon.busernum 공통 컬럼
DESC gogek;  -- jikwon.jikwonno, buser.gogekdamsano 공통 칼럼.
-- buser와 gogek은 공통 칼럼이 없어 직접 조인 불가.
SELECT * FROM gogek;


SELECT * FROM jikwon;

-- 1번
SELECT j.jikwonno 사번,j.jikwonname 직원명,j.jikwonjik 직급,p.gogekname 고객명,p.gogektel 고객전화,
if(p.gogekjumin LIKE '%-1%' OR p.gogekjumin LIKE '%-3%', '남','여') 고객성별 -- 1,3 이면  남 아닌경우 여 출력
FROM jikwon j INNER JOIN gogek p ON j.jikwonno = p.gogekdamsano
WHERE j.jikwonjik='사원';

-- 2번
SELECT j.jikwonno, COUNT(gogekno) AS 고객수
FROM jikwon j LEFT JOIN gogek p ON j.jikwonno = p.gogekdamsano
GROUP BY j.jikwonno;

-- 3번
SELECT j.jikwonname 직원명, j.jikwonjik 직급, p.gogekname 고객명
FROM jikwon j INNER JOIN gogek p ON j.jikwonno = p.gogekdamsano
WHERE p.gogekname='강나루';

-- 4번
SELECT p.gogekname 고객명,p.gogektel 고객전화,p.gogekjumin 주민번호,
CASE 
WHEN SUBSTR(p.gogekjumin, 8, 1) < 3 THEN DATE_FORMAT(NOW(), '%Y') - (SUBSTR(p.gogekjumin, 1, 2) + 1900)
ELSE DATE_FORMAT(NOW(), '%Y') - (SUBSTR(p.gogekjumin, 1, 2) + 2000) -- substr(문자열,시작위치,가져올 글자수)
END AS 나이
FROM jikwon j INNER JOIN gogek p ON j.jikwonno = p.gogekdamsano
WHERE j.jikwonname='이순신';




-- 세 개의 테이블
SELECT jikwonname, busername, gogekname FROM jikwon, buser, gogek
WHERE busernum=buserno AND jikwonno=gogekdamsano;

SELECT jikwonname,busername,gogekname
FROM jikwon 
INNER join buser ON busernum = buserno
JOIN gogek ON jikwonno = gogekdamsano;

SELECT * FROM buser;
-- 서울에 근무하는 직원이 담당하는 고객출력
SELECT g.gogekname AS 고객명, j.jikwonname AS 담당직원, busername AS 부서명, b.buserloc AS 근무지역
FROM gogek g
INNER JOIN jikwon j ON j.jikwonno = g.gogekdamsano
INNER JOIN buser b ON j.busernum = b.buserno
WHERE b.buserloc='서울';

-- 담당 고객이 2명이상인 직원정보 출력
SELECT j.jikwonname AS 직원명, b.busername AS 부서명,COUNT(gogekno) AS 담당고객수
FROM jikwon j
inner JOIN buser b ON j.busernum=b.buserno
inner JOIN gogek g ON j.jikwonno=g.gogekdamsano
GROUP BY j.jikwonno, j.jikwonname,b.busername
HAVING 담당고객수 >= 2;


-- join 연습2 -- 
SELECT* FROM buser;
SELECT* FROM gogek;
SELECT* FROM jikwon;

-- 문1) 총무부에서 관리하는 고객수 출력 (고객 30살 이상만 작업에 참여)
SELECT COUNT(*) AS 고객수
FROM jikwon j
INNER JOIN buser b ON j.busernum = b.buserno
INNER JOIN gogek g ON j.jikwonno = g.gogekdamsano
WHERE b.busername = '총무부'
AND 
(CASE WHEN SUBSTR(g.gogekjumin,8,1) IN ('1','2') 
THEN DATE_FORMAT(NOW(),'%Y') - (1900 + SUBSTR(g.gogekjumin,1,2))
ELSE DATE_FORMAT(NOW(),'%Y') - (2000 + SUBSTR(g.gogekjumin,1,2))
END) >= 30;

-- 문2) 부서명별 고객 인원수 (부서가 없으면 "무소속")
SELECT nvl(busername,'무소속') AS 부서명, COUNT(g.gogekno) AS 고객인원수
FROM jikwon j
inner JOIN buser b ON j.busernum = b.buserno
inner JOIN gogek g ON j.jikwonno = g.gogekdamsano
GROUP BY nvl(b.busername,'무소속'); 


-- 문3) 고객이 담당직원의 자료를 보고 싶을 때 즉, 고객명을 입력하면  담당직원 자료 출력  
--        :    ~ WHERE GOGEK_NAME='강나루'
-- 출력 ==>  직원명    직급   부서명  부서전화    성별
SELECT j.jikwonname AS 직원명, j.jikwonjik AS 직급, b.busername AS 부서명, b.busertel AS 부서전화,j.jikwongen AS 성별
FROM jikwon j
inner JOIN buser b ON j.busernum=b.buserno
inner JOIN gogek g ON j.jikwonno=g.gogekdamsano
WHERE g.gogekname = '강나루';
 

-- 문4) 부서와 직원명을 입력하면 관리고객 자료 출력
--         ~ WHERE BUSER_NAME='영업부' AND JIKWON_NAME='이순신'
-- 출력 ==>  고객명    고객전화      성별
--           강나루   123-4567       남
SELECT g.gogekname AS 고객명, g.gogektel AS 고객전화, 
case 
WHEN SUBSTR(g.gogekjumin, 8, 1) IN (1, 3) THEN '남'
WHEN SUBSTR(g.gogekjumin, 8, 1) IN (2, 4) THEN '여'
END AS 성별
FROM jikwon j
inner JOIN buser b ON j.busernum=b.buserno
inner JOIN gogek g ON j.jikwonno=g.gogekdamsano
WHERE b.busername = '영업부' AND j.jikwonname = '이순신';

-- 문5) 담당 고객이 한 명도 없는 직원 찾기
SELECT j.jikwonno, j.jikwonname, j.jikwonjik
FROM jikwon j
LEFT OUTER JOIN gogek g ON j.jikwonno = g.gogekdamsano
WHERE g.gogekno IS NULL;


-- 문6) buser, jikwon, gogek 세 테이블을 이용하여 부서명, 직원명, 직급, 담당 고객 수를 출력하시오.

-- 단, 담당 고객이 없는 직원도 출력하고 담당 고객 수가 많은 직원부터 정렬하시오.

-- 저작자 표시컨텐츠변경비영리

SELECT b.busername AS 부서명, j.jikwonname AS 직원명, j.jikwonjik AS 직급, COUNT(g.gogekno) AS 담당고객수
FROM jikwon j
LEFT OUTER JOIN buser b ON j.busernum = b.buserno
LEFT OUTER JOIN gogek g ON j.jikwonno = g.gogekdamsano
GROUP BY j.jikwonno, j.jikwonname, j.jikwonjik
ORDER BY 담당고객수 DESC;


-- ---------------------------------------------------------------

-- union : 구조가 일치하는 두 개 이상의 테이브 자료 합쳐보기
CREATE TABLE sangpum1(bun INT PRIMARY KEY, pummok VARCHAR(20) NOT NULL);
INSERT INTO sangpum1 VALUES(1, '귤');
INSERT INTO sangpum1 VALUES(2, '사과');
INSERT INTO sangpum1 VALUES(3, '배');
SELECT * FROM sangpum1;


CREATE TABLE sangpum2(num INT PRIMARY KEY, sangpum VARCHAR(20) NOT NULL);
INSERT INTO sangpum2 VALUES(10, '토마토');
INSERT INTO sangpum2 VALUES(20, '오이');
INSERT INTO sangpum2 VALUES(30, '피망');
INSERT INTO sangpum2 VALUES(40, '수박');
SELECT * FROM sangpum2;


SELECT bun AS 번호, pummok AS 상품명 FROM sangpum1
UNION
SELECT num AS 번호, sangpum AS 상품명 FROM sangpum2;

-- 참고 : merge는 mariadb x, oracle o


-- subsquery : sql문 안에 포함된 또다른 select 문의 사용
-- 일반적으로 안쪽 select문을 실행해서 그 결과를 구한 후 바깥쪽 sql문에서 사용하는 방식
-- 복잡한 조건을 단계적으로 처리할 수 있다.

-- 사번 10번 박치기 직원과 직급이 같은 모든 직원 출력
SELECT jikwonjik FROM jikwon WHERE jikwonno = 10;
SELECT * FROM jikwon WHERE jikwonjik='사원'; -- 결과를 위해 두번의 sql문을 사용
-- subquery 사용
SELECT * FROM jikwon WHERE jikwonjik = (SELECT jikwonjik FROM jikwon WHERE jikwonno = 10);

-- 직급이 대리 중 가장 먼저 입사한 직원은?  주의할 사항있음!!!
SELECT min(jikwonibsail) FROM jikwon WHERE jikwonjik='대리';  -- 2013-02-05
SELECT * FROM jikwon WHERE jikwonjik='대리' and jikwonibsail = '2013-02-05';
-- subquery 사용
SELECT * FROM jikwon WHERE jikwonjik='대리' 
AND jikwonibsail = (SELECT min(jikwonibsail) FROM jikwon WHERE jikwonjik='대리');


--  인천에 근무하는 직원출력      - =: 반드시 한개의 값
SELECT * FROM jikwon WHERE busernum = (SELECT buserno FROM buser WHERE buserloc='인천');

-- 인천 이외에 근무하는 직원출력
-- in은 서브쿼리 결과가 여러개 일때, 그 값들 중 하나와 일치하는지 비교하기 위해 사용한다.
SELECT * FROM jikwon WHERE busernum IN (SELECT buserno FROM buser WHERE not buserloc='인천');

-- 서울에 근무하는 직원출력
SELECT * FROM jikwon WHERE busernum IN (SELECT buserno FROM buser WHERE buserloc='서울');

SELECT * FROM gogek;

-- 고객 중 차일호와 나이가 같은 고객 모두를 출력
SELECT * FROM gogek WHERE SUBSTR(gogekjumin, 1,2) = 
(SELECT  SUBSTR(gogekjumin, 1, 2) FROM gogek WHERE gogekname='차일호');

-- 고객을 담당하고 있는 직원은?
SELECT * FROM jikwon WHERE jikwonno IN(SELECT distinct(gogekdamsano) FROM gogek);

-- 이순신 직원이 속한 부서의 평균연봉보다 많이 받는 직원 출력 - subquery 내에 subquery 가능
SELECT * FROM jikwon 
WHERE jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon 
WHERE busernum = (SELECT busernum FROM jikwon WHERE jikwonname = '이순신'));



-- SubQuery 연습문제

-- 문1) 2010년 이후에 입사한 남자 중 급여를 가장 많이 받는 직원은?

SELECT * FROM jikwon WHERE jikwonibsail >= '2010-1-1' and jikwongen='남' 
AND jikwonpay = (SELECT max(jikwonpay) FROM jikwon WHERE jikwongen='남' AND jikwonibsail >= '2010-1-1');
 

-- 문2)  평균급여보다 급여를 많이 받는 직원은?
SELECT * FROM jikwon 
WHERE jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon );
 

-- 문3) '이미라' 직원의 입사 이후에 입사한 직원은?
SELECT * FROM jikwon WHERE jikwonibsail >= (SELECT jikwonibsail FROM jikwon 
WHERE jikwonname = '이미라');

 

-- 문4) 2010 ~ 2015년 사이에 입사한 총무부(10),영업부(20),전산부(30) 직원 중 급여가 가장 적은 사람은? (직급이 NULL인 자료는 작업에서 제외)
SELECT * FROM jikwon 
WHERE jikwonibsail BETWEEN '2010-1-1'AND '2015-12-31' AND busernum IN(10,20,30) AND
jikwonpay = (SELECT MIN(jikwonpay) FROM jikwon WHERE jikwonibsail BETWEEN '2010-1-1'AND '2015-12-31'
and busernum IN (10, 20, 30)) AND jikwonjik IS NOT NULL;


-- 문5) 한송이, 이순신과 직급이 같은 사람은 누구인가? 
SELECT jikwonname, jikwonjik 
FROM jikwon 
WHERE jikwonjik in (SELECT jikwonjik FROM jikwon  WHERE jikwonname IN ('한송이', '이순신'));




-- 문6) 과장 중에서 최대급여, 최소급여를 받는 사람은?
SELECT * FROM jikwon
WHERE jikwonjik = '과장' and jikwonpay 
in ((SELECT MAX(jikwonpay) FROM jikwon
where jikwonjik = '과장'),(SELECT min(jikwonpay) from jikwon WHERE jikwonjik = '과장'));
 
 

 

-- 문7) 30번 부서의 평균급여보다 급여가 많은 '대리' 는 몇명인가? 
SELECT COUNT(jikwonjik) as 인원수 FROM jikwon 
WHERE jikwonjik = '대리' AND jikwonpay > (SELECT AVG(jikwonpay) FROM jikwon WHERE busernum = 30);

 

-- 문8) 고객을 확보하고 있는 직원들의 이름, 직급, 부서명을 입사일 별로 출력하라.
SELECT jikwonname,jikwonjik,busername,jikwonibsail FROM jikwon
LEFT OUTER JOIN buser ON jikwon.busernum = buser.buserno
where jikwonno IN(SELECT distinct(gogekdamsano) FROM gogek) ORDER BY jikwonibsail;


-- 문9) 이순신과 같은 부서에 근무하는 직원과 해당 직원이 관리하는 고객 출력 
-- (고객은 나이가 30 이하면 '청년', 50 이하면 '중년', 그 외는 '노년'으로 표시하고, 고객 연장자 부터 출력)

-- 출력 ==>  직원명    부서명     부서전화     직급      고객명    고객전화    고객구분
--           한송이    총무부     123-1111    사원      백송이    333-3333    청년   


SELECT j.jikwonjik AS 직원명, b.busername AS 부서명,j.jikwonjik AS 직급, g.gogekname AS 고객명, g.gogektel AS 고객전화, g.gogekjumin AS 주민번호,
CASE
WHEN  DATE_FORMAT(NOW(),'%Y') - (SUBSTR(g.gogekjumin, 1, 2) + 1900) <= 30 THEN '청년'
when  DATE_FORMAT(NOW(),'%Y') - (SUBSTR(g.gogekjumin, 1, 2) + 1900) <= 50 THEN '중년'
ELSE '노년'
END AS 고객구분
FROM jikwon j
inner JOIN buser b ON j.busernum=b.buserno
inner JOIN gogek g ON j.jikwonno=g.gogekdamsano
WHERE j.busernum=(SELECT busernum FROM jikwon WHERE jikwonname='이순신')
ORDER BY gogekjumin;
SELECT * FROM gogek

-- 문10) JIKWON, BUSER, GOGEK 테이블을 이용하여 담당 고객 수가 가장 많은 직원을 출력하시오. - 동일한 고객 수를 가진 직원이 여러 명이면 모두 출력한다. 
-- 출력 ==>   부서명   직원명   직급   담당고객수
-- 힌트 :  GROUP BY ~ HAVING 사용
-- 직원별 고객 수 계산 --> 그중 가장 큰 고객 수 계산 --> 그 고객 수를 가진 직원 찾기 ^^

SELECT * FROM buser
SELECT * FROM jikwon

SELECT b.busername AS 부서명, j.jikwonname AS 직원명, j.jikwonjik AS 직급, COUNT(*) AS 담당고객수
FROM jikwon j
inner JOIN buser b ON j.busernum=b.buserno
INNER JOIN gogek g ON j.jikwonno = g.gogekdamsano
GROUP BY j.jikwonno
HAVING COUNT(*) = (
	SELECT MAX(cnt)
	FROM (
		SELECT COUNT(*) AS cnt
		FROM jikwon j2
		INNER JOIN gogek g2 ON j2.jikwonno = g2.gogekdamsano
		GROUP BY j2.jikwonno) AS gogek_count
);
-- as gogek_count는 from절의 서브쿼리 결과를 하나의 테이블처럼 사용하기 위해 붙인 가상 이름

-- 총무부에 근무하는 직원들이 관리하는 고객 출력하기
-- subquery 사용
SELECT gogekno,gogekname,gogektel FROM gogek
WHERE gogekdamsano IN (SELECT jikwonno FROM jikwon
WHERE busernum = (SELECT buserno FROM buser WHERE busername='총무부'));
-- 필요한 값을 단계적으로 찾는다. 총무부번호는? -> 직원번호는 -> 고객은?

-- join 사용
SELECT gogekno,gogekname,gogektel FROM gogek
INNER JOIN jikwon ON jikwonno=gogekdamsano
INNER JOIN buser ON busernum=buserno
WHERE busername='총무부';
-- 관련 테이블을 연결한 뒤 조건으로 조회함. 여러 테이블의 칼럼을 함께 출력할 때 효과적




-- subquery에서 any,all 연산자 : null 인 자료는 제외하고 작업
-- <any : subquery의 반환값 중 최대값 보다 작은~   <=
-- >any : subquery의 반환값 중 최소값 보다 큰~     >=
-- <any : subquery의 반환값 중 최소값 보다 작은~   <=
-- >any : subquery의 반환값 중 최대값 보다 큰~     >=


-- 직급 중 대리의 최대값 보다 작은 연봉을 받는 직원은?
SELECT jikwonno,jikwonname,jikwonpay FROM jikwon
WHERE jikwonpay <ANY (SELECT jikwonpay FROM jikwon WHERE jikwonjik='대리');

-- 30번 부서의 최고 연봉자보다 연봉을 많이 받는 직원은?
SELECT jikwonno,jikwonname,jikwonpay FROM jikwon
WHERE jikwonpay >All (SELECT jikwonpay FROM jikwon WHERE busernum=30);

-- 30번 부서의 최저 연봉자보다 연봉을 많이 받는 직원은?
SELECT jikwonno,jikwonname,jikwonpay FROM jikwon
WHERE jikwonpay >Any (SELECT jikwonpay FROM jikwon WHERE busernum=30);


-- from 절에 사용하는 subquery
-- 전체 평균 연봉과 최대 연봉 사이의 연봉울 받는 직원은?
SELECT jikwonno,jikwonname,jikwonpay
FROM jikwon a, (SELECT AVG(jikwonpay) avgs, MAX(jikwonpay) maxs FROM jikwon) b
WHERE a.jikwonpay BETWEEN b.avgs AND b.maxs;       -- subquery 진행 후 between 5384 and 9900

-- 각 부서별로 최고 연봉을 받는 직원 출력
SELECT a.jikwonno,a.jikwonname,a.jikwonpay,a.busernum FROM jikwon a,
(SELECT busernum, MAX(jikwonpay) maxpay FROM jikwon GROUP BY busernum) b
WHERE a.busernum = b.busernum AND a.jikwonpay = b.maxpay;  
-- 같은 부서이면서 그 부서의 최고 연봉과 같은 직원


-- group by의 HAVING 절에 포함된 subquery
-- 부서별 평균 연봉 중 30번 부서의 평균 연봉 보다 큰 부서 자료 출력
SELECT busernum, AVG(jikwonpay) FROM jikwon
GROUP BY busernum
HAVING AVG(jikwonpay) > (SELECT AVG(jikwonpay) FROM jikwon WHERE busernum=30);


-- exists 연산자 사용
-- 직원이 있는 부서 출력
SELECT busername.buserloc FROM buser bu
WHERE EXISTS (SELECT 'imsi' FROM jikwon WHERE busernum=bu.buserno);  -- EXISTS : true or false 반환

-- 상관 서브쿼리 : outer(main) query의 값을 inner query에서 참조하여 수행하는 서브쿼리
-- 상관 서브쿼리는 서브쿼리가 독립적으로 실행되지 않고, 바같 쿼리의 현재 행 값을 받아서 실행됨
-- 연습1) 각 직원이 자기 부서의 평균 급여보다 많이 받는지 조회

SELECT a.jikwonno,a.jikwonname,a.jikwonpay,busernum FROM jikwon a
WHERE a.jikwonpay > (SELECT AVG(b.jikwonpay) FROM jikwon b WHERE b.busernum=a.busernum) 
ORDER BY a.busernum asc;

-- 연습 2)
SELECT * FROM jikwon a WHERE a.jikwonpay =
(SELECT MAX(b.jikwonpay) FROM jikwon b WHERE a.busernum=b.busernum);

-- 연습3) 연봉 순위 3위 이내의 직원 출력(내림 차순)
SELECT a.jikwonno,a.jikwonname,a.jikwonpay FROM jikwon a
WHERE 3 > (SELECT COUNT(*) FROM jikwon b WHERE b.jikwonpay > a.jikwonpay)
AND a.jikwonpay IS NOT NULL ORDER BY a.jikwonpay DESC;


-- subquery를이용한 table 생성 및 insert 수행
CREATE TABLE jik1 AS SELECT * FROM jikwon;  -- jikwon과 동일한 테이블 생성됨 - pk는 적용은 안됨
DESC jikwon;
DESC jik1;
SELECT * FROM jik1;

CREATE TABLE jik2 AS SELECT * FROM jikwon WHERE 1=0; -- 구조만 가진 테이블 생성
SELECT * FROM jik2;

INSERT INTO jik2 SELECT * FROM jikwon WHERE jikwonjik='과장';  -- query로 insert

DESC jikwon;
INSERT INTO jik2(jikwonno,jikwonname,busernum) SELECT jikwonno,jikwonname,busernum FROM jikwon
WHERE jikwonjik= '대리';  -- jikwonjik에 default가 사원이라서 대리가 사원으로 입력됨
SELECT * FROM jik2;

-- 일부 칼럼만 가진 테이블 생성
CREATE TABLE jik3 SELECT jikwonno AS bunho, jikwonname AS irum, jikwonpay AS pay FROM jikwon WHERE 1=0;
DESC jik3;
SELECT *FROM jik3;

-- update, delete 에서 subquery 사용
-- update : 총무부 직원의 급여를 10% 인상
SELECT * FROM jik1;
UPDATE jik1 SET jikwonpay = jikwonpay * 1.1
WHERE busernum = (SELECT buserno FROM buser WHERE busername='총무부');

-- delete : 고객이 있는 직원을 삭제
DELETE FROM jik1 WHERE jikwonno in(SELECT DISTINCT gogekdamsano FROM gogek);
SELECT * FROM jik1;

-- 트랜잭션(Transaction)은 여러 SQL 작업을 하나의 작업 단위로 묶어 처리하는 것. 
-- 단위별 데이처 처리를 의미한다.
-- 예를 들어 '계좌이체'처럼
-- - A 계좌 출금
-- - B 계좌 입금
-- 두 작업이 모두 성공해야 하나의 정상 처리된다. 중간에 실패라면 원래의 작업으로 복귀.
-- 트랜잭션은 여러 SQL 문을 하나의 논리적인 작업 단위로 처리하며, 
-- 모두 성공하면 COMMIT, 문제가 생기면 ROLLBACK 한다.
-- INSERT, UPDATE, DELETE 같은 DML 문이 실행되면 트랜잭션이 시작되며, 
-- 명시적 트랜잭션에서는 COMMIT 또는 ROLLBACK을 만나면 종료된다.

-- MaiaDB는 묵시적으로 INSERT, UPDATE, DELETE 하면 자동 commit 된다. 
-- 즉, client의 자료를 근거로 db-server의 자료를 갱신한다.
-- 현재 설정 확인:  SELECT @@autocommit;   결과가 1이면 자동 커밋 상태임

-- 연습용 테이블
CREATE TABLE jiktab AS SELECT * FROM jikwon;
SELECT * FROM jiktab;

SELECT @@autocommit;    -- 1
SET autocommit = FALSE; -- 트랜젝션을 수동으로 전환
SELECT @@autocommit;    -- 0
SELECT * FROM jiktab;
DELETE FROM jiktab WHERE jikwonno >= 6; -- 트렌젝션 시작(local 자료만 삭제됨. 이 정보를 log로 기억)
SELECT * FROM jiktab;     -- 현재는 local 자료만 보임
ROLLBACK;               -- 트렌젝션 종료. log 정보를 바탕으로 삭제 취소
SELECT * FROM jiktab;

-- VIEW 파일(객체) : 
-- 실제 데이터(물리적 테이블)를 별도로 저장하는 파일이 아니라, 
-- SELECT 문을 저장하여 테이블처럼 사용할 수 있게 만든 데이터베이스 객체이다. 가상의 테이블.
-- 실제 데이터를 별도로 복사해 저장하는 일반 테이블은 아님
-- 원본 테이블의 데이터를 기준으로 조회 결과를 보여줌
-- 복잡한 SELECT 문을 단순하게 재사용할 수 있음
-- 필요한 컬럼만 보여줘 보안에도 활용 가능

-- VIEW 기본 형식 : 
-- 뷰 생성 : CREATE or REPLACE VIEW 뷰이름 AS SELECT 컬럼명1, 컬럼명2, ... FROM 테이블명 WHERE 조건;
-- 조회 형식 : SELECT * FROM 뷰이름;
-- 삭제 형식 : DROP VIEW 뷰이름;

CREATE or REPLACE VIEW v_a AS
SELECT jikwonno,jikwonname,jikwonpay FROM jikwon WHERE jikwonibsail < '2010-12-31';

SHOW TABLES;
select * from v_a;
DESC v_a;
SELECT SUM(jikwonpay) FROM v_a;

DROP VIEW v_b;
CREATE VIEW v_b AS
SELECT * FROM jikwon WHERE jikwonname LIKE '김%' OR jikwonname LIKE '박%';
SELECT * FROM v_b;
select * FROM v_a;

ALTER TABLE jikwon RENAME kbs;
SELECT * FROM jikwon;  -- err
SELECT * FROM v_b;     -- err 
SELECT * FROM v_a;     -- err
ALTER TABLE kbs RENAME jikwon;
SELECT * FROM v_b;     -- good 
SELECT * FROM v_a;     -- good

CREATE VIEW v_c AS SELECT * FROM jikwon ORDER  BY jikwonpay DESC;   -- 정렬
SELECT * FROM v_c;

CREATE VIEW v_d AS SELECT jikwonname, jikwonpay * 10000 AS ypay FROM jikwon;  -- 계산 칼럼 적용
SELECT * FROM v_d;   -- ypay는 계산에 의해 작성된 칼럼이므로 값 수정 불가

CREATE VIEW v_e AS SELECT * FROM v_d WHERE ypay >= 50000000;   -- view로 view를 생성
SELECT * FROM v_e;
RENAME TABLE v_e TO mbc;   -- view 객체 이름 변경
SELECT * FROM mbc;

CREATE VIEW v_f AS SELECT * FROM jikwon WHERE jikwonpay >= 5000;
SELECT * FROM v_f;
UPDATE v_f SET jikwonname='사오정' WHERE jikwonname='홍길동';
SELECT * FROM v_f;
UPDATE v_f SET jikwonname='저팔계' WHERE jikwonno=30;  -- view에 존재하지 않으므로 원본 갱신 없음
SELECT * FROM v_f; 
SELECT * FROM jikwon;
DELETE FROM v_f WHERE jikwonno=27;  -- good
SELECT * FROM v_f; 
DELETE FROM v_f WHERE jikwonno=30;  -- view에 존재하지 않으므로 원본 삭제 없음
SELECT * FROM jikwon;

CREATE VIEW v_g AS SELECT jikwonno,jikwonname,busernum,jikwonpay FROM jikwon; 
SELECT * FROM v_g;
INSERT INTO v_g VALUES(31,'손오공',10,7000);  -- view를 이용해 원본 테이블에 자료를 저장
SELECT * FROM v_g;
SELECT * FROM jikwon;

CREATE VIEW v_h AS 
SELECT jikwonjik,SUM(jikwonpay) AS hap, AVG(jikwonpay) AS ave FROM jikwon 
GROUP BY jikwonjik;   -- GROUP BY도 VIEW 작성 가능
SELECT * FROM v_h;

-- join도 가능 
CREATE VIEW v_i AS SELECT j.jikwonno,j.jikwonname,j.jikwonjik,b.busername
FROM jikwon j INNER JOIN buser b ON j.busernum = b.buserno;
SELECT * FROM v_i;


-- 문1) 사번   이름    부서  직급  근무년수  고객확보
-- 	1   홍길동  영업부 사원     6           O   or  X
-- 조건 : 직급이 없으면 임시직, 전산부 자료는 제외
-- 위의 결과를 위한 뷰파일 v_exam1을 작성

CREATE view v_exam1 AS SELECT j.jikwonno AS 사번, j.jikwonname AS 이름, b.busername AS 부서, NVL(j.jikwonjik, '임시직') AS 직급,
TIMESTAMPDIFF(YEAR, j.jikwonibsail, CURDATE()) AS 근무년수,
CASE
WHEN j.jikwonno IN (SELECT DISTINCT gogekdamsano FROM gogek)
THEN 'O' ELSE 'X' END AS 고객확보
FROM jikwon j
LEFT OUTER JOIN buser b ON j.busernum = b.buserno WHERE b.busername <> '전산부' OR b.busername IS NULL;

SELECT * FROM v_exam1;

DROP VIEW v_exam1;

-- 문2) 부서명   인원수
-- 		영업부     7
-- 조건 : 직원수가 가장 많은 부서 출력
-- 위의 결과를 위한 뷰파일 v_exam2을 작성

CREATE VIEW v_exam2 AS SELECT b.busername AS 부서명, COUNT(*) AS 인원수
FROM jikwon j
INNER JOIN buser b ON j.busernum = b.buserno
GROUP BY b.busername
HAVING COUNT(*) = (SELECT COUNT(*) FROM jikwon GROUP BY busernum ORDER BY COUNT(*) desc LIMIT 1);

SELECT * FROM v_exam2;

DROP VIEW v_exam2;

-- 문3) 가장 많은 직원이 입사한 요일에 입사한 직원 출력
-- 직원명   요일     부서명   부서전화
-- 한국인  수요일   전산부   222-2222

-- 위의 결과를 위한 뷰파일 v_exam3을 작성
CREATE VIEW v_exam3 AS SELECT j.jikwonname AS 직원명, 
case
DATE_FORMAT(j.jikwonibsail, '%W') 
when 'Monday' 		THEN '월요일'
WHEN 'Tuesday' 	THEN '화요일'
WHEN 'Wednsday' 	THEN '수요일'
WHEN 'Thursday' 	THEN '목요일'
WHEN 'Friday' 		THEN '금요일'
WHEN 'Saturday' 	THEN '토요일'
WHEN 'sunday' 		THEN '일요일'
end AS 요일,
b.busername AS 부서명, b.busertel AS 부서전화
FROM jikwon j
INNER join buser b ON j.busernum = b.buserno 
WHERE DATE_FORMAT(j.jikwonibsail, '%W') = (SELECT DATE_FORMAT(jikwonibsail, '%W')
FROM jikwon
GROUP BY DATE_FORMAT(jikwonibsail, '%W') ORDER BY COUNT(*) DESC
LIMIT 1);

SELECT * FROM v_exam3;
DROP VIEW v_exam3;


-- 저장 프로시저(stored Procedure)  - 오라클에서는 PL/SQL이라 부름
-- : 자주 사용하는 SQL 작업을 DB 안에 이름을 붙여 저장해 두고, 필요할 때 실행하는 기능
-- : SQL + Programming - 절차적 프로그래밍이 가능

-- maria db 기준 기본 형태 확인
-- 실습1
DELIMITER $$
CREATE PROCEDURE sp_1()
BEGIN
    SELECT '안녕 프로시저 세상 방문을 환영합니다';
END $$
DELIMITER ;

CALL sp_1();  -- PROCEDURE 호출
SHOW PROCEDURE STATUS; -- PROCEDURE 목록 확인
SHOW CREATE PROCEDURE sp_1; -- 해당 PROCEDURE 정보확인
DROP PROCEDURE sp_1; -- PROCEDURE 삭제

-- 실습 2 : 매개변수 사용
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_2(IN a INT, IN b INT)
BEGIN
    DECLARE x, y INT DEFAULT 0;
    SET x = 10;
    SELECT x, y;
    SELECT a + b AS result;
END $$
DELIMITER ;

CALL sp_2(2, 3);

-- 실습3 : table 사용
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_3(IN para1 INT, IN para2 INT)
BEGIN
	SELECT * FROM jikwon WHERE jikwonno < 3;
	SELECT * FROM buser;
	SELECT * FROM gogek where gogekno=para1;
	SELECT * FROM gogek where gogekno=para2;
END $$
DELIMITER ;

CALL sp_3(2, 5);

-- 실습4 : if 사용
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_4(IN jik VARCHAR(20), IN num INT)
BEGIN
	SELECT jik;
	SELECT * FROM jikwon WHERE jikwonjik=jik;
	if(num = 10) then
		SELECT * FROM jikwon WHERE busernum=num;
	elseif(num = 20) then
		SELECT * FROM jikwon WHERE busernum=num;
	ELSE
		SELECT * FROM jikwon WHERE busernum NOT IN(10, 20);
	END if;
END $$
DELIMITER ;

CALL sp_4('대리', 20);

-- 실습5 : if 사용 
-- 고객번호 입력하면 고객정보 조회
-- 담당 직원번호를 입력하면 해당 직원이 관리하는 고객 출력
-- 둘 다 입력 안하면 모든 고객 출력
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_5(IN p_gogekno INT, IN p_damsano INT)
BEGIN
	-- 특정 고객 조회
	if p_gogekno IS NOT NULL then
		SELECT * FROM gogek WHERE gogekno=p_gogekno;
	-- 해당 직원이 관리하는 고객 출력
	ELSEIF p_damsano IS NOT NULL then
		SELECT * FROM gogek WHERE gogekdamsano=p_damsano;
	-- 모든 고객 출력
		SELECT * FROM gogek;
	END if;
END $$
DELIMITER ;

CALL sp_5(5, NULL); -- 고객 번호 5번
CALL sp_5(NULL, 3); -- 담당 직원 번호 3번이 관리하는 고객조회
CALL sp_5(NULL, NULL);

-- 실습6 : while 사용
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_6()
BEGIN
	DECLARE n INT;
	DECLARE str VARCHAR(255);
	SET n = 1;
	SET str = '';
	
	while n <= 5 DO
		SET str = CONCAT(str, n, ',');
		SET n = n + 1;
	END while;
	
	SELECT str;
END $$
DELIMITER ;

CALL sp_6;


-- 실습7 : while 사용
-- 입력한 시작번호, 끝번호 까지 고객자료 출력
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_7(IN start_no INT, IN end_no INT)
BEGIN
	DECLARE current_no INT;
	SET current_no = start_no;
	
	while current_no <= end_no do
		SELECT * FROM gogek WHERE gogekno=current_no;
		SET current_no = current_no + 1;
	END while;
END $$
DELIMITER ;

CALL sp_7(3, 6);

-- 실습 8번 : while 사용
-- jikwon 테이블을 이용해 입력한 직급의 직원수와 직원 목록 출력
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_8(IN p_jik VARCHAR(20))
BEGIN
	DECLARE cnt INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
	
	-- 해당 직급의 직원수 저장
	SELECT COUNT(*) INTO cnt FROM jikwon WHERE jikwonjik=p_jik;
	
	SELECT p_jik AS 직급, cnt AS 인원수;
	
	-- 직원 수 만큼 반복
	while i < cnt do
		SELECT jikwonno,jikwonname,jikwonjik,jikwonpay FROM jikwon
		WHERE jikwonjik=p_jik ORDER BY jikwonno LIMIT i, 1;
		SET i = i + 1;
	END while;
END $$
DELIMITER ;

CALL sp_8('대리');




SELECT ROUND(jikwonpay * 0.05) FROM jikwon; -- 전문가가 작성한 내장함수
-- 사용자 정의 함수
-- bmi 지수 = 몸무게 * 10000 / (신장(cm단위) * 신장(cm단위))
delimiter $$
CREATE OR REPLACE FUNCTION fu_1(height INT, weight INT) RETURNS DOUBLE
BEGIN
	RETURN weight * 10000 / (height * height);

END $$
DELIMITER ;

SELECT fu_1(175, 65);


-- 사용자 정의 함수2 : 전체 직원의 연봉 평균 반환
delimiter $$
CREATE OR REPLACE FUNCTION fu_2() RETURNS DOUBLE
BEGIN
	DECLARE res DOUBLE;
	SELECT AVG(jikwonpay) INTO res FROM jikwon;
	RETURN res;
	
END $$
DELIMITER ;

SELECT fu_2(); -- 사용자 함수
SELECT AVG(jikwonpay) FROM jikwon; -- 내장함수

-- 사용자 정의 함수3 : 각 직원의 연봉의 10% 반환값
delimiter $$
CREATE OR REPLACE FUNCTION fu_3(bun INT) RETURNS DOUBLE
BEGIN
	DECLARE pay INT;
	SET pay = 0;
	SELECT jikwonpay * 0.1 INTO pay FROM jikwon WHERE jikwonno=bun;
	RETURN pay;
	
END $$
DELIMITER ;

SELECT fu_3(1);
SELECT jikwonno,jikwonname,jikwonjik,fu_3(jikwonno) AS donate,jikwongen FROM jikwon;

