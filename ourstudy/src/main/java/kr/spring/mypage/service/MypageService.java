package kr.spring.mypage.service;

import kr.spring.member.vo.MemberVO;

public interface MypageService {
	
	public MemberVO selectMember(Integer mem_num);
	
	public void updateProfile(MemberVO member);
	
	public void updateMember_detail(MemberVO member);
}
