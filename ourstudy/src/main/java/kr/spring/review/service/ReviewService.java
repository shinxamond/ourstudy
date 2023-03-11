package kr.spring.review.service;

import java.util.List;
import java.util.Map;

import kr.spring.review.vo.ReviewReplyVO;
import kr.spring.review.vo.ReviewVO;

public interface ReviewService {
	/*==== 부모글 ====*/
	//이용후기 글개수
	public List<ReviewVO> selectList(Map<String,Object> map);
	//이용후기 글목록
	public int selectRowCount(Map<String,Object> map);	
	//이용후기 글쓰기
	public void insertReview(ReviewVO review);
	//이용후기 글상세
	public ReviewVO selectReview(Integer review_num);
	//이용후기 글수정
	public void updateReview(ReviewVO review);
	//이용후기 글삭제
	public void deleteReview(Integer review_num);
	//이용후기 이미지 삭제
	public void deleteFile(Integer review_num);
		
	/*==== 댓글 ====*/
	//댓글 목록
	public List<ReviewReplyVO> selectListReply(Map<String,Object> map);
	//댓글 개수
	public int selectRowCountReply(Map<String,Object> map);
	//댓글 상세
	public ReviewReplyVO selectReply(Integer re_num);
	//댓글 등록
	public void insertReply(ReviewReplyVO reviewReply);
	//댓글 수정
	public void updateReply(ReviewReplyVO reviewReply);
	//댓글 삭제
	public void deleteReply(Integer re_num);
}
