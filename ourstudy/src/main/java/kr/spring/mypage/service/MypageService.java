package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;
import kr.spring.pay.vo.PayVO;
import kr.spring.point.vo.PointVO;
import kr.spring.seat.vo.SeatVO;

public interface MypageService {
	/*==================================
    		프로필 이미지 등록 및 수정
	====================================*/	
	
	public void updateProfile(MemberVO member);
	
	/*==================================
    			회원정보 수정
	====================================*/
	
	public MemberVO selectMember(Integer mem_num);
	
	public void updateMember_detail(MemberVO member);
	
	public void updatePassword(MemberVO member);
	
	public void deleteMember(Integer mem_num);
	
	//결제에서 같이 처리
	//public void insertPoint(PointVO point);
	
	public List<PointVO> selectPointListByMemNum(Map<String, Object> map);
	
	public Integer selectTotalPoint(int mem_num);
	
	/*==================================
    				공부시간
	====================================*/		
	
	public SeatVO selectCurSeat(Integer mem_num);
	
	public int selectSeatDetailRowCount(Integer mem_num);
	
	public List<SeatVO> selectSeatDetailListByMem_num(Map<String, Object> map);
	
	public int selectAccrueStudyTime(MemberVO member);

	public void updateStudyTime(SeatVO seat);
	
	
	
	public void insertPoint(PayVO payVO);
	
	//////////////나중에 지울것////////////////////////////
	public void deleteSomething(Integer mem_num);

}
