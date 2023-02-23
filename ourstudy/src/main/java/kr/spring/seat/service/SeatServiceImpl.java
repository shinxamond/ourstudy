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
		
		//좌석 이용시간 구하는 메서드
		
		seatMapper.seatStatusHold(seat_num);	//외출상태로 변환(status)
	}

	//퇴실처리
	@Override
	public void outSeat(int seat_num) {
		seatMapper.insertOutTimeBySeat_num(seat_num);			//퇴실시간 찍기
		seatMapper.seatStatusOut(seat_num); 		//사용가능 상태로 변환(status)
		//좌석 이용시간 구하기 메서드(DB에서 가져와서 차이 계산한다음 DB total_time에 다시 넣어줘야 할듯)
	}

	@Override
	public SeatVO getTimes(int seat_num) {
		return seatMapper.getTimes(seat_num);
	}

	//퇴실시간 - 입실시간
	@Override
	public void insertTotal_time(SeatVO vo) {
		seatMapper.insertTotal_time(vo);
	}
	
	

}
