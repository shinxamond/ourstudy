package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminLockerHistoryVO;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;

public interface AdminService {
	//현재고객현황판
	public int countUsingNum();
	public int countTermNum();
	public int countTimeNum();

	//회원목록
	public List<AdminMemberVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//좌석히스토리목록
	public List<AdminSeatHistoryVO> selectSeatList(Map<String,Object> map);
	public int selectSeatRowCount(Map<String,Object> map);
	
	//사물함히스토리목록
	public List<AdminLockerHistoryVO> selectLockerList(Map<String,Object> map);
	public int selectLockerRowCount(Map<String,Object> map);	
}
