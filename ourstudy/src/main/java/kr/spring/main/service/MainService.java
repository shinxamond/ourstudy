package kr.spring.main.service;

import java.util.List;
import java.util.Map;

import kr.spring.member.vo.MemberVO;

public interface MainService {
	public List<MemberVO> member_studyTime(Map<String,Object> map);
}
