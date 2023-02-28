package kr.spring.pay.service;

import java.util.List;
import java.util.Map;

import kr.spring.pay.vo.PayVO;

public interface PayService {
	public int selectPay_num();
	public void insertPay(PayVO payVO);
	public List<PayVO> selectListPay(Map<String, Object> map);
	
	public int selectPoint(Integer mem_num);
	
	public PayVO selectPay(PayVO payVO);
}
