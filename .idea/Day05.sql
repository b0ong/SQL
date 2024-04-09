-- emp 테이블에서 입사일 순으로 사원번호, 이름, 업무, 급여, 입사일자, 부서번호 조회
SELECT EMPNO, ENAME, EMP.JOB, SAL, HIRERATE, DEPTNO
FROM EMP ORDER BY HIRERATE;

-- emp 테이블에서 부서번호로 정렬한 후 급여가 많은 순으로 사원번호, 성명, 업무, 부서번호, 급여를 조회
SELECT EMPNO, ENAME, EMP.JOB, DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO, SAL DESC;

-- emp 테이블에서 모든 salesman의 급여 평균, 최고액, 최저액, 합계를 조회하시오
SELECT avg(SAL)AS "평균", max(SAL) AS "최고액",min(SAL) AS "최소액", sum(SAL) AS "합계"
FROM EMP WHERE EMP.JOB = 'SALESMAN';

-- emp 테이블에서 각 부서별로 인원수, 급여의 평균, 최저 급여, 최고 급여, 급여의 합을 구하여 급여의 합이 많은 순으로 출력하시오
SELECT count(*),round(avg(SAL),1),min(SAL),max(SAL),sum(SAL)
FROM EMP GROUP BY DEPTNO ORDER BY sum(SAL) DESC ;