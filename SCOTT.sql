SELECT * FROM EMP ORDER BY ENAME ASC;

-- 연봉 구해보기
SELECT ENAME AS 이름, SAL AS 월급, SAL*12 AS 연봉 FROM EMP;

-- 오름차순, 내림차순
SELECT * FROM EMP ORDER BY DEPTNO ASC, SAL DESC;

-- 하나만 조회
SELECT * FROM EMP WHERE EMPNO = 7566;

-- DEPTNO 30
SELECT * FROM EMP WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
SELECT * FROM EMP WHERE DEPTNO = 30 OR JOB = 'SALESMAN';

-- SAL 3000 이상
SELECT * FROM EMP WHERE SAL >= 3000;

-- SAL 3000이 아닌 사람
SELECT * FROM EMP WHERE SAL NOT IN 3000;
SELECT * FROM EMP WHERE SAL <> 3000;
SELECT * FROM EMP WHERE SAL ^= 3000;
SELECT * FROM EMP WHERE SAL != 3000;

-- JOB 
SELECT * FROM EMP WHERE JOB = 'MANAGER' OR JOB = 'CLERK';
SELECT * FROM EMP WHERE JOB IN ( 'MANAGER', 'CLERK' );
SELECT * FROM EMP WHERE JOB NOT IN ( 'MANAGER', 'CLERK' );
SELECT * FROM EMP WHERE DEPTNO IN (10, 20);

-- 사이의 값
SELECT * FROM EMP WHERE SAL BETWEEN 2000 AND 3000;
SELECT * FROM EMP WHERE EMPNO BETWEEN 7000 AND 7600;
SELECT * FROM EMP WHERE ENAME BETWEEN 'A' AND 'D';

-- LIKE 연산자
SELECT * FROM EMP WHERE ENAME LIKE 'S%';
SELECT * FROM EMP WHERE ENAME LIKE '%S%';
SELECT * FROM EMP WHERE ENAME LIKE 'A%';
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
SELECT * FROM EMP WHERE ENAME LIKE '%AM%';
SELECT * FROM EMP WHERE ENAME LIKE '%M%I%';
SELECT * FROM EMP WHERE ENAME LIKE '%A%' AND ENAME LIKE '%M%';
SELECT * FROM EMP WHERE ENAME LIKE '%ER';

-- 몇 번째 글짜
SELECT * FROM EMP WHERE ENAME LIKE '_L%';
SELECT * FROM EMP WHERE ENAME LIKE '__A%';
SELECT * FROM EMP WHERE ENAME LIKE '_____';

-- NULL CHECK
SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- GROUP BY
SELECT AVG(SAL) AS 평균급여, DEPTNO FROM EMP; -- 오류남
SELECT AVG(SAL) AS 평균급여, DEPTNO FROM EMP GROUP BY DEPTNO;
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP GROUP BY JOB; -- 오류남
SELECT DEPTNO, JOB, AVG(SAL) FROM EMP GROUP BY DEPTNO, JOB;
SELECT ENAME, DEPTNO, AVG(SAL) FROM EMP GROUP BY DEPTNO, ENAME;

-- 1
SELECT * FROM EMP WHERE ENAME LIKE '%S';
-- 2 
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
-- 3
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO IN (20, 30) AND SAL > 2000;
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO IN (20, 30) 
MINUS SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP 
WHERE DEPTNO IN (20, 30) AND SAL <= 2000;
-- 4
SELECT * FROM EMP 
WHERE SAL < 2000 OR SAL > 3000;
-- 5
SELECT ENAME, EMPNO, SAL, DEPTNO FROM EMP 
WHERE SAL NOT BETWEEN 1000 AND 2000 AND ENAME LIKE '%E%' AND DEPTNO = 30;
-- 6
SELECT * FROM EMP 
WHERE ENAME NOT LIKE '_L%' 
AND JOB IN ('MANAGER', 'CLERK')
AND MGR IS NOT NULL;

-- UNION / INTERSECT
SELECT * FROM EMP WHERE DEPTNO = 10 
UNION SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP WHERE DEPTNO = 10 
UNION ALL SELECT * FROM EMP WHERE DEPTNO = 10;
SELECT * FROM EMP INTERSECT
SELECT * FROM EMP WHERE DEPTNO = 10;

