package kr.spring.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.spring.main.dao.MainMapper;
import kr.spring.member.vo.MemberVO;
import kr.spring.seat.vo.SeatVO;

@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	private MainMapper mainMapper;

	@Override
	public int[] setMemberArray() {
		return mainMapper.setMemberArray();
	}

	@Override
	public List<MemberVO> member_studyTime(Map<String, Object> map) {
		return mainMapper.member_studyTime(map);
	}

	@Override
	public List<SeatVO> member_Rank(int[] member_list, String weekStart, String weekEnd) {
		return mainMapper.member_Rank(member_list, weekStart, weekEnd);
	}
	

}
