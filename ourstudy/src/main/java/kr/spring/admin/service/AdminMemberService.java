package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminMemberVO;

public interface AdminMemberService {
	//회원관리 - 관리자
	public List<AdminMemberVO> selectList(
			Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
}
