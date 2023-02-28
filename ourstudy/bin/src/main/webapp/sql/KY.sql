---좌석 
CREATE TABLE SEAT(
    seat_num number not null,
    seat_status number(1) default 1 not null,
    constraint seat_pk primary key (seat_num)
);

--좌석번호 
CREATE SEQUENCE SEAT_SEQ;

--좌석상세
CREATE TABLE SEAT_DETAIL(
	seat_detail_num number not null,
    seat_num number not null,
    mem_num number not null,
    mem_name varchar2(30) not null,
    in_time date default SYSDATE not null,
    out_time date,
    total_time number,
    constraint seat_detail_pk primary key (num),
    constraint seat_detail_fk1 foreign key (seat_num) references seat(seat_num),
    constraint seat_detail_fk2 foreign key (mem_num) references member(mem_num)
);

--좌석상세
CREATE SEQUENCE SEAT_DETAIL_SEQ;

