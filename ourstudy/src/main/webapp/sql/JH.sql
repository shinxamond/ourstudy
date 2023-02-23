-- locker Table Create SQL
CREATE TABLE locker_info
( 
    locker_num NUMBER NOT NULL,
    locker_status NUMBER(1) default 1 NOT NULL,
   
    CONSTRAINT locker_info_pk PRIMARY KEY (locker_num)
);
CREATE SEQUENCE locker_seq;

-- locker_detail Table Create SQL
CREATE TABLE locker_detail
( 	
	locker_detail_num NUMBER NOT NULL,
    locker_num NUMBER NOT NULL,
    mem_num NUMBER NOT NULL,
    mem_name VARCHAR2(30) NOT NULL,
    locker_start DATE default SYSDATE NOT NULL,
    locker_end DATE,
    locker_diff NUMBER,
    
    CONSTRAINT locker_detail_pk PRIMARY KEY (locker_detail_num),
    CONSTRAINT locker_detail_fk FOREIGN KEY (locker_num) REFERENCES locker_info(locker_num),
    CONSTRAINT locker_detail_fk2 FOREIGN KEY (mem_num) REFERENCES member(mem_num)
);

CREATE SEQUENCE locker_detail_seq;