-- 오라클 함수
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME) FROM EMP;
SELECT * FROM EMP;
SELECT ENAME, LENGTH(ENAME) FROM EMP;
SELECT ENAME FROM EMP WHERE LENGTH(ENAME) = 6;
SELECT LENGTH('오라클'), LENGTHB('오라클 SQL') FROM DUAL;

-- DUMMY TABLE 
-- DUAL

-- 글자 잘라내기
SELECT JOB, SUBSTR(JOB, 1, 2) FROM EMP;
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, -3, 2), SUBSTR(JOB, -3) FROM EMP;
SELECT SUBSTR(JOB, -LENGTH(JOB)) FROM EMP;

-- 문자열의 위치를 찾는 함수
SELECT INSTR('HELLO, ORACLE', 'L') FROM DUAL;
SELECT INSTR('HELLO, ORACLE', 'L', 1, 2) FROM DUAL; -- 1번부터 찾는데 두 번째 L
SELECT INSTR('Oracle databases 11g releases', 'DATABASES') FROM DUAL;
SELECT INSTR('Oracle databases 11g releases', LOWER('DATABASES')) FROM DUAL;
SELECT * FROM EMP WHERE INSTR(ENAME, 'S') > 0;

-- REPLACE
SELECT '010-1111-2222' AS ORIGINAL, 
REPLACE('010-1111-2222', '-', ' ') AS NEW1, 
REPLACE('010-1111-2222', '-') AS NEW2 FROM DUAL;
SELECT '010 1111-2222' AS ORIGINAL, 
REPLACE(REPLACE('010 1111-2222', '-'), ' ') AS NEW1 FROM DUAL;


-- RPAD, LPAD
SELECT 'ORACLE' AS ORACLE,
LPAD('ORACLE', 10, '#') AS LPAD1,
RPAD('ORACLE', 10, '#') AS RPAD1,
LPAD('ORACLE', 10) AS LPAD2,
RPAD('ORACLE', 10) AS RPAD2
FROM DUAL;
SELECT RPAD(SUBSTR(ENAME, 1, 2), LENGTH(ENAME), '*') FROM EMP; 
SELECT RPAD('123456-2', 14, '*') AS JUMIN FROM DUAL;
SELECT RPAD('010-2333-', 13, '*') AS JUMIN FROM DUAL;

-- CONCAT
SELECT CONCAT(EMPNO, ENAME) AS CONCAT,
CONCAT(EMPNO, CONCAT(' : ', ENAME)) AS doubleCONCAT FROM EMP;
SELECT (ENAME || ' : ' || JOB) FROM EMP;

-- TRIM
-- 회원가입이나 로그인할 때 뒤에 스페이스바를 치고 입력해서 공백이 있는 경우 활용
SELECT '[' || TRIM('    ORACLE          ') || ']' FROM DUAL;
SELECT '[' || LTRIM('    ORACLE          ') || ']' FROM DUAL;
SELECT '[' || RTRIM('    ORACLE          ') || ']' FROM DUAL;
SELECT '[' || TRIM(BOTH '_' FROM '__ORACLE__') || ']' FROM DUAL;
SELECT '[' || RTRIM('__ORACLE__', '_') || ']' FROM DUAL;
SELECT '[' || TRIM(TRAILING '_' FROM '_ _ORACLE_ _') || ']' FROM DUAL;
SELECT '!' || REPLACE('     ORACLE        ', ' ', '') || '!' FROM DUAL;

-- 숫자함수
SELECT 1234.59 AS NUM FROM DUAL;
SELECT TRUNC(1234.59) FROM DUAL; --절사
SELECT ROUND(1234.3) FROM DUAL;
SELECT ROUND(1234.59) FROM DUAL;
SELECT ROUND(1234.59, 1) FROM DUAL;
SELECT CEIL(1234.3) FROM DUAL;
SELECT CEIL(1234.59) FROM DUAL;
SELECT FLOOR(1234.3) AS NUM FROM DUAL;
SELECT FLOOR(1234.59) FROM DUAL;
SELECT MOD(11, 3) FROM DUAL;

-- 날짜
SELECT SYSDATE AS TODAY, 
SYSDATE - 1 AS YESTERDAY, 
SYSDATE + 1 AS TOMORROW FROM DUAL;

