package kr.spring.seat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.seat.dao.SeatMapper;
import kr.spring.seat.vo.SeatVO;

@Service
@Transactional
public class SeatServiceImpl implements SeatService{

	@Autowired
	private SeatMapper seatMapper;

	//좌석등록
	@Override
	public void insertSeat(SeatVO vo) {
		vo.setSeat_num(seatMapper.selectSeat_num());
		seatMapper.insertSeat(vo);
	}

	//좌석 선택
	@Override
	public void selectSeat(SeatVO vo) {
		vo.setSeat_detail_num(seatMapper.selectSeat_Detail_num());
		seatMapper.insertToSelectSeat(vo);		//회원상세정보 등록
		seatMapper.seatStatusIn(vo);
	}

	//좌석 리스트
	@Override
	public List<SeatVO> getSeatList() {
		List<SeatVO> list = seatMapper.getSeatList();
		return list;
	}
	
	
	//좌석이동
		//기존 좌석 퇴실
		//기존 좌석 status = 1 변환
		//새 좌석 입실
		//해당 좌석 status = 0 변환
	
	
	//외출처리
	@Override
	public void holdSeat(int seat_num) {
		seatMapper.insertOutTimeBySeat_num(seat_num);			//퇴실시간 찍기
		seatMapper.seatStatusHold(seat_num);					//외출상태로 변환(status)
	}

	//퇴실처리
	@Override
	public void outSeat(int seat_num) {
		seatMapper.insertOutTimeBySeat_num(seat_num);			//퇴실시간 찍기
		seatMapper.seatStatusOut(seat_num); 					//사용가능 상태로 변환(status)
	}

	//입실시간/ 퇴실시간 추출
	@Override
	public SeatVO getTimes(int seat_num) {
		return seatMapper.getTimes(seat_num);
	}

	//회원이름, 회원번호, 좌석번호 추출
	public SeatVO getSeatDetail(int mem_num) {
		return seatMapper.getSeatDetailByMem_num(mem_num);
	}
	
	//퇴실시간 - 입실시간
	@Override
	public void insertTotal_time(SeatVO vo) {
		seatMapper.insertTotal_time(vo);
	}
	
	

}
