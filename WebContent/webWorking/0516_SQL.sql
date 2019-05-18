--建立表格: 
--------------------------------------------------------------------------------------------------------
DROP TABLE RESTAURANT_RESPONSES;
DROP TABLE FRIEND_LIST;
DROP TABLE CUSTOMER_SERVICE_RECORD;
DROP TABLE CHAT_RECORD;
DROP TABLE ARTICLE_REPORTED;
DROP TABLE ARTICLE_PUBLISHED;
DROP TABLE COMMENT_REPORTED;
DROP TABLE MEMBER_WALLET_LIST;
DROP TABLE COMMENTS;
DROP TABLE ORDER_DETAIL;
DROP TABLE RESTAURANT_MENU ;
DROP TABLE RESERVATION_TABLE_NUMBER;
DROP TABLE RESERVATION_TABLE_ORDERED;
DROP TABLE EXCEPTION_DATE;
DROP TABLE RESERVATION_TIME;
DROP TABLE RES_TRANSACTION_LIST;
DROP TABLE FAV_RES;
DROP TABLE REP_RES;
DROP TABLE WAIT_POS ;
DROP TABLE ORD;
DROP TABLE TABLES;
DROP TABLE NEWS ;
DROP TABLE FEATURE_DETAIL;
DROP TABLE FEATURE;
DROP TABLE EMPLOYEE;
DROP TABLE VENDOR ;
DROP TABLE MEMBER;


DROP SEQUENCE ARTPUB_SEQ;
DROP SEQUENCE ARTRE_SEQ;a
DROP SEQUENCE CH_RE_SEQ;
DROP SEQUENCE CU_SE_RE_SEQ;
DROP SEQUENCE RESTAURANT_RESPONSES_SEQ;
DROP SEQUENCE COMMENT_REPORTED_SEQ;
DROP SEQUENCE COMMENTS_SEQ;
DROP SEQUENCE EMPLOYEE_SEQ;
DROP SEQUENCE EXCEPTION_DATE_SEQ;
DROP SEQUENCE FEATURE_SEQ;
DROP SEQUENCE MEMBER_SEQ;
DROP SEQUENCE MEMBER_WALLET_LIST_SEQ;
DROP SEQUENCE NEWS_SEQ;
DROP SEQUENCE ORD_SEQ;
DROP SEQUENCE REP_RES_SEQ;
DROP SEQUENCE RES_T_L_SEQ;
DROP SEQUENCE RESERVATION_T_SEQ;
DROP SEQUENCE RESERVATION_TABLE_NUMBER_SEQ;
DROP SEQUENCE RESERVATION_TABLE_ORDERED_SEQ;
DROP SEQUENCE RESTAURANT_MENU_SEQ;
DROP SEQUENCE TABLES_SEQ;
DROP SEQUENCE VENDOR_SEQ;
DROP SEQUENCE WAIT_POS_SEQ;
----------------------------------------------------------------
alter session set nls_date_format = 'dd/MON/yyyy hh24:mi:ss';
----------------------------------------------------------------
--會員
CREATE TABLE MEMBER  (                
  MEM_NO      VARCHAR2(7 BYTE)  NOT NULL
, MEM_NAME      VARCHAR2(30 BYTE) NOT NULL UNIQUE
, MEM_ACCOUNT     VARCHAR2(10 BYTE)   NOT NULL 
, MEM_PWD       VARCHAR2(10 BYTE) NOT NULL 
, MEM_GENDER    VARCHAR2(2 BYTE)  NOT NULL 
, MEM_MAIL      VARCHAR2(50 BYTE)   NOT NULL UNIQUE
, MEM_ID      VARCHAR2(10 BYTE)   NOT NULL UNIQUE 
, MEM_TEL       VARCHAR2(10 BYTE)  NOT NULL 
, MEM_STATUS    VARCHAR2(2 BYTE)  DEFAULT '2' 
, MEM_PIC BLOB  
, MEM_BALANCE     NUMBER(10, 0)     NOT NULL
, MEM_NICKNAME    VARCHAR2(50 BYTE)   NOT NULL 
, CONSTRAINT MEMBER_MEM_NO_PK PRIMARY KEY (MEM_NO)
);
--SEQUENCE MEM_NO
CREATE SEQUENCE MEMBER_SEQ     -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1           -- 每次增加數量
START WITH 1           -- 從1開始
NOMAXVALUE             -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號


--------------------------------------------------------------------------------------------------
--廠商
CREATE TABLE VENDOR  (
  VENDOR_NO     VARCHAR2(7 BYTE)  NOT NULL
, V_ACCOUNT     VARCHAR2(10 BYTE)   NOT NULL UNIQUE 
, V_PWD       VARCHAR2(10 BYTE)   NOT NULL 
, V_MAIL      VARCHAR2(50 BYTE)   NOT NULL UNIQUE 
, V_TEL       VARCHAR2(10 BYTE)   NOT NULL 
, V_N_CODE      VARCHAR2(10 BYTE) 
, V_AD_CODE     VARCHAR2(10 BYTE)   NOT NULL 
, V_ADDRESS1    VARCHAR2(10 BYTE)   NOT NULL 
, V_ADDRESS2    VARCHAR2(30 BYTE)   NOT NULL 
, V_ADDRESS3    VARCHAR2(100 BYTE)  NOT NULL 
, V_WALLET      VARCHAR2(20 BYTE)   NOT NULL   
, V_NAME      VARCHAR2(100 BYTE)   NOT NULL 
, V_W_NO      NUMBER(10, 0)     DEFAULT 0 NOT NULL
, V_N_NO      NUMBER(10, 0)     DEFAULT 0 NOT NULL
, V_ALT_NO      NUMBER(10, 0)     DEFAULT 0 NOT NULL
, V_START_TIME    VARCHAR2(10 BYTE)   NOT NULL 
, V_END_TIME    VARCHAR2(10 BYTE)   NOT NULL 
, V_DAY       VARCHAR2(7 BYTE)  NOT NULL
, V_TABLES    VARCHAR2(10 BYTE)   NOT NULL  
, V_PIC BLOB
, V_AD BLOB
, V_STATUS      VARCHAR2(2 BYTE)  DEFAULT '0' 
, V_WAIT_STATUS          VARCHAR2(2 BYTE)    DEFAULT '0' 
, V_TYPE          VARCHAR2(18 BYTE)    
, V_TEXT          VARCHAR2(500 BYTE) 
, CONSTRAINT VENDOR_VENDOR_NO_PK PRIMARY KEY (VENDOR_NO)
);
--SEQUENCE VENDOR_NO
CREATE SEQUENCE VENDOR_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

------------------------------------------------------------------------------------------------------------------------------
--候位明細
CREATE TABLE WAIT_POS (
  WAIT_NO       VARCHAR2(10 BYTE) NOT NULL
, MEM_NO      VARCHAR2(7 BYTE)  NOT NULL
, VENDOR_NO     VARCHAR2(7 BYTE)  NOT NULL
, WAIT_MUN      NUMBER(10, 0)     NOT NULL
, WAIT_PEOPLE       NUMBER(10, 0)     NOT NULL
, WAIT_GETTIME      DATE          
, WAIT_REMIND       NUMBER(10, 0)
, WAIT_STATUS       NUMBER(10, 0)     DEFAULT 2 NOT NULL 
--FK
, CONSTRAINT WAIT_POS_MEM_NO_FK   FOREIGN KEY (MEM_NO)  REFERENCES MEMBER (MEM_NO)
, CONSTRAINT WAIT_POS_VENDOR_NO_FK  FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT WAIT_POS_WAIT_NO_PK  PRIMARY KEY (WAIT_NO)
);

--SEQUENCE  WAIT_NO 
CREATE SEQUENCE WAIT_POS_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-----------------------------------------------------------------
--餐廳檢舉清單
CREATE TABLE REP_RES (
  REP_RES_NO    VARCHAR2(10 BYTE)   NOT NULL
, MEM_NO      VARCHAR2(7 BYTE)  NOT NULL
, VENDOR_NO     VARCHAR2(7 BYTE)  NOT NULL
, REP_RES_DETL    VARCHAR2(100 BYTE)  NOT NULL 
, REP_RES_TIME      DATE
, REP_RES_STATUS    VARCHAR2(2 BYTE)  NOT NULL 
--FK
, CONSTRAINT REP_RES_MEM_NO_FK    FOREIGN KEY (MEM_NO)  REFERENCES MEMBER (MEM_NO)
, CONSTRAINT REP_RES_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT REP_RES_NO_PK      PRIMARY KEY (REP_RES_NO)
);

