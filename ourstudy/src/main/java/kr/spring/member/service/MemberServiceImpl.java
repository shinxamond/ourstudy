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
	}

	@Override
	public MemberVO selectCheckMember(String mem_id) {
		return memberMapper.selectCheckMember(mem_id);
	}

	@Override
	public void updateAuto_id(String auto_id, String mem_id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberVO selectAuto_id(String auto_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteAuto_id(int mem_num) {
		// TODO Auto-generated method stub
		
	}

}
