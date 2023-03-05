package kr.spring.main.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;
import kr.spring.seat.vo.SeatVO;

public interface MainService {
	
	public List<MemberVO> member_studyTime(Map<String, Object> map);
	
	public List<SeatVO> member_Rank(int[] member_list, String weekStart, String weekEnd);
	
	public int[] setMemberArray();
}
