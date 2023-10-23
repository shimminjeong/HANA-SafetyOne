-- indexing--

CREATE INDEX CLUSTER_INDEX ON clustertable(clusternum,email);

CREATE INDEX idx_hist_date ON cardhistory(cardhisdate);
CREATE INDEX idx_cardhist_cardid ON cardhistory(CARDID);


CREATE INDEX idx_cardhistory_optimized ON cardhistory(CARDHISDATE, CATEGORYSMALL);
CREATE INDEX idx_card_email_cardid ON card(EMAIL, CARDID);

EXPLAIN PLAN FOR
SELECT m.EMAIL, c.CARDNAME, ch.CARDHISID, ch.CATEGORYBIG, ch.CATEGORYSMALL, ch.REGIONNAME, ch.STORE, ch.CARDHISDATE, ch.AMOUNT
FROM member m
JOIN card c ON m.EMAIL = c.EMAIL
JOIN cardhistory ch ON c.CARDID = ch.CARDID
WHERE ch.CARDHISDATE BETWEEN TRUNC(SYSDATE) - 7 AND TRUNC(SYSDATE)
AND ch.AMOUNT >= 10000
AND ch.CATEGORYSMALL = '귀금속'
AND m.EMAIL LIKE '%naver.com%'
ORDER BY ch.AMOUNT DESC, ch.CARDHISDATE DESC;



---------------클러스터별 카테고리별 한달 평균사용금액, 한달평균사용빈도------------
-- 집계, 통계 쿼리
--EXPLAIN PLAN FOR
SELECT
    clt.CLUSTERNum as clusterNum,
    ch.categorySmall as categorySmall,
    trunc(SUM(ch.amount) /cc.clusterCount) as amount,
    ROUND(COUNT(*) /cc.clusterCount, 3) as count
FROM cardhistory ch 
JOIN card c ON ch.cardid = c.cardid
JOIN clusterTable clt ON c.email = clt.EMAIL
JOIN (
    SELECT clusterNum, COUNT(*) AS clusterCount
    FROM clusterTable
    GROUP BY clusterNum
) cc ON clt.CLUSTERNum = cc.clusterNum
GROUP BY clt.CLUSTERNum, ch.categorySmall, cc.clusterCount
ORDER BY clt.CLUSTERNum, count;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());



--VIEW
DROP VIEW clusterstaticView;
CREATE VIEW clusterstaticView
AS 
SELECT 
    clt.CLUSTERNum as clusterNum,
    ch.categorySmall as categorySmall,
    trunc(SUM(ch.amount) /cc.clusterCount) as amount,
    ROUND(COUNT(*) /cc.clusterCount, 3) as count
FROM cardhistory ch 
JOIN card c ON ch.cardid = c.cardid
JOIN clusterTable clt ON c.email = clt.EMAIL
JOIN (
    SELECT clusterNum, COUNT(*) AS clusterCount
    FROM clusterTable
    GROUP BY clusterNum
) cc ON clt.CLUSTERNum = cc.clusterNum
GROUP BY clt.CLUSTERNum, ch.categorySmall, cc.clusterCount
ORDER BY clt.CLUSTERNum, count;

EXPLAIN PLAN FOR
SELECT *
FROM clusterstaticView;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());



-- MVIEW
DROP MATERIALIZED VIEW clusterstatic;
CREATE MATERIALIZED VIEW clusterstatic
BUILD IMMEDIATE
REFRESH ON DEMAND
AS 
SELECT 
    clt.CLUSTERNum as clusterNum,
    ch.categorySmall as categorySmall,
    trunc(SUM(ch.amount) /cc.clusterCount) as amount,
    ROUND(COUNT(*) /cc.clusterCount, 3) as count
FROM cardhistory ch 
JOIN card c ON ch.cardid = c.cardid
JOIN clusterTable clt ON c.email = clt.EMAIL
JOIN (
    SELECT clusterNum, COUNT(*) AS clusterCount
    FROM clusterTable
    GROUP BY clusterNum
) cc ON clt.CLUSTERNum = cc.clusterNum
GROUP BY clt.CLUSTERNum, ch.categorySmall, cc.clusterCount
ORDER BY clt.CLUSTERNum, count;

SELECT * FROM clusterstatic;


SELECT * FROM CATEGORY;

EXPLAIN PLAN FOR
SELECT *
FROM clusterstatic;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY());
