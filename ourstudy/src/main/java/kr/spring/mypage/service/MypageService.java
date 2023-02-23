package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;
import kr.spring.point.vo.PointVO;
import kr.spring.seat.vo.SeatVO;

public interface MypageService {
	
	public MemberVO selectMember(Integer mem_num);
	
	public void updateProfile(MemberVO member);
	
	public void updateMember_detail(MemberVO member);
	
	public void updatePassword(MemberVO member);
	
	public void deleteMember(Integer mem_num);
	
	//결제에서 같이 처리
	//public void insertPoint(PointVO point);
	
	public List<PointVO> selectPointListByMemNum(Map<String, Object> map);
	
	public int selectTotalPoint(int mem_num);
	
	public SeatVO selectCurSeat(Integer mem_num);
}
