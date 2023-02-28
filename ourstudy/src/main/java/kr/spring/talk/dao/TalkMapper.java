package kr.spring.talk.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;

@Mapper
public interface TalkMapper {
	//채팅방 목록
	public List<TalkRoomVO> selectTalkRoomList(Map<String,Object> map);
	//회원정보
	public List<MemberVO> selectMemberList(Map<String,Object> map);
	//회원정보 개수
	public int selectMemberCount (Map<String,Object> map);
	//채팅방 상세
	@Select("SELECT * FROM talkroom WHERE talkroom_num=#{talkroom_num}")
	public TalkRoomVO selectTalkRoom(Integer talkroom_num);
	
	//채팅방 체크(있는지 없는지 확인)1
	@Select("SELECT count(*) FROM talkroom WHERE talkroom_name=#{talkroom_name}")
	public int selectTalkRoomCheck(String talkroom_name);
	//채팅방 번호 구하기
	@Select("SELECT talkroom_num FROM talkroom WHERE talkroom_name=#{talkroom_name}")
	public int selectTalkRoomNumMain(String talkroom_name);
	//채팅방 하나의 정보?
	public List<TalkRoomVO> selectTalkRoomOne(Integer talkroom_num);
	
	//채팅방 중복 검사2
	@Select("SELECT count(*) FROM talk_member WHERE mem_num=#{mem_num1} AND talkroom_num IN (SELECT talkroom_num FROM talk_member WHERE mem_num=#{mem_num2})")
	public int talkRoomCheck(@Param(value="mem_num1") Integer mem_num1, 
		     @Param(value="mem_num2") Integer mem_num2);
	
	//채팅방 번호 생성
	@Select("SELECT talkroom_seq.nextval FROM dual")
	public Integer selectTalkRoomNum();
	
	//채팅방 생성
	@Insert("INSERT INTO talkroom (talkroom_num, talkroom_name) VALUES (#{talkroom_num}, #{talkroom_name})")
	public void insertTalkRoom(TalkRoomVO talkRoomVO);
	
	
	//채팅방 멤버 등록
	@Insert("INSERT INTO talk_member (talkroom_num, mem_num) VALUES (#{talkroom_num}, #{mem_num})")
	public void insertTalkRoomMember(@Param(value="talkroom_num") Integer talkroom_num, 
								     @Param(value="mem_num") Integer mem_num);
	
	//채팅 메시지 번호 생성
	@Select("SELECT talk_seq.nextval FROM dual")
	public Integer selectTalkNum();
	//채팅 메시지 등록
	@Insert("INSERT INTO talk (talk_num,talkroom_num,mem_num,message) VALUES (#{talk_num},#{talkroom_num},#{mem_num},#{message})")
	public void insertTalk(TalkVO talkVO);
	//채팅 메시지 읽기
	public List<TalkVO> selectTalkDetail(Integer talkroom_num);
	
	//채팅 멤버 읽기
	@Select("SELECT mem_num, mem_id FROM talk_member JOIN member USING(mem_num) WHERE talkroom_num=#{talkroom_num}")
	public List<TalkVO> selectTalkMember(Integer talkroom_num);
	
	//읽지 않은 채팅 기록 저장
	@Insert("INSERT INTO talk_read (talkroom_num,talk_num,mem_num) VALUES (#{talkroom_num},#{talk_num},#{mem_num})")
	public void insertTalkRead(@Param(value="talkroom_num") int talkroom_num, @Param(value="talk_num") int talk_num,
							   @Param(value="mem_num") int mem_num);
	
	//읽은 채팅 기록 삭제
	@Delete("DELETE FROM talk_read WHERE talkroom_num=#{talkroom_num} AND mem_num=#{mem_num}")
	public void deleteTalkRead(Map<String,Integer> map);
	//채팅방 나가기
	@Delete("DELETE FROM talk_member WHERE talkroom_num=#{talkroom_num} AND mem_num=#{mem_num}")
	public void deleteTalkRoomMember(TalkVO talkVO);
	//채팅 메시지 삭제
	@Delete("DELETE FROM talk WHERE talkroom_num=#{talkroom_num}")
	public void deleteTalk(Integer talkroom_num);
	//채팅방 삭제
	@Delete("DELETE FROM talkroom WHERE talkroom_num=#{talkroom_num}")
	public void deleteTalkRoom(Integer talkroom_num);
}


