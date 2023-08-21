
-- 커서 실행 단축키    : ctrl + enter
-- 문서 전체 실행      : F5
SELECT 1+1
FROM dual;


-- 1. 계정 접속 명령어
-- conn 계정명/비밀번호;
conn system/123456;

-- 2.
-- SQL 은 대/소문자 구분이 없다.
SELECT user_id, username
FROM all_users;
-- WHERE username = 'HR'; // 조회되는 내용이 없음

-- 기본 계정 생성 - HR 계정 생성하기
-- 'C##' 접두어 없이 계정 생성

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- CREATE USER 계정명 IDENTIFIIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;
-- ALTER USER 계정명 DEFAULT TABLESPACE users; // HR 계정의 기본 테이블 영역을 'users' 영역으로 지정
ALTER USER HR DEFAULT TABLESPACE users;
-- 계정이 사용할 수 있는 용량 설정 : HR 계정의 사용 용량을 무한대로 지정
-- ALTER USER 계정명 QUOTA UNLIMED ON 테이블스페이스;
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정에 권한을 부여 : HR 계정에 connect, resource 권한을 부여
-- GRANT connect, resource TO 계정명;
GRANT connect, resource TO HR;

-- 계정 삭제
-- DROP USER 계정명 [CASCADE];
DROP USER HR CASCADE;

-- 계정 잠금 해제
-- ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR ACCOUNT UNLOCK;

-- HR 샘플 스키마(데이터) 가져오기
-- 1. SQL PLUS
-- 2. HR 계정을 접속
-- 3. 명령어 입력
-- @[경로]\hr_main.sql
-- @? : 오라클이 설치된 기본 경로
-- @?/demo/schema/human_resources/hr_main.sql
-- 4. 123456 [비밀번호]
-- 5. users[tablesapce]
-- 6. temp[temp tablespace]
-- 7. [log 경로] - @?/demo/schema/log

-- 3.
-- 테이블 EXPLOYEES의 테이블 구조를 조회하는 SQL 문을 작성하시오.
DESC employees;

-- 테이블 EMPLOYESS에서 EMPLOYEE_ID, FIRST_NAME (회원번호, 이름) 를 조회하는 SQL 문을 작성하시오.
-- * 사원테이블의 사원번호와 이름을 조회
SELECT employee_id, first_name
FROM employees;

-- 4.
-- * 띄어쓰기가 없으면, 따옴표 생략가능
-- * AS 생략가능
-- employee_id AS 사원 번호 (X),employee_ AS "사원 번호" (O), employee_id 
-- 테이블 EMPLOYESS 이 <예시>와 같이 출력되도록 조회하는 SQL 문을 작성하시오.
-- * 한글 별칭을 부여하여 조회
-- AS (alias) : 출력되는 컬러명에 별명을 짓는 명령어
SELECT employee_id AS "사원 번호"       -- 띄어쓰기가 있으면 " " 로 표기
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number AS 전화번호
      ,hire_date AS 입사일자
      ,salary AS 급여
FROM employees
;

--
SELECT *            -- (*) [애스터리크] : 모든 컬럼 지정
FROM employees
;

-- 5.
-- 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL문을 작성하시오.
-- * DISTINCT 컬럼명 : 중복된 데이터를 제거하고 조회하는 명령어
SELECT DISTICT job_id
FROM employees;

-- 6.
-- 테이블 EMPLOYEES의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- * WHERE 조건 : 조회 조건을 작성하는 구문
-- WHERE salary > 6000;
SELECT *
FROM employees
WHERE salary > 6000
;

-- 7.
SELECT *
FROM employees
WHERE salary = 10000
;

-- 8.
-- 테이블 employees 의 모든 속성들을 salary를 기준으로 내림차순 정렬하고,
-- first_name을 기준으로 오름차순 정렬하여 조회하는 SQL문을 작성하시오.

-- 정렬 명령어
-- ORDER BY 컬렴명 [ASC/DESC];
-- * ASC    : 오름차순
-- * DESC   : 내림차순
-- * (생략)   : 오름차순이 기본값
SELECT *
FROM employees 
ORDER BY salary DESC, first_name;

-- 9.
-- 테이블 EMPLOYEES의 JOB_ID가 'FI_ACCOUNT' 이거나 'IT_PROG' 인
-- 사원의 모든 칼럼을 조회하는 SQL 문을 작성하시오.
-- 조건 연산
-- OR 연산 : ~ 또는, ~이거나
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
OR job_id = 'IT_PROG'
;

-- 10.
-- 테이블 EMPLOYEES의 JOB_ID가 'FI_ACCOUNT' 이거나 'IT_PROG' 인
-- 사원의 모든 칼럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
-- * 컬럼명 IN ('A', 'B')  : OR연산을 대체하여 사용할 수 있는 키워드

SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG')
;

-- 11.
-- 테이블 employees의 job_id가 'fi_account' 이거나 'it_prog' 아닌
-- 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- 단, IN 키워드를 사용하시오.
-- * 컬럼명 NOT IN ('A', 'B')  : 'A', 'B'를 제외한 결과를 조회
SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG')
;

-- 12.
-- 테이블 EMPLOYEES의 JOB_ID가 'IT_PROG' 이면서 SALARY가 6000 이상인
-- 사원의 모든 컬럼을 조회하는 SQL
-- 조건 연산
-- AND 연산 : ~ 이면서 
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000
;

-- 13.
-- WHERE first_name LIKE 'S%';
-- % : 여러 문자를 대체
-- _ : 한 문자를 대체
-- LIKE
-- * 컬럼명 LIKE '와일드카드';
SELECT *
FROM employees
WHERE first_name LIKE 's%'
;

-- 14.
SELECT *
FROM employees
WHERE first_name LIKE '%s'
;

-- 15.
SELECT *
FROM employees
WHERE first_name LIKE '%S%'
;

-- 16.
SELECT *
FROM employees
WHERE first_name LIKE '_____'
; 

-- 17.
-- 테이블 employees의 commission_PCT가 NULL 인 사원의 모든 칼럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NULL
;

-- 18.
-- 테이블 employees의 commission_PCT가 NULL 이 아닌 사원의 모든 칼럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
;

-- 19.
-- 테이블 employees의 사원의 HIRE_DATE가 04년 이상인 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YYYYMMDD')       -- SQL Developer 에서 문자형 데이터를 날짜형 데이터로 자동 변환
;

-- 20.
-- 테이블 employees의 사원의 Hire_date가 04년도부터 05년도인 모든 컬럼을 조회하는 SQL문을 작성하시오.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YYYYMMDD')
AND hire_date >= TO_DATE('05/01/01', 'YYYYMMDD')
;

-- 컬럼 BETWEEN A AND B;
-- : A보다 크거나 같고 B보다 작거나 같은 조건 (사이)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('04/01/01', 'YYYYMMDD') AND TO_DATE('05/01/01', 'YYYYMMDD');
-- WHERE hire_date BETWEEN ('04/01/01', 'YYYYMMDD') AND ('05/01/01', 'YYYYMMDD');






