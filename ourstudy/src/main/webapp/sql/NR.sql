--회원
create table member(
 mem_num number,
 mem_id varchar2(12) unique not null,
 mem_auth number(1) default 1 not null,
 mem_status number(1) default 0 not null,
 auto_id varchar2(36),
 constraint member_pk primary key (mem_num)
);
--회원번호 시퀀스
create sequence member_seq;

--회원상세
create table member_detail(
 mem_num number,
 mem_name varchar2(30) not null,
 mem_pw varchar2(16) not null,
 mem_phone varchar2(13),
 mem_email varchar2(50) not null,
 mem_zipcode varchar2(5),
 mem_address1 varchar2(90),
 mem_address2 varchar2(90),
 mem_photo blob,
 mem_regdate date default sysdate not null,
 mem_mdate date,
 constraint member_detail_pk primary key (mem_num),
 constraint member_detail_fk1 foreign key (mem_num) references member (mem_num)
);

--회원 기록
create table member_history(
 mem_num number,
 mem_study number,
 mem_ticket number(3),
 constraint member_history_pk primary key (mem_num),
 constraint member_history_fk1 foreign key (mem_num) references member (mem_num)
);