package kr.spring.seat.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.spring.member.vo.MemberVO;
import kr.spring.seat.vo.SeatVO;


public interface SeatService {

   //좌석등록
   public void insertSeat(SeatVO vo);
   //좌석선택
   public void selectSeat(SeatVO vo);
   //좌석리스트
   public List<SeatVO> getSeatList();
   //좌석 이동 (좌석 퇴실 처리 후, 새좌석에 추가)
   //외출
   public void holdSeat(SeatVO vo);
   //입실 상태일 때 퇴실
   public void outSeatWhenIn(SeatVO vo);
   //외출 상태일 때 퇴실
   public void outSeatWhenHold(SeatVO vo);
   //외출했다가 다시 입실
   public int getOutMemberSeat(int mem_num);		//내가 신청했던 좌석들 중 현재좌석(=외출중인 좌석)번호 가져오기
   public int getInMemberSeat(int mem_num);			//내가 앉았던 좌석들 중 현재좌석(=입실중인 좌석)번호 가져오기
   public void inSeatWhenHold(SeatVO vo);
   //날짜 추출
   public SeatVO getTimes(int seat_num);
   //좌석번호,회원번호,회원이름 추출
   public SeatVO getSeatDetail(int seat_num);
   //total_time 입력
   public void insertTotal_time(SeatVO vo);
   //현재 회원 좌석상태 구하기
   public int getMem_status(int mem_num);
   //현재 좌석의 입실상태 구하기
   public int getSeat_status(int seat_num);
   //회원 잔여시간 가져오기
   public Float getMemberHour(int mem_num);
   //회원 잔여기간 가져오기
   public Float getMemberTerm(int mem_num);
   //시간권 새로운 시간 갱신
   public void updateMemberHistory_Hour(Float time, Integer mem_num);
}

