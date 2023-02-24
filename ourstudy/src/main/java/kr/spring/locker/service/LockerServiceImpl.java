package kr.spring.locker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.locker.dao.LockerMapper;
import kr.spring.locker.vo.LockerVO;

@Service
@Transactional
public class LockerServiceImpl implements LockerService{

	@Autowired
	private LockerMapper lockerMapper;
	
	/*=================================
					ADMIN
	  =================================*/
	//새로운 좌석 등록
	@Override
	public void insertLocker(LockerVO vo) {
		vo.setLocker_num(lockerMapper.selectLocker_num());
		lockerMapper.insertLocker(vo);
	}

	/*=================================
					MEMBER
	  =================================*/
	//좌석 선택
	@Override
	public void selectLocker(LockerVO vo) {
		vo.setLocker_detail_num(lockerMapper.selectLocker_Detail_num());
		lockerMapper.insertToSelectLocker(vo);
		lockerMapper.lockerStatusIn(vo);
	}

	//좌석 정보 불러오기
	@Override
	public List<LockerVO> getLockerList() {
		return lockerMapper.getLockerList();
	}

	
}
