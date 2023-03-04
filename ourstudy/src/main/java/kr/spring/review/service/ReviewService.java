package kr.spring.review.service;

import java.util.List;
import java.util.Map;

import kr.spring.review.vo.ReviewVO;

public interface ReviewService {
	/* ===부모글=== */
	public List<ReviewVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//이용후기 글쓰기
	public void insertReview(ReviewVO board);
	
	public ReviewVO selectReview(Integer board_num);
	public void updateReview(ReviewVO board);
	public void deleteReview(Integer board_num);
	public void deleteFile(Integer board_num);
}