--SEQUENCE  WAIT_NO 
CREATE SEQUENCE REP_RES_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-----------------------------------------------------------------
--收藏店家清單
CREATE TABLE FAV_RES (
  MEM_NO      VARCHAR2(7 BYTE) NOT NULL
, VENDOR_NO     VARCHAR2(7 BYTE) NOT NULL
--FK
, CONSTRAINT FAV_RES_MEM_NO_FK    FOREIGN KEY (MEM_NO)  REFERENCES MEMBER (MEM_NO)
, CONSTRAINT FAV_RES_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT FAV_RES_MEM_NO_VEN_DOR_NO_PK PRIMARY KEY (MEM_NO,VENDOR_NO )
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------
--桌位   丞智

CREATE TABLE TABLES (
    TBL_NO      VARCHAR2(7 BYTE),
    VENDOR_NO   VARCHAR2(7 BYTE) NOT NULL,
    TBL_NAME    VARCHAR2(30) NOT NULL,
    TBL_SIZE    NUMBER(1) NOT NULL,
    TBL_TYPE    NUMBER(1),
    TBL_X       NUMBER(4),
    TBL_Y       NUMBER(4),
    --PK
    CONSTRAINT TABLES_TBL_NO_PK PRIMARY KEY (TBL_NO),
    --FK
    CONSTRAINT TABLES_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
);

CREATE SEQUENCE TABLES_seq INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE;
CREATE UNIQUE INDEX TBLNAME_INX ON TABLES (VENDOR_NO, TBL_NAME);
------------------------------------------------------------------------------------------------------------------------------------------------------
--
--訂單   丞智

CREATE TABLE ORD (
    ORD_NO          VARCHAR2(15),
    MEM_NO          VARCHAR2(7) NOT NULL,
    VENDOR_NO       VARCHAR2(7) NOT NULL,
    TBL_NO          VARCHAR2(7),
    PARTY_SIZE      NUMBER(2) NOT NULL,
    SHARE_MEM_NO1   VARCHAR2(7),
    SHARE_MEM_NO2   VARCHAR2(7),
    SHARE_AMOUNT    NUMBER(7),
    ORD_TIME        TIMESTAMP NOT NULL,
    BOOKING_DATE    DATE NOT NULL,
    BOOKING_TIME    VARCHAR2(5) NOT NULL,
    NOTES           VARCHAR2(150),
    TOTAL           NUMBER(7) NOT NULL,
    ARRIVAL_TIME    VARCHAR2(5),
    FINISH_TIME     VARCHAR2(5),
    VERIF_CODE      VARCHAR2(20),
    STATUS          NUMBER(1) NOT NULL,
--PK    
    CONSTRAINT ORD_ORD_NO_PK PRIMARY KEY ( ORD_NO ),
    CONSTRAINT ORD_MEM_NO_FK FOREIGN KEY ( MEM_NO ) REFERENCES MEMBER ( MEM_NO ),
--FK
--    CONSTRAINT ORD_SHARE_MEM_NO1_FK FOREIGN KEY ( SHARE_MEM_NO1 ) REFERENCES MEMBER ( MEM_NO ),
--    CONSTRAINT ORD_SHARE_MEM_NO2_FK FOREIGN KEY ( SHARE_MEM_NO2 ) REFERENCES MEMBER ( MEM_NO ),
    CONSTRAINT ORD_VENDOR_NO_FK FOREIGN KEY ( VENDOR_NO ) REFERENCES VENDOR ( VENDOR_NO ),
    CONSTRAINT ORD_TBL_NO_FK FOREIGN KEY ( TBL_NO ) REFERENCES TABLES ( TBL_NO ) ON DELETE SET NULL
);
        
CREATE SEQUENCE ORD_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE;

CREATE UNIQUE INDEX TBL_INX 
    ON ORD (TBL_NO,
               CASE WHEN TBL_NO is null THEN null ELSE BOOKING_DATE END,
               CASE WHEN TBL_NO is null THEN null ELSE BOOKING_TIME END);


-----------------------------------------------------------------------------------------------------------------------------------------------------


--餐廳帳戶交易明細  柏熹
CREATE TABLE RES_TRANSACTION_LIST  (                 
  TRST_NO       VARCHAR2(10 BYTE) 
, VENDOR_NO     VARCHAR2(7 BYTE)  NOT NULL
, AMOUNT        NUMBER(7) 
, PAY_DATE      DATE  
, ORD_NO        VARCHAR2(15)
, V_WALLET      NUMBER(20, 0)   NOT NULL

--FK
, CONSTRAINT RTL_ORD_NO_FK FOREIGN KEY (ORD_NO) REFERENCES ORD (ORD_NO)
, CONSTRAINT RTL_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT RTL_TRST_NO_PK PRIMARY KEY (TRST_NO)
); 
--SEQUENCE TRST_NO
CREATE SEQUENCE RES_T_L_SEQ     -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1                  -- 每次增加數量
START WITH 1                    -- 從1開始
NOMAXVALUE                      -- 沒有最大值
NOCYCLE                         -- 不循環
NOCACHE;                        -- 不快取,防止掉號 

-----------------------------------------------------------------------------------------------------------------------------------------------------
--餐廳開放訂位時段   柏熹

CREATE TABLE RESERVATION_TIME  (                
  RT_NO       VARCHAR2(10 BYTE) 
, VENDOR_NO   VARCHAR2(7 BYTE)  NOT NULL--原表格資料格式有誤
, R_TIME      VARCHAR2(10 BYTE)
--FK
, CONSTRAINT RT_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT RT_RT_NO_PK PRIMARY KEY (RT_NO)
); 
--SEQUENCE TRST_NO
CREATE SEQUENCE RESERVATION_T_SEQ -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1           -- 每次增加數量
START WITH 1           -- 從1開始
NOMAXVALUE             -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;             -- 不快取,防止掉號

-----------------------------------------------------------------------------------------------------------------------------------------------------
--餐廳不開放日期    柏熹
CREATE TABLE EXCEPTION_DATE  (                
  EXC_NO      VARCHAR2(10 BYTE) --原資料型態有誤
, VENDOR_NO     VARCHAR2(7 BYTE)  NOT NULL--原表格資料格式有誤
, EXC_DATE      DATE
--FK
, CONSTRAINT EXCEPTION_DATE_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT EXCEPTION_DATE_EXC_NO_PK PRIMARY KEY (EXC_NO)
); 
--SEQUENCE TRST_NO
CREATE SEQUENCE EXCEPTION_DATE_SEQ -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1           -- 每次增加數量
START WITH 1           -- 從1開始
NOMAXVALUE             -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;             -- 不快取,防止掉號

-----------------------------------------------------------------------------------------------------------------------------------------------------

--餐廳已訂桌位數量   柏熹
CREATE TABLE RESERVATION_TABLE_ORDERED  (                               
  RTO_NO            VARCHAR2(10) 
, VENDOR_NO         VARCHAR2(7 BYTE)  NOT NULL--原表格資料格式有誤
, BOOKING_DATE      DATE
, BOOKING_TIME      VARCHAR2(5)
, TBL_O_NUM1       NUMBER(10)
, TBL_O_NUM2       NUMBER(10)
, TBL_O_NUM3       NUMBER(10)
, TBL_O_NUM4       NUMBER(10)
, TBL_O_NUM5       NUMBER(10)
, TBL_ORDERED1     NUMBER(10)
, TBL_ORDERED2     NUMBER(10)
, TBL_ORDERED3     NUMBER(10)
, TBL_ORDERED4     NUMBER(10)
, TBL_ORDERED5     NUMBER(10)

--FK
, CONSTRAINT RTO_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT RTO_RTO_NO_PK PRIMARY KEY (RTO_NO)
); 
--SEQUENCE TRST_NO
CREATE SEQUENCE RESERVATION_TABLE_ORDERED_SEQ -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1                 -- 每次增加數量
START WITH 1                   -- 從1開始
NOMAXVALUE                     -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號


-----------------------------------------------------------------------------------------------------------------------------------------------------
--餐廳開放訂位桌位數量   柏熹
CREATE TABLE RESERVATION_TABLE_NUMBER  (                                
  RTN_NO            VARCHAR2(10) 
, VENDOR_NO         VARCHAR2(7 BYTE)  NOT NULL--原表格資料格式有誤
, RTBL_O_NUM1         NUMBER
, RTBL_O_NUM2         NUMBER
, RTBL_O_NUM3         NUMBER
, RTBL_O_NUM4         NUMBER
, RTBL_O_NUM5         NUMBER

--FK
, CONSTRAINT RTN_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)
--PK
, CONSTRAINT RTN_RTN_NO_PK PRIMARY KEY (RTN_NO)
); 
--SEQUENCE TRST_NO
CREATE SEQUENCE RESERVATION_TABLE_NUMBER_SEQ -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1                 -- 每次增加數量
START WITH 1                   -- 從1開始
NOMAXVALUE                     -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號

-----------------------------------------------------------------------------------------------------------------------------------------------------
--餐廳菜單清單  雋捷

CREATE TABLE RESTAURANT_MENU  (                                 
  MENU_NO           VARCHAR2(10 BYTE) NOT NULL
, VENDOR_NO         VARCHAR2(7 BYTE) 
, MENU_NAME         VARCHAR2(100 BYTE)
, MENU_PRICE        VARCHAR2(5 BYTE) 
, MENU_PIC BLOB     
, MENU_STAT         NUMBER(1)         
, MENU_TEXT         VARCHAR2(500 BYTE) 
--PK
, CONSTRAINT RESTAURANT_MENU_MENU_NO_PK PRIMARY KEY (MENU_NO)
--FK
, CONSTRAINT RESTAURANT_MENU_VENDOR_NO_FK FOREIGN KEY (VENDOR_NO) REFERENCES VENDOR (VENDOR_NO)

);
--SEQUENCE MEM_NO
CREATE SEQUENCE RESTAURANT_MENU_SEQ     -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1                 -- 每次增加數量
START WITH 1                   -- 從1開始
NOMAXVALUE                     -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號

-----------------------------------------------------------------------------------------------------------------------------------------------------
--訂單明細 --丞智

CREATE TABLE ORDER_DETAIL (
   ORD_NO    VARCHAR2(15)
 , MENU_NO   VARCHAR2(10)
 , QTY       NUMBER(2) NOT NULL
 , PRICE     NUMBER(7) NOT NULL
 
 --PK
 , CONSTRAINT ORDER_DETAIL_ORD_MENU_NO_PK PRIMARY KEY ( ORD_NO, MENU_NO )
--FK
 , CONSTRAINT ORDER_DETAIL_ORD_NO_FK FOREIGN KEY ( ORD_NO ) REFERENCES ORD ( ORD_NO )
 , CONSTRAINT ORDER_DETAIL_MENU_NO_FK FOREIGN KEY ( MENU_NO ) REFERENCES RESTAURANT_MENU ( MENU_NO )
);

-----------------------------------------------------------------------------------------------------------------------------------------------------
--評論   --丞智
CREATE TABLE COMMENTS (
    CMNT_NO       VARCHAR2(7),
    ORD_NO        VARCHAR2(15) NOT NULL,
    VENDOR_NO     VARCHAR2(7) NOT NULL,
    SCORE         NUMBER(1) NOT NULL,
    CMNT          VARCHAR2(1200),
    TIME          TIMESTAMP NOT NULL,
    CMNT_STATUS   NUMBER(1) NOT NULL,
--PK
    CONSTRAINT COMMENT_CMNT_NO_PK PRIMARY KEY ( CMNT_NO ),
--FK 
    CONSTRAINT COMMENT_ORD_NO_FK FOREIGN KEY ( ORD_NO ) REFERENCES ORD ( ORD_NO ),
    CONSTRAINT COMMENT_VENDOR_NO_FK FOREIGN KEY ( VENDOR_NO ) REFERENCES VENDOR ( VENDOR_NO )
);

CREATE SEQUENCE COMMENTS_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE;

--------------------------------------------------------------------------------------------------------
--承豊
--後台員工
CREATE TABLE EMPLOYEE (
  EMP_NO VARCHAR2(10) NOT NULL 
, EMP_NAME VARCHAR2(20) NOT NULL 
, EMP_SEX VARCHAR2(1) NOT NULL 
, EMP_ACC VARCHAR2(15) NOT NULL  UNIQUE 
, EMP_PWD VARCHAR2(15) NOT NULL 
, EMP_MAIL VARCHAR2(30) NOT NULL 
, EMP_HIRE DATE NOT NULL 
, EMP_RESIGN DATE 
, EMP_STAT NUMBER(2) NOT NULL 

, CONSTRAINT EMPLOYEE_EMP_NO_PK PRIMARY KEY (EMP_NO )
);

--SEQUENCE EMPLOYEE_SEQ
CREATE SEQUENCE EMPLOYEE_SEQ     
INCREMENT BY 1      
START WITH 1        
NOMAXVALUE      
NOCYCLE                        
NOCACHE;

--------------------------------------------------------------------------------------------------------
--承豊
--後台功能
CREATE TABLE FEATURE (
  FEA_NO VARCHAR2(10) NOT NULL 
, FEA_NAME VARCHAR2(20) NOT NULL 
, FEA_DET VARCHAR2(150)
, CONSTRAINT FEATURE_FEA_NO_PK PRIMARY KEY (FEA_NO)
);

--SEQUENCE FEATURE_SEQ
CREATE SEQUENCE FEATURE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;


--------------------------------------------------------------------------------------------------------
--承豊
--員工功能明細
CREATE TABLE FEATURE_DETAIL (
  FEA_NO VARCHAR2(10) NOT NULL 
, EMP_NO VARCHAR2(10) NOT NULL 
, CONSTRAINT FEATURE_DETAIL_FEA_NO_FK   FOREIGN KEY (FEA_NO) REFERENCES FEATURE (FEA_NO)
, CONSTRAINT FEATURE_DETAIL_EMP_NO_FK   FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE (EMP_NO)
, CONSTRAINT FEATURE_DETAIL_PRIMARY_KEY PRIMARY KEY (EMP_NO , FEA_NO )
);

--------------------------------------------------------------------------------------------------------
--承豊
--最新消息
CREATE TABLE NEWS (
  NEWS_NO VARCHAR2(10) NOT NULL 
, EMP_NO VARCHAR2(10) NOT NULL 
, NEWS_CONT VARCHAR2(150) NOT NULL 
, NEWS_PIC BLOB 
, NEWS_REA DATE NOT NULL 
, NEWS_TEXT VARCHAR2(500) 
, CONSTRAINT NEWS_PRIMARY_KEY PRIMARY KEY (NEWS_NO)
, CONSTRAINT NEWS_EMP_NO_FK FOREIGN KEY (EMP_NO) REFERENCES EMPLOYEE (EMP_NO)
);

CREATE SEQUENCE NEWS_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;


--------------------------------------------------------------------------------------------------------
--  會員錢包收支明細   雋捷

CREATE TABLE MEMBER_WALLET_LIST  (                              
  LIST_NO           VARCHAR2(10 BYTE) NOT NULL
, MEM_NO            VARCHAR2(7 BYTE) 
, LIST_TIME         DATE
, LIST_WIT          VARCHAR2(10 BYTE) 
, LIST_STAT         NUMBER(1) 
, LIST_DEP          VARCHAR2(10 BYTE) 
, PAY_FOR           VARCHAR2(15 BYTE) 
--PK
, CONSTRAINT MEMBER_WALLET_LIST_LIST_NO_PK PRIMARY KEY (LIST_NO)
--FK
, CONSTRAINT MEMBER_WALLET_LIST_MEM_NO_FK FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)

);

CREATE SEQUENCE MEMBER_WALLET_LIST_SEQ     -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1                 -- 每次增加數量
START WITH 1                   -- 從1開始
NOMAXVALUE                     -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號

--------------------------------------------------------------------------------------------------------

-- 13 評論檢舉清單   雋捷
CREATE TABLE COMMENT_REPORTED  (                                
  REP_NO            VARCHAR2(10 BYTE) NOT NULL
, CMNT_NO           VARCHAR2(7 BYTE) 
, MEM_NO            VARCHAR2(7 BYTE) 
, REP_FOR           VARCHAR2(500 BYTE) 
, REP_TIME          DATE 
, REP_STAT          NUMBER(1) NOT NULL

--PK
, CONSTRAINT COMMENT_REPORTED_REP_NO_PK PRIMARY KEY (REP_NO)
--Fk
, CONSTRAINT COMMENT_REPORTED_CMNT_NO_FK FOREIGN KEY (CMNT_NO) REFERENCES COMMENTS (CMNT_NO)
, CONSTRAINT COMMENT_REPORTED_MEM_NO_FK FOREIGN KEY (MEM_NO) REFERENCES MEMBER (MEM_NO)

);
--SEQUENCE 
CREATE SEQUENCE COMMENT_REPORTED_SEQ     -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1                 -- 每次增加數量
START WITH 1                   -- 從1開始
NOMAXVALUE                     -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號


