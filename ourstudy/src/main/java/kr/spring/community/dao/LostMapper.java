package kr.spring.community.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.community.vo.LostReplyVO;
import kr.spring.community.vo.LostVO;


@Mapper
public interface LostMapper {
	
	@Select("SELECT lost_found_seq.nextval FROM dual")
	public int selectLost_num();
	@Select("SELECT * FROM lost_found l JOIN member_detail d "
			  + "USING(mem_num) JOIN member_detail d "
			  + "USING(mem_num) WHERE l.lf_num=#{lf_num}")
	public LostVO selectLost(Integer lf_num);
	
	//글목록
	public List<LostVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//글등록
	@Insert("INSERT INTO lost_found (lf_num,lf_type,"
			+"lf_title,lf_content,lf_item,lf_time,lf_loc,"
			+"f_condition,mem_num) "
			+"VALUES (lost_found_seq.nextval,#{lf_type},"
			+"#{lf_title},#{lf_content},#{lf_item},#{lf_time},#{lf_loc},"
			+"#{f_condition},#{mem_num})")
	public void insertLost(LostVO lost);
	
	//글수정 삭제
	public void updateLost(LostVO lost);
	@Delete("DELETE FROM lost_found WHERE lf_num=#{lf_num}")
	public void deleteLost(Integer lf_num);

	
	//댓글
	public List<LostReplyVO> selectListLostReply(Map<String,Object> map);
	@Select("SELECT reply_lost_seq.nextval FROM dual")
	public int selectRowCountLostReply(Map<String,Object> map);
	@Select("SELECT * FROM reply_lost WHERE re_num=#{re_num}")
	public LostReplyVO selectLostReply(Integer re_num);
	@Insert("INSERT INTO reply_lost (re_num,re_content,"
			  + "lf_num,mem_num) VALUES ("
			  + "reply_lost_seq.nextval,#{re_content},"
			  + "#{lf_num},#{mem_num})")
	public void insertLostReply(LostReplyVO lostReply);
	@Update("UPDATE reply_lost SET re_content=#{re_content}, re_modify_date=SYSDATE "
			  + "WHERE re_num=#{re_num}")
	public void updateLostReply(LostReplyVO lostReply);
	@Delete("DELETE FROM reply_lost WHERE re_num=#{re_num}")
	public void deleteLostReply(Integer lf_num);
	@Delete("DELETE FROM reply_lost WHERE lf_num=#{lf_num}")
	public void deleteLostReplyByLostNum(Integer lf_num);
}
