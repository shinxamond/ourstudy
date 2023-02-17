package kr.spring.ticket.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.ticket.dao.TicketMapper;
import kr.spring.ticket.vo.TicketVO;

@Service
@Transactional
public class TicketServiceImpl implements TicketService{
	
	@Autowired
	private TicketMapper ticketMapper;

	@Override
	public TicketVO selectTicket(Integer ticket_num) {
		return ticketMapper.selectTicket(ticket_num);
	}
	
	@Override
	public void insertTicket(TicketVO ticket) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTicket(TicketVO ticket) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTicket(Integer ticket_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TicketVO> selectList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
}
