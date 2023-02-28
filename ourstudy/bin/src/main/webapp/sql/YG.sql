create table information(
  info_num number not null,
  info_date date not null,
  info_title varchar2(100) not null,
  info_content clob not null,
  info_pin number(1) default 1 not null,
  mem_num number not null,
  constraint information_pk primary key (info_num),
  constraint information_fk foreign key(mem_num) references member (mem_num)
);
create sequence information_seq;


--분실물 찾기
create table lost_found(
  lf_num number not null,
  lf_type number(1) not null,
  lf_title varchar2(100) not null,
  lf_content varchar2(1000) not null,
  lf_imgsrc varchar2(300),
  f_condition number(1) not null,
  mem_num number not null,
  constraint lost_found_pk primary key (lf_num),
  constraint lost_found_fk foreign key(mem_num)references member (mem_num)
);
create sequence lost_found_seq;


--분실물 찾기 댓글 
create table reply_lost(
  re_num number not null,
  re_date date default sysdate not null,
  re_content varchar2(1000) not null,
  lf_num number not null,
  mem_num number not null,
  constraint reply_lost_pk primary key (re_num),
  constraint reply_lost_fk1 foreign key(lf_num)references lost_found(lf_num),
  constraint reply_lost_fk2 foreign key(mem_num)references member(mem_num)
);
create sequence reply_lost_seq;


--이용후기
create table review(
  r_num number not null,
  r_title varchar2(100) not null,
  r_content clob not null,
  r_rate number(1) not null,
  r_imgsrc varchar2(300),
  mem_num number not null,
  constraint review_pk primary key (r_num),
  constraint review_fk foreign key(mem_num)references member (mem_num)
);
create sequence review_seq;


--이용후기 댓글 
create table reply_review(
  revw_num number not null,
  revw_date date default sysdate not null,
  revw_content varchar2(1000) not null,
  r_num number not null,
  mem_num number not null,
  constraint reply_review_pk primary key (revw_num),
  constraint reply_review_fk1 foreign key(r_num)references review(r_num),
  constraint reply_review_fk2 foreign key(mem_num)references member(mem_num)
);
create sequence reply_review_seq;