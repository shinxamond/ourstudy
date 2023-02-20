package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.admin.vo.AdminMemberVO;

@Mapper
public interface AdminMemberMapper {
	//회원관리 - 관리자
	public List<AdminMemberVO> selectList(Map<String,Object> map);
	
	public int selectRowCount(Map<String,Object> map);
}


