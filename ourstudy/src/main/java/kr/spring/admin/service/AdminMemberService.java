package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminMemberVO;

public interface AdminMemberService {
	//현재고객현황판
	public int countUsingNum();
	public int countTermNum();
	public int countTimeNum();
	
	//회원목록
	public List<AdminMemberVO> selectList(
			Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
}
