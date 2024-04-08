SELECT ENAME, UPPER(ENAME)
FROM EMP E; -- 대문자로 저장, 여기서 E는 별칭 없어도 됨

SELECT ENAME, LOWER(ENAME)
FROM EMP;  -- 소문자로 저장

SELECT ENAME, INITCAP(ENAME)
FROM EMP;  -- 첫글자를 대문자로 변환

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION -- 집합연산자
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO = 10
UNION   -- 데이터 유형의 갯수, 정렬이 같아야함
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT SAL, JOB, DEPTNO, SAL
FROM EMP WHERE DEPTNO=20;       -- 열의 갯수와 데이터 유형이 같아야한다.

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
MINUS   -- 차집함연산자
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP WHERE DEPTNO = 10;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
INTERSECT   -- 교집함연산자
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP WHERE DEPTNO = 10;

SELECT ENAME, LENGTH(ENAME)
FROM EMP;   -- 길이를 출력

-- 이름 글자가 5글자 이상인 사람 출력
SELECT ENAME, LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >= 5;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;      -- LENGTH: 문자길이, LENGTHB: 바이트크기

/* 문자열 일부를 추출 SUBSTR 함수 */
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5)     -- SQL은 첫번째인덱스는 1번부터 시작 0이아님
FROM EMP;
-- SUBSTR함수를 사용해서 모든 사원의 이름을 3번째부터 출력
SELECT ENAME, SUBSTR(ENAME,3)
FROM EMP;

-- 특정문자 위치를 찾는 INSTR함수
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR1,          -- 전체에서 찾기
       INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR2,       -- 5는 인덱스 위치부터 찾음
       INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR3       -- 2번째 문자부터 2번째로 나오는 문자 찾기
FROM DUAL;

/* 사원 이름중 'S'가 들어가 있는 사원의 정보 출력*/
SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0;    --INSTR함수가 찾으려는 글자가 없으면 0을 출력

SELECT *
FROM EMP WHERE ENAME LIKE '%S%';

/* 문자변환 REPLACE 함수 */
SELECT '010-1234-5678' AS REPLACE1,
       REPLACE('010-1234-5678','-',' ') AS REPLACE2,            -- REPLACE(문자열, 찾는문자(필수), 대체문자(선택))
       REPLACE('010-1234-5678', '-') AS REPLACE3
FROM DUAL;

/* 빈공간 매우는 LPAD, RPAD 함수*/
SELECT 'ORACLE',
       LPAD('ORACLE',10,'#') AS LPAD1,          -- LPAD(문자열, 전체자리수, 빈자리채울문자)
       RPAD('ORACLE', 10, '*') AS RPAD1,
       LPAD('ORACLE',10) AS LPAD2,
       RPAD('ORACLE', 10) AS RPAD2
FROM DUAL;

/* 주민번호, 전화번호 끝에 7자리, 4자리 처리를 '*'로 변경 */
SELECT RPAD('961014-', 14, '*') AS RPAD1,
       RPAD('010-1234-',13,'*')
FROM DUAL;

/* 특정 문자를 지우는 TRIM, LTRIM, RTRIM 함수 */
SELECT '[' || TRIM(' __ORACLE__ ') || ']' AS TRIM, -- 앞뒤의 공백 삭제
        '[' || TRIM(LEADING FROM ' __ORACLE__ ') || ']' AS TRIM_LEADING,
        '[' || TRIM(BOTH FROM ' __ORACLE__ ') || ']' AS TRIM_BOTH
FROM DUAL;

/* 반올림 함수 ROUND */
SELECT ROUND(1234.5678),
       ROUND(1234.5678, 0),
       ROUND(1234.56578, 1),
       ROUND(1234.5678, -1), -- 자연수 첫째자리 반올림;
       ROUND(1234.5678, -2)
FROM DUAL;

/* 버림하는 함수 TRUNC */
SELECT TRUNC(1234.5678),
       TRUNC(1234.5678, 0),
       TRUNC(1234.5678, 1),
       TRUNC(1234.5678, -1)
FROM DUAL;

/* 나머지를 구하는 함수 MOD */
SELECT mod(15,2), mod(10,2), mod(11,2)
FROM DUAL;
-- 각 사원별 시급을 계산하여 부서번호, 사원이름, 시급을 출력
/*
 1. 한달 근무일시 20일, 하루 근무 시간은 8시간
 2. 부서별로 오름차순으로 정렬
 3. 시급은 소수 2자리까지
 4. 시급이 높은순으로 출력
 */
SELECT DEPTNO,ENAME,
       ROUND(SAL / 20 / 8, 1) AS "시급"-- 시급
FROM EMP ORDER BY DEPTNO , SAL DESC ;
/* 날짜 함수 */
SELECT SYSDATE AS NOW,
       SYSDATE -1 AS YESTERDAY,
       SYSDATE +1 AS TOMORROW
