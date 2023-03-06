package kr.spring.info.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.info.vo.InformationVO;
import kr.spring.info.dao.InformationMapper;


@Service
@Transactional
public class InformationServicelmpl implements InformationService{

	@Autowired
	private InformationMapper informationMapper;
	
	@Override
	public InformationVO selectInformation(Integer info_num) {
		return informationMapper.selectInformation(info_num);
	}

	@Override
	public int selectinfoRowCount(Map<String, Object> map) {
		return informationMapper.selectinfoRowCount(map);
	}

	@Override
	public List<InformationVO> selectInfoList(Map<String, Object> map) {
		return informationMapper.selectInfoList(map);
	}

	@Override
	public void insertInformation(InformationVO info) {
		informationMapper.insertInformation(info);
		
	}

	@Override
	public void updateInformation(InformationVO info) {
		informationMapper.updateInformation(info);
		
	}

	@Override
	public void deleteInformation(Integer info_num) {
		informationMapper.deleteInformation(info_num);		
	}

	@Override
	public void deleteFile(Integer info_num) {
		informationMapper.deleteFile(info_num);
		
	}

	@Override
	public int checkImportant() {
		return informationMapper.checkImportant();
	}
	
	
	/*
	 * @Override public List<InformationVO> notice(Integer info_pin) { return
	 * informationMapper.notice(); }
	 */
}
