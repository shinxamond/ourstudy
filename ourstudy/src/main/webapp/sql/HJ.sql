--이용권 테이블
CREATE TABLE Ticket(
 ticket_num number,
 ticket_kind number(1) not null,
 ticket_name varchar(30) not null,
 ticket_type number(1) not null,
 ticket_price number(8) not null,
 mem_num number not null,
 constraint ticket_pk primary key (ticket_num),
 constraint ticket_fk1 foreign key (mem_num) references  member (mem_num)
);

-- 이용권 시퀀스
create sequence ticket_seq;

-- 결제 테이블
CREATE TABLE pay(
 pay_num number,
 pay_price number(8) not null,
 pay_plan number(1) not null,
 pay_content varchar(50) not null,
 pay_date date default sysdate not null,
 mem_num number not null,
 ticket_num number not null,
 point_num number not null,
 constraint pay_pk primary key (pay_num),
 constraint pay_fk1 foreign key (mem_num) references  member (mem_num),
 constraint pay_fk2 foreign key (ticket_num) references ticket (ticket_num),
 constraint pay_fk3 foreign key (point_num) references point (point_num)
);

-- 결제 시퀀스
create sequence pay_seq;
