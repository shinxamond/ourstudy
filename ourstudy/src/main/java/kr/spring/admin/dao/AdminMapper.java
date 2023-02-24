package kr.spring.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.admin.vo.AdminItemHistoryVO;
import kr.spring.admin.vo.AdminLockerHistoryVO;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;

@Mapper
public interface AdminMapper {
	//현재 고객 현황판
	@Select("SELECT COUNT(*) FROM seat WHERE SEAT_STATUS!=1")
	public int countUsingNum(); //현재 이용중인 회원수
		
	@Select("SELECT COUNT(*) FROM member_history WHERE MEM_TICKET_TERM>0")
	public int countTermNum(); //기간권 회원수
	
	@Select("SELECT COUNT(*) FROM member_history WHERE MEM_TICKET_HOUR>0")
	public int countTimeNum(); //시간권 회원수
	
	//회원목록
	public int selectRowCount(Map<String,Object> map);
	public List<AdminMemberVO> selectList(Map<String,Object> map);
	
	//좌석 히스토리목록
	public int selectSeatRowCount(Map<String,Object> map);
	public List<AdminSeatHistoryVO> selectSeatList(Map<String,Object> map);	
	
	//사물함 히스토리목록
	public int selectLockerRowCount(Map<String,Object> map);
	public List<AdminLockerHistoryVO> selectLockerList(Map<String,Object> map);	
	
	//물품대여 히스토리목록
	public int selectItemRowCount(Map<String,Object> map);
	public List<AdminItemHistoryVO> selectItemList(Map<String,Object> map);	
	
	//미반납자 목록
	public int selectUnreturnRowCount(Map<String,Object> map);
	public List<AdminItemHistoryVO> selectUnreturnList(Map<String,Object> map);	
}


