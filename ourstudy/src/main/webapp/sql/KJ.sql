--물품
create table item(
 item_num number(10),
 item_index number(10) not null,
 item_title varchar2(20) not null,
 item_imgsrc varchar2(300),
 item_start date default SYSDATE not null,
 item_end date not null,
 item_p_status number(1) not null,
 item_r_status number(1) default 1 not null,
 mem_num number not null,
 constraint item_pk primary key (item_num),
 constraint item_fk foreign key (mem_num) references member (mem_num)
);
create sequence item_seq;

--채팅
create table message(
 mes_num number(10),
 mem_num number not null,
 mes_fname varchar2(20) not null,
 mes_tname varchar2(20) not null,
 mes_time date default SYSDATE not null,
 mes_scontent varchar2(100) not null,
 mes_content clob not null,
 constraint message_pk primary key (mes_num),
 constraint message_fk foreign key (mem_num) references member (mem_num)
);
create sequence message_seq;
