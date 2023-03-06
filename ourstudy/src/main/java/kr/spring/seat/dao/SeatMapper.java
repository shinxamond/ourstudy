package kr.spring.seat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
                GET DATA(LIST)
    ======================================= */
   //해당 DB에서 정보 가져오기
   public List<SeatVO> getSeatList();
   public List<SeatVO> getSeatDetailList(); //*없음*/
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
   
   //외출->입실할 경우 현재 외출 상태인 좌석번호 가져오기
   @Select("SELECT sd.seat_num FROM SEAT_DETAIL sd JOIN MEMBER m ON sd.mem_num = m.mem_num WHERE m.mem_num=#{mem_num} AND m.mem_status=2 AND rownum=1 ORDER BY sd.out_time DESC")
   public int getOutMemberSeat(int mem_num);
   
   //입실->퇴실할 경우 현재 입실 상태인 좌석번호 가져오기
   @Select("SELECT sd.seat_num FROM seat_detail sd JOIN member m ON sd.mem_num=m.mem_num WHERE m.mem_num=#{mem_num} AND sd.total_time IS NULL")
   public int getInMemberSeat(int mem_num);
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
   /*===========================================
                KEEP
     ===========================================*/
   //현재 좌석의 컬럼수
   @Select("SELECT COUNT(*) FROM SEAT_DETAIL WHERE seat_num=#{seat_num}")
   public int getSeatCount(SeatVO vo);
   //좌석 이동시 새로 선택한 좌석에 정보넣기
   @Insert("INSERT INTO SEAT_DETAIL(mem_num,mem_name,in_time) VALUES(#{mem_num},#{mem_name},#{in_time}) WHERE seat_num=#{seat_num}")
   public void insertToMoveSeat(int seat_num);
   
}

