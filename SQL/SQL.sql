------------------------고객
CREATE SEQUENCE MEMBER_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE MEMBER (
      EMAIL         VARCHAR2(50)    NOT NULL    PRIMARY KEY,    -- 이메일
      NAME          VARCHAR2(50)    NOT NULL,                   -- 이름
      PASSWORD      VARCHAR2(50)    NOT NULL,                   -- 비밀번호
      PHONE         VARCHAR2(50)    NOT NULL,                   -- 휴대전화
      GENDER           CHAR(1)         CHECK(GENDER IN ('M','F')),    -- 성별
      ADDRESS       VARCHAR2(255),                              -- 주소
      IDENTITYNUM   VARCHAR2(20)    NOT NULL,                   -- 주민번호
      AGE           NUMBER          NOT NULL,
      REGDATE       DATE            NOT NULL,                   -- 등록일시
      AUTHORITY  CHAR(1)         DEFAULT 'U' CHECK(AUTHORITY IN ('U','M'))  -- 회원권한
);



DESC MEMBER;

------------------------- 카드

CREATE TABLE CARD (
      CARDID               VARCHAR2(20)    NOT NULL    PRIMARY KEY, 
      EMAIL                 VARCHAR2(50),
      CARDCVC              CHAR(3)         NOT NULL,           -- CVC번호
      CARDPASSWORD         CHAR(4)         NOT NULL,           -- 비밀번호
      CARDREGDATE         DATE            NOT NULL,           -- 카드 등록일자
      AMOUNTLIMIT          NUMBER(10)      NOT NULL,           -- 카드 한도
      FDSSERSTATUS        CHAR(1)         DEFAULT 'N' CHECK(FDSSERSTATUS IN ('Y','N')),        -- FDS 서비스신청여부
      SELFFDSSERSTATUS    CHAR(1)         DEFAULT 'N' CHECK(SELFFDSSERSTATUS IN ('Y','N')),    -- SelfFDS 서비스 신청여부
      VALIDDATE           DATE            NOT NULL,
      CARDNAME            VARCHAR2(255)   NOT NULL,
      CONSTRAINT MEMBERID FOREIGN KEY (EMAIL) REFERENCES MEMBER (EMAIL)
);


--------------------------- 거래내역

CREATE SEQUENCE CARD_HIS_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE CARDHISTORY (
      CARDHISID           NUMBER(20)      DEFAULT CARD_HIS_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
      CARDID               VARCHAR2(20)    NOT NULL,               -- 카드번호
      CATEGORYSMALL              VARCHAR2(50)    NOT NULL,   
      REGIONNAME           VARCHAR2(50), 
      STORE                 VARCHAR2(255),                          -- 가맹점명
      CARDHISDATE         DATE            NOT NULL,               -- 거래시간
      CARDHISTIME         VARCHAR(20)     NOT NULL,
      AMOUNT                NUMBER(10,0)    NOT NULL,                             -- 거래금액
      CONSTRAINT CARDID    FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);



-------------------------도난/분실 신고내역
DROP SEQUENCE LOSTCARD_ID_SEQ;
DROP table LOSTCARD;
CREATE SEQUENCE LOSTCARD_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

create table LOSTCARD(
LOSTCARDIDSEQ          NUMBER(20)      DEFAULT LOSTCARD_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
REGLOSTDATE             DATE DEFAULT SYSDATE,
CARDID               VARCHAR2(20)    NOT NULL,
LOSTDATE               DATE,
LOSTPLACE              VARCHAR2(255)    NOT NULL,
LOSTREASON               VARCHAR2(255)    NOT NULL,
REISSUED               CHAR(1)    CHECK(REISSUED IN ('Y','N')),
CONSTRAINT CON_LOSTCARD_CARDID  FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);



----------------------------------결제
-----------------------결제카드info---------------
CREATE TABLE PaymentCardInfo (
      CARDID               VARCHAR2(20)    NOT NULL    PRIMARY KEY, 
      EMAIL                 VARCHAR2(50),
      CONSTRAINT PAYMENT_MEMBERID FOREIGN KEY (EMAIL) REFERENCES MEMBER (EMAIL),
      CONSTRAINT PAYMENT_CARDID FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);


---------------------결제로그-------------------
DROP SEQUENCE PAYMENTLOG_ID_SEQ;

CREATE SEQUENCE PAYMENTLOGIDSEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

