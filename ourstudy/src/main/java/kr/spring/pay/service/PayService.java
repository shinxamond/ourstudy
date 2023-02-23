package kr.spring.pay.service;

import java.util.List;
import java.util.Map;

import kr.spring.pay.vo.PayVO;

public interface PayService {
	public int selectPay_num();
	public int insertPay(PayVO pay);
	public List<PayVO> selectListPay(Map<String, Object> map);
	public PayVO selectPay(PayVO payVO);
}
