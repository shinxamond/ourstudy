package kr.spring.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;
import kr.spring.point.vo.PointVO;

@Mapper
public interface MypageMapper {
	/*==================================
            프로필 이미지 등록 및 수정
	====================================*/
	
	@Update("UPDATE member_detail SET mem_photo=#{mem_photo}, mem_photo_name = #{mem_photo_name} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);
	

	
	
	/*==================================
	             회원정보 수정
	====================================*/
	//회원정보 가져오기
	@Select("SELECT * FROM member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=#{mem_num}")
	public MemberVO selectMember(Integer mem_num);
	
	//회원 상세 정보 수정
	@Update("UPDATE member_detail SET mem_name = #{mem_name}, mem_phone = #{mem_phone}, mem_email = #{mem_email}, mem_zipcode = #{mem_zipcode}, mem_address1 = #{mem_address1}, mem_address2 = #{mem_address2}, mem_mdate = SYSDATE WHERE mem_num = #{mem_num}")
	public void updateMember_detail(MemberVO member);
	
	//회원 비밀번호 수정
	@Update("UPDATE member_detail SET mem_pw = #{mem_pw} WHERE mem_num = #{mem_num}")
	public void updatePassword(MemberVO member);
	
	//회원 탈퇴
	@Update("UPDATE member SET mem_auth = 0 WHERE mem_num = #{mem_num}")
	public void deleteMember(Integer mem_num);
	
	//회원 탈퇴
	@Delete("DELETE FROM member_detail WHERE mem_num = #{mem_num}")
	public void deleteMember_detail(Integer mem_num);
	
	
	
	
	/*==================================
                     포인트
    ====================================*/
	
	//포인트
	@Select("SELECT point_seq.nextval FROM dual")
	public int selectPoint_num();
	
	//포인트 합산하는 열 필요 없을 듯
	@Insert("INSERT INTO point (point_num, point_point, pay_num, mem_num) VALUES (#{point_num}, #{point_point}, #{pay_num}, #{mem_num})")
	public void insertPoint(PointVO point);
	
	//개인별 포인트 내역 확인
	//@Select("SELECT s.in_time, s.out_time, s.total_time, p.point_point, p.point_accrue FROM seat_detail s JOIN point p WHERE mem_num = #{mem_num}")
	//public List<PointVO> selectPointListByMemNum(Map<String, Object> map); - 나중에 페이징 처리 해야됨 xml에 작성
	@Select("SELECT y.pay_price, y.pay_plan, y.pay_date, y.pay_content, p.point_point FROM pay y JOIN point p ON y.pay_num = p.pay_num WHERE mem_num = #{mem_num}")
	public List<PointVO> selectPointListByMemNum(Map<String, Object> map);
	
	//합산 포인트 불러오기
	@Select("SELECT sum(point) FROM point WHERE mem_num = #{mem_num}")
	public int selectTotalPoint(int mem_num);
	
	
	
	
	/*==================================
    			    공부시간
	====================================*/	
	
	
	//좌석 이름 가져오기
	@Select("SELECT s.seat_name FROM seat s JOIN seat_detail d ON s.seat_num = d.seat_num WHERE mem_num = #{mem_num} AND d.total_time IS NULL")
	public String selectSeatName(Integer mem_num);
	
	//누적 공부시간 불러오기
	//@Select("SELECT mem_study FROM member_history WHERE mem_num = #{mem_num}")
	//public int selectAccrueStudyTime(MemberVO member);
	
	//공부 시간 누적
	//@Update("Update member_history SET mem_study = mem_study + #{total_time} WHERE mem_num = #{mem_num}") //나중에 seatVO에 mem_study 필드 추가해야될 수도 있음 그럼 #{mem_study} + #{total_time}으로 수정 // or 위에 누적 공부시간 불러오는 메서드 써서 데이터 가져온 다음 java로 연산해서 update
	//public void updateStudyTime(SeatVO seat);
	
	
	//잔여 시간 불러오기 - 저장될 때 ms 단위로 되면 num길이 늘려야될수도 + update 되는거니까 디폴트값 0으로 변경
	//@Select("SELECT mem_study FROM member_history WHERE mem_num = #{mem_num}")
	//public int selectRemainTime(MemberVO member);
	
	//잔여 시간 업데이트
	//@Update("UPDATE member_history SET mem_study = mem_study + #{total_time} WHERE mem_num = #{mem_num}") //마찬가지
	//public void updateRemainTime(MemberVO member);
}
