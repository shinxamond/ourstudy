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
	
	//아이디 찾기
	public String[] find_id(String mem_name, String mem_email);
	//비밀번호 찾기
	public String find_pw(String mem_id, String mem_email);
	
	//회원번호 불러오기 (seatAdminController에서 사용)
	public String getMem_name(int mem_num);
	
}