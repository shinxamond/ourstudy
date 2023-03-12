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
import kr.spring.admin.vo.AdminSalesVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;
import kr.spring.admin.vo.AdminTalkHistoryVO;

@Mapper
public interface AdminMapper {
	//현재 고객 현황판
	@Select("SELECT COUNT(*) FROM seat WHERE SEAT_STATUS=0")
	public int countUsingNum(); //이용중인 회원수
	
	@Select("SELECT COUNT(*) FROM seat WHERE SEAT_STATUS=2")
	public int countGoOutNum(); //외출중인 회원수	
		
	@Select("SELECT COUNT(*) FROM member_history WHERE MEM_TICKET_TERM IS NOT NULL")
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
	
	//일별 판매 정산판
	@Select("SELECT NVL(SUM(TICKET_PRICE), 0) FROM ticket t LEFT OUTER JOIN pay p "
			+ "ON t.ticket_num=p.ticket_num "
			+ "WHERE TICKET_KIND=1 AND TO_CHAR(PAY_DATE, 'YYYY-MM-DD') = TO_CHAR(sysdate, 'YYYY-MM-DD')")
	public int ticketSalesSum(); //이용권 판매 금액
		
	@Select("SELECT NVL(SUM(TICKET_PRICE), 0) FROM ticket t LEFT OUTER JOIN pay p "
			+ "ON t.ticket_num=p.ticket_num "
			+ "WHERE TICKET_KIND=2 AND TO_CHAR(PAY_DATE, 'YYYY-MM-DD') = TO_CHAR(sysdate, 'YYYY-MM-DD')")
	public int lockerSalesSum(); //사물함 판매 금액
	
	//판매기록목록
	public int selectSalesRowCount(Map<String,Object> map);
	public List<AdminSalesVO> selectSalesList(Map<String,Object> map);	
	
	//수신 채팅 히스토리
	public int selectReceiveRowCount(Map<String,Object> map);
	public List<AdminTalkHistoryVO> selectReceiveList(Map<String,Object> map);		
	
	//발신 채팅 히스토리
	public int selectSendRowCount(Map<String,Object> map);
	public List<AdminTalkHistoryVO> selectSendList(Map<String,Object> map);			
}


