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
	==================================*/
	//사물함 번호
	@Select("SELECT locker_info_seq.nextval FROM dual")
	public int selectLocker_num();
	//좌석 등록
	@Insert("INSERT INTO LOCKER_INFO(locker_num) VALUES(locker_info_seq.nextval)")
	public void insertLocker(LockerVO vo);

	/*==================================
     			MEMBER
	==================================*/
	//사물함 선택 
	@Select("SELECT locker_detail_seq.nextval FROM DUAL")
	public int selectLocker_Detail_num();
	//사물함 이용시작시간 입력 (사물함을 선택했을 때)
	@Insert("INSERT INTO LOCKER_DETAIL (locker_detail_num,locker_num,mem_num,mem_name) VALUES(locker_detail_seq.nextval,#{locker_num},#{mem_num},#{mem_name})")
	public void insertToSelectLocker(LockerVO vo);
	
	/*==================================
     			IN / OUT / DATE
	==================================*/
	//이용시작 시간 + 1주/2주/4주
	//사용불가상태
	@Update("UPDATE LOCKER_INFO SET locker_status=0 WHERE locker_num=#{locker_num}")
	public void lockerStatusIn(LockerVO vo);
	//사용가능상태
	@Update("UPDATE LOCKER_INFO SET locker_status=1 WHERE locker_num=#{locker_num}")
	public void lockerStatusOut(int locker_num);
	
	/*==================================
     			GET DATA
	==================================*/
	//사물함 정보 불러오기
	@Select("SELECT * FROM LOCKER_INFO")
	public List<LockerVO> getLockerList();
}
