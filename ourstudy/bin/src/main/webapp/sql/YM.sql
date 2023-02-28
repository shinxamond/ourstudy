--포인트 테이블 생성
create table point(
 point_num number,
 point_point number not null,
 point_accrue number default 0 not null ,
 pay_num number not null,
 mem_num number not null,
 constraint point_pk primary key (point_num),
 constraint point_pay_fk foreign key (pay_num) references pay (pay_num),
 constraint point_member_fk foreign key (mem_num) references member (mem_num)
);
--포인트 시퀀스 생성
create sequence point_seq;

