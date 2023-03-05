package kr.spring.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;
import kr.spring.seat.vo.SeatVO;


@Mapper
public interface MainMapper {
	
	//누적시간 차트
	@Select("SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT mem_name, (mem_study/3600) mem_study FROM member_detail JOIN member_history USING(mem_num) ORDER BY mem_study DESC)a) WHERE rownum<=5 ")
	public List<MemberVO> member_studyTime(Map<String, Object> map);
	
	public List<SeatVO> member_Rank(@Param(value = "member_list") int[] member_list, @Param(value = "weekStart") String weekStart, @Param(value = "weekEnd") String weekEnd);
	
	//seat_detail에 입실 기록 있는 mem_num 가져오기
	@Select("SELECT mem_num FROM seat_detail")
	public int[] setMemberArray();
}