--------------------------------------------------------------------------------------------------------
--文章  聖照

CREATE TABLE ARTICLE_PUBLISHED(
    ART_NO      VARCHAR2(10)    NOT NULL
,   MEM_NO      VARCHAR2(7)     NOT NULL
,   ART_TITLE   VARCHAR2(30)    NOT NULL
,   ART_CONTENT VARCHAR2(1500)  NOT NULL
,   ART_TIME    DATE            NOT NULL
,   ART_PIC1    BLOB
,   ART_PIC2    BLOB
,   ART_PIC3    BLOB
,   ART_PIC4    BLOB
,   ART_PIC5    BLOB
,   ART_CODE    NUMBER(1,0)     NOT NULL
,   CONSTRAINT  ART_PUB_NO_PK   PRIMARY KEY(ART_NO)
,   CONSTRAINT  ART_PUB_MEM_FK  FOREIGN KEY(MEM_NO) REFERENCES MEMBER(MEM_NO)
);
CREATE SEQUENCE ARTPUB_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------------------------------------------------------------------------------
--文章檢舉清單  聖照

CREATE TABLE ARTICLE_REPORTED(
    ARTRE_NO        VARCHAR2(10)    NOT NULL
,   ART_NO          VARCHAR2(10)    NOT NULL
,   MEM_NO          VARCHAR2(7)     NOT NULL
,   ARTRE_CONTENT   VARCHAR2(300)   NOT NULL
,   ARTRE_TIME      DATE            NOT NULL
,   ARTRE_CODE      NUMBER(1)       NOT NULL
--PK
,   CONSTRAINT  ART_RE_ARTRE_NO_PK    PRIMARY KEY(ARTRE_NO)
--FK
,   CONSTRAINT  ART_RE_MEM_NO_FK   FOREIGN KEY(MEM_NO) REFERENCES MEMBER(MEM_NO)
,   CONSTRAINT  ART_RE_ART_NO_FK   FOREIGN KEY(ART_NO) REFERENCES ARTICLE_PUBLISHED(ART_NO)
);

CREATE SEQUENCE ARTRE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------------------------------------------------------------------------------
--聊天紀錄  聖照
CREATE TABLE CHAT_RECORD(
    CHAT_NO     VARCHAR2(10)    NOT NULL
,   MEM_NO      VARCHAR2(7)     NOT NULL
,   FRIE_NO     VARCHAR2(7)     NOT NULL
,   WORDS       VARCHAR2(500)
,   CHAT_TIME   TIMESTAMP       NOT NULL
,   CONSTRAINT  CH_RE_NO_PK PRIMARY KEY(CHAT_NO)
,   CONSTRAINT  CH_RE_MEMNO_FK  FOREIGN KEY(MEM_NO) REFERENCES MEMBER(MEM_NO)
,   CONSTRAINT  CH_RE_FRIENO_FK FOREIGN KEY(FRIE_NO) REFERENCES MEMBER(MEM_NO)
);

CREATE SEQUENCE CH_RE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------------------------------------------------------------------------------
--客服記錄   聖照
--客服記錄   聖照
CREATE TABLE CUSTOMER_SERVICE_RECORD(
    CUST_SER_NO     VARCHAR2(10)    NOT NULL
,   MEM_NO          VARCHAR2(7)     NOT NULL
,   EMP_NO          VARCHAR2(10)    NOT NULL 
,   QUESTION        VARCHAR2(500)
,   ANSWER          VARCHAR2(500)
,   CUST_SER_TIME   TIMESTAMP   NOT NULL
,   CONSTRAINT  CU_RE_NO_PK PRIMARY KEY(CUST_SER_NO)
,   CONSTRAINT  CU_RE_MEMNO_FK  FOREIGN KEY(MEM_NO) REFERENCES MEMBER(MEM_NO)
,   CONSTRAINT  CU_RE_EMPNO_FK  FOREIGN KEY(EMP_NO) REFERENCES EMPLOYEE(EMP_NO)
);

CREATE SEQUENCE CU_SE_RE_SEQ
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--好友清單 聖照
CREATE TABLE FRIEND_LIST(
    MEM_NO      VARCHAR2(7) NOT NULL
,   FRIE_NO     VARCHAR2(7) NOT NULL
,   FRIE_CODE   NUMBER(1,0) NOT NULL
,   CONSTRAINT  FRLI_MEMFR_PK   PRIMARY KEY(MEM_NO,FRIE_NO)
,   CONSTRAINT  FRLI_MEMNO_FK   FOREIGN KEY(MEM_NO) REFERENCES MEMBER(MEM_NO)
,   CONSTRAINT  FRLI_FRIENO_FK  FOREIGN KEY(FRIE_NO) REFERENCES MEMBER(MEM_NO)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--餐廳回應清單  --雋捷
CREATE TABLE RESTAURANT_RESPONSES  (                
  RES_NO      VARCHAR2(10 BYTE) NOT NULL
, CMNT_NO     VARCHAR2(7 BYTE) NOT NULL 
, RES_TEXT      VARCHAR2(500 BYTE) NOT NULL 
, RES_TIME      DATE 

, CONSTRAINT RESTAURANT_RESPONSES_RES_NO PRIMARY KEY (RES_NO)
, CONSTRAINT RESTAURANT_RESPONSES_CMNT_NO FOREIGN KEY (CMNT_NO) REFERENCES COMMENTS (CMNT_NO)

);
--SEQUENCE 
CREATE SEQUENCE RESTAURANT_RESPONSES_SEQ     -- 一個表格只會有一個流水號,所以命名規格table_SEQ
INCREMENT BY 1           -- 每次增加數量
START WITH 1           -- 從1開始
NOMAXVALUE             -- 沒有最大值
NOCYCLE                        -- 不循環
NOCACHE;                       -- 不快取,防止掉號


--假資料開始

--Member 會員
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'聖甲蟲','qq1234','aa1234','M','qq123@gmail.com','A123456789','0975954468','2',NULL,51561,'聖甲甲');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'張正浩','yen1888152','yen1888152','M','qaz123@gmail.com','H107242497','0970268373','1',NULL,499,'黑狗');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'張天志','nbx2973446','nbx2973446','M','sapien@metuean.com','A132729384','0988647356','3',NULL,599,'白狗');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'張峰','utx7773166','utx7773166','F','Proin@dolorDgla.com','A116709980','0953147021','3',NULL,699,'峰子');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'葉大雄','wzq0833787','pvq0699636','F','at.velit.Cras@orci.edu','A162110259','0963418454','1',NULL,799,'瞌睡王');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'林俊傑','f1234561','val5080809','F','f1@faucibusleoin.org','F172002313','0930779472','2',NULL,899,'JJ');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'郭董','f1234562','val5080809','F','f2@faucibusleoin.org','F172002314','0930779472','2',NULL,899,'紅頂商人');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'習大大','f1234563','val5080809','F','f3@faucibusleoin.org','F172002315','0930779472','2',NULL,899,'維尼');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'賴清德','f1234564','val5080809','F','f4@faucibusleoin.org','F172002316','0930779472','2',NULL,899,'做功德');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'陳菊','f1234565','val5080809','F','f5@faucibusleoin.org','F172002317','0930779472','2',NULL,899,'花媽');
INSERT INTO MEMBER VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 6, '0'),'蔡英文','f1234566','val5080809','F','f6@faucibusleoin.org','F172002318','0930779472','2',NULL,899,'小英');

--EMPLOYEE 後台員工
INSERT INTO EMPLOYEE VALUES ('E'||LPAD(to_char(EMPLOYEE_SEQ.nextval), 9, '0'),'林俊傑','M','Jimmy123','c123456','duckk@gmail.com',TO_DATE('2019-03-28','YYYY-MM-DD'),TO_DATE('2019-03-30','YYYY-MM-DD'),2);
INSERT INTO EMPLOYEE VALUES ('E'||LPAD(to_char(EMPLOYEE_SEQ.nextval), 9, '0'),'游宗叡','M','Bob123','c123456','dook@gmail.com',TO_DATE('2019-03-20','YYYY-MM-DD'),TO_DATE('2019-03-30','YYYY-MM-DD'),2);
INSERT INTO EMPLOYEE VALUES ('E'||LPAD(to_char(EMPLOYEE_SEQ.nextval), 9, '0'),'林承豊','M','Chris123','c123456','loo@gmail.com',TO_DATE('2016-03-15','YYYY-MM-DD'),TO_DATE('2019-01-30','YYYY-MM-DD'),2);
INSERT INTO EMPLOYEE VALUES ('E'||LPAD(to_char(EMPLOYEE_SEQ.nextval), 9, '0'),'吳永志','M','Peter123','c123456','hkkk@gmail.com',TO_DATE('2000-03-20','YYYY-MM-DD'),NULL,1);
INSERT INTO EMPLOYEE VALUES ('E'||LPAD(to_char(EMPLOYEE_SEQ.nextval), 9, '0'),'吳冠宏','M','David123','c123456','assdkk@gmail.com',TO_DATE('2008-03-20','YYYY-MM-DD'),NULL,1);

--VENDOR 廠商
  INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'aaaaaa','111111','jkl8519653@gmail.com','81017799','02','244',
 '台北市','信義區','市府路45號台北101購物中心','248677','鼎泰豐',1,1,1,'0900','2000','1111100','68',NULL,NULL,'1','0','中式餐廳','經典台式小吃餐廳，排隊排到崩潰哦！');
  INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'bbbbbb','222222','rmv6574499@gmail.com','27239987','02','110',
