package kr.spring.locker.service;

import java.util.List;

import kr.spring.locker.vo.LockerVO;

public interface LockerService {
	//사물함 등록
	public void insertLocker(LockerVO vo);
	//사물함 이용시작
	//선택한 사물함번호, 회원번호, 회원이름, 이용시작 날짜 입력
	public void selectLocker(LockerVO vo);
	
	//사물함 정보 불러오기
	public List<LockerVO> getLockerList();
	
}
