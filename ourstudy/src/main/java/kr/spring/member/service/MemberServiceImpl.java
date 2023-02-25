package kr.spring.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.MemberVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
		memberMapper.insertMember_history(member);
	}

	@Override
	public MemberVO selectCheckMember(String mem_id) {
		return memberMapper.selectCheckMember(mem_id);
	}

	@Override
	public void updateAuto_id(String auto_id, String mem_id) {
		memberMapper.updateAuto_id(auto_id, mem_id);
	}

	@Override
	public MemberVO selectAuto_id(String auto_id) {
		return memberMapper.selectAuto_id(auto_id);
	}

	@Override
	public void deleteAuto_id(int mem_num) {
		memberMapper.deleteAuto_id(mem_num);
		
	}

	@Override
	public String getMem_name(int mem_num) {
		return memberMapper.getMem_name(mem_num);
	}

	@Override
	public String[] find_id(String mem_name, String mem_email) {
		return memberMapper.find_id(mem_name, mem_email);
	}
	
	@Override
	public String find_pw(String mem_id, String mem_email) {
		return memberMapper.find_pw(mem_id, mem_email);
	}
	
}