'台北市','信義區','松壽路9號','2545','瓦城泰國料理 - 台北三越信義店',1,1,1,'0900','2000','1111100','20',NULL,NULL,'1','0','泰國餐廳','我們瓦城，白飯一碗45元，東西都辣的');
  INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'cccccc','333333','cth9614531@gmail.com','24652222','04','407',
 '台中市','西屯區','國安一路168號','9422','屋馬燒肉國安店',1,1,1,'1600','2300','1111111','40',NULL,NULL,'2','0','燒烤餐廳','全台最強燒烤就在我們家');
  INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'dfh3689153','dfh3689153','dfh3689153@gmail.com','22271927','04','400',
 '台中市','中區','中山路20號','188372','宮原眼科',20,18,3,'1300','1700','1111111','60',NULL,NULL,'1','0','甜點店','不是眼科的眼科，觀光客的最愛');
  INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'leg0543027','le123456','leg05430271@gmail.com','2165711','07','801',
 '高雄市','前金區','新田路207號','5231','辣癮食尚麻辣火鍋',10,7,1,'1300','1700','0101010','57',NULL,NULL,'1','0','火鍋店','本店保證您吃完辣三天，不辣免費');
  INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'leg0543021','le123456','leg05430272@gmail.com','2165711','07','801',
 '高雄市','鹽埕區','光明里大仁路6號','44231','辣菊花食尚麻辣火鍋',50,45,0,'1300','1700','0101010','44',NULL,NULL,'1','0','火鍋店','本店保證您吃完辣三天，辣到烙賽');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'leg0543022','le123456','leg05430273@gmail.com','2165711','07','801',
 '高雄市','小港區','港南里小港路158號','416531','榕樹下臭豆腐',27,26,0,'1300','1700','0101010','44',NULL,NULL,'2','0','中式料理','好吃的臭豆腐,臭到要你命');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'leg0543023','le123456','leg05430274@gmail.com','2165711','07','801',
 '台中市','西區','精誠29街18號','225231','老媽媽芋園',25,25,1,'1300','1700','0101010','26',NULL,NULL,'1','0','中式料理','老媽媽芋園,樸實古早味,夏天一碗透心涼');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'leg0543024','le123456','leg05430275@gmail.com','2165711','07','801',
 '桃園市','中壢區','中央路27號','315231','聖甲蟲500吃到飽',40,38,2,'1300','1700','0101010','14',NULL,NULL,'1','0','吃到飽','聖甲蟲吃到飽,保證讓你500吃好吃滿');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'leg0543025','le123456','leg05430276@gmail.com','2165711','07','801',
 '桃園市','八德區','中華路116號','884231','鶴麟綠咖哩',60,55,3,'1300','1700','0101010','86',NULL,NULL,'1','0','東南亞風味','以老闆本人經驗製作,保證你吃完綠光罩頂');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1231','le123456','fake1@gmail.com','2165711','07','801',
 '花蓮市','瑞穗區','瑞穗村成功南路19號','45231','小吳汁男湯',40,38,1,'1300','1700','0101010','37',NULL,NULL,'1','0','日式料理','神級老師的醍醐味');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1232','le123456','fake2@gmail.com','2165711','07','801',
 '屏東縣','屏東市','台糖街61號','30231','騰政肉圓',60,58,3,'1300','1700','0101010','87',NULL,NULL,'1','0','中式料理','以老闆多年賽車經驗,精心製作每顆肉圓');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1233','le123456','fake3@gmail.com','2165711','07','801',
 '台北市','信義區','信義路五段7號','955231','泰時尚泰式料理',21,10,1,'1300','1700','0101010','44',NULL,NULL,'1','0','東南亞風味','道地泰式料理配合精緻時尚內裝讓你一來再來');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1234','le123456','fake4@gmail.com','2165711','07','801',
 '台南市','東區','大學路1號','645231','仲儀肥腸湯',5,2,0,'1300','1700','0101010','30',NULL,NULL,'1','0','中式料理','神級老闆的醍醐味');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1235','le123456','fake5@gmail.com','2165711','07','801',
 '新竹市','東區','光復路二段101號','4875231','彥智炸雞',7,6,1,'1300','1700','0101010','44',NULL,NULL,'1','0','美式餐廳','新鮮雞肉粿粉酥炸保證美味');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1236','le123456','fake6@gmail.com','2165711','07','801',
 '彰化縣','大村鄉','學府路168號','556231','美式早餐屋',8,8,0,'1300','1700','0101010','125',NULL,NULL,'1','0','美式餐廳','經典美式早餐補充你一天的活力');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1237','le123456','fake7@gmail.com','2165711','07','801',
 '台南市','東區','大學路1號','69231','白鬍子牛排',20,15,1,'1300','1700','0101010','212',NULL,NULL,'1','0','美式餐廳','學區的平價牛排卻不失美味');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1238','le123456','fake8@gmail.com','2165711','07','801',
 '屏東縣','恆春鎮','天文路1號','955231','歐姆萊斯',55,66,77,'1300','1700','0101010','41',NULL,NULL,'1','0','日式料理','滑嫩蛋皮配上濃厚咖哩醬的絕妙滋味');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake1239','le123456','fake9@gmail.com','2165711','07','801',
 '嘉義縣','番路鄉','觸口村車埕51號','4431','大中央牛排館',55,66,77,'1300','1700','0101010','55',NULL,NULL,'1','0','東南亞風味','便宜平價超大份量不怕你吃不飽');
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake124','le123456','fake10@gmail.com','2165711','07','801',
 '高雄市','鳳山區','光復路二段132號','62231','彥傑義大利麵',40,35,1,'1300','1700','0101010','91',NULL,NULL,'1','0','義式料理','美味義大利麵讓你欲罷不能');  
    INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'fake125','le123456','fake110@gmail.com','2165771','03','337',
 '桃園市','大園區','沙崙里漁港路451巷25號','50005','鼎鈞香香煙',80,75,0,'1000','2100','0101010','91',NULL,NULL,'1','0','東南亞風味','老闆吃什麼，你就吃什麼，老闆通常只需呼吸就會飽');
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'6QIy81NK','fake123456','6QIy81NK@gmail.com','0987987987','07','801','桃園市','桃園區','中正路1117號','100','TGI FRIDAYS 星期五美式餐廳 桃園餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'trz816kc','fake123456','trz816kc@gmail.com','0987987987','07','801','桃園市','桃園區','莊敬路一段101號','100','打鹿岸原住民人文主題餐廳《桃園店》','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'lqT74QSB','fake123456','lqT74QSB@gmail.com','0987987987','07','801','桃園市','龜山區','興邦路35號','100','點水樓桃園店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'OSlBy5NW','fake123456','OSlBy5NW@gmail.com','0987987987','07','801','桃園市','桃園區','宏昌三街28巷1號','100','十里香私房料理餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'QtY7UYBW','fake123456','QtY7UYBW@gmail.com','0987987987','07','801','蘆竹區','南崁路一段','1126樓號','100','漢來海港 台茂店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'UDP5Z1es','fake123456','UDP5Z1es@gmail.com','0987987987','07','801','桃園區','中正路','473F號','100','VASA 瓦薩美式餐廳 - ATT門市','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'4yXFv8Ks','fake123456','4yXFv8Ks@gmail.com','0987987987','07','801','桃園區','中正路','61號6','100','饗泰多泰式風格餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'cs1fT61F','fake123456','cs1fT61F@gmail.com','0987987987','07','801','桃園市','桃園區','中埔二街36號','100','廣德海鮮餐廳（桃園大興店）','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'IVj8nbO9','fake123456','IVj8nbO9@gmail.com','0987987987','07','801','桃園市','桃園區','國際路二段27號','100','洋朵庭園餐廳-國際店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'KM0S5qoF','fake123456','KM0S5qoF@gmail.com','0987987987','07','801','台灣','桃園市','龜山區山鶯路號','100','Bistro181法國餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'kCMaX6kD','fake123456','kCMaX6kD@gmail.com','0987987987','07','801','桃園市','桃園區','南華街60號','100','藝奇新日本料理桃園南華店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'RmZq52ip','fake123456','RmZq52ip@gmail.com','0987987987','07','801','桃園區','中山東路','512F號','100','夏慕尼新香榭鐵板燒 桃園中山東店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'0I0sFcCQ','fake123456','0I0sFcCQ@gmail.com','0987987987','07','801','桃園區','中正路','1910樓號','100','瓦城泰國料理 - 桃園三越站前店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'L62wDnH1','fake123456','L62wDnH1@gmail.com','0987987987','07','801','桃園市','桃園區','莊敬路一段313號','100','覓燒肉','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'8Efpk05D','fake123456','8Efpk05D@gmail.com','0987987987','07','801','台灣','桃園市','桃園區同德五街號','100','欣葉日本料理中茂店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'0a95hOwd','fake123456','0a95hOwd@gmail.com','0987987987','07','801','蘆竹區','南崁路一段','112號6樓','100','原燒桃園台茂店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'s4QK70Gr','fake123456','s4QK70Gr@gmail.com','0987987987','07','801','桃園市','桃園區','中正路1650號','100','易鼎活蝦（桃園店）','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'811o8xA4','fake123456','811o8xA4@gmail.com','0987987987','07','801','桃園市','桃園區','經國路336巷86號','100','森日式料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'26VlEUcp','fake123456','26VlEUcp@gmail.com','0987987987','07','801','桃園市','蘆竹區','南崁路192號','100','Cafe' de M&L李．西餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'SPJKBjf7','fake123456','SPJKBjf7@gmail.com','0987987987','07','801','桃園市','桃園區','民生路129號','100','端陽邀月','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'maHLRlUd','fake123456','maHLRlUd@gmail.com','0987987987','07','801','桃園市','大園區','航站南路1之1號','100','The Square 品坊西餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'70L7MWyx','fake123456','70L7MWyx@gmail.com','0987987987','07','801','桃園市','桃園區','三民路二段63號','100','新梅龍鎮復古餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'qj7p81G7','fake123456','qj7p81G7@gmail.com','0987987987','07','801','平鎮區','延平路一段','22F號','100','夏慕尼新香榭鐵板燒中壢延平店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'hPv10xHZ','fake123456','hPv10xHZ@gmail.com','0987987987','07','801','桃園市','桃園區','大興西路一段333號','100','桐花客家創意料理-桃園店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'L30wMZk4','fake123456','L30wMZk4@gmail.com','0987987987','07','801','桃園市','桃園區','大興西路一段225號','100','紅拱門泰式複合式餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'n7K9HU71','fake123456','n7K9HU71@gmail.com','0987987987','07','801','桃園市','蘆竹區','南崁路一段112號','100','添好運 桃園台茂店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'lc86600J','fake123456','lc86600J@gmail.com','0987987987','07','801','桃園區','中正路','20號9樓','100','大戶屋桃園遠百店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'5H5le5KV','fake123456','5H5le5KV@gmail.com','0987987987','07','801','桃園區','同德五街','77號4樓','100','夢工場親子主題餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'6a159o47','fake123456','6a159o47@gmail.com','0987987987','07','801','桃園市','桃園區','中正路953號','100','T2 Kitchen & Bar 美式餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'NLn5tqhJ','fake123456','NLn5tqhJ@gmail.com','0987987987','07','801','桃園市','桃園區','中正路1078號','100','村民食堂-廚窗港點&海月鍋物','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'3T3jLCID','fake123456','3T3jLCID@gmail.com','0987987987','07','801','桃園區','成功路一段','29號2F','100','檸檬草美食茶房 桃園店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'2sY0G5X5','fake123456','2sY0G5X5@gmail.com','0987987987','07','801','桃園市','桃園區','大興西路一段325號','100','圓味涮涮鍋-桃園大興店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'5MEMK59K','fake123456','5MEMK59K@gmail.com','0987987987','07','801','桃園市','中壢區','民權路398號','100','明皇樓中餐廳 Tang's Chinese Restaurant','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'c3o14dG0','fake123456','c3o14dG0@gmail.com','0987987987','07','801','中壢區','元化路','3578樓號','100','瓦城泰國料理 - 中壢SOGO店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'9oM4c20W','fake123456','9oM4c20W@gmail.com','0987987987','07','801','桃園市','桃園區','同德六街158巷21號','100','桃園美食.海鮮.無菜單.消夜嘎嘎～嚴選手作','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'8DLzf1X2','fake123456','8DLzf1X2@gmail.com','0987987987','07','801','桃園市','龍潭區','十一份路196號','100','林可可家的牧場 - 親子寵物友善餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'C1oYAfbV','fake123456','C1oYAfbV@gmail.com','0987987987','07','801','桃園市','桃園區','新埔六街89號','100','梳子餐廳 Salud Tapas Restaurant','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'82c75Hg8','fake123456','82c75Hg8@gmail.com','0987987987','07','801','中壢區','中園路二段','501號4樓','100','TGI FRIDAYS 星期五美式餐廳 中壢餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'73jL5vP8','fake123456','73jL5vP8@gmail.com','0987987987','07','801','中壢區','中山路','1182樓號','100','藝奇新日本料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'0429huG8','fake123456','0429huG8@gmail.com','0987987987','07','801','中壢區','中山路','1112樓號','100','陶板屋','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'k6kzFved','fake123456','k6kzFved@gmail.com','0987987987','07','801','桃園區','大興西路一段','200號3樓','100','(福容大飯店)福園中餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'bf33X423','fake123456','bf33X423@gmail.com','0987987987','07','801','桃園市','桃園區','三民路三段98號','100','嚇嚇跳活蝦料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'pdqmj9fC','fake123456','pdqmj9fC@gmail.com','0987987987','07','801','桃園市','桃園區','中正路313號','100','銅鑼灣港式美食','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'9aC3RM17','fake123456','9aC3RM17@gmail.com','0987987987','07','801','台灣','桃園市','中壢區民權路398號','100','古華薈泰式料理暨酒吧 Great Kuva Thai Food & Lounge','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'M4n5PbkH','fake123456','M4n5PbkH@gmail.com','0987987987','07','801','桃園市','桃園區','永順街57號','100','叔悟小餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'u6DoUPsr','fake123456','u6DoUPsr@gmail.com','0987987987','07','801','桃園市','蘆竹區','南竹路二段313之1號','100','NINI 尼尼義大利餐廳 南崁店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'uYM887YO','fake123456','uYM887YO@gmail.com','0987987987','07','801','大園區','中正東路','No. 972號8','100','大園101景觀餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'spDz22dY','fake123456','spDz22dY@gmail.com','0987987987','07','801','桃園市','桃園區','經國路281號','100','活跳跳活蝦餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'Z67ZrgOk','fake123456','Z67ZrgOk@gmail.com','0987987987','07','801','桃園市','大園區','航站南路1-1號','100','諾富特華航桃園機場飯店 (味坊中餐廳)','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'IPi5470O','fake123456','IPi5470O@gmail.com','0987987987','07','801','桃園市','蘆竹區','南竹路二段156-2號','100','川門子時尚美食會館','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'6I13ppIn','fake123456','6I13ppIn@gmail.com','0987987987','07','801','台灣','桃園市','蘆竹區南華一街號','100','PRIMO SOLE 陽果西餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'EcpXn7m1','fake123456','EcpXn7m1@gmail.com','0987987987','07','801','台灣','桃園市','桃園市楊銅路二段號','100','觀天下咖啡庭園景觀餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'2QHvts99','fake123456','2QHvts99@gmail.com','0987987987','07','801','蘆竹區','中正路','323號1、2樓','100','Pizza Rock Nankan 南崁店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'JF9cFIM8','fake123456','JF9cFIM8@gmail.com','0987987987','07','801','台灣','桃園市','桃園區中正路號','100','開飯川食堂 桃園店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'O79DeLGW','fake123456','O79DeLGW@gmail.com','0987987987','07','801','330','台灣','桃園市桃園區號','100','IKEA宜家家居餐廳 桃園店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'806zduk1','fake123456','806zduk1@gmail.com','0987987987','07','801','桃園市','桃園區','南華街66號','100','TASTY西堤牛排桃園南華店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'5EZs59ZF','fake123456','5EZs59ZF@gmail.com','0987987987','07','801','桃園市','桃園區','南平路254巷11號','100','木頭人','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'k7r699br','fake123456','k7r699br@gmail.com','0987987987','07','801','桃園市','桃園區','中正路429號','100','庄仔內燒烤快炒美食','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'3QXp1E6f','fake123456','3QXp1E6f@gmail.com','0987987987','07','801','桃園市','桃園區','大同路24號','100','すき家Sukiya 桃園站前店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'NVeDAbQk','fake123456','NVeDAbQk@gmail.com','0987987987','07','801','桃園市','大溪區','員林路三段202號','100','二畝園麵館','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'x50DuZB3','fake123456','x50DuZB3@gmail.com','0987987987','07','801','花蓮市','明心街','1之23號1F','100','【花蓮美食】查理食藝-平價餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'4mBWNwHU','fake123456','4mBWNwHU@gmail.com','0987987987','07','801','花蓮縣','新城鄉','明潭街10巷23號','100','慕名私房料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'TJfiGvhr','fake123456','TJfiGvhr@gmail.com','0987987987','07','801','花蓮縣','花蓮市','民國路88-1號','100','老時光燒肉酒肴','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'8AF8k3Z2','fake123456','8AF8k3Z2@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中和街228號','100','闔家歡餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'S9Zu21ca','fake123456','S9Zu21ca@gmail.com','0987987987','07','801','976','台灣','花蓮縣光復鄉號','100','芬功合作 & 嘎拉富的店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'PtB7PE9n','fake123456','PtB7PE9n@gmail.com','0987987987','07','801','花蓮縣','花蓮市','博愛街150號','100','極焰精緻燒肉','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'m3n1Y26w','fake123456','m3n1Y26w@gmail.com','0987987987','07','801','花蓮縣','花蓮市','民權路11-1號','100','伊江滇緬料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'HaBiXJ1l','fake123456','HaBiXJ1l@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中美路106號','100','家咖哩總店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'r46v09ny','fake123456','r46v09ny@gmail.com','0987987987','07','801','972','台灣','花蓮縣秀林鄉號','100','洄瀾灣景觀餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'J1dlVJIo','fake123456','J1dlVJIo@gmail.com','0987987987','07','801','花蓮縣','花蓮市','大同街87號','100','花蓮·邊城滇味','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'s1739TD1','fake123456','s1739TD1@gmail.com','0987987987','07','801','花蓮縣','花蓮市','博愛街144號','100','炭火燒肉工房','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'5sQ8Emv6','fake123456','5sQ8Emv6@gmail.com','0987987987','07','801','花蓮縣','花蓮市','復興街92號','100','Dos Tacos','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'8y44bZr8','fake123456','8y44bZr8@gmail.com','0987987987','07','801','花蓮縣','豐濱鄉','新社42號','100','噶瑪蘭海產店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'iEX1M5NB','fake123456','iEX1M5NB@gmail.com','0987987987','07','801','花蓮縣','光復鄉','大全街62巷16號','100','紅瓦屋老地方文化美食餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'irKucvex','fake123456','irKucvex@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中山路611號','100','OH LA LA 法式薄餅 · 家常菜','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'08X81AZQ','fake123456','08X81AZQ@gmail.com','0987987987','07','801','花蓮縣','花蓮市','富安路22號','100','常春藤素食(Buffet)吃到飽餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'86Br8HzD','fake123456','86Br8HzD@gmail.com','0987987987','07','801','花蓮縣','花蓮市','府前路95-5號','100','流流社風味餐','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'V2EaVBb4','fake123456','V2EaVBb4@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中美路263-2號','100','美崙海鮮','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'o7yFro2o','fake123456','o7yFro2o@gmail.com','0987987987','07','801','花蓮縣','吉安鄉','中山路三段226號','100','阿姑的店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'2yy6j175','fake123456','2yy6j175@gmail.com','0987987987','07','801','974','台灣','花蓮縣壽豐鄉號','100','055龍蝦海鮮','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'Yg2MUtTy','fake123456','Yg2MUtTy@gmail.com','0987987987','07','801','花蓮縣','花蓮市','仁愛街81號','100','食驛','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'t9PZ9O7q','fake123456','t9PZ9O7q@gmail.com','0987987987','07','801','花蓮市','永興路','2號1F','100','翰品酒店花蓮- 翔雲廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'9B53n5ED','fake123456','9B53n5ED@gmail.com','0987987987','07','801','花蓮縣','花蓮市','東興一街124號','100','荷蘭雅妮鬆餅屋','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'Q8IlZSEt','fake123456','Q8IlZSEt@gmail.com','0987987987','07','801','花蓮縣','花蓮市','博愛街122號','100','Three Koalas 無尾熊','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'8ndu1jJg','fake123456','8ndu1jJg@gmail.com','0987987987','07','801','花蓮縣','光復鄉','明德路36號','100','大和擂茶舖','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'aX1CDCU5','fake123456','aX1CDCU5@gmail.com','0987987987','07','801','花蓮縣','花蓮市','大同街54號','100','Africa 非洲象牙海岸小廚房','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'q9ps0x9o','fake123456','q9ps0x9o@gmail.com','0987987987','07','801','花蓮縣','花蓮市','民國路80巷16號','100','時光1939','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'6Hw4wSvb','fake123456','6Hw4wSvb@gmail.com','0987987987','07','801','花蓮縣','花蓮市','博愛街138號','100','芝麻開門定食屋','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'FU747JEz','fake123456','FU747JEz@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中山路407號','100','Farmers' Kitchen 蔬食早午餐','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'C8rFGBv7','fake123456','C8rFGBv7@gmail.com','0987987987','07','801','花蓮縣','花蓮市','仁和街16號','100','苗家美食','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'uu3BjOCq','fake123456','uu3BjOCq@gmail.com','0987987987','07','801','花蓮縣','壽豐鄉','福德街39號','100','泰瘋隨意料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'8Ju7TV1o','fake123456','8Ju7TV1o@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中山路一段386之6號','100','3番2次原住民風味餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'d77KUaUU','fake123456','d77KUaUU@gmail.com','0987987987','07','801','花蓮縣','壽豐鄉','福德46號','100','屋銤海鮮','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'m8jIOibx','fake123456','m8jIOibx@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中美路34號','100','洋基牧場','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'m8FZb0dz','fake123456','m8FZb0dz@gmail.com','0987987987','07','801','花蓮縣','花蓮市','林政街10號','100','森山舎 morning mountain（森山舍）','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'Y0Q7z7zU','fake123456','Y0Q7z7zU@gmail.com','0987987987','07','801','花蓮縣','花蓮市','府前路94號','100','Old Germany 德國餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'qlu598q3','fake123456','qlu598q3@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中山路549-1號','100','九号餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'2z3LE1zK','fake123456','2z3LE1zK@gmail.com','0987987987','07','801','花蓮縣','花蓮市','公正街6號','100','《花蓮在地小吃》～餓勢力精緻麵食','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'9l3eQ7jh','fake123456','9l3eQ7jh@gmail.com','0987987987','07','801','花蓮縣','花蓮市','國興五街210號','100','花蓮美食-31酒夯BAR燒烤店','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'o8OP9c3T','fake123456','o8OP9c3T@gmail.com','0987987987','07','801','花蓮縣','吉安鄉','南海六街7號','100','牛巴達全牛料理','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'g507c6o2','fake123456','g507c6o2@gmail.com','0987987987','07','801','花蓮縣','秀林鄉','7鄰96號','100','達基力餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'t52OjHVW','fake123456','t52OjHVW@gmail.com','0987987987','07','801','花蓮縣','花蓮市','建國路6巷2號','100','花蓮•深夜食堂','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'26l41J0B','fake123456','26l41J0B@gmail.com','0987987987','07','801','花蓮縣','花蓮市','和平路362-1號','100','龍私廚義法餐廳Aaron kitchen','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'RJZQ6OP8','fake123456','RJZQ6OP8@gmail.com','0987987987','07','801','花蓮縣','花蓮市','信義街53號','100','福畊食館','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'6d8g9hi0','fake123456','6d8g9hi0@gmail.com','0987987987','07','801','花蓮縣','花蓮市','和平路482號','100','瑪丁娜印度小館','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'XH7X4Ad5','fake123456','XH7X4Ad5@gmail.com','0987987987','07','801','花蓮市','林森路','280號1樓','100','愛上這味懷舊餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'PUWoKWiv','fake123456','PUWoKWiv@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中山路565號','100','王記茶舖','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'iOAlFujb','fake123456','iOAlFujb@gmail.com','0987987987','07','801','花蓮縣','花蓮市','富吉路54號','100','Eating House','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'yuDD41e2','fake123456','yuDD41e2@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中正路590號','100','藍天麗池飯店 綠波廊西餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'Vb77zfha','fake123456','Vb77zfha@gmail.com','0987987987','07','801','花蓮縣','花蓮市','東興二街13巷3號','100','獵人廚房Hunter's kitchen','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'eCL7b7LG','fake123456','eCL7b7LG@gmail.com','0987987987','07','801','花蓮縣','花蓮市','自由街130號','100','美兆廚房','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'ZKeOJMrt','fake123456','ZKeOJMrt@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中美路2號','100','多桑餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'3SavHT25','fake123456','3SavHT25@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中正路644之2號','100','石屋燒肉火鍋','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','日式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'JbNoN1aq','fake123456','JbNoN1aq@gmail.com','0987987987','07','801','花蓮縣','花蓮市','海岸路4號','100','海霸天花蓮港音樂餐廳','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'59Az5jjX','fake123456','59Az5jjX@gmail.com','0987987987','07','801','花蓮縣','花蓮市','府前路34號','100','COUNTRY MOTHER'S','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','美式餐廳',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'Zs5VbL8A','fake123456','Zs5VbL8A@gmail.com','0987987987','07','801','花蓮縣','花蓮市','中華路489號','100','庸的廚房 | 花蓮美食','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'xs3VlBj4','fake123456','xs3VlBj4@gmail.com','0987987987','07','801','花蓮縣','花蓮市','莊敬路170號','100','大米廚房','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','東南亞風味',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'TyTa1zAE','fake123456','TyTa1zAE@gmail.com','0987987987','07','801','花蓮縣','壽豐鄉','中華路一段36號','100','月之廬食堂','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'06t80z45','fake123456','06t80z45@gmail.com','0987987987','07','801','花蓮縣','花蓮市','博愛街238號','100','木子食堂','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);
INSERT INTO VENDOR VALUES ('V'||LPAD(to_char(VENDOR_SEQ.NEXTVAL), 6, '0'),'kDYg0r7M','fake123456','kDYg0r7M@gmail.com','0987987987','07','801','花蓮縣','花蓮市','南京街185號','100','黎明紅茶','55','66','77','0900','2000','1111111','202',Null,Null,'1','0','義式料理',Null);


 --WAIT_POS 候位明細
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000001','V000001',10,7,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000002','V000001',15,6,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000003','V000003',16,1,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000004','V000004',13,3,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000005','V000005',60,4,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000006','V000006',60,4,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000007','V000007',60,4,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000008','V000008',60,4,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000009','V000009',60,4,sysdate,3,2);
INSERT INTO WAIT_POS VALUES ('WP'||LPAD(to_char(WAIT_POS_SEQ.NEXTVAL), 8, '0'),'M000010','V000010',60,4,sysdate,3,2);

