package kr.spring.seat.service;

import java.util.List;

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
	//퇴실
	public void outSeat(SeatVO vo);
	//날짜 추출
	public SeatVO getTimes(int seat_num);
	//좌석번호,회원번호,회원이름 추출
	public SeatVO getSeatDetail(int mem_num);
	//total_time 입력
	public void insertTotal_time(SeatVO vo);
}