-- 몇 달 뒤 (ADD_MONTHS)
SELECT SYSDATE AS NOW, 
ADD_MONTHS(SYSDATE, 3) AS AFTER3M
FROM DUAL;

SELECT SYSDATE AS NOW, 
TO_CHAR(NEXT_DAY(ADD_MONTHS(SYSDATE, 3), '월요일'), 'yyyy-MM-dd') AS AFTER3M
FROM DUAL;

SELECT EMPNO, ENAME, 
HIREDATE,
TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 120), '수요일'), 'yy-MM-dd') AS AFTER10Y,
SYSDATE 
FROM EMP;

-- MONTHS_BETWEEN
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
TRUNC(MONTHS_BETWEEN(HIREDATE, SYSDATE)) AS MONTH01,
TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH02,
TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12) AS MONTH03
FROM EMP;

-- NEXT_DAY(), LAST_DAY()
SELECT SYSDATE, 
NEXT_DAY(SYSDATE, '금요일') AS NEXTDAY,
LAST_DAY(SYSDATE) AS LASTDAY
FROM DUAL;

SELECT SYSDATE,
NEXT_DAY(SYSDATE, '일요일') AS NEXTSUN
FROM DUAL;

-- 형변환 함수 TO_CHAR() / TO_NUMBER() / TO_DATE
SELECT 
TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS CUR 
FROM DUAL;

SELECT SYSDATE, 
TO_CHAR(SYSDATE, 'MM') AS MM,
TO_CHAR(SYSDATE, 'MON') AS MON,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = FRENCH') AS MON,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = GERMAN') AS MON,
TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON,
TO_CHAR(SYSDATE, 'MONTH') AS MONTH
FROM DUAL;

SELECT SYSDATE, 
TO_CHAR(SYSDATE, 'DD') AS DD,
TO_CHAR(SYSDATE, 'DDD') AS DDD,
TO_CHAR(SYSDATE, 'DY') AS DY,
TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = GERMAN') AS DAY
FROM DUAL;

SELECT SAL, 
TO_CHAR(SAL, '$999,999') AS DOLLAR, 
TO_CHAR(SAL, 'L999,999') AS WON,
TO_CHAR(SAL, '999,999.00') AS DOLLAR,
TO_CHAR(SAL, '000,999,999.00') AS DOLLAR
FROM EMP;

SELECT TO_NUMBER('12345') FROM DUAL;

SELECT EMPNO, ENAME, EMPNO + 500 FROM EMP;
SELECT EMPNO, ENAME, EMPNO + '500' FROM EMP; -- 오라클이 자동 형변환

SELECT 
1300 - '1500',
TO_NUMBER('1,300', '999,999') + TO_NUMBER('1,500', '999,999') AS NUM
FROM DUAL;

-- 날짜로 바꾸기
SELECT 
TO_DATE('2023-02-24', 'YY-MM-DD') AS DAY1,
TO_DATE('2023-02-24', 'YYYY-MM-DD HH24:MI:SS') AS DAY2
FROM DUAL;

SELECT EXTRACT(HOUR FROM TO_TIMESTAMP('2023-02-24', 'YYYY-MM-DD')) AS HOUR FROM DUAL;

SELECT * FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY-MM-DD'); -- 특정 날짜보다 늦게 입사한 사람

-- NULL 연산 : NVL, NVL2
SELECT 
EMPNO, ENAME, 
TO_CHAR(SAL, '$999,999') AS SAL, 
TO_CHAR(NVL(COMM, 0), '$999,999') AS COMM, 
NVL2(COMM, 'O', 'X') AS COMM_EXIST,
TO_CHAR(SAL * 12 + NVL(COMM,0), '$999,999') AS ANNUAL_INCOME1,
TO_CHAR(NVL2(COMM, SAL*12 + COMM, SAL*12), '$999,999') AS ANNUAL_INCOME2
FROM EMP;

-- DECODE (IF, ELSE) : 오라클 전용
-- CASE WHEN
SELECT EMPNO, ENAME, JOB, SAL AS PRIOR_SAL,
DECODE(JOB,
    'MANAGER', SAL*1.1,
    'SALESMAN', SAL*1.05,
    'ANALYST', SAL,
    SAL*1.03) AS UP_SAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL AS PRIOR_SAL,
