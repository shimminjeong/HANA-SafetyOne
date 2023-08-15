DROP SEQUENCE CARD_HIS_ID_SEQ;
DROP TABLE CARD_HISTORY;
DROP table CARD;
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
      EMAIL         VARCHAR2(50)    NOT NULL    PRIMARY KEY,    -- 이메일
      NAME          VARCHAR2(50)    NOT NULL,                   -- 이름
      PASSWORD      VARCHAR2(50)    NOT NULL,                   -- 비밀번호
      PHONE         VARCHAR2(50)    NOT NULL,                   -- 휴대전화
      SEX           CHAR(1)         CHECK(SEX IN ('M','F')),    -- 성별
      ADDRESS       VARCHAR2(255),                              -- 주소
      IDENTITY_NM   VARCHAR2(20)    NOT NULL,                   -- 주민번호
      REG_DATE      DATE            NOT NULL,                   -- 등록일시
      MEMBER_STATUS CHAR(1)         DEFAULT 'Y' CHECK(MEMBER_STATUS IN ('Y','N'))  -- 회원상태
 
);

------------------------- 카드

CREATE TABLE CARD (
      CARD_ID               VARCHAR2(20)    NOT NULL    PRIMARY KEY, 
      EMAIL                 VARCHAR2(50),
      CARD_CVC              CHAR(3)         NOT NULL,           -- CVC번호
      CARD_PASSWORD         CHAR(4)         NOT NULL,           -- 비밀번호
      CARD_REG_DATE         DATE            NOT NULL,           -- 카드 등록일자
      AMOUNT_LIMIT          NUMBER(10)      NOT NULL,           -- 카드 한도
      FDS_SER_STATUS        CHAR(1)         DEFAULT 'N' CHECK(FDS_SER_STATUS IN ('Y','N')),        -- FDS 서비스신청여부
      SELFFDS_SER_STATUS    CHAR(1)         DEFAULT 'N' CHECK(SELFFDS_SER_STATUS IN ('Y','N')),    -- SelfFDS 서비스 신청여부
      CONSTRAINT MEMBER_ID FOREIGN KEY (EMAIL) REFERENCES MEMBER (EMAIL)
);




--------------------------- 거래내역
CREATE SEQUENCE CARD_HIS_ID_SEQ
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;

CREATE TABLE CARD_HISTORY (
      CARD_HIS_ID           NUMBER(20)      DEFAULT CARD_HIS_ID_SEQ.nextval     NOT NULL PRIMARY KEY,
      CARD_ID               VARCHAR2(20)    NOT NULL,               -- 카드번호
      CATEGORY              VARCHAR2(20)    NOT NULL,               -- 거래업종코드
      REGION_NAME           VARCHAR2(50),                           -- 가맹점위치코드
      STORE                 VARCHAR2(255),                          -- 가맹점명
      CARD_HIS_DATE         DATE            NOT NULL,               -- 거래시간
      CARD_HIS_TIME         VARCHAR(20)     NOT NULL,
      AMOUNT                NUMBER(10,0)    NOT NULL,                             -- 거래금액
      CONSTRAINT CARD_ID    FOREIGN KEY (CARD_ID) REFERENCES CARD (CARD_ID)
);

select count(*) from card_history
where card_his_date between to_char('23/03/01') and to_char('23/06/01');
select count(*) from card_history
where card_his_date between to_char('23/06/02') and to_char('23/09/01');
select * from card;
select count(*) from card;
SELECT count(*) FROM MEMBER;
SELECT * FROM CARD_HISTORY;

select category,sum(amount),count(*) from CARD_HISTORY
group by category
order by count(*);


SELECT TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD'),count(*) AS CNT
FROM CARD_HISTORY
GROUP BY TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD')
ORDER BY TO_CHAR(CARD_HIS_DATE, 'YYYY/MM/DD') DESC;



----------------------

INSERT INTO MEMBER (EMAIL, NAME, PASSWORD, PHONE,SEX,ADDRESS,IDENTITY_NM,REG_DATE)
VALUES ('pooh5045@gmail.com', '심민정', 'test123', '010-5043-7629','F','경기도 광명시 일직동','981223-2123122',TO_DATE('2020-08-07', 'YYYY-MM-DD'));
INSERT INTO MEMBER (EMAIL, NAME, PASSWORD, PHONE,SEX,ADDRESS,IDENTITY_NM,REG_DATE)
VALUES ('admin@gmail.com', '관리자', 'test123', '010-5043-7629','F','경기도 광명시 일직동','981223-2123122',TO_DATE('2020-08-07', 'YYYY-MM-DD'));
commit;

---------------------- CODE ENTITY-----------------------
-- TIME

CREATE TABLE TIME (
      TIME_CODE   VARCHAR2(20)      NOT NULL   PRIMARY KEY,  --시간코드
      TIME        VARCHAR2(50)      NOT NULL                 --시간  
);

INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0102', '0102');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0304', '0304');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0506', '0506');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0708', '0708');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T0910', '0910');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1112', '1112');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1314', '1314');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1516', '1516');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1718', '1718');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T1920', '1920');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T2122', '2122');
INSERT INTO TIME (TIME_CODE, TIME) VALUES ('T2324', '2324');
COMMIT;



-- CATEGORY
CREATE TABLE CATEGORY (
      CATEGORY_CODE         VARCHAR2(20)       NOT NULL   PRIMARY KEY,  -- 업종코드
      CATEGORY_BIG          VARCHAR2(255)      NOT NULL,                -- 업종대분류 
      CATEGORY_MIDDLE       VARCHAR2(255)      NOT NULL,                -- 업종중분류 
      CATEGORY_SMALL        VARCHAR2(255)      NOT NULL                 -- 업종소분류 
);


-- REGION
CREATE TABLE REGION (
      REGION_CODE       VARCHAR2(20)      NOT NULL   PRIMARY KEY, --지역코드
      REGION_NAME       VARCHAR2(50)      NOT NULL                -- 지역이름 
);


INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('02', '서울특별시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('031', '경기도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('032', '인천광역시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('033', '강원도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('041', '충청남도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('042', '대전광역시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('043', '충청북도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('051', '부산광역시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('052', '울산광역시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('053', '대구광역시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('054', '경상북도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('055', '경상남도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('061', '전라남도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('062', '광주광역시');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('063', '전라북도');
INSERT INTO REGION (REGION_CODE, REGION_NAME) VALUES ('064', '제주도');
COMMIT;

