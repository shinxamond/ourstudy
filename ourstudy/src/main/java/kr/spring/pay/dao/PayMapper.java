package kr.spring.pay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;
import kr.spring.pay.vo.PayVO;
import kr.spring.ticket.vo.TicketVO;

@Mapper
public interface PayMapper {

	//결제
	@Select("SELECT pay_seq.nextval FROM dual")
	public int selectPay_num();
	@Insert("INSERT INTO pay (pay_num,pay_price,pay_plan,"
		  + "pay_content,pay_date,mem_num,ticket_num)"
		  + " VALUES (#{pay_num},#{pay_price},#{pay_plan},"
		  + "#{pay_content},SYSDATE,#{mem_num},#{ticket_num})")
	public void insertPay(PayVO payVO);
	public List<PayVO> selectListPay(Map<String, Object> map);

	//포인트
	@Select("SELECT point_accrue FROM point WHERE mem_num=#{mem_num}")
	public int selectPoint(Integer mem_num);
	
	//이용권 시간 계산
	@Select("SELECT * FROM ticket WHERE ticket_num=#{ticket_num}")
	public TicketVO selectTicket(Integer ticket_num);
	@Update("UPDATE member_history SET mem_ticket_term=mem_ticket_term+#{time} "
		  + "WHERE mem_num=#{mem_num}")
	public void updateMemberHistory_Term(@Param(value="time") Integer time, 
			   							@Param(value="mem_num") Integer mem_num);
	@Update("UPDATE member_history SET mem_ticket_hour=mem_ticket_hour+#{time} "
		  + "WHERE mem_num=#{mem_num}")
	public void updateMemberHistory_Hour(@Param(value="time") Integer time, 
										@Param(value="mem_num") Integer mem_num);
	public int insertTicketTime();

}

