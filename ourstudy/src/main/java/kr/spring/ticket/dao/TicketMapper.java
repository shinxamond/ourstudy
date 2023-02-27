package kr.spring.ticket.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.ticket.vo.TicketVO;

@Mapper
public interface TicketMapper {
	
	@Select("SELECT ticket_seq.nextval FROM dual")
	public int selectTicket_num();
	//이용권 선택
	@Select("SELECT * FROM ticket WHERE ticket_num=#{ticket_num}")
	public TicketVO selectTicket(Integer ticket_num);
	//이용권 등록
	@Insert("INSERT INTO ticket (ticket_num,ticket_kind,"
		  + "ticket_name,ticket_type,ticket_price) VALUES "
		  + "(ticket_seq.nextval,#{ticket_kind},#{ticket_name},"
		  + "#{ticket_type},#{ticket_price})")
	public void insertTicket(TicketVO ticket);
	//이용권 수정
	@Update("UPDATE ticket SET ticket_kind=#{ticket_kind},"
			+ "ticket_name=#{ticket_name},ticket_type=#{ticket_type},"
			+ "ticket_price=#{ticket_price} WHERE ticket_num=#{ticket_num}")
	public void updateTicket(TicketVO ticket);
	//이용권 삭제
	@Delete("DELETE FROM ticket WHERE ticket_num=#{ticket_num}")
	public void deleteTicket(Integer ticket_num);
	//이용권 목록
	public List<TicketVO> selectTicketList(Map<String, Object> map);
	public int selectTicketCount(Map<String, Object> map);
	
}
