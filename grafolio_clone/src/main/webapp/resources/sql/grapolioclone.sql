/************************* 시퀀스 *************************/
DROP SEQUENCE USER_SEQ;
DROP SEQUENCE ACCESS_HISTORY_SEQ;
DROP SEQUENCE LEAVE_USER_SEQ;
DROP SEQUENCE POST_SEQ;
DROP SEQUENCE COMMENT_SEQ;
DROP SEQUENCE LIKE_SEQ;
DROP SEQUENCE FOLLOW_SEQ;

CREATE SEQUENCE USER_SEQ NOCACHE;
CREATE SEQUENCE ACCESS_HISTORY_SEQ NOCACHE;
CREATE SEQUENCE LEAVE_USER_SEQ NOCACHE;
CREATE SEQUENCE POST_SEQ START WITH 1001 NOCACHE;
CREATE SEQUENCE COMMENT_SEQ NOCACHE;
CREATE SEQUENCE LIKE_SEQ NOCACHE;
CREATE SEQUENCE FOLLOW_SEQ NOCACHE;

/************************* 테이블 *************************/
DROP TABLE FOLLOW_T;
DROP TABLE LIKE_T;
DROP TABLE COMMENT_T;
DROP TABLE POST_T;
DROP TABLE LEAVE_USER_T;
DROP TABLE ACCESS_HISTORY_T;
DROP TABLE USER_T;

CREATE TABLE USER_T (
  /* 회원번호(PK) */               USER_NO     NUMBER             NOT NULL,
  /* 이메일(인증수단) */           EMAIL       VARCHAR2(100 BYTE) NOT NULL UNIQUE,
  /* 암호화(SHA-256) */            PW          VARCHAR2(64 BYTE),
  /* 이름 */                       NAME        VARCHAR2(100 BYTE),
  /* 휴대전화 */                   MOBILE      VARCHAR2(20 BYTE),
  /* 미니 프로필 사진 정보 */      MINI_PROFILE_PICTURE_PATH VARCHAR2(400 BYTE),
  /* 메인 프로필 사진 정보 */      MAIN_PROFILE_PICTURE_PATH VARCHAR2(400 BYTE),
  /* 프로필 설명 */                DESCRIPT VARCHAR2(200 BYTE),
  /* 프로필 태그 */                PROFILE_CATEGORY VARCHAR2(200 BYTE),
  /* 가입형태(0:직접,1:네이버) */  SIGNUP_KIND NUMBER,
  /* 비밀번호수정일 */             PW_MODIFY_DT DATE,
  /* 가입일 */                     SIGNUP_DT DATE,
  CONSTRAINT PK_USER PRIMARY KEY(USER_NO)
);

CREATE TABLE ACCESS_HISTORY_T (
  ACCESS_HISTORY_NO NUMBER             NOT NULL,
  EMAIL             VARCHAR2(100 BYTE),
  IP                VARCHAR2(50 BYTE),
  USER_AGENT        VARCHAR2(150 BYTE),
  SESSION_ID        VARCHAR2(32 BYTE),
  SIGNIN_DT         DATE,
  SIGNOUT_DT        DATE,
  CONSTRAINT PK_ACCESS_HISTORY PRIMARY KEY(ACCESS_HISTORY_NO),
  CONSTRAINT FK_ACCESS_HISTORY_USER
    FOREIGN KEY(EMAIL)
      REFERENCES USER_T(EMAIL)
        ON DELETE CASCADE
);

CREATE TABLE LEAVE_USER_T (
  LEAVE_USER_NO NUMBER             NOT NULL,
  EMAIL         VARCHAR2(100 BYTE) NOT NULL UNIQUE,
  LEAVE_DT      DATE,
  CONSTRAINT PK_LEAVE_USER PRIMARY KEY(LEAVE_USER_NO)
);

-- 블로그 (댓글형 게시판)
CREATE TABLE POST_T (
  POST_NO   NUMBER              NOT NULL,
  TITLE     VARCHAR2(1000 BYTE) NOT NULL,
  CONTENTS  CLOB,
  HIT       NUMBER DEFAULT 0,
  USER_NO   NUMBER,
  CREATE_DT DATE,
  MODIFY_DT DATE,
  CATEGORY  NUMBER, -- 1 일러스트 2 사진 3 디자인 4 회화 5 조소/공예 6 사운드 7 애니메이션 8 캘리그라피 9 기타
  CONSTRAINT PK_POST PRIMARY KEY(POST_NO),
  CONSTRAINT CATE_CK CHECK (CATEGORY BETWEEN 1 AND 9),
  CONSTRAINT FK_POST_USER FOREIGN KEY(USER_NO)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE
);

