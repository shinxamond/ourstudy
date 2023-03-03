package kr.spring.info.service;

import java.util.List;
import java.util.Map;

import kr.spring.info.vo.InformationVO;

public interface InformationService {

	public InformationVO selectInformation(Integer info_num);
	public int selectinfoRowCount(Map<String,Object> map);
	public List<InformationVO> selectInfoList(Map<String,Object> map);
	public void insertInformation(InformationVO info);
	public void updateInformation(InformationVO info);
	public void deleteInformation(Integer info_num);
	public void deleteFile(Integer info_num);

}
