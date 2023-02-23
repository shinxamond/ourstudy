package kr.spring.pay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import kr.spring.pay.vo.PayVO;

@Mapper
public interface PayMapper {
	
	//결제
	@Select("SELECT pay_seq.nextval FROM dual")
	public int selectPay_num();
	@Insert("INSERT INTO pay (pay_num,item_num,"
		  + "mem_num,pay_plan) VALUES "
		  + "(pay_seq.nextval,#{item_num},#{mem_num},"
		  + "#{pay_plan})")
	public int insertPay(PayVO pay);
	public List<PayVO> selectListPay(Map<String, Object> map);
	public PayVO selectPay(PayVO payVO);
	
	//이용권 시간 계산
	public int insertTicket_time();
	
}
