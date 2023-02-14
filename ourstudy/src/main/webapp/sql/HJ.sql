--독서실 이용권 테이블
CREATE TABLE study(
 study_num number,
 study_name varchar2(30) not null,
 study_type number(1) not null,
 study_price number(8) not null,
 mem_num number not null,
 constraint study_pk primary key (study_num),
 constraint study_fk foreign key (mem_num) references member (mem_num)
);

-- 독서실 이용권 시퀀스
create sequence study_seq;

-- 사물함 이용권 테이블
CREATE TABLE locker(
 lock_num number,
 lock_name varchar2(30) not null,
 lock_type number(1) not null,
 lock_price number(8) not null,
 mem_num number not null,
 constraint locker_pk primary key (lock_num),
 constraint locker_fk foreign key (mem_num) references member (mem_num)
);

-- 사물함 이용권 시퀀스
create sequence locker_seq;

-- 결제 테이블
CREATE TABLE pay(
 pay_num number,
 pay_price number(8) not null,
 pay_plan number(1) not null,
 pay_content varchar(50) not null,
 pay_date date default sysdate not null,
 mem_num number not null,
 study_num number not null,
 lock_num number not null,
 constraint pay_pk primary key (pay_num),
 constraint pay_fk1 foreign key (mem_num) references  member (mem_num),
 constraint pay_fk2 foreign key (study_num) references study (study_num),
 constraint pay_fk3 foreign key (lock_num) references locker (lock_num)
);