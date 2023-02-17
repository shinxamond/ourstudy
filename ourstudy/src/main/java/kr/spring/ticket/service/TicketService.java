package kr.spring.ticket.service;

import java.util.List;
import java.util.Map;

import kr.spring.ticket.vo.TicketVO;

public interface TicketService {

	//이용권 선택
	public TicketVO selectTicket(Integer ticket_num);
	//이용권 등록
	public void insertTicket(TicketVO ticket);
	//이용권 수정
	public void updateTicket(TicketVO ticket);
	//이용권 삭제
	public void deleteTicket(Integer ticket_num);
	//이용권 목록
	public List<TicketVO> selectList(Map<String, Object> map);

}
