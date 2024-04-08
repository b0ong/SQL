/* 다중함수 (집계함수) : SUM, MIN, MAX, COUNT, AVG */
SELECT COUNT(ENAME)
FROM EMP;

SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;

SELECT SUM(COMM)
FROM EMP;

SELECT SUM(SAL)
FROM EMP;

SELECT SUM(DISTINCT SAL), -- 중복제거
       SUM(ALL SAL),      -- 중복포함 전체
       SUM(SAL)           -- 중복포함 전체
FROM EMP;

SELECT COUNT(SAL),
       COUNT(ALL SAL),
       COUNT(DISTINCT SAL)
FROM EMP;
-------------------------------------------
SELECT MAX(SAL), MIN(SAL)
FROM EMP
WHERE DEPTNO = 10;
-- 20번 부서에서 신입과 최고참의 입사일 조회
SELECT MAX(HIRERATE), MIN(HIRERATE)
FROM EMP
WHERE DEPTNO = 20;

-- 30번 부서의 월급 평균 조회
SELECT avg(SAL),trunc(avg(SAL), 0)
FROM EMP WHERE DEPTNO=30;

/* GRUP BY */
SELECT TRUNC(AVG(SAL), 0), '10' AS DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT TRUNC(AVG(SAL), 0), '20' AS DEPTNO
FROM EMP
WHERE DEPTNO = 20
UNION
SELECT TRUNC(AVG(SAL), 0), '30' AS DEPTNO
FROM EMP
WHERE DEPTNO = 30;

SELECT trunc(avg(SAL)), DEPTNO
FROM EMP GROUP BY DEPTNO;

SELECT DEPTNO, EMP.JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, EMP.JOB;

/* 코딩순서 : SELECT ~~ FROM ~~ WHERE ~~ GROUP BY ~~ ORDER BY ~~
 실행순서 : FROM ~~ WHERE ~~ GROUP BY ~~ SELECT  ~~ ORDER BY ~~ */
SELECT DEPTNO, EMP.JOB, AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000      -- SELECT가 실행이 안된 상태에서 AVG를 구해라해서 실행 오류발생, WHERE절에서는 집계함수를 사용할 수 없다
GROUP BY DEPTNO, EMP.JOB
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, EMP.JOB, AVG(SAL)
FROM EMP
--WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO, EMP.JOB
HAVING AVG(SAL) >= 2000     -- WHERE 대신에 HAVING 을 사용
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, EMP.JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000       -- 단독 가능, 집계안됨( -> HAVING 사용)
GROUP BY DEPTNO, EMP.JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

/* 오라클 JOIN */
SELECT *
FROM DEPT d;
SELECT *
FROM EMP e,DEPT d;
-- from절에서 테이블로 조인
SELECT *
FROM EMP e,
     DEPT d;

-- where절에서 열이름 비교하는 조건식으로 조인
SELECT *
FROM EMP e,
     DEPT d
WHERE e.DEPTNO = d.DEPTNO
ORDER BY EMPNO;

SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME
FROM EMP e,
     DEPT d
WHERE e.DEPTNO = d.DEPTNO
ORDER BY d.DEPTNO, e.EMPNO;     -- 등가 조인

SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME
FROM EMP e,
     DEPT d
WHERE e.DEPTNO = d.DEPTNO
  AND SAL >= 3000;      -- 조인에 조건식 추가

SELECT *
FROM EMP e,
     SALGRADE s
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

SELECT e.EMPNO, e.ENAME, e.MGR,
       e2.EMPNO AS MRG_EMPNO, e2.ENAME AS MRG_ENAME
FROM EMP e , EMP e2
WHERE e.MGR = e2.EMPNO (+)
ORDER BY e.EMPNO;

SELECT MGR
FROM EMP;

SELECT EMPNO
FROM EMP;

SELECT e.EMPNO, e.ENAME, e.JOB, e.MGR, e.HIRERATE, e.SAL, e.COMM,
       DEPTNO, d.DNAME, d.LOC
FROM EMP e NATURAL JOIN DEPT d
ORDER BY DEPTNO, e.EMPNO;

SELECT *
FROM EMP e JOIN DEPT d ON (e.DEPTNO = d.DEPTNO)
WHERE SAL >= 3000;

SELECT e.EMPNO, e.ENAME, e.MGR,
       e2.EMPNO AS MGR_DMPNO,
       e2.ENAME AS MGR_ENAME
