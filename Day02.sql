select * from EMP;

select EMPNO, ENAME, SAL from EMP;      -- 사원번호, 사원이름, 월급 조회

select ENAME  "이름", SAL  "월급" from EMP;     -- 큰따옴표는 식별자
-- 사원번호, 사원이름, 월급, 연봉을 구하고 컬럼명은 사원번호, 사원이름, 월급, 연봉으로 조회

select EMPNO "사원번호", ENAME "사원이름", SAL "월급",SAL * 12 "연봉" from EMP;

select distinct JOB from EMP e ;        -- 중복데이터를 제거
select distinct JOB, DEPTNO from EMP e ;
select all JOB, DEPTNO from EMP e;
-- 사칙연산을 하는 함수? DUAL
select 'ABC'from DUAL;
select 2 + 3 from DUAL;
select 'ABC', 2+3 from DUAL;
select 2+3 as RESULT from DUAL;
-- '' 에 들어가는거는 숫자형으로 변형한다,
select 1 + '5' from DUAL;
select '1' + '5' from DUAL;
select 1 || '5' from DUAL;

/* 사원명과 업무로 연결 (SMITH, CLERK) 표시하고 컬럼명은 EMPLOYEE AND JOB으로 표시*/
select '(' || ENAME|| ',' ||JOB ||')' as "Employee and Job" from EMP;


/* 사원별 연간 총 수입을 별칭은 연간총수입으로 표현 */

select ENAME, SAL *12 +COMM as "연간총수익" from EMP;

select * from EMP e;
select * from EMP e order by SAL;       -- 오름차순 정렬
select * from EMP e order by EMPNO;
select * from EMP e order by SAL DESC;  -- 내림차순 정렬
/* --------------------------------------------------*/
-- 조건을 추가하는 WHERE절
select * from EMP e where EMPNO = 7839;
-- 사원번호가 7698번의 사원명과 업무, 급여를 출력
select ENAME, JOB, SAL from EMP e where EMPNO = 7698;
-- Smith의 사원명, 부서, 월급
select JOB, SAL from EMP e where ENAME = 'SMITH';
select * from EMP e where SAL = 3000;
select * from EMP e where SAL != 3000;
select * from EMP e where SAL ^= 4000; -- !=와 동일하게 사용됨
select * from EMP e where SAL <> 5000; -- !=와 동일하게 사용됨
select * from EMP e where not SAL = 6000; -- !=와 동일하게 사용됨
select * from EMP e where ENAME >= 'M'; -- 문자중에 첫글자가 M보다 같거나 큰(뒷)문자만 분류해서 출력

-- 월급이 2500 이상이고 3000 미만인 사원과 입사일 월급 출력
select ENAME,HIRERATE, SAL from EMP e where SAL >= 2500 and SAL < 3000;
-- 월급이 2500 이상이고, 3000 이하에 포함되지 않는 사원명과 월급 입사일 출력
select ENAME,HIRERATE, SAL from EMP e where not (SAL >= 2500 and SAL <= 3000);

select * from EMP e where SAL between 2500 and 3000; -- 이상 이하일때만 between 사용가능
-- 81년 5월 1일과 81년 12월 3일 사이에 입사한 사원, 급여, 입사일을 조회
select ENAME, SAL, HIRERATE from  EMP e where HIRERATE between to_date('19810501', 'yyyymmdd')and to_date('19811203', 'yyyymmdd');
-- 1987년도 입사한 사원명, 월급, 입사일 조회
SELECT ENAME, SAL, HIRERATE FROM EMP e WHERE HIRERATE BETWEEN TO_DATE('19870101', 'YYYYMMDD') AND TO_DATE('19871231', 'YYYYMMDD');
-- 직원이 'manager', 'clerk', 'salesman'
select * from EMP e where JOB = 'MANAGER' or JOB = 'CLERK' or JOB = 'SALESMAN';
select * from EMP e where JOB in ('MANAGER', 'SALESMAN');
-- 사번이 7566, 7782, 7934 인 사원은 제외한 사원이름, 월급출력
select EMPNO, ENAME, SAL
from EMP e where EMPNO not in ('7566','7782','7934');
-- 부서번호 30에서 근무하고 월 2000달러 이하를 받는 81년 5월 1일 이전의 입사한 사원의 이름, 급여, 부서번호, 입사일 조회
select ENAME, SAL, DEPTNO, HIRERATE
from EMP e where DEPTNO = '30' and SAL <= 2000 and HIRERATE < to_date('19810501', 'yyyymmdd');
-- 부서가 10 또는 30인 부서에서 월급이 2000 ~ 5000 사이의 사원명, 급여, 부서번호 조회
select ENAME, SAL, DEPTNO
from EMP e where DEPTNO in ('10', '30') and e.SAL between 2000 and 5000;
-- job이 manager or salesman 급여가 1600, 2975 , 2850가 아닌 사원 정보 출력
select ENAME, HIRERATE, SAL, DEPTNO
from EMP e where SAL not in (1600 , 2975 , 2850);
/* =============================================================*/
select *
from EMP e where ENAME like 'S%'; -- 첫번째 문자가 대문자 'S'인 문자열 찾기
select *
from EMP e where ENAME like '_L%'; -- 두번째 문자가 대문자 'L'인 문자열 찾기
-- 사원이름중 'S'가 포함되지 않은 부서번호 20인 사원의 이름, 부서번호 조회
select ENAME, DEPTNO
from EMP e where ENAME not like '%S%' and DEPTNO = '20';
-- 1981.6.1 ~ 1981.12.31 입사자중 30인 부서의 부서번호, 사원명, 직업, 입사일 출력(입사일 오름차순으로 정렬)
select DEPTNO, ENAME, JOB, HIRERATE
from EMP e
where HIRERATE between to_date('19810601', 'yyyymmdd') and to_date('19811231', 'yyyymmdd')
  and DEPTNO = 30
order by HIRERATE;
-- 사원 이름중에 A와 E가 있는 사원을 조회
select *
from EMP e where ENAME like '%A%' and ENAME like '%E%';

select *
from EMP e where COMM = null; -- 비교연산자에서는 null을 사용하지 못함

select ENAME, SAL, SAL * 12 + COMM, COMM
from EMP e;

select *
from EMP e
where COMM is not null;  -- null인 열을 찾는 방법


-- 사수가 있는 사원 출력
select *
from EMP e
where MGR is not null ;


-- 수당에서 0을 제외한 사원 조회
select *
from EMP e
where COMM != 0
   or COMM is null;

