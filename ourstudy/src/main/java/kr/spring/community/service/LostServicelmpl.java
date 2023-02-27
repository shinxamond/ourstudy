package kr.spring.community.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.community.dao.LostMapper;
import kr.spring.community.vo.LostReplyVO;
import kr.spring.community.vo.LostVO;

@Service
@Transactional
public class LostServicelmpl implements LostService {

	@Autowired
	private LostMapper lostMapper;
	
	@Override
	public LostVO selectLost(Integer lf_num) {
		return lostMapper.selectLost(lf_num);
	}

	@Override
	public List<LostVO> selectList(Map<String, Object> map) {
		return lostMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return lostMapper.selectRowCount(map);
	}

	@Override
	public void insertLost(LostVO lost) {
		lostMapper.insertLost(lost);
		
	}

	@Override
	public void updateLost(LostVO lost) {
		lostMapper.updateLost(lost);
		
	}

	@Override
	public void deleteLost(Integer lf_num) {
		lostMapper.deleteLost(lf_num);
		
	}

	@Override
	public void deleteLostFile(Integer lf_num) {
		lostMapper.deleteLostFile(lf_num);
		
	}

	@Override
	public List<LostReplyVO> selectListLostReply(Map<String, Object> map) {
		return lostMapper.selectListLostReply(map);
	}

	@Override
	public int selectRowCountLostReply(Map<String, Object> map) {
		return lostMapper.selectRowCountLostReply(map);
	}

	@Override
	public LostReplyVO selectLostReply(Integer re_num) {
		return lostMapper.selectLostReply(re_num);
	}

	@Override
	public void insertLostReply(LostReplyVO lostReply) {
		lostMapper.insertLostReply(lostReply);
		
	}

	@Override
	public void deleteLostReply(Integer lf_num) {
		lostMapper.deleteLostReply(lf_num);
		
	}

	@Override
	public void deleteLostReplyByLostNum(Integer lf_num) {
		lostMapper.deleteLostReplyByLostNum(lf_num);
		
	}
	
	
	
}
