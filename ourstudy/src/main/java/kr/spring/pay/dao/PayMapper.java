package kr.spring.pay.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import kr.spring.pay.vo.PayVO;

public interface PayMapper {
	
	//결제
	@Select("SELECT pay_seq.nextval FROM dual")
	public int selectPay_num();
	@Insert("INSERT INTO pay pay_price VALUES #{pay_price}")
	public int insertPay_price(PayVO pay);
	//@Select("SELECT pay_plan FROM pay WHERE ")
	public int selectPay_plan(PayVO pay);
	public int insertTicket_time();
	
}
