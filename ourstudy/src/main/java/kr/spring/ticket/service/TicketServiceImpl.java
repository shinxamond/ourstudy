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
		ticketMapper.insertTicket(ticket);
		
	}

	@Override
	public void updateTicket(TicketVO ticket) {
		ticketMapper.updateTicket(ticket);
		
	}

	@Override
	public List<TicketVO> selectTicketList(Map<String, Object> map) {
		return ticketMapper.selectTicketList(map);
	}

	@Override
	public int selectTicketCount(Map<String, Object> map) {
		return ticketMapper.selectTicketCount(map);
	}

	@Override
	public List<TicketVO> selectAdminTicketList(Map<String, Object> map) {
		return ticketMapper.selectAdminTicketList(map);
	}

	@Override
	public void deleteTicket(int[] ticket_nums) {
		ticketMapper.deleteTicket(ticket_nums);
		
	}
}
