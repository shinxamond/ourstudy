package kr.spring.member.service;

import kr.spring.member.vo.MemberVO;

public interface MemberService {

	//회원가입
	public void insertMember(MemberVO member);

	//아이디 중복 체크
	public MemberVO selectCheckMember(String mem_id);

	//자동로그인
	public void updateAuto_id(String auto_id, String mem_id);
	public MemberVO selectAuto_id(String auto_id);
	public void deleteAuto_id(int mem_num);
}
