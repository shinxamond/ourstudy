package kr.spring.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.review.dao.ReviewMapper;
import kr.spring.review.vo.ReviewVO;

@Service
@Transactional
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Override
	public List<ReviewVO> selectList(Map<String, Object> map) {
		return reviewMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return reviewMapper.selectRowCount(map);
	}
	
	//이용후기 글쓰기
	@Override
	public void insertReview(ReviewVO review) {
		reviewMapper.insertReview(review);
	}

	@Override
	public ReviewVO selectReview(Integer review_num) {
		return reviewMapper.selectReview(review_num);
	}

	@Override
	public void updateReview(ReviewVO review) {
		reviewMapper.updateReview(review);
	}

	@Override
	public void deleteReview(Integer review_num) {
		//댓글 삭제
		//reviewMapper.deleteReplyByReviewNum(review_num);
		
		//부모글 삭제
		reviewMapper.deleteReview(review_num);
	}

	@Override
	public void deleteFile(Integer review_num) {
		reviewMapper.deleteFile(review_num);
	}	
}
