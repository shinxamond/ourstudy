package kr.spring.mypage.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.community.vo.LostVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.mypage.dao.MypageMapper;
import kr.spring.pay.vo.PayVO;
import kr.spring.point.vo.PointVO;
import kr.spring.seat.vo.SeatVO;

@Service
@Transactional
public class MypageServiceImpl implements MypageService{

	@Autowired
	private MypageMapper mypageMapper;
	
	@Override
	public MemberVO selectMember(Integer mem_num) {
		return mypageMapper.selectMember(mem_num);
	}

	@Override
	public void updateProfile(MemberVO member) {
		mypageMapper.updateProfile(member);
	}

	@Override
	public void updateMember_detail(MemberVO member) {
		mypageMapper.updateMember_detail(member);
	}

	@Override
	public void updatePassword(MemberVO member) {
		mypageMapper.updatePassword(member);
	}

	@Override
	public void deleteMember(Integer mem_num) {
		mypageMapper.deleteMember(mem_num);
		mypageMapper.deleteMember_detail(mem_num);
	}

	@Override
	public int selectPointListCountByMemNum(Map<String, Object> map) {
		return mypageMapper.selectPointListCountByMemNum(map);
	}
	
	@Override
	public List<PayVO> selectPointListByMemNum(Map<String, Object> map) {
		return mypageMapper.selectPointListByMemNum(map);
	}

	@Override
	public Integer selectTotalPoint(int mem_num) {
		return mypageMapper.selectTotalPoint(mem_num);
	}

	@Override
	public SeatVO selectCurSeat(Integer mem_num) {
		return mypageMapper.selectCurSeat(mem_num);
	}

	@Override
	public int selectSeatDetailRowCount(Integer mem_num) {
		return mypageMapper.selectSeatDetailRowCount(mem_num);
	}

	@Override
	public List<SeatVO> selectSeatDetailListByMem_num(Map<String, Object> map) {
		return mypageMapper.selectSeatDetailListByMem_num(map);
	}

	@Override
	public int selectAccrueStudyTime(MemberVO member) {
		return mypageMapper.selectAccrueStudyTime(member);
	}

	@Override
	public void updateStudyTime(SeatVO seat) {
		mypageMapper.updateStudyTime(seat);
	}

	@Override
	public void insertPoint(PayVO payVO) {
		mypageMapper.insertPoint(payVO);
	}
	
	@Override
	public float selectRemainTime(Integer mem_num) {
		return mypageMapper.selectRemainTime(mem_num);
	}

	//////////////나중에 지울것////////////////////////////
	@Override
	public void deleteSomething(Integer mem_num) {
		mypageMapper.deleteHistory(mem_num);
		mypageMapper.deleteSeatHistory(mem_num);
	}

	@Override
	public String selectRegDate(Integer mem_num) {
		return mypageMapper.selectRegDate(mem_num);
	}

	@Override
	public int selectSumTotalTimeForGraph(String weekStart, String weekEnd, Integer mem_num) {
		Integer result;
		try {
			result = mypageMapper.selectSumTotalTimeForGraph(weekStart, weekEnd, mem_num);
			return result;
		}catch(Exception e) {
			result = 0;
			return result;
		}
	}

	@Override
	public void updateRegDate() {
		mypageMapper.updateRegDate();
	}

	@Override
	public int selectLockerNumByMem_num(Integer mem_num) {
		try {
			return mypageMapper.selectLockerNumByMem_num(mem_num);
		}catch(Exception e) {
			return 0;
		}
	}

	@Override
	public List<LostVO> getLostFoundList(Integer mem_num) {
		return mypageMapper.getLostFoundList(mem_num);
	}

	@Override
	public String selectRemainTimeTerm(Integer mem_num) {
		return mypageMapper.selectRemainTimeTerm(mem_num);
	}






}