FROM EMP e LEFT JOIN EMP e2 ON(e.MGR = e2.EMPNO);            -- 왼쪽 외부 조인 MGR

SELECT e.EMPNO, e.ENAME, e.MGR,
       e2.EMPNO AS MGR_DMPNO,
       e2.ENAME AS MGR_ENAME
FROM EMP e RIGHT JOIN EMP e2 ON(e.MGR = e2.EMPNO);

SELECT e.EMPNO, e.ENAME, e.MGR,
       e2.EMPNO AS MGR_DMPNO,
       e2.ENAME AS MGR_ENAME
FROM EMP e FULL JOIN EMP e2 ON(e.MGR = e2.EMPNO);

/* 서브쿼리 : SQL 쿼리 안에 포함된 또 다른 쿼리를 말함. 즉, 하나의 SQL 문장 안에서 또 다른 SQL 문장이 사용되는 것
   쿼리를 사용하여 데이터베이스에서 원하는 정보를 검색하거나 삽입, 갱신, 삭제하는 등의 작업을 수행할 수 있다.
   대부분의 쿼리는 SELECT, INSERT, UPDATE, DELETE와 같은 SQL 문장을 사용하여 작성됨.
   */
SELECT ROWNUM, EMP.*
FROM EMP;

SELECT *
FROM (SELECT ROWNUM, EMP.* FROM EMP)
WHERE ROWNUM BETWEEN 1 AND 5;
SELECT *
FROM (SELECT ROWNUM N, EMP.* FROM EMP)      -- select 안에 또 select가 들어가는 것을 서브쿼리라고 한다.
WHERE N BETWEEN 6 AND 10;

-- 급여를 내림차순으로 정리한 다음에 상위 5명 정보 출력
SELECT *
FROM (SELECT ROWNUM, EMP.* FROM EMP)
WHERE ROWNUM BETWEEN 1 AND 5 ORDER BY SAL DESC;

-- 급여를 내림차순으로 정렬한 다음, 상위 5명 정보 출력
SELECT *
FROM (SELECT EMP.* FROM EMP ORDER BY SAL DESC )
WHERE ROWNUM BETWEEN 1 AND 5;

-- 'SCOTT' 보다 높은 급여를 받는 사원
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');

-- 'ALLEN'의 추가수당보다 높은 추가수당을 받는 사원
SELECT *
FROM EMP
WHERE COMM > (SELECT COMM FROM EMP WHERE ENAME = 'ALLEN');

/* 문제 풀기
   1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 출력
   2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력
   3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력
   4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력
*/
-- --1번
-- SELECT *
-- FROM (SELECT DEPTNO, count(*) AS 인원수 FROM EMP GROUP BY DEPTNO )
-- WHERE ROWNUM BETWEEN 1 AND 6;
--
-- SELECT COUNT(DEPTNO) FROM EMP WHERE DEPTNO = 30;
--
--
-- SELECT DEPTNO, count(*) AS 인원수 FROM EMP GROUP BY DEPTNO ;

--1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 조회하라
SELECT DEPTNO AS 부서번호, COUNT(*) AS 인원수, SUM(SAL) AS 총급여
FROM EMP e
GROUP BY DEPTNO
HAVING COUNT(*) > 4;
-- WHERE 절은 집계함수를 사용할 수 없다는 점 기억하기 , GROUP BY / HAVING 으로 대체

--2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 조회하라.
SELECT *
FROM (
     SELECT DEPTNO AS 부서번호, COUNT(*) AS 사원수
     FROM EMP
     GROUP BY DEPTNO
     ORDER BY COUNT(*) DESC
)
WHERE ROWNUM = 1;

--3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 조회하라
SELECT MGR AS 대장
FROM (
     -- MGR로 그룹핑 한 후, COUNT를 통해 이하 계수 파악
     -- 내림차순으로 가장 많은 사원을 가진 MGR이 1행에 위치하도록 설정
     SELECT MGR, COUNT(*) AS 사원수
     FROM EMP
     GROUP BY MGR
     ORDER BY COUNT(*) DESC
     ) -- WHERE절에 1행을 설정하면서 가장 많은 직원을 가진 MGR이 조회되도록 필터링
WHERE ROWNUM = 1;

--4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 조회하라

SELECT '30' AS 부서번호, COUNT(*) AS 사원수
FROM EMP
WHERE DEPTNO = 30
UNION ALL
SELECT '10', COUNT(*)
FROM EMP
WHERE DEPTNO = 10;
