package kr.spring.locker.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.locker.vo.LockerVO;

@Mapper
public interface LockerMapper {
	/*==================================
				ADMIN
	====================================*/
	//사물함 번호
	@Select("SELECT locker_info_seq.nextval FROM dual")
	public int selectLocker_num();
	//좌석 등록
	@Insert("INSERT INTO LOCKER_INFO(locker_num) VALUES(#{locker_num})")
	public void insertLocker(LockerVO vo);

	/*==================================
     			MEMBER
	==================================*/
	//사물함 선택
	//사물함 회원정보,이용시작시간 자동입력 (사물함을 선택했을 때)
	@Insert("INSERT INTO LOCKER_DETAIL (locker_detail_num,locker_num,mem_num,mem_name) VALUES(locker_detail_seq.nextval,#{locker_num},#{mem_num},#{mem_name})")
	public void insertToSelectLocker(LockerVO vo);
	
	/*==================================
     			IN / OUT / DATE
	==================================*/
	//이용시작 시간 + 1주/2주/4주
	//이용시작 시간 추출
	@Select("SELECT TO_CHAR(locker_start, 'yyyy-MM-dd HH24:MI:SS') locker_start FROM LOCKER_DETAIL WHERE mem_num=#{mem_num} AND locker_diff IS NULL")
	public String getLocker_start(LockerVO vo);
	//종료시간, 남은시간 입력
	@Update("UPDATE LOCKER_DETAIL SET locker_end=TO_DATE(#{locker_end},'yy/MM/dd hh24:mi:ss'),locker_diff=#{locker_diff} WHERE mem_num=#{mem_num} AND locker_diff IS NULL")
	public void insertEndAndDiff(LockerVO vo);
	//사용불가상태
	@Update("UPDATE LOCKER_INFO SET locker_status=0 WHERE locker_num=#{locker_num}")
	public void lockerStatusIn(LockerVO vo);
	//사용가능상태
	@Update("UPDATE LOCKER_INFO SET locker_status=1 WHERE locker_num=#{locker_num}")
	public void lockerStatusOut(LockerVO vo);
	
	/*==================================
     			GET DATA
	==================================*/
	//사물함 정보 불러오기
	@Select("SELECT * FROM LOCKER_INFO ORDER BY LOCKER_NUM ASC")
	public List<LockerVO> getLockerList();
	
	//기존에 등록된 사물함 check 갯수 불러오기
	@Select("SELECT count(*) FROM LOCKER_INFO i JOIN (SELECT * FROM LOCKER_DETAIL WHERE mem_num=#{mem_num}) d ON d.locker_num=i.locker_num WHERE i.locker_status=0")
	public int getMyLockerCount(int mem_num);
}
