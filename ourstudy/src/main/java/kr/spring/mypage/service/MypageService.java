package kr.spring.mypage.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import kr.spring.community.vo.LostVO;
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
	
	/*==================================
					포인트
	====================================*/		
	
	public int selectPointListCountByMemNum(Map<String, Object> map);
	
	public List<PayVO> selectPointListByMemNum(Map<String, Object> map);
	
	public Integer selectTotalPoint(int mem_num);
	
	public void insertPoint(PayVO payVO);
	
	/*==================================
    				공부시간
	====================================*/		
	
	public SeatVO selectCurSeat(Integer mem_num);
	
	public int selectSeatDetailRowCount(Integer mem_num);
	
	public List<SeatVO> selectSeatDetailListByMem_num(Map<String, Object> map);
	
	public int selectAccrueStudyTime(MemberVO member);

	public void updateStudyTime(SeatVO seat);
	
	public float selectRemainTime(Integer mem_num);
	
	public int selectRemainTimeTerm(Integer mem_num);
	
	
	
	public String selectRegDate(Integer mem_num);
	
	public int selectSumTotalTimeForGraph(String weekStart, String weekEnd, Integer mem_num);
	
	public void updateRegDate();
	
	//////////////나중에 지울것////////////////////////////
	public void deleteSomething(Integer mem_num);
	
	
	
	public int selectLockerNumByMem_num(Integer mem_num);
	
	
	public List<LostVO> getLostFoundList(Integer mem_num);
	

}
