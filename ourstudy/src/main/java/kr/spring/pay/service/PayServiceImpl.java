package kr.spring.pay.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.pay.dao.PayMapper;
import kr.spring.pay.vo.PayVO;
import kr.spring.point.vo.PointVO;

@Service
@Transactional
public class PayServiceImpl implements PayService{
	
	@Autowired
	private PayMapper payMapper;

	@Override
	public int selectPay_num() {
		return payMapper.selectPay_num();
	}

	@Override
	public PayVO insertPay(PayVO payVO) {
		return payMapper.insertPay(payVO);
	}

	@Override
	public List<PayVO> selectListPay(Map<String, Object> map) {
		return payMapper.selectListPay(map);
	}
	
	@Override
	public PayVO selectPay(PayVO payVO) {
		return payMapper.selectPay(payVO);
	}

	@Override
	public int selectPoint(Integer mem_num) {
		return payMapper.selectPoint(mem_num);
	}

}

