package kr.spring.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.main.dao.MainMapper;
import kr.spring.member.vo.MemberVO;

@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	private MainMapper mainMapper;
	
	public List<MemberVO> member_studyTime(Map<String,Object> map){
		return mainMapper.member_studyTime(map);
	}
}
