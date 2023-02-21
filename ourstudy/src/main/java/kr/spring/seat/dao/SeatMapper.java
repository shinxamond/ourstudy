package kr.spring.seat.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.seat.vo.SeatVO;

@Mapper
public interface SeatMapper {
	/*==================================
		    		관 리 자
	  ==================================*/
	//좌석번호
	@Select("SELECT seat_seq.nextval FROM dual")
	public int selectSeat_num();
	//좌석 등록
	@Insert("INSERT INTO SEAT(seat_num,seat_name) VALUES(seat_seq.nextval, #{seat_name})")
	public void insertSeat(SeatVO vo);
	
	
	/*==================================
			     회       원
	==================================*/
	//좌석 선택 
	//회원 정보, 입실 날짜 입력
	@Insert("INSERT INTO SEAT_DETAIL(mem_num,mem_name,seat_num) VALUES (#{mem_num},#{mem_name},#{seat_num})")
	public void selectSeat(SeatVO vo);
	//좌석 이동(퇴실 처리후 입실)
	//selectSeat -> deleteSeatDetail
	
	
	/*========================================*/
	//해당 DB에서 정보 가져오기
	public List<SeatVO> getSeatList();
	public List<SeatVO> getSeatDetailList();
	//새좌석에 정보넣기
	@Insert("INSERT INTO SEAT_DETAIL(mem_num,mem_name,in_time) VALUES(#{mem_num},#{mem_name},#{in_time}) WHERE seat_num=#{seat_num}")
	public void insertSeatDetail(int seat_num);
	//좌석 정보 모두 삭제(아예퇴실)
	@Delete("DELETE SEAT_DETAIL WHERE seat_num=#{seat_num}")
	public void deleteSeatDetail(int seat_num);
	
	//좌석이용시간 구하기
	//좌석 상태 변경
	//외출상태로 변경
	@Update("UPDATE SEAT SET seat_status=2 WHERE seat_num=#{seat_num}")
	public void SeatStatusHold(int seat_num);
	//사용불가상태로 변경
	@Delete("DELETE SEAT SET seat_status=0 WHERE seat_num=#{seat_num}")
	public void seatStatusIn(SeatVO vo);
	//사용가능 상태로 변경
	public void seatStatusOut(int seat_num);
	//퇴실날짜정보 등록
	@Update("UPDATE SEAT_DETAIL SET out_time=SYSDATE WHERE seat_num=#{seat_num}")
	public void outSeat(int seat_num);
	
}
