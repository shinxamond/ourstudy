package kr.spring.pay.dao;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.locker.vo.LockerVO;
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
	//이용권 정보 가져오기
	@Select("SELECT * FROM ticket WHERE ticket_num=#{ticket_num}")
	public TicketVO selectTicket(Integer ticket_num);
	//독서실 기간권 계산
	@Update("UPDATE member_history SET mem_ticket_term=mem_ticket_term+#{time} "
		  + "WHERE mem_num=#{mem_num}")
	public void updateMemberHistory_Term(@Param(value="time") Integer time, 
			   							@Param(value="mem_num") Integer mem_num);
	//독서실 시간권 계산
	@Update("UPDATE member_history SET mem_ticket_hour=mem_ticket_hour+#{time} "
		  + "WHERE mem_num=#{mem_num}")
	public void updateMemberHistory_Hour(@Param(value="time") Integer time, 
										@Param(value="mem_num") Integer mem_num);
	
	//사물함 시간 계산
	@Insert("INSERT INTO LOCKER_DETAIL (locker_detail_num,locker_num,mem_num,mem_name,locker_end) VALUES(locker_detail_seq.nextval,#{locker_num},#{mem_num},#{mem_name},#{locker_end})")
	public void insertNewLockerMember(PayVO payVO);
	@Update("UPDATE locker_detail SET locker_end= #{locker_end} "
		  + "WHERE mem_num=#{mem_num}")
	public void updateLocker_end(LockerVO lockerVO);
	//사물함 이용자 locker_end 불러오기
	@Select("SELECT locker_end FROM locker_detail WHERE mem_num = #{mem_num}")
	public String selectLockerEnd(Integer mem_num);
	@Select("SELECT mem_num FROM locker_detail WHERE mem_num = #{mem_num}")
	public int checkUsingLocker(Integer mem_num);
	
}