-- 블로그 댓글( 댓글 게시판 (1차 답글만 가능))
CREATE TABLE COMMENT_T (
  COMMENT_NO NUMBER              NOT NULL,
  CONTENTS   VARCHAR2(4000 BYTE) NOT NULL,
  CREATE_DT  DATE,
  STATE      NUMBER              NULL, -- 0:삭제 1:정상 (삽입기능수정 / 관련 Dto 및 resultMap 수정)
  DEPTH      NUMBER, -- 원글 0, 답글1
  GROUP_NO   NUMBER, -- 원글에 달린 모든 답글은 동일한 GROUP_NO 를 가짐
  USER_NO    NUMBER,
  POST_NO    NUMBER,
  CONSTRAINT PK_COMMENT PRIMARY KEY(COMMENT_NO),
  CONSTRAINT FK_COMMENT_USER FOREIGN KEY(USER_NO)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE,
  CONSTRAINT FK_COMMENT_POST FOREIGN KEY(POST_NO)
    REFERENCES POST_T(POST_NO) ON DELETE CASCADE
);

CREATE TABLE LIKE_T (
  LIKE_NO NUMBER NOT NULL,
  POST_NO NUMBER,
  USER_NO NUMBER,
  CREATE_DT DATE,
  CONSTRAINT PK_LIKE PRIMARY KEY(LIKE_NO),
  CONSTRAINT FK_LIKE_POST FOREIGN KEY(POST_NO)
    REFERENCES POST_T(POST_NO) ON DELETE CASCADE,
  CONSTRAINT FK_LIKE_USER FOREIGN KEY(USER_NO)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE
);

CREATE TABLE FOLLOW_T(
  FOLLOW_NO NUMBER NOT NULL,
  FROM_USER NUMBER,
  TO_USER NUMBER,
  CREATE_DT DATE,
  CONSTRAINT PK_FOLLOW PRIMARY KEY(FOLLOW_NO),
  CONSTRAINT FK_FOLLOW_FROM_USER FOREIGN KEY(FROM_USER)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE,
  CONSTRAINT FK_FOLLOW_TO_USER FOREIGN KEY(TO_USER)
    REFERENCES USER_T(USER_NO) ON DELETE CASCADE
);

-- 기초 데이터 (사용자)
INSERT INTO USER_T VALUES(
    USER_SEQ.NEXTVAL
  , 'a'
  , STANDARD_HASH('1', 'SHA256')
  , 'admin'
  , '010-1111-1111'
  , null
  , null
  , null
  , null
  , 0
  , CURRENT_DATE
  , CURRENT_DATE);

commit;

-- 유저 프로필 테스트용
INSERT INTO USER_T VALUES(
    USER_SEQ.NEXTVAL
  , 'subin'
  , STANDARD_HASH('1', 'SHA256')
  , 'subin'
  , '010-1111-1111'
  , null
  , null
  , '내가 찍은 사진들로 나의 시선 기록하기 (2차 가공X)'
  , '디자인, 사진'
  , 0
  , CURRENT_DATE
  , CURRENT_DATE);
  


commit;

/************************* 트리거 *************************/
/*
  1. DML (INSERT, UPDATE, DELETE) 작업 이후 자동으로 실행되는 데이터베이스 객체이다.
  2. 행 (ROW) 단위로 동작한다.
  3. 종류
    1) BEFORE : DML 동작 이전에 실행되는 트리거
    2) AFTER  : DML 동작 이후에 실행되는 트리거
  4. 형식
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE | AFTER
    INSERT OR UPDATE OR DELETE
    ON 테이블명
    FOR EACH ROW
    BEGIN
      트리거본문
    END;
*/

/*
  USER_T 테이블에서 삭제된 회원정보를 LEAVE_USER_T 테이블에 자동으로 삽입하는
  LEAVE_TRIGGER 트리거 생성하기
*/
CREATE OR REPLACE TRIGGER LEAVE_TRIGGER
  AFTER
  DELETE
  ON USER_T
  FOR EACH ROW
BEGIN
  INSERT INTO LEAVE_USER_T (
      LEAVE_USER_NO
    , EMAIL
    , LEAVE_DT
  ) VALUES (
      LEAVE_USER_SEQ.NEXTVAL
    , :OLD.EMAIL
    , CURRENT_DATE
  );
  -- COMMIT;  트리거 내에서는 오류가 있으면 ROLLBACK, 없으면 COMMIT 자동 처리
END;