FROM DUAL;

SELECT SYSDATE , ADD_MONTHS (SYSDATE, 3) -- 현재 달에서 숫자만큼 달을 추가
FROM DUAL;

-- 입사 10주년이 되는 사원들 출력(사원번호, 사원이름, 입사일, 10주년)
SELECT EMPNO, ENAME,HIRERATE,
       ADD_MONTHS(HIRERATE, 120) AS "입사 10주년"
FROM EMP;
-- 두 날짜간의 개월차
SELECT EMPNO, ENAME, HIRERATE, SYSDATE,
        MONTHS_BETWEEN(HIRERATE, SYSDATE) AS MONTHS1,
        MONTHS_BETWEEN(SYSDATE, HIRERATE) AS MONTHS2,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRERATE)) AS MONTHS3
FROM EMP;

-- 요일, 마지막 날짜
SELECT SYSDATE,
       NEXT_DAY(SYSDATE, '월요일'),
       LAST_DAY(SYSDATE)        -- 특정날짜가 속한 마지막 날
FROM DUAL;
SELECT SYSDATE,
       ROUND(SYSDATE, 'CC') AS FORMAT_CC,
       ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY
FROM DUAL;

/* 형변환 */
SELECT EMPNO, ENAME, EMPNO + '500'
FROM EMP
WHERE ENAME = 'SCOTT';
/*
 암묵적인 형변환 (컴파일이 자동 변환) <--> 명시적 형변환(사용자가 변환)
 TO_CHAR : 숫자 또는 날짜 데이터를 문자 데이터로 변환
 TO_NUMBER : 문자 (또는 날짜 데이터)를 숫자 데이터로 변환
 TO_DATE : 문자 (또는 숫자 데이터)를 날짜 데이터로 변환
 */
SELECT 'ABCD' + EMPNO, EMPNO
FROM EMP
WHERE ENAME = 'SCOTT';

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')  AS 현재날짜시간
FROM DUAL;
/*
 CC: 세기,
 YYYY: 연, YY: 연(2),
 MM: 월, MON: 월(약어), MONTH: 월(전체),
 DD: 일, DDD: 365일,
 DY: 요일(약어), DAY: 요일(전체)
 W: 주

 HH24: 24시간, HH/HH12: 12시간, MI: 분, SS: 초, AM/PM/A.M/P.M: 오전, 오후
 */
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON') AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY') AS DY,
       TO_CHAR(SYSDATE, 'DAY') AS DAY
FROM DUAL;

SELECT sysdate,
       TO_CHAR(SYSDATE, 'MM') AS MM,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_K,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_J,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_E,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_K,
       TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_E,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD') AS DD,
       TO_CHAR(SYSDATE, 'DY') AS DY,
       TO_CHAR(SYSDATE, 'DAY') AS DAY
FROM DUAL;

SELECT SYSDATE,
       TO_CHAR(SYSDATE,'HH24:MI:SS') AS HH24MISS,
       TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
       TO_CHAR(SYSDATE, 'HH:MI,SS P.M.') AS HHMISS_PM
FROM DUAL;

SELECT TO_DATE('2019-04-04', 'YYYY-MM-DD') AS TODATE,
       TO_DATE('20100301', 'YYYY-MM-DD') AS TODATE2
FROM DUAL;

-- 1981년 12월 1일 이후에 입사한 사원 정보 출력
SELECT ENAME, HIRERATE
FROM EMP WHERE HIRERATE > TO_DATE('1981-12-01', 'yyyy-mm-dd');
/*------------------------------------------------------------------------------------*/
-- null 처리
SELECT *
FROM EMP;

SELECT COMM *1.1
FROM EMP;

SELECT NVL(COMM, 0)
FROM EMP;                -- NVL(해당열, 대체값)
SELECT NVL2(COMM, COMM*1.1, 0)
FROM EMP;               -- NVL2(해당열, 정상값, NULL이면 대체값)
-- DECODE 함수: 조건에따라서 값을 선택
SELECT EMPNO,ENAME,JOB,SAL,
DECODE( JOB,                    -- 해당열
    'MANAGER', SAL * 1.1,       -- 'MANAGER'가 적용되는 값
    'SALESMAN', SAL*1.05,       -- 'SALESMAN'이 적용되는 값
    'ALALYST',SAL,              -- 'ALALYST'가 적용되는 값
    SAL * 1.03) AS UPSAL        -- 그외 나머지가 적용되는 값
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL,
CASE JOB
    WHEN 'MANAGER' THEN SAL*1.1
    WHEN 'SALESMAN' THEN SAL*1.5
    WHEN 'ALALYST' THEN SAL
    ELSE SAL*1.03
END AS UPSAL
FROM EMP;
/* 행 제한하기 */
SELECT ROWNUM,JOB
FROM EMP WHERE ROWNUM<=5;
