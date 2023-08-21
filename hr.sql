
-- Ŀ�� ���� ����Ű    : ctrl + enter
-- ���� ��ü ����      : F5
SELECT 1+1
FROM dual;


-- 1. ���� ���� ��ɾ�
-- conn ������/��й�ȣ;
conn system/123456;

-- 2.
-- SQL �� ��/�ҹ��� ������ ����.
SELECT user_id, username
FROM all_users;
-- WHERE username = 'HR'; // ��ȸ�Ǵ� ������ ����

-- �⺻ ���� ���� - HR ���� �����ϱ�
-- 'C##' ���ξ� ���� ���� ����

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- CREATE USER ������ IDENTIFIIED BY ��й�ȣ;
CREATE USER HR IDENTIFIED BY 123456;
-- ALTER USER ������ DEFAULT TABLESPACE users; // HR ������ �⺻ ���̺� ������ 'users' �������� ����
ALTER USER HR DEFAULT TABLESPACE users;
-- ������ ����� �� �ִ� �뷮 ���� : HR ������ ��� �뷮�� ���Ѵ�� ����
-- ALTER USER ������ QUOTA UNLIMED ON ���̺����̽�;
ALTER USER HR QUOTA UNLIMITED ON users;
-- ������ ������ �ο� : HR ������ connect, resource ������ �ο�
-- GRANT connect, resource TO ������;
GRANT connect, resource TO HR;

-- ���� ����
-- DROP USER ������ [CASCADE];
DROP USER HR CASCADE;

-- ���� ��� ����
-- ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR ACCOUNT UNLOCK;

-- HR ���� ��Ű��(������) ��������
-- 1. SQL PLUS
-- 2. HR ������ ����
-- 3. ��ɾ� �Է�
-- @[���]\hr_main.sql
-- @? : ����Ŭ�� ��ġ�� �⺻ ���
-- @?/demo/schema/human_resources/hr_main.sql
-- 4. 123456 [��й�ȣ]
-- 5. users[tablesapce]
-- 6. temp[temp tablespace]
-- 7. [log ���] - @?/demo/schema/log

-- 3.
-- ���̺� EXPLOYEES�� ���̺� ������ ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
DESC employees;

-- ���̺� EMPLOYESS���� EMPLOYEE_ID, FIRST_NAME (ȸ����ȣ, �̸�) �� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- * ������̺��� �����ȣ�� �̸��� ��ȸ
SELECT employee_id, first_name
FROM employees;

-- 4.
-- * ���Ⱑ ������, ����ǥ ��������
-- * AS ��������
-- employee_id AS ��� ��ȣ (X),employee_ AS "��� ��ȣ" (O), employee_id 
-- ���̺� EMPLOYESS �� <����>�� ���� ��µǵ��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- * �ѱ� ��Ī�� �ο��Ͽ� ��ȸ
-- AS (alias) : ��µǴ� �÷��� ������ ���� ��ɾ�
SELECT employee_id AS "��� ��ȣ"       -- ���Ⱑ ������ " " �� ǥ��
      ,first_name AS �̸�
      ,last_name AS ��
      ,email AS �̸���
      ,phone_number AS ��ȭ��ȣ
      ,hire_date AS �Ի�����
      ,salary AS �޿�
FROM employees
;

--
SELECT *            -- (*) [�ֽ��͸�ũ] : ��� �÷� ����
FROM employees
;

-- 5.
-- ���̺� EMPLOYEES �� JOB_ID�� �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
-- * DISTINCT �÷��� : �ߺ��� �����͸� �����ϰ� ��ȸ�ϴ� ��ɾ�
SELECT DISTICT job_id
FROM employees;

-- 6.
-- ���̺� EMPLOYEES�� SALARY(�޿�)�� 6000�� �ʰ��ϴ� ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- * WHERE ���� : ��ȸ ������ �ۼ��ϴ� ����
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
-- ���̺� employees �� ��� �Ӽ����� salary�� �������� �������� �����ϰ�,
-- first_name�� �������� �������� �����Ͽ� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.

-- ���� ��ɾ�
-- ORDER BY �÷Ÿ� [ASC/DESC];
-- * ASC    : ��������
-- * DESC   : ��������
-- * (����)   : ���������� �⺻��
SELECT *
FROM employees 
ORDER BY salary DESC, first_name;

-- 9.
-- ���̺� EMPLOYEES�� JOB_ID�� 'FI_ACCOUNT' �̰ų� 'IT_PROG' ��
-- ����� ��� Į���� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ���� ����
-- OR ���� : ~ �Ǵ�, ~�̰ų�
-- WHERE A OR B;
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
OR job_id = 'IT_PROG'
;

-- 10.
-- ���̺� EMPLOYEES�� JOB_ID�� 'FI_ACCOUNT' �̰ų� 'IT_PROG' ��
-- ����� ��� Į���� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, IN Ű���带 ����Ͻÿ�.
-- * �÷��� IN ('A', 'B')  : OR������ ��ü�Ͽ� ����� �� �ִ� Ű����

SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG')
;

-- 11.
-- ���̺� employees�� job_id�� 'fi_account' �̰ų� 'it_prog' �ƴ�
-- ����� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, IN Ű���带 ����Ͻÿ�.
-- * �÷��� NOT IN ('A', 'B')  : 'A', 'B'�� ������ ����� ��ȸ
SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG')
;

-- 12.
-- ���̺� EMPLOYEES�� JOB_ID�� 'IT_PROG' �̸鼭 SALARY�� 6000 �̻���
-- ����� ��� �÷��� ��ȸ�ϴ� SQL
-- ���� ����
-- AND ���� : ~ �̸鼭 
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000
;

-- 13.
-- WHERE first_name LIKE 'S%';
-- % : ���� ���ڸ� ��ü
-- _ : �� ���ڸ� ��ü
-- LIKE
-- * �÷��� LIKE '���ϵ�ī��';
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
-- ���̺� employees�� commission_PCT�� NULL �� ����� ��� Į���� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE commission_pct IS NULL
;

-- 18.
-- ���̺� employees�� commission_PCT�� NULL �� �ƴ� ����� ��� Į���� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL
;

-- 19.
-- ���̺� employees�� ����� HIRE_DATE�� 04�� �̻��� ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YYYYMMDD')       -- SQL Developer ���� ������ �����͸� ��¥�� �����ͷ� �ڵ� ��ȯ
;

-- 20.
-- ���̺� employees�� ����� Hire_date�� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YYYYMMDD')
AND hire_date >= TO_DATE('05/01/01', 'YYYYMMDD')
;

-- �÷� BETWEEN A AND B;
-- : A���� ũ�ų� ���� B���� �۰ų� ���� ���� (����)
SELECT *
FROM employees
WHERE hire_date BETWEEN TO_DATE('04/01/01', 'YYYYMMDD') AND TO_DATE('05/01/01', 'YYYYMMDD');
-- WHERE hire_date BETWEEN ('04/01/01', 'YYYYMMDD') AND ('05/01/01', 'YYYYMMDD');






