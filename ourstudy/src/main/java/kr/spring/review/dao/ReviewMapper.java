package kr.spring.review.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.review.vo.ReviewVO;

@Mapper
public interface ReviewMapper {
	/* ===부모글=== */
	//이용후기 글개수
	public List<ReviewVO> selectList(Map<String,Object> map);
	
	//이용후기 글목록
	public int selectRowCount(Map<String,Object> map);

	//이용후기 글쓰기
	@Insert("INSERT INTO review (r_num, r_title, r_content, r_rate, mem_num, r_img, r_imgname) "
		  + "VALUES (review_seq.nextval, #{r_title}, #{r_content}, #{r_rate}, #{mem_num}, #{r_img}, #{r_imgname})")
	public void insertReview(ReviewVO review);
	
	//이용후기 글상세
	@Select("SELECT r.*, mem_name FROM review r JOIN member_detail d ON r.mem_num=d.mem_num "
		  + "WHERE r.r_num=#{r_num}") 
	public ReviewVO selectReview(Integer review_num);
	
	public void updateReview(ReviewVO review);
	//@Delete("DELETE FROM spboard WHERE board_num=#{board_num}")
	public void deleteReview(Integer review_num);
	//@Update("UPDATE spboard SET uploadfile='',filename='' WHERE board_num=#{board_num}")
	public void deleteFile(Integer review_num);

}
