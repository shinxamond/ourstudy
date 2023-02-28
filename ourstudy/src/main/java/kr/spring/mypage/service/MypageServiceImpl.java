package kr.spring.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	/* 여기 서비스 말고 결제에서 mypagemapper 주입받고 결제 정보에 따라 point 계산해서 insert
	 * @Override public void insertPoint(PointVO point) {
	 * point.setPoint_num(mypageMapper.selectPoint_num());
	 * mypageMapper.insertPoint(point); }
	 */

	@Override
	public List<PointVO> selectPointListByMemNum(Map<String, Object> map) {
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


}