DROP TABLE PAYMENTLOG;
CREATE TABLE PAYMENTLOG (
      PAYMENTLOGID            NUMBER(20)       DEFAULT PAYMENTLOGIDSEQ.nextval     NOT NULL    PRIMARY KEY,
      CARDID                   VARCHAR2(20)     NOT NULL,               -- 카드번호
      ADDRESS                   VARCHAR2(255)     NOT NULL,               -- 가맹점주소
      STORE                     VARCHAR2(255)    NOT NULL,               -- 가맹점명
      PAYMENTDATE              TIMESTAMP        NOT NULL,               -- 결제시간
      categorySmall             VARCHAR2(255)     NOT NULL,               -- 업종코드
      AMOUNT                    NUMBER           NOT NULL,               -- 결제금액
      paymentApprovalStatus   CHAR(1)          CHECK(paymentApprovalStatus IN ('Y','N')),  --최종결제 승인여부
      fdsDetectionStatus       CHAR(1),            --FDS 탐지 승인여부
      CONSTRAINT PAYMENT_LOG_CARD_ID FOREIGN KEY (CARDID) REFERENCES PaymentCardInfo (CARDID)
);


-------------------------안심서비스
DROP SEQUENCE SAFETY_ID_SEQ;
DROP table safetycard;
CREATE SEQUENCE SAFETY_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

drop table safetycard;
create table safetycard(
        SAFETYIDSEQ          NUMBER(20)      DEFAULT SAFETY_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
        CARDID               VARCHAR2(20)    NOT NULL,
        SAFETYSTARTDATE        DATE, 
        SAFETYENDDATE         DATE,
        REGIONNAME      VARCHAR2(50),
        CATEGORYSMALL       VARCHAR2(50),
        TIME           VARCHAR2(50),
        STATUS            CHAR(1)         DEFAULT 'Y' CHECK(STATUS IN ('Y','N')),
        STOPSTARTDATE        DATE, 
        STOPENDDATE         DATE,
        CONSTRAINT CON_SAFETY_CARDID  FOREIGN KEY (CARDID) REFERENCES CARD (CARDID)
);




---------------------------이상소비알림서비스
CREATE TABLE FDS (
    CARDID VARCHAR2(20) PRIMARY KEY REFERENCES CARD(CARDID),
    SERREGDATE DATE,        -- 서비스 신청일자
    SERENDDATE DATE,        -- 서비스 종료일자
    SERVICESTATUS VARCHAR2(50) NOT NULL, 
    LEARNINGDATE DATE ,         -- 학습일자
    WEIGHTSAVEPATH VARCHAR2(255),          -- 이상탐지가중치저장경로
    CATEGORYSMALLSTATS VARCHAR2(255),             -- 업종평균
    REGIONSTATS VARCHAR2(255),               -- 지역평균
    TIMESTATS VARCHAR2(255),                 -- 시간평균
    AMOUNTSTATS VARCHAR2(255)               -- 가격평균

);



---------------------- CODE ENTITY-----------------------------------------------------------------
---------------- CATEGORY
CREATE TABLE CATEGORY (
      CATEGORYCODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- 업종코드
      CATEGORYBIG          VARCHAR2(255)      NOT NULL,                -- 업종대분류 
      CATEGORYMIDDLE       VARCHAR2(255)      NOT NULL,                -- 업종중분류 
      CATEGORYSMALL        VARCHAR2(255)      NOT NULL                 -- 업종소분류 
);



---------------- REGION
CREATE TABLE REGION (
      REGIONCODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --지역코드
      REGIONNAME       VARCHAR2(50)      NOT NULL                -- 지역이름 
);



-------------------------분석테이블-------------------

---------------------------클러스터
CREATE TABLE clusterTable (
    email VARCHAR2(50) PRIMARY KEY REFERENCES member(email),
    clusterNum Varchar2(20)
    );

---------------- MVIEW
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



---------------- CATEGORYembedding
CREATE TABLE CATEGORYembedding (
      CATEGORYCODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- 업종코드
      CATEGORYSMALL        VARCHAR2(255)      NOT NULL,              -- 업종소분류 
      barToEmbedding       number,
      diamondToEmbedding   number
);

----------------- REGIONembedding
CREATE TABLE REGIONembedding (
      REGIONCODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --지역코드
      REGIONNAME       VARCHAR2(50)      NOT NULL,
      seoultToRegionTime number(10),
      seoultToRegionDistance number(10)
);


INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('02', '서울특별시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('031', '경기도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('032', '인천광역시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('033', '강원도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('041', '충청남도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('042', '대전광역시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('043', '충청북도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('044', '세종특별자치시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('051', '부산광역시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('052', '울산광역시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('053', '대구광역시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('054', '경상북도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('055', '경상남도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('061', '전라남도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('062', '광주광역시');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('063', '전라북도');
INSERT INTO REGION (REGIONCODE, REGIONNAME) VALUES ('064', '제주도');
COMMIT;