--REP_RES 餐廳檢舉清單
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000001','V000001','東西太難吃',sysdate,'2');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000002','V000002','服務態度不好',sysdate,'1');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000003','V000003','店員長太醜',sysdate,'3');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000004','V000004','要不到LINE',sysdate,'1');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000005','V000005','我是來亂的',sysdate,'3');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000006','V000006','我是含粉',sysdate,'3');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000007','V000007','桌子太硬',sysdate,'1');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000008','V000008','椅子太軟',sysdate,'3');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000009','V000009','店長太軟',sysdate,'1');
INSERT INTO REP_RES VALUES ('RR'||LPAD(to_char(REP_RES_SEQ.NEXTVAL), 8, '0'),'M000010','V000010','魚太新鮮',sysdate,'3');


--FAV_RES 收藏店家清單
INSERT INTO FAV_RES VALUES ('M000001','V000001');
INSERT INTO FAV_RES VALUES ('M000002','V000002');
INSERT INTO FAV_RES VALUES ('M000003','V000003');
INSERT INTO FAV_RES VALUES ('M000004','V000004');
INSERT INTO FAV_RES VALUES ('M000005','V000005');
INSERT INTO FAV_RES VALUES ('M000006','V000006');
INSERT INTO FAV_RES VALUES ('M000007','V000007');
INSERT INTO FAV_RES VALUES ('M000008','V000008');
INSERT INTO FAV_RES VALUES ('M000009','V000009');
INSERT INTO FAV_RES VALUES ('M000010','V000010');

