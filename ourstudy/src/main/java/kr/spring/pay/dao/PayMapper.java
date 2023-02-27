package kr.spring.pay.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.pay.vo.PayVO;
import kr.spring.point.vo.PointVO;

@Mapper
public interface PayMapper {

	//결제
	@Select("SELECT pay_seq.nextval FROM dual")
	public int selectPay_num();
	public int insertPay(PayVO pay);
	public List<PayVO> selectListPay(Map<String, Object> map);
	public PayVO selectPay(PayVO payVO);

	//포인트
	@Select("SELECT point_accrue FROM point WHERE mem_num=#{mem_num}")
	public int selectPoint(Integer mem_num);
	@Update("UPDATE point SET point_accrue=#{point_accrue} WHERE mem_num=#{mem_num}")
	public int updatePoint(Integer mem_num);

	//이용권 시간 계산
	public int insertTicket_time();

}

