package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.admin.vo.AdminItemHistoryVO;
import kr.spring.admin.vo.AdminLockerHistoryVO;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.admin.vo.AdminSalesVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;
import kr.spring.admin.vo.AdminTalkHistoryVO;

public interface AdminService { 
	//현재고객현황판
	public int countUsingNum();
	public int countTermNum();
	public int countTimeNum();

	//회원목록
	public List<AdminMemberVO> selectList(Map<String,Object> map);
	public int selectRowCount(Map<String,Object> map);
	
	//좌석 히스토리목록
	public List<AdminSeatHistoryVO> selectSeatList(Map<String,Object> map);
	public int selectSeatRowCount(Map<String,Object> map);
	
	//사물함 히스토리목록
	public List<AdminLockerHistoryVO> selectLockerList(Map<String,Object> map);
	public int selectLockerRowCount(Map<String,Object> map);	
	
	//물품대여 히스토리목록
	public List<AdminItemHistoryVO> selectItemList(Map<String,Object> map);
	public int selectItemRowCount(Map<String,Object> map);		
	
	//미반납자 목록
	public List<AdminItemHistoryVO> selectUnreturnList(Map<String,Object> map);
	public int selectUnreturnRowCount(Map<String,Object> map);	
	
	//현재고객현황판
	public int ticketSalesSum();
	public int lockerSalesSum();

	//판매기록목록
	public List<AdminSalesVO> selectSalesList(Map<String,Object> map);
	public int selectSalesRowCount(Map<String,Object> map);	
	
	//수신 채팅 히스토리
	public List<AdminTalkHistoryVO> selectReceiveList(Map<String,Object> map);
	public int selectReceiveRowCount(Map<String,Object> map);		
	
}
