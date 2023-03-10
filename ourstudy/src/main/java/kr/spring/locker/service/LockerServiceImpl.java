package kr.spring.locker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.locker.dao.LockerMapper;
import kr.spring.locker.vo.LockerVO;
import kr.spring.pay.vo.PayVO;

@Service
@Transactional
public class LockerServiceImpl implements LockerService{

   @Autowired
   private LockerMapper lockerMapper;
   
   /*=================================
               ADMIN
     =================================*/
   //새로운 사물함 등록
   @Override
   public void insertLocker(LockerVO vo) {
      vo.setLocker_num(lockerMapper.selectLocker_num());
      lockerMapper.insertLocker(vo);
   }


	/*=================================
					MEMBER
	  =================================*/
	//사물함 선택
	@Override
	public void selectLocker(LockerVO vo) {
		lockerMapper.insertToSelectLocker(vo);
//		lockerMapper.lockerStatusIn(vo);
	}
	
	/*==================================
     			GET DATA
	==================================*/
	//사물함 정보 불러오기
	@Override
	public List<LockerVO> getLockerList() {
		return lockerMapper.getLockerList();
	}

   @Override
   public int getMyLockerCount(int mem_num) {
      return lockerMapper.getMyLockerCount(mem_num);
   }
   
   /*=================================
            IN / OUT / DATE
     =================================*/
   //시작일 불러오기
   @Override
   public String getLocker_start(LockerVO vo) {
      return lockerMapper.getLocker_start(vo);
   }

   //종료일, 남은시각 저장 (퇴실 시)
   @Override
   public void insertEndAndDiff(LockerVO vo) {
      lockerMapper.insertEndAndDiff(vo);
   }


	//사물함 이용불가 상태로 변경
	@Override
	public void lockerStatusIn(PayVO vo) {
		lockerMapper.lockerStatusIn(vo);
	}

   //사물함 이용가능 상태로 변경
   @Override
   public void lockerStatusOut(LockerVO vo) {
      lockerMapper.lockerStatusOut(vo);
   }


   
   


}