--TABLES 桌位
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','A1', 1,1,200,200);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','A2', 1,1,NULL,NULL);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','A3', 1,1,NULL,NULL);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','B1', 2,2,300,400);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','B2', 2,1,500,250);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','B3', 2,1,20,30);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','C1', 3,1,150,200);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','C2', 3,2,200,200);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','D1', 4,1,400,230);
INSERT INTO TABLES VALUES ('T'||LPAD(to_char(tables_seq.NEXTVAL), 6, '0'),'V000001','E1', 5,1,300,120);



--RESTAURANT_MENU 餐廳菜單清單
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000001','炸鳳尾蝦','777',null,1,'所以我說那個醬汁呢？');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000002','豆腐三重奏','9000',null,1,'那真是太諷刺了紹安，你離開你師傅繞了一大圈，最後到達的境界，竟然是你不想學的，你師傅的料理，所以說呢，人心最終還是要回到故鄉來的');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000003','法式烘蛋','10',null,1,'雞蛋家常菜，佛心便宜賣');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000004','雖敗遊龍鍋貼','300',null,1,'這位先生叫武雄吧，你有沒有想過品嚐美食的人，到底真正在追求什麼呢,那時候我對你們說要再來一盤，並不是因為肚子餓才說的。');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000005','特級廚師小當家豪華餐','9481',null,1,'平淡的創意卻企圖以華麗表演來掩飾，你應該感到慚愧。貧乏的想像力和技巧的沉迷，都是廚師的致命傷。你還是回去磨練21小時再來吧');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000005','鶴麟綠咖哩戴綠帽套餐','9482',null,1,'平淡的咖哩料理卻隱藏著綠光,淡淡的哀傷讓我越吃越哀傷');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000005','聖甲蟲500吃到飽','943',null,1,'500吃到飽500吃到好,想要我變好,等到你變老');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000005','含粉特級冷凍包子','944',null,1,'包子還是冷凍的好吃,高雄發大財');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000005','老媽媽芋園','945',null,1,'老媽媽芋園有老媽媽的味道,雖然店員比芋園好吃就是了');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000001','小紅牛腿排','9486',null,1,'牛排雖好吃,腿排位更佳,媽媽很不錯,女兒才是棒');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000001','排骨炒飯','768',null,1,'不就排骨，不就炒飯，加在一起，當你盤子');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000001','鮮蝦蒸餃','4000',null,1,'本店唯一正常的東西，正常的蝦子，正常的餃子，唯一不正常的是價格');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000001','宇宙大燒賣','1200',null,1,'居然包了一整頭豬在裡面啊！');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000002','可口可樂','50',null,1,'就是要喝');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000003','水晶肉圓','200',null,1,'摔打揉捏經由七七四十九道工序製作而成，香Q有彈性，聽說有客人吃到牙都給彈出來了');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000002','蔬菜漢堡','100',null,1,'用蔬菜葉子包著地瓜片，套餐還附蘆筍，非常健康');

INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000011','卑南豬哥湯','100',null,1,'用地方豬血熬製，套餐還附小吳簽名照，養眼又保平安');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000011','卑南豬腿飯','100',null,1,'用地方豬頭熬製，升級套餐還附JAVA心法，吃得開心,學的easy');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000011','瑞穗大奶雞','500',null,1,'用大陸雞搭配瑞穗鮮乳，醃製七七四十九天,有病治病,沒病強身');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000011','殺小碗糕','500',null,1,'在資策會教書的日子，學生常常聊到殺小的話題,讓老闆從中得到靈感,這道美食就此誕生');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000011','吳家臭豆腐','780',null,1,'談到臭豆腐,我們吳家使用獨家酵母，使用甲蟲,地瓜,還有光合作用的深層發酵,吃完絕對變成臭嘴哥');
INSERT INTO RESTAURANT_MENU VALUES ('RM'||LPAD(to_char(RESTAURANT_MENU_SEQ.NEXTVAL), 8, '0')
    ,'V000011','吳哥戀戀不捨','500',null,1,'在夏天的午後,來一碗綿綿冰,周圍淋上滿滿的戀奶,讓你依依不捨,戀上一個人');

---------以下處理currval問題-------------------------------

------------ORD 訂單-------------
INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000001','V000001','T000001',5,NULL,NULL,NULL,sysdate,TO_DATE('2019-03-31', 'YYYY-MM-DD'),'1030',NULL,1600,NULL,NULL,'qL62THYwvZuVkka2aDTt',1);
--COMMENTS 評論
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000001',4,'地點很方便，鄰近捷運站，店裡環境優美氣氛很好，適合親朋好友、情侶聚餐、聊心事，外加上食物美味，服務員和善，推薦給大家這個優質餐廳。',CURRENT_TIMESTAMP ,1);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000002',4,'用餐環境很好，店員服務親切，推薦來用餐！餐點價格合理，地點也在市中心，十分方便！非常適合朋友、情侶聚餐！',CURRENT_TIMESTAMP ,1);
--RES_TRANSACTION_LIST 餐廳帳戶交易明細
INSERT INTO RES_TRANSACTION_LIST VALUES ('RTL'||LPAD(to_char(RES_T_L_SEQ.NEXTVAL), 7, '0'),'V000001','1000',sysdate,to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'01');
--ORDER_DETAIL 訂單明細
INSERT INTO ORDER_DETAIL VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'RM00000001',2,400);

------------ORD 訂單-------------
INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000002','V000002','T000001',2,'M000002',NULL,400,sysdate,TO_DATE('2019-03-31', 'YYYY-MM-DD'),'1100','請給我靠窗的位置',1000,'1110','1205','Q3DbGZ4tHLYHa7NdHwSx',1);
--COMMENTS 評論
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000003',4,'東西選擇很多，環境舒適，人員服務也親切? 不管家庭聚會，朋友小酌，情侶用餐皆宜 在東區你的其中一個選擇',CURRENT_TIMESTAMP ,1);
--RES_TRANSACTION_LIST 餐廳帳戶交易明細
INSERT INTO RES_TRANSACTION_LIST VALUES ('RTL'||LPAD(to_char(RES_T_L_SEQ.NEXTVAL), 7, '0'),'V000002','2000',sysdate,to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'02');
--ORDER_DETAIL 訂單明細
INSERT INTO ORDER_DETAIL VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'RM00000002',2,300);

------------ORD 訂單-------------
INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000003','V000003','T000001',1,NULL,NULL,NULL,sysdate,TO_DATE('2019-04-01', 'YYYY-MM-DD'),'1430',NULL,500,NULL,NULL,'nFaa5DJu7SqvZqXNmjSz',2);
--COMMENTS 評論
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000004',5,'個人非常愛義式料理，尤其是披薩，這間的披薩是薄皮的，一份大概就是一人份，可以點好幾種口味一起分享，好吃。',CURRENT_TIMESTAMP ,1);
--ORDER_DETAIL 訂單明細
INSERT INTO ORDER_DETAIL VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'RM00000003',1,200);

------------ORD 訂單-------------
INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000004','V000004','T000001',6,'M000003','M000004',2000,sysdate,TO_DATE('2019-04-01', 'YYYY-MM-DD'),'1700',NULL,3000,NULL,NULL,'H6xLzWZykL3ArVV9xFJp',3);
--COMMENTS 評論
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000005',3,'如果以義式餐廳來說，我認為這個價位有更好的選擇，不過在五星飯店裡面，還是有一定的水準，不定時還有life band，商業午餐okay',CURRENT_TIMESTAMP ,1);
--RES_TRANSACTION_LIST 餐廳帳戶交易明細
INSERT INTO RES_TRANSACTION_LIST VALUES ('RTL'||LPAD(to_char(RES_T_L_SEQ.NEXTVAL), 7, '0'),'V000003','3000',sysdate,to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'03');
INSERT INTO RES_TRANSACTION_LIST VALUES ('RTL'||LPAD(to_char(RES_T_L_SEQ.NEXTVAL), 7, '0'),'V000004','4000',sysdate,to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'04');
--ORDER_DETAIL 訂單明細
INSERT INTO ORDER_DETAIL VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'RM00000004',1,400);

------------ORD 訂單-------------
--COMMENTS 評論
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000006',3,'整體來說不錯，不過鍋物的辣度有待加強，愛吃辣的朋友可能會覺得不夠辣',CURRENT_TIMESTAMP ,1);
INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000005','V000005','T000001',4,'M000003',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5bvrN2y6h4h',3);
--RES_TRANSACTION_LIST 餐廳帳戶交易明細
INSERT INTO RES_TRANSACTION_LIST VALUES ('RTL'||LPAD(to_char(RES_T_L_SEQ.NEXTVAL), 7, '0'),'V000005','5000',sysdate,to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'05');
--ORDER_DETAIL 訂單明細
INSERT INTO ORDER_DETAIL VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'RM00000005',1,600);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000006','V000008',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000008',5,'甜湯非常好吃，尤其是主打的芋園，跟九份芋圓有得比，非常值得來品嚐',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000007','V000009',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000009',1,'奇怪的店名,奇怪的老闆,點了一份套餐老闆卻打開筆電跟我秀它寫出來的500,相當不推',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000008','V000010',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000010',4,'老闆感覺是一個有故事的人,一進店門看到他就覺得有一股綠色的氣息,臉是綠的,頭頂也是綠的',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000009','V000011',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000011',5,'汁男湯果然不負盛名,鮮美濃厚,喝完感覺變成程式高手了',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000010','V000012',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000012',4,'聽說老闆是傳奇賽車手,邊吃肉圓還可以看到他拿著手機賽車',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000008','V000013',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000013',4,'道地的泰式料理,再加上時尚的內部裝潢,非常推薦喜歡泰式料理的朋友可以來品嘗',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000006','V000014',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000014',1,'老闆怪怪的,吃完東西要付錢的時候他叫我把錢丟進香油錢箱就好了',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000008','V000015',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000015',3,'炸雞味道還不錯,聽說帶著她心愛的櫃台美眉來找他還就可以免費榨雞吃到飽喔',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000007','V000016',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000016',4,'大份量的早餐,適合晚起的人當作早午餐吃,cp值滿高的',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000003','V000017',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000017',3,'平價的牛排館,肉質尚可,但其他部分有待加強,不必特地來吃',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000001','V000018',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000018',5,'好吃的蛋包飯,尤其是淋上那個特製的咖哩醬,吃過一次就很難忘啊',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000005','V000019',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000019',2,'牛排普普通通唯一優點是麵包可以吃到飽,如果沒有特別餓,不建議來吃',CURRENT_TIMESTAMP ,1);

INSERT INTO ORD VALUES (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000008','V000020',NULL,4,'M000006',NULL,2000,sysdate,TO_DATE('2019-04-10', 'YYYY-MM-DD'),'1930',NULL,5000,NULL,NULL,'8JPXY6wQc5gggN2y6h4h',3);
INSERT INTO COMMENTS VALUES ('C'||LPAD(to_char(comments_seq.NEXTVAL), 6, '0'),to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.CURRVAL), 6, '0'),'V000020',4,'台式義大利麵,大推奶油培根口味,份量也很夠,值得一來',CURRENT_TIMESTAMP ,1);


