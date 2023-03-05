package kr.spring.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.review.vo.ReviewReplyVO;
import kr.spring.review.vo.ReviewVO;

@Mapper
public interface ReviewMapper {
	/*==== 부모글 ====*/	
	//이용후기 글개수
	public int selectRowCount(Map<String,Object> map);
	//이용후기 글목록
	public List<ReviewVO> selectList(Map<String,Object> map);	
	//이용후기 글쓰기
	@Insert("INSERT INTO review (r_num, r_title, r_content, r_rate, mem_num, r_img, r_imgname) "
		  + "VALUES (review_seq.nextval, #{r_title}, #{r_content}, #{r_rate}, #{mem_num}, #{r_img}, #{r_imgname})")
	public void insertReview(ReviewVO review);	
	//이용후기 글상세
	@Select("SELECT r.*, mem_name FROM review r JOIN member_detail d ON r.mem_num=d.mem_num "
		  + "WHERE r.r_num=#{r_num}") 
	public ReviewVO selectReview(Integer review_num);	
	//이용후기 글수정
	public void updateReview(ReviewVO review);	
	//이용후기 글삭제
	@Delete("DELETE FROM review WHERE r_num=#{r_num}")
	public void deleteReview(Integer review_num);
	//이용후기 이미지 삭제
	@Update("UPDATE review SET r_img='',r_imgname='' WHERE r_num=#{r_num}")
	public void deleteFile(Integer review_num);
	
	/*==== 댓글 ====*/
	//댓글 개수
	@Select("SELECT COUNT(*) FROM reply_review JOIN WHERE r_num=#{r_num}")
	public int selectRowCountReply(Map<String,Object> map);	
	//댓글 목록
	public List<ReviewReplyVO> selectListReply(Map<String,Object> map);
	//댓글 상세
	@Select("SELECT * FROM reply_review WHERE revw_num=#{revw_num}")
	public ReviewReplyVO selectReply(Integer re_num);
	//댓글 등록
	@Insert("INSERT INTO reply_review (revw_num, revw_content, r_num, mem_num) "
		  + "VALUES (reply_review_seq.nextval, #{revw_content}, #{r_num}, #{mem_num})")
	public void insertReply(ReviewReplyVO reviewReply);
	//댓글 수정
	@Update("UPDATE reply_review SET revw_content=#{revw_content}, revw_mdate=SYSDATE "
		  + "WHERE revw_num=#{revw_num}")
	public void updateReply(ReviewReplyVO reviewReply);
	//댓글 삭제
	@Delete("DELETE FROM reply_review WHERE revw_num=#{revw_num}")
	public void deleteReply(Integer re_num);
	
	//이용후기 삭제 시의 댓글 삭제
	@Delete("DELETE FROM reply_review WHERE r_num=#{r_num}")
	public void deleteReplyByReviewNum(Integer review_num);
}
