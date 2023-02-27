package kr.spring.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.admin.dao.AdminMapper;
import kr.spring.admin.vo.AdminItemHistoryVO;
import kr.spring.admin.vo.AdminLockerHistoryVO;
import kr.spring.admin.vo.AdminMemberVO;
import kr.spring.admin.vo.AdminSalesVO;
import kr.spring.admin.vo.AdminSeatHistoryVO;

@Service
@Transactional
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminMapper adminMapper;
	
	//현재고객현황판
	@Override
	public int countUsingNum() {
		return adminMapper.countUsingNum();
	}

	@Override
	public int countTermNum() {
		return adminMapper.countTermNum();
	}

	@Override
	public int countTimeNum() {
		return adminMapper.countTimeNum();
	}

	//회원목록
	@Override
	public List<AdminMemberVO> selectList(Map<String, Object> map) {
		return adminMapper.selectList(map);
	}
	
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return adminMapper.selectRowCount(map);
	}	
	
	//좌석 히스토리목록
	@Override
	public List<AdminSeatHistoryVO> selectSeatList(Map<String, Object> map) {
		return adminMapper.selectSeatList(map);
	}
	
	@Override
	public int selectSeatRowCount(Map<String, Object> map) {
		return adminMapper.selectSeatRowCount(map);
	}

	//사물함 히스토리목록
	@Override
	public List<AdminLockerHistoryVO> selectLockerList(Map<String, Object> map) {
		return adminMapper.selectLockerList(map);
	}
	
	@Override
	public int selectLockerRowCount(Map<String, Object> map) {
		return adminMapper.selectLockerRowCount(map);
	}
	
	//물품대여 히스토리목록
	@Override
	public List<AdminItemHistoryVO> selectItemList(Map<String, Object> map) {
		return adminMapper.selectItemList(map);
	}

	@Override
	public int selectItemRowCount(Map<String, Object> map) {
		return adminMapper.selectItemRowCount(map);
	}

	//미반납자 목록
	@Override
	public List<AdminItemHistoryVO> selectUnreturnList(Map<String, Object> map) {
		return adminMapper.selectUnreturnList(map);
	}

	@Override
	public int selectUnreturnRowCount(Map<String, Object> map) {
		return adminMapper.selectUnreturnRowCount(map);
	}
	
	//일별판매정산판
	@Override
	public int ticketSalesSum() {
		return adminMapper.ticketSalesSum();
	}

	@Override
	public int lockerSalesSum() {
		return adminMapper.lockerSalesSum();
	}
	
	//판매기록목록
	@Override
	public List<AdminSalesVO> selectSalesList(Map<String, Object> map) {
		return adminMapper.selectSalesList(map);
	}

	@Override
	public int selectSalesRowCount(Map<String, Object> map) {
		return adminMapper.selectSalesRowCount(map);
	}
	
}
