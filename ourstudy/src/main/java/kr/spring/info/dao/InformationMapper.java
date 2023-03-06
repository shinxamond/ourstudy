package kr.spring.info.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


import kr.spring.info.vo.InformationVO;

@Mapper
public interface InformationMapper {
	
	@Select("SELECT information_seq.nextval FROM dual")
	public int selectInformation_num();
	@Select("SELECT * FROM information i JOIN member_detail d "
			  + "USING(mem_num) JOIN member_detail d "
			  + "USING(mem_num) WHERE i.info_num=#{info_num}")
	public InformationVO selectInformation(Integer info_num);
	
	//글목록
	public List<InformationVO> selectInfoList(Map<String,Object> map);
	public int selectinfoRowCount(Map<String,Object> map);
	
	//글등록
	@Insert("INSERT INTO information (info_num,info_date,info_title,"
			+ "info_content,info_pin,mem_num)" 
			+ "VALUES (information_seq.nextval,sysdate,#{info_title},"
			+ "#{info_content},#{info_pin},#{mem_num})")
	public void insertInformation(InformationVO info);

	//글수정

	public void updateInformation(InformationVO info);
	
	//글삭제
	@Delete("DELETE FROM information WHERE info_num=#{info_num}")
	public void deleteInformation(Integer info_num);
	@Update("UPDATE information SET uploadfile='',filename='' WHERE info_num=#{info_num}")
	public void deleteFile(Integer info_num);
	
	//필독 개수 체크
	@Select("SELECT COUNT(*) FROM information WHERE info_pin = 1")
	public int checkImportant();
}