DECODE(JOB,
    'MANAGER', '매니저',
    'PRESIDENT', '최고 관리자',
    'CLERK', '사원',
    'ANALYST', '분석가',
    '영업') AS JOB_DESC
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL AS PRIOR_SAL,
    CASE JOB
        WHEN 'MANAGER'  THEN SAL * 1.1
        WHEN 'SALESMAN' THEN SAL * 1.05
        WHEN 'ANALYST'  THEN SAL 
        ELSE SAL * 1.03 
    END AS UP_SAL
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL AS PRIOR_SAL,
    CASE 
        WHEN JOB = 'MANAGER'  THEN SAL * 1.1
        WHEN JOB = 'SALESMAN' THEN SAL * 1.05
        WHEN JOB = 'ANALYST'  THEN SAL 
        ELSE SAL * 1.03 
    END AS UP_SAL
FROM EMP;

SELECT EMPNO, ENAME,
    CASE 
        WHEN COMM IS NULL THEN 'NOT DECIDED YET'
        WHEN COMM = 0 THEN 'NO BONUS'
        WHEN COMM > 0 THEN 'BONUS : ' || COMM
    END AS COMM_TXT
FROM EMP;

-- 0
SELECT EMPNO, ENAME, NVL(TO_CHAR(COMM), ' ') AS COMM, SAL,
    CASE 
        WHEN SAL > 2900 THEN 'DIAMOND'
        WHEN SAL > 2700 THEN 'GOLD'
        WHEN SAL > 2000 THEN 'SILVER'
        ELSE 'BRONZE'
    END AS RANK
FROM EMP;

SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'Q') || '분기' AS QUARTER FROM EMP;

SELECT EMPNO, ENAME, 
    CASE 
        WHEN TO_CHAR(HIREDATE, 'Q') = '1' THEN '1분기 입사'
        WHEN TO_CHAR(HIREDATE, 'Q') = '2' THEN '2분기 입사'
        WHEN TO_CHAR(HIREDATE, 'Q') = '3' THEN '3분기 입사'
        WHEN TO_CHAR(HIREDATE, 'Q') = '4' THEN '4분기 입사'
        ELSE '해당사항 없음'
    END AS 분기별_입사
FROM EMP;

-- 1
SELECT EMPNO,
RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS MASKING_EMPNO,
ENAME,
RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
FROM EMP 
WHERE LENGTH(ENAME) = 5;

-- 2 
SELECT EMPNO,
ENAME, SAL,
TRUNC(SAL / 21.5, 2) AS DAY_PAY,
ROUND(SAL / (21.5 * 8), 1) AS TIME_PAY
FROM EMP;

-- 3 
-- NVL
SELECT EMPNO,
ENAME, 
TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS HIREDATE,
TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-dd') AS R_JOB, 
NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;

-- DECODE
SELECT EMPNO,
ENAME, 
TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS HIREDATE,
TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-dd') AS R_JOB, 
DECODE(COMM, NULL, 'N/A', COMM) AS COMM 
FROM EMP;

-- 4
-- CASE WHEN
SELECT 
EMPNO, ENAME, NVL(TO_CHAR(MGR), ' ') AS MGR,
    CASE 
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(MGR, 1, 2) = 75 THEN '5555'
        WHEN SUBSTR(MGR, 1, 2) = 76 THEN '6666'
        WHEN SUBSTR(MGR, 1, 2) = 77 THEN '7777'
        WHEN SUBSTR(MGR, 1, 2) = 78 THEN '8888'
        ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;
-- DECODE
SELECT 
    EMPNO, 
    ENAME, 
    NVL(TO_CHAR(MGR), ' ') AS MGR,
    DECODE(SUBSTR(MGR, 1, 2),
        NULL, '0000',
        '75', '5555',
        '76', '6666',
        '77', '7777',
        '78', '8888',
        TO_CHAR(MGR)
    ) AS CHG_MGR
FROM EMP;

-- 응용
SELECT 
NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT 
TO_CHAR(NEXT_DAY(SYSDATE, '목요일'), 'YYYY-MM-dd') || ' 목요일' FROM DUAL;

