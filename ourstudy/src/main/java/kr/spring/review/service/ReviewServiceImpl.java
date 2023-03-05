package kr.spring.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.review.dao.ReviewMapper;
import kr.spring.review.vo.ReviewReplyVO;
import kr.spring.review.vo.ReviewVO;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private ReviewMapper reviewMapper;
	
	/*==== 부모글 ====*/
	//이용후기 글개수
	@Override
	public List<ReviewVO> selectList(Map<String, Object> map) {
		return reviewMapper.selectList(map);
	}	
	//이용후기 글목록
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return reviewMapper.selectRowCount(map);
	}	
	//이용후기 글쓰기
	@Override
	public void insertReview(ReviewVO review) {
		reviewMapper.insertReview(review);
	}	
	//이용후기 글상세
	@Override
	public ReviewVO selectReview(Integer review_num) {
		return reviewMapper.selectReview(review_num);
	}	
	//이용후기 글수정
	@Override
	public void updateReview(ReviewVO review) {
		reviewMapper.updateReview(review);
	}	
	//이용후기 글삭제
	@Override
	public void deleteReview(Integer review_num) {
		//댓글 삭제
		reviewMapper.deleteReplyByReviewNum(review_num);
		
		//부모글 삭제
		reviewMapper.deleteReview(review_num);
	}
	//이용후기 이미지 삭제
	@Override
	public void deleteFile(Integer review_num) {
		reviewMapper.deleteFile(review_num);
	}
	
	/*==== 댓글 ====*/
	//댓글 목록
	@Override
	public List<ReviewReplyVO> selectListReply(Map<String, Object> map) {
		return reviewMapper.selectListReply(map);
	}
	//댓글 개수
	@Override
	public int selectRowCountReply(Map<String, Object> map) {
		return reviewMapper.selectRowCountReply(map);
	}
	//댓글 상세
	@Override
	public ReviewReplyVO selectReply(Integer re_num) {
		return reviewMapper.selectReply(re_num);
	}
	//댓글 등록
	@Override
	public void insertReply(ReviewReplyVO reviewReply) {
		reviewMapper.insertReply(reviewReply);
	}
	//댓글 수정
	@Override
	public void updateReply(ReviewReplyVO reviewReply) {
		reviewMapper.updateReply(reviewReply);
	}
	//댓글 삭제
	@Override
	public void deleteReply(Integer re_num) {
		reviewMapper.deleteReply(re_num);
	}
}