--RESERVATION_TIME 餐廳開放訂位時段
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1000,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1100,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1200,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1700,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1800,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(1900,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(2000,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1000,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1100,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1200,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1700,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1800,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000002',TO_CHAR(1900,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000001',TO_CHAR(2000,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(1700,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(1800,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(1900,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(2000,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(2100,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000003',TO_CHAR(2200,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000004',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000004',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000004',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000004',TO_CHAR(1600,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000005',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000005',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000005',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000005',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000005',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000006',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000006',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000006',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000006',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000006',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000007',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000007',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000007',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000007',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000007',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000008',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000008',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000008',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000008',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000008',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000009',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000009',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000009',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000009',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000009',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000010',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000010',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000010',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000010',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000010',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000011',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000011',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000011',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000011',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000011',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000012',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000012',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000012',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000012',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000012',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000013',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000013',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000013',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000013',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000013',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000014',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000014',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000014',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000014',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000014',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000015',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000015',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000015',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000015',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000015',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000016',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000016',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000016',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000016',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000016',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000017',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000017',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000017',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000017',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000017',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000018',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000018',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000018',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000018',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000018',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000019',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000019',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000019',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000019',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000019',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000020',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000020',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000020',TO_CHAR(1500,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000020',TO_CHAR(1600,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000020',TO_CHAR(1700,'0000'));

INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1000,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1100,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1200,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1300,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1400,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1700,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1800,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(1900,'0000'));
INSERT INTO RESERVATION_TIME VALUES ('RT'||LPAD(to_char(RESERVATION_T_SEQ.NEXTVAL), 8, '0'),'V000021',TO_CHAR(2000,'0000'));

--EXCEPTION_DATE 餐廳不開放日期
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000001',to_date('25-6月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000004',to_date('22-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000004',to_date('29-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000005',to_date('23-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000005',to_date('30-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000006',to_date('24-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000006',to_date('31-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000007',to_date('20-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000007',to_date('27-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000008',to_date('21-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000008',to_date('28-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000009',to_date('22-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000009',to_date('29-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000010',to_date('23-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000010',to_date('30-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000011',to_date('20-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000011',to_date('27-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000012',to_date('21-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000012',to_date('28-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000013',to_date('22-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000013',to_date('29-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000014',to_date('23-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000014',to_date('30-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000015',to_date('24-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000015',to_date('31-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000016',to_date('20-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000016',to_date('27-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000017',to_date('21-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000017',to_date('28-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000018',to_date('22-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000018',to_date('29-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000019',to_date('23-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000019',to_date('30-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000020',to_date('24-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000020',to_date('31-5月-19','DD-MON-RR'));

INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000021',to_date('17-5月-19','DD-MON-RR'));
INSERT INTO EXCEPTION_DATE VALUES ('ED'||LPAD(to_char(EXCEPTION_DATE_SEQ.NEXTVAL), 8, '0'),'V000021',to_date('31-5月-19','DD-MON-RR'));


--RESERVATION_TABLE_ORDERED 餐廳已訂桌位數量

--V000001
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('25-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('26-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('27-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('28-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('29-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('30-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1310',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('31-5月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('01-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('02-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('03-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('04-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('05-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('06-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('07-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('08-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('09-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('10-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('11-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('12-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('13-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('14-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('15-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('16-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('17-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('18-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('19-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('20-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('21-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('22-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('23-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1000',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1100',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1200',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1300',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1700',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1800',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'1900',8,8,7,2,2,7,7,6,1,1);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000001',to_date('24-6月-19','DD-MON-RR'),'2000',8,8,7,2,2,7,7,6,1,1);

------------------------------------------V000002-------------------------------

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('25-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('26-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('27-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('28-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('29-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('30-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1310',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('31-5月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('01-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('02-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('03-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('04-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('05-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('06-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('07-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('08-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('09-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('10-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('11-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('12-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('13-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('14-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('15-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('16-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('17-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('18-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('19-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('21-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('22-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('23-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1000',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1100',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1200',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1300',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1700',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1800',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'1900',7,7,6,3,3,6,6,5,2,2);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('24-6月-19','DD-MON-RR'),'2000',7,7,6,3,3,6,6,5,2,2);

-----------------------------------V000003-----------------------

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);


-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('25-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('26-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('27-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('28-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('29-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('30-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'1510',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('31-5月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('01-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('02-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('03-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('04-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('05-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('06-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('07-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('08-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('09-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('10-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('11-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('12-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('13-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('14-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('15-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('16-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('17-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('18-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('19-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('21-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('22-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('23-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'1300',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'1400',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'1500',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'1600',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'2000',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'2100',6,6,5,4,4,5,5,4,3,3);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('24-6月-19','DD-MON-RR'),'2200',6,6,5,4,4,5,5,4,3,3);

-----------------------------------------------V000004----------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);


-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);

---------------------------------V000005-------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

---------------------------------------V000006----------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000006',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

----------------------------------V000007-----------------------------------------




-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000007',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

---------------------------------V000008----------------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000008',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-------------------------------V000009-------------------------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000009',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

----------------------------------V000010-----------------------------------------




INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000010',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

---------------------------V000011-----------------------------------------



-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000011',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-------------------------V000012---------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000012',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


------------------------V000013----------------------------------------



INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);


-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('25-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('25-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('25-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('25-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('25-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('26-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('26-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('26-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('26-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('26-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('27-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('27-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('27-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('27-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('27-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('28-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('28-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('28-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('28-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('28-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('29-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('29-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('29-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('29-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('29-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('30-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('30-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('30-5月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('30-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('30-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('31-5月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('31-5月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('31-5月-19','DD-MON-RR'),'1510',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('31-5月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('31-5月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('01-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('01-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('01-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('01-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('01-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('02-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('02-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('02-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('02-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('02-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('03-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('03-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('03-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('03-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('03-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('04-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('04-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('04-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('04-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('04-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('05-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('05-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('05-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('05-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('05-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('06-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('06-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('06-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('06-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('06-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('07-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('07-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('07-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('07-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('07-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('08-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('08-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('08-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('08-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('08-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('09-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('09-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('09-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('09-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('09-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('10-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('10-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('10-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('10-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('10-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('11-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('11-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('11-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('11-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('11-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('12-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('12-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('12-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('12-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('12-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('13-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('13-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('13-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('13-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('13-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('14-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('14-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('14-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('14-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('14-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('15-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('15-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('15-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('15-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('15-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('16-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('16-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('16-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('16-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('16-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('17-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('17-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('17-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('17-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('17-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('18-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('18-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('18-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('18-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('18-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('19-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('19-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('19-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('19-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('19-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('20-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('21-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('22-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('23-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);

INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-6月-19','DD-MON-RR'),'1300',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-6月-19','DD-MON-RR'),'1400',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-6月-19','DD-MON-RR'),'1500',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-6月-19','DD-MON-RR'),'1600',5,5,5,5,5,4,4,4,4,4);
INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000013',to_date('24-6月-19','DD-MON-RR'),'1700',5,5,5,5,5,4,4,4,4,4);




-----------------------------------------------------------

-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000002',to_date('20-8月-18','DD-MON-RR'),'1700',3,2,2,2,0,1,2,1,1,0);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000003',to_date('20-9月-18','DD-MON-RR'),'2000',4,2,2,2,0,1,1,1,1,0);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000004',to_date('20-10月-18','DD-MON-RR'),'1300',2,3,2,2,0,1,1,2,1,0);
-- INSERT INTO RESERVATION_TABLE_ORDERED VALUES ('RTO'||LPAD(to_char(RESERVATION_TABLE_ORDERED_SEQ.NEXTVAL), 7, '0'),'V000005',to_date('20-11月-18','DD-MON-RR'),'1100',3,2,3,2,0,2,1,2,1,0);

--RESERVATION_TABLE_NUMBER 餐廳開放訂位桌位數量
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000001',8,8,7,2,2);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000002',7,7,6,3,3);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000003',6,6,5,4,4);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000004',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000005',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000006',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000007',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000008',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000009',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000010',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000011',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000012',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000013',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000014',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000015',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000016',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000017',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000018',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000019',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000020',5,5,5,5,5);
INSERT INTO RESERVATION_TABLE_NUMBER VALUES ('ETN'||LPAD(to_char(RESERVATION_TABLE_NUMBER_SEQ.NEXTVAL), 7, '0'),'V000021',5,5,5,5,5);

--FEATURE 後台功能
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'用戶管理',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'員工管理',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'店家檢舉審核',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'文章檢舉審核',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'評論檢舉審核',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'撥款作業',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'退訂作業',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'最新消息管理',NULL);
INSERT INTO FEATURE VALUES ('F'||LPAD(to_char(FEATURE_SEQ.nextval), 3, '0'),'店家申請作業',NULL);

--FEATURE_DETAIL 員工功能明細
INSERT INTO FEATURE_DETAIL VALUES ('F003','E000000005');
INSERT INTO FEATURE_DETAIL VALUES ('F004','E000000005');
INSERT INTO FEATURE_DETAIL VALUES ('F005','E000000005');
INSERT INTO FEATURE_DETAIL VALUES ('F003','E000000004');
INSERT INTO FEATURE_DETAIL VALUES ('F004','E000000004');
INSERT INTO FEATURE_DETAIL VALUES ('F005','E000000004');
INSERT INTO FEATURE_DETAIL VALUES ('F001','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F003','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F004','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F005','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F006','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F007','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F008','E000000003');
INSERT INTO FEATURE_DETAIL VALUES ('F001','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F003','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F004','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F005','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F006','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F007','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F008','E000000002');
INSERT INTO FEATURE_DETAIL VALUES ('F001','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F002','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F003','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F004','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F005','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F006','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F007','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F008','E000000001');
INSERT INTO FEATURE_DETAIL VALUES ('F009','E000000001');

--NEWS 最新消息
INSERT INTO NEWS VALUES ('N'||LPAD(to_char(NEWS_SEQ.nextval), 3, '0'),'E000000001','101跳樓大拍賣',NULL,TO_DATE('2019-03-28','YYYY-MM-DD'),'101跳樓大拍賣不買太可惜,門票100塊獲得一次投胎機會,外贈一本名為《第一次投胎就上手》的行前說明書,保證你下輩子變成三歲自耕農住帝寶,修滿八堂財金課還可以變成理財專家喔~');
INSERT INTO NEWS VALUES ('N'||LPAD(to_char(NEWS_SEQ.nextval), 3, '0'),'E000000001','蜂蜜不甜砍頭',NULL,TO_DATE('2018-03-28','YYYY-MM-DD'),'蜂蜜不甜保證砍頭,只是砍的不是老闆,砍蜜蜂的頭啊,嚴選知名添加物外加特級化學香料,保證跟天然蜂蜜風味相同,天天喝我們的蜂蜜,就可以讓你的身體負擔加重,面臨洗腎的危險絕對不唬爛優');
INSERT INTO NEWS VALUES ('N'||LPAD(to_char(NEWS_SEQ.nextval), 3, '0'),'E000000003','帝王蟹季',NULL,TO_DATE('2019-02-28','YYYY-MM-DD'),'你知道北極現在面臨帝王蟹浩劫嗎?當季新鮮的帝王蟹空運來台,我們的地球需要我們拯救,只要張開嘴巴吃掉他,就可以避免地球的生態浩劫阿,拯救地球人人有責,出錢出力救地球');
INSERT INTO NEWS VALUES ('N'||LPAD(to_char(NEWS_SEQ.nextval), 3, '0'),'E000000003','下麵給你吃',NULL,TO_DATE('2017-10-28','YYYY-MM-DD'),'肚子餓了嗎?下麵給你吃,只要儲值五萬塊,附贈兩粒......貢丸,寶贈一定可以填飽你那飢餓的肚子,以及....飢渴的靈魂,無論在寂寞難耐的晚上,還是委靡不振的中午,來一碗保證您精神百倍');
INSERT INTO NEWS VALUES ('N'||LPAD(to_char(NEWS_SEQ.nextval), 3, '0'),'E000000005','過年大特價',NULL,TO_DATE('2019-03-08','YYYY-MM-DD'),'過年大特價,天天都過年天天都特價,這價格保證只有過年才有,要是非過年期間買到的絕對比現在便宜,要買要快錯過會後悔喔,覺得錢包太厚存款帶多的,趕快來這邊讓您的錢包瘦身喔');

--MEMBER_WALLET_LIST 會員錢包收支明細
INSERT INTO MEMBER_WALLET_LIST VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0')
    ,'M000001',sysdate,'5566',1,null,'20190330-000001');
INSERT INTO MEMBER_WALLET_LIST VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0')
    ,'M000001',sysdate,'3000',2,null,'20190330-000002');
INSERT INTO MEMBER_WALLET_LIST VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0')
    ,'M000001',sysdate,null,3,'600',null);
INSERT INTO MEMBER_WALLET_LIST VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0')
    ,'M000001',sysdate,null,1,'50000','20190330-000004');
INSERT INTO MEMBER_WALLET_LIST VALUES ('MWL'||LPAD(to_char(MEMBER_WALLET_LIST_SEQ.NEXTVAL), 7, '0')
    ,'M000001',sysdate,null,3,'9527',null);

--COMMENT_REPORTED 評論檢舉清單
INSERT INTO COMMENT_REPORTED VALUES ('CR'||LPAD(to_char(COMMENT_REPORTED_SEQ.NEXTVAL), 8, '0')
    ,'C000001','M000001','挖靠？垃圾廣告欸？這不用管一下嗎',CURRENT_TIMESTAMP,1);
INSERT INTO COMMENT_REPORTED VALUES ('CR'||LPAD(to_char(COMMENT_REPORTED_SEQ.NEXTVAL), 8, '0')
    ,'C000002','M000002','這根本是其他店惡意來鬧的吧？最好我們的牛肉麵沒有牛肉喔！而且還唬爛說吃到蟑螂咧，我明明有撈掉啊？管理員出來面對',CURRENT_TIMESTAMP,3);
INSERT INTO COMMENT_REPORTED VALUES ('CR'||LPAD(to_char(COMMENT_REPORTED_SEQ.NEXTVAL), 8, '0')
    ,'C000003','M000002','消費10元也算一篇？這店家派來的工讀生吧，啊我去吃怎麼沒有送龍蝦、送鮑魚，超唬爛',CURRENT_TIMESTAMP,1);
INSERT INTO COMMENT_REPORTED VALUES ('CR'||LPAD(to_char(COMMENT_REPORTED_SEQ.NEXTVAL), 8, '0')
    ,'C000004','M000002','這篇是來亂的吧?為什麼會貼別家店的東西？美式餐廳有賣小籠包喔?',CURRENT_TIMESTAMP,2);
INSERT INTO COMMENT_REPORTED VALUES ('CR'||LPAD(to_char(COMMENT_REPORTED_SEQ.NEXTVAL), 8, '0')
    ,'C000005','M000003','寫這篇的妹子都不加我好友，怒檢舉一波',CURRENT_TIMESTAMP,1);

--ARTICLE_PUBLISHED 文章
INSERT INTO ARTICLE_PUBLISHED VALUES('AP'||LPAD(to_char(ARTPUB_SEQ.NEXTVAL),8,'0'),'M000001','甜滋滋的炸鳳尾蝦','   來生猛海鮮吃炸蝦啦!這家炸海鮮專賣店,使用新鮮海味,去腸泥、去殼的炸鳳尾蝦,炸的外皮酥脆,灑了很像鹹酥雞的香料超美味阿!!!
        融入了新鮮大干貝和神秘香料釀製的漿汁,難怪炸完還這麼飽滿大顆!而且咬一口裡面水分飽飽!!!',TO_DATE('2016-10-28','YYYY-MM-DD'),null,null,null,null,null,1);
INSERT INTO ARTICLE_PUBLISHED VALUES('AP'||LPAD(to_char(ARTPUB_SEQ.NEXTVAL),8,'0'),'M000003','神奇撒尿牛丸',' 今天來到星爺開的傳說中的小吃店特別來一嚐傳說中的撒尿牛丸,美顆牛丸都經過晶姐每分鐘九百下的敲打,裡面充滿撒尿蝦的風味,咬下去噴出了難以忘懷的湯汁。
        每吃過一次,我就更有動力寫CODE，以後吃不道該怎麼辦啊!!!!',TO_DATE('2018-10-28','YYYY-MM-DD'),null,null,null,null,null,1);
INSERT INTO ARTICLE_PUBLISHED VALUES('AP'||LPAD(to_char(ARTPUB_SEQ.NEXTVAL),8,'0'),'M000005','特製的銀河面',' 聽說小當家當上特級廚師以後,我就特地跟公司一嘗傳說中的銀河面,麵條融入無賊的墨汁,充滿了海洋的味道。
        上面灑滿了珍貴的珍珠滿,晚上來吃真的可以看到充滿星星的星河',TO_DATE('2017-01-11','YYYY-MM-DD'),null,null,null,null,null,1);
INSERT INTO ARTICLE_PUBLISHED VALUES('AP'||LPAD(to_char(ARTPUB_SEQ.NEXTVAL),8,'0'),'M000002','香噴噴的咖哩飯','    桃園中央大學學區房,共120坪,總價500萬,要買要錯,錯過可惜喔!!!',TO_DATE('2018-03-15','YYYY-MM-DD'),null,null,null,null,null,1);
INSERT INTO ARTICLE_PUBLISHED VALUES('AP'||LPAD(to_char(ARTPUB_SEQ.NEXTVAL),8,'0'),'M000004','繽紛鬆餅盛宴','     每個人都愛吃甜,來這裡一嚐美味鬆餅套餐,開胃菜是一杯特調微醺的雞尾酒,接著各種口味的鬆餅,有卡士達花生、草莓冰淇淋和綜合水果酒釀,最後還有手工愛玉冰,今天吃得好幸福',TO_DATE('2019-02-17','YYYY-MM-DD'),null,null,null,null,null,1);

--ARTICLE_REPORTED 文章檢舉清單
INSERT INTO ARTICLE_REPORTED VALUES('AR'||LPAD(to_char(ARTRE_SEQ.NEXTVAL),8,'0'),'AP00000001','M000006','裡面竟然含有賣房廣告',TO_DATE('2017-01-11','YYYY-MM-DD'),1);
INSERT INTO ARTICLE_REPORTED VALUES('AR'||LPAD(to_char(ARTRE_SEQ.NEXTVAL),8,'0'),'AP00000002','M000002','說得誇張了,裡面哪有珍珠粉,明明只是普通的糖粉',TO_DATE('2017-02-15','YYYY-MM-DD'),2);
INSERT INTO ARTICLE_REPORTED VALUES('AR'||LPAD(to_char(ARTRE_SEQ.NEXTVAL),8,'0'),'AP00000003','M000005','我是個孤單的人,想找我吃飯隨時歡迎',TO_DATE('2017-01-11','YYYY-MM-DD'),3);
INSERT INTO ARTICLE_REPORTED VALUES('AR'||LPAD(to_char(ARTRE_SEQ.NEXTVAL),8,'0'),'AP00000004','M000001','線上抽獎百分百,快來參加,頭獎一千萬等著你喔!!!',TO_DATE('2017-02-15','YYYY-MM-DD'),3);
INSERT INTO ARTICLE_REPORTED VALUES('AR'||LPAD(to_char(ARTRE_SEQ.NEXTVAL),8,'0'),'AP00000005','M000002','說得誇張了,裡面哪有珍珠粉,明明只是普通的糖粉',TO_DATE('2017-02-15','YYYY-MM-DD'),2);

--CHAT_RECORD 聊天紀錄
INSERT INTO CHAT_RECORD VALUES('CH'||LPAD(to_char(CH_RE_SEQ.NEXTVAL),8,'0'),'M000001','M000002','安安',CURRENT_TIMESTAMP);
INSERT INTO CHAT_RECORD VALUES('CH'||LPAD(to_char(CH_RE_SEQ.NEXTVAL),8,'0'),'M000002','M000001','哈囉',CURRENT_TIMESTAMP);
INSERT INTO CHAT_RECORD VALUES('CH'||LPAD(to_char(CH_RE_SEQ.NEXTVAL),8,'0'),'M000001','M000002','周日放假想找人吃飯,妳要來嗎?',CURRENT_TIMESTAMP);
INSERT INTO CHAT_RECORD VALUES('CH'||LPAD(to_char(CH_RE_SEQ.NEXTVAL),8,'0'),'M000002','M000001','好啊要去哪裡',CURRENT_TIMESTAMP);
INSERT INTO CHAT_RECORD VALUES('CH'||LPAD(to_char(CH_RE_SEQ.NEXTVAL),8,'0'),'M000001','M000002','你覺得桃園小蒙牛如何?',CURRENT_TIMESTAMP);
INSERT INTO CHAT_RECORD VALUES('CH'||LPAD(to_char(CH_RE_SEQ.NEXTVAL),8,'0'),'M000002','M000001','恩恩，不錯我考慮看看',CURRENT_TIMESTAMP);

--CUSTOMER_SERVICE_RECORD 客服記錄
INSERT INTO CUSTOMER_SERVICE_RECORD VALUES('CU'||LPAD(to_char(CU_SE_RE_SEQ.NEXTVAL),8,'0'),'M000001','E000000001','您好',NULL,CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER_SERVICE_RECORD VALUES('CU'||LPAD(to_char(CU_SE_RE_SEQ.NEXTVAL),8,'0'),'M000002','E000000002',NULL,'您好,很榮幸為您服務',CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER_SERVICE_RECORD VALUES('CU'||LPAD(to_char(CU_SE_RE_SEQ.NEXTVAL),8,'0'),'M000003','E000000003','我有退訂的問題要請教您',NULL,CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER_SERVICE_RECORD VALUES('CU'||LPAD(to_char(CU_SE_RE_SEQ.NEXTVAL),8,'0'),'M000004','E000000004',NULL,'恩恩，麻煩您敘述您的問題?',CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER_SERVICE_RECORD VALUES('CU'||LPAD(to_char(CU_SE_RE_SEQ.NEXTVAL),8,'0'),'M000005','E000000005','我可以退訂上周一的一份訂單嗎?',NULL,CURRENT_TIMESTAMP);
INSERT INTO CUSTOMER_SERVICE_RECORD VALUES('CU'||LPAD(to_char(CU_SE_RE_SEQ.NEXTVAL),8,'0'),'M000001','E000000001',NULL,'根據平臺規定幾天內都可以進行退定訂單',CURRENT_TIMESTAMP);

--FRIEND_LIST 好友清單 
--FRIEND_LIST 好友清單 
INSERT INTO FRIEND_LIST VALUES('M000001','M000002',1);
INSERT INTO FRIEND_LIST VALUES('M000002','M000001',2);
INSERT INTO FRIEND_LIST VALUES('M000001','M000009',7);
INSERT INTO FRIEND_LIST VALUES('M000009','M000001',7);
INSERT INTO FRIEND_LIST VALUES('M000001','M000010',7);
INSERT INTO FRIEND_LIST VALUES('M000010','M000001',7);
INSERT INTO FRIEND_LIST VALUES('M000001','M000011',7);
INSERT INTO FRIEND_LIST VALUES('M000011','M000001',7);
INSERT INTO FRIEND_LIST VALUES('M000001','M000005',6);
INSERT INTO FRIEND_LIST VALUES('M000005','M000001',5);
INSERT INTO FRIEND_LIST VALUES('M000004','M000006',7);
INSERT INTO FRIEND_LIST VALUES('M000006','M000004',7);
--RESTAURANT_RESPONSES 餐廳回應清單
INSERT INTO RESTAURANT_RESPONSES VALUES ('RR'||LPAD(to_char(RESTAURANT_RESPONSES_SEQ.NEXTVAL), 8, '0'),'C000001','感謝光臨，希望您再度蒞臨本店用餐！',CURRENT_TIMESTAMP);
INSERT INTO RESTAURANT_RESPONSES VALUES ('RR'||LPAD(to_char(RESTAURANT_RESPONSES_SEQ.NEXTVAL), 8, '0'),'C000002','謝謝您的好評，很高興您能喜歡我們的服務與餐點哦! 祝順心~~',CURRENT_TIMESTAMP);
INSERT INTO RESTAURANT_RESPONSES VALUES ('RR'||LPAD(to_char(RESTAURANT_RESPONSES_SEQ.NEXTVAL), 8, '0'),'C000003','感謝您的介紹與支持，本店一路走來就是秉持著給客人最好也最安心的餐點，並給各位賓至如歸又溫暖的服務',    CURRENT_TIMESTAMP);
INSERT INTO RESTAURANT_RESPONSES VALUES ('RR'||LPAD(to_char(RESTAURANT_RESPONSES_SEQ.NEXTVAL), 8, '0'),'C000004','今年主廚準備眾多新菜及頂級食材，就是為了給您難忘的夜晚，品嚐美食並搭配杯美酒，快來與我們共度西洋情人節吧',    CURRENT_TIMESTAMP);
INSERT INTO RESTAURANT_RESPONSES VALUES ('RR'||LPAD(to_char(RESTAURANT_RESPONSES_SEQ.NEXTVAL), 8, '0'),'C000005','所有海鮮中，味道最鮮美的就是貝類了，而在日本赤貝則是被大量使用的食材之一，其中又以宮城縣?上赤貝最為肥美清脆，是老饕都非常喜愛的食材',  CURRENT_TIMESTAMP);



 

COMMIT;
