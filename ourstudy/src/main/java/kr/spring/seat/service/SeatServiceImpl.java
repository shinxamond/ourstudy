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
      seatMapper.insertToSelectSeat(vo);      //회원상세정보 등록
      seatMapper.seatStatusIn(vo.getSeat_num());
      seatMapper.memberStatusIn(vo.getMem_num());
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
   public void holdSeat(SeatVO vo) {
      seatMapper.seatStatusHold(vo.getSeat_num());               //외출상태로 변환(status)
      seatMapper.memberStatusHold(vo.getMem_num());
   }

   //입실 상태일 때 퇴실처리
   @Override
   public void outSeatWhenIn(SeatVO vo) {
      seatMapper.insertOutTimeBySeat_num(vo.getSeat_num());         //퇴실시간 찍기
      seatMapper.seatStatusOut(vo.getSeat_num());                //사용가능 상태로 변환(status)
      seatMapper.memberStatusOut(vo.getMem_num());
   }
   
   //외출 상태일 때 퇴실 처리
   @Override
   public void outSeatWhenHold(SeatVO vo) {
      seatMapper.insertOutTimeBySeat_num(vo.getSeat_num());         //퇴실시간 찍기
      seatMapper.seatStatusOut(vo.getSeat_num());
      seatMapper.memberStatusOut(vo.getMem_num());
      
   }
   
   //외출했다가 다시 입실
   @Override
   public void inSeatWhenHold(SeatVO vo) {
      seatMapper.seatStatusIn(vo.getSeat_num());
      seatMapper.memberStatusIn(vo.getMem_num());
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

   @Override
   public int getMem_status(int mem_num) {
      return seatMapper.getMem_status(mem_num);
   }


   

}