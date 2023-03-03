package kr.spring.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;


@Mapper
public interface MainMapper {
	
	//누적시간 차트
	@Select("SELECT mem_name, mem_study FROM member_detail JOIN member_history USING(mem_num) ORDER BY mem_study DESC")
	public List<MemberVO> member_studyTime(Map<String,Object> map);
	
}
