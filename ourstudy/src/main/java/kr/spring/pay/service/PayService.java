package kr.spring.pay.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.spring.locker.vo.LockerVO;
import kr.spring.pay.vo.PayVO;
import kr.spring.ticket.vo.TicketVO;

public interface PayService {
	public int selectPay_num();
	public void insertPay(PayVO payVO);
	public List<PayVO> selectListPay(Map<String, Object> map);
	
	public int selectPoint(Integer mem_num);
	
	//이용권 시간 계산
	public TicketVO selectTicket(Integer ticket_num);
	public void updateMemberHistory_Term(Integer time, Integer mem_num);
	public void updateMemberHistory_Hour(Integer time, Integer mem_num);
	public void updateLocker_end(LockerVO lockerVO);
	public String selectLockerEnd(Integer mem_num);
	public void insertNewLockerMember(PayVO payVO);
	//라커 구매 시 이미 라커 보유중인지 체크
	public int checkUsingLocker(Integer mem_num);
}
