package kr.spring.community.service;

import java.util.List;
import java.util.Map;


import kr.spring.community.vo.LostReplyVO;
import kr.spring.community.vo.LostVO;

public interface LostService {
	
	public LostVO selectLost(Integer lf_num);
	public List<LostVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	public void insertLost(LostVO lost);
	public void updateLost(LostVO lost);
	public void deleteLost(Integer lf_num);
	
	
	//댓글
	public List<LostReplyVO> selectListLostReply(Map<String,Object> map);
	public int selectRowCountLostReply(Map<String,Object> map);
	public LostReplyVO selectLostReply(Integer re_num);
	public void insertLostReply(LostReplyVO lostReply);
	public void deleteLostReply(Integer lf_num);
	public void deleteLostReplyByLostNum(Integer lf_num);
	public void updateLostReply(LostReplyVO lostReply);
	
	
}
