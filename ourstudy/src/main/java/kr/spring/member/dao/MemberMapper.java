package kr.spring.member.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.member.vo.MemberVO;

@Mapper
public interface MemberMapper {
	//회원관리 - 일반회원
	@Select("SELECT member_seq.nextval FROM dual")
	public int selectMem_num();

	//회원가입
	@Insert("INSERT INTO member (mem_num,mem_id) VALUES (#{mem_num},#{mem_id})")
	public void insertMember(MemberVO member);
	@Insert("INSERT INTO member_detail (mem_num,mem_name,mem_pw,mem_phone,mem_email,mem_zipcode,mem_address1,mem_address2) VALUES"
			+ " (#{mem_num},#{mem_name},#{mem_pw},#{mem_phone},#{mem_email},#{mem_zipcode},#{mem_address1},#{mem_address2})")
	public void insertMember_detail(MemberVO member);

	//아이디 중복 체크
	@Select("SELECT m.mem_num,m.mem_id,m.mem_auth,m.auto_id,d.mem_pw,d.mem_email FROM member m "
			+ "LEFT OUTER JOIN member_detail d ON m.mem_num=d.mem_num WHERE m.mem_id=#{mem_id}")
	public MemberVO selectCheckMember(String mem_id);

	//자동로그인
	@Update("UPDATE member SET auto_id=#{auto_id} WHERE mem_id=#{mem_id}")
	public void updateAuto_id(@Param("auto_id") String auto_id, @Param("mem_id") String mem_id);
	@Select("SELECT m.mem_num,m.mem_id,m.mem_auth,m.auto_id,d.mem_pw,d.mem_email FROM "
			+ "member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE m.auto_id=#{auto_id}")
	public MemberVO selectAuto_id(String auto_id);
	//비밀번호를 변경하면 자동로그인이 해제되도록 처리. Auto_id만 지우는 거라 DELETE가 아닌 UPDATE
	@Update("UPDATE member SET auto_id='' WHERE mem_num=#{mem_num}")
	public void deleteAuto_id(int mem_num);
	
}


