package kr.spring.seat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;
import kr.spring.seat.vo.SeatVO;

@Mapper
public interface SeatMapper {
   /*==================================
                ADMIN
     ==================================*/
   //좌석번호
   @Select("SELECT seat_seq.nextval FROM dual")
   public int selectSeat_num();
   //좌석 등록
   @Insert("INSERT INTO SEAT(seat_num,seat_name) VALUES(#{seat_num}, #{seat_name})")
   public void insertSeat(SeatVO vo);
   
   
   /*==================================
                 MEMBER
   ==================================*/
   //회원 정보, 입실 날짜 입력
   @Insert("INSERT INTO SEAT_DETAIL(seat_detail_num,mem_num,mem_name,seat_num) VALUES (seat_detail_seq.nextval,#{mem_num},#{mem_name},#{seat_num})")
   public void insertToSelectSeat(SeatVO vo);
   //좌석 이동(퇴실 처리후 입실)
   //selectSeat -> deleteSeatDetail
   
   
   /*========================================
              GET DATA(LIST) - SEAT
    ======================================= */
   //해당 DB에서 정보 가져오기
   @Select("select * FROM SEAT ORDER BY seat_num ASC")
   public List<SeatVO> getSeatList();
   @Select("SELECT d.seat_detail_num,d.seat_num,s.seat_name,d.mem_name,TO_CHAR(d.in_time, 'yyyy-MM-dd HH24:MI:SS') in_time, TO_CHAR(d.out_time, 'yyyy-MM-dd HH24:MI:SS') out_time,d.total_time FROM SEAT_DETAIL d JOIN SEAT s ON s.seat_num = d.seat_num")
   public List<SeatVO> getSeatDetailList();
   //좌석이용시간 구하기
   
   //해당 멤버의 좌석 번호 구하기
   @Select("SELECT seat_num, mem_num, mem_name FROM SEAT_DETAIL WHERE seat_num=#{seat_num} AND out_time IS NULL")
   public SeatVO getSeatDetailBySeat_num(int seat_num);			//*없음*/
   
   //total_time 이 null인 회원의 입실날짜와 퇴실날짜를 String으로 불러온다.
   @Select("SELECT TO_CHAR(in_time, 'yyyy-MM-dd HH24:MI:SS') in_time, TO_CHAR(out_time, 'yyyy-MM-dd HH24:MI:SS') out_time FROM SEAT_DETAIL WHERE seat_num=#{seat_num} AND total_time IS NULL")
   public SeatVO getTimes(int seat_num);


   //현재 회원의 좌석 상태 구하기
   @Select("SELECT mem_status FROM MEMBER WHERE mem_num=#{mem_num}")
   public int getMem_status(int mem_num);
   
   //현재 좌석의 입실상태 구하기
   @Select("SELECT seat_status FROM SEAT WHERE seat_num=#{seat_num}")
   public int getSeat_status(int seat_num);
   
   //외출->입실할 경우 현재 외출 상태인 좌석번호 가져오기
   @Select("SELECT d.seat_num FROM (SELECT sd.seat_num FROM SEAT_DETAIL sd JOIN MEMBER m ON sd.mem_num = m.mem_num WHERE m.mem_num=#{mem_num} AND m.mem_status=2 ORDER BY sd.out_time DESC) d WHERE rownum=1")
   public int getOutMemberSeat(int mem_num);
   
   //입실->퇴실할 경우 현재 입실 상태인 좌석번호 가져오기
   @Select("SELECT sd.seat_num FROM seat_detail sd JOIN member m ON sd.mem_num=m.mem_num WHERE m.mem_num=#{mem_num} AND sd.total_time IS NULL")
   public int getInMemberSeat(int mem_num);
   /*========================================
            GET DATA(LIST) - HISTORY
    ======================================= */
   //잔여시간 가져오기
   @Select("SELECT mem_ticket_hour FROM MEMBER_HISTORY WHERE mem_num=#{mem_num}")
   public Float getMemberHour(int mem_num);
   
   //잔여기간 가져오기
   @Select("SELECT mem_ticket_term FROM MEMBER_HISTORY WHERE mem_num=#{mem_num}")
   public String getMemberTerm(int mem_num);
   
   /*========================================
                ABOUT HISTORY
    ======================================= */
   //독서실 시간권 계산
   @Update("UPDATE member_history SET mem_ticket_hour=#{time} "
		   + "WHERE mem_num=#{mem_num}")
   public void updateMemberHistory_Hour(@Param(value="time") Float time, 
		   @Param(value="mem_num") Integer mem_num);
   
   /*========================================
                IN / OUT / HOLD
    ======================================= */
   //좌석 상태 변경
   //사용가능 상태로 변경
   @Update("UPDATE SEAT SET seat_status=1 WHERE seat_num=#{seat_num}")
   public void seatStatusOut(int seat_num);
   @Update("UPDATE MEMBER SET mem_status=0 WHERE mem_num=#{mem_num}")
   public void memberStatusOut(int mem_num);
   //사용불가상태로 변경
   @Update("UPDATE SEAT SET seat_status=0 WHERE seat_num=#{seat_num}")
   public void seatStatusIn(int seat_num);
   @Update("UPDATE MEMBER SET mem_status=1 WHERE mem_num=#{mem_num}")
   public void memberStatusIn(int mem_num);
   //외출상태로 변경
   @Update("UPDATE SEAT SET seat_status=2 WHERE seat_num=#{seat_num}") 
   public void seatStatusHold(int seat_num);
   @Update("UPDATE MEMBER SET mem_status=2 WHERE mem_num=#{mem_num}")
   public void memberStatusHold(int mem_num);
   //퇴실날짜정보 등록
   @Update("UPDATE SEAT_DETAIL SET out_time=SYSDATE WHERE seat_num=#{seat_num} AND out_time IS NULL")
   public void insertOutTimeBySeat_num(int seat_num);
   @Update("UPDATE SEAT_DETAIL SET out_time=SYSDATE WHERE mem_num=#{mem_num} AND out_time IS NULL")
   public void insertOutTimeByMem_num(int mem_num);
   //입퇴실날짜 저장
   @Update("UPDATE SEAT_DETAIL SET total_time=#{total_time} WHERE seat_num=#{seat_num} AND total_time IS NULL")
   public void insertTotal_time(SeatVO vo);
}

