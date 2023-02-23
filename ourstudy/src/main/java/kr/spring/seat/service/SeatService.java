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
	public void holdSeat(int seat_num);
	//퇴실
	public void outSeat(int seat_num);
	//날짜 추출
	public SeatVO getTimes(int seat_num);
	//total_time 입력
	public void insertTotal_time(SeatVO vo);
}
