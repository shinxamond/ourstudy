package kr.spring.talk.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.member.vo.MemberVO;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;

public interface TalkService {
	//채팅방 목록
	public List<TalkRoomVO> selectTalkRoomList(Map<String,Object> map);
	//채팅방 상세
	public TalkRoomVO selectTalkRoom(Integer talkroom_num);
	//채팅방 생성
	public void insertTalkRoom(TalkRoomVO talkRoomVO);
	//채팅 메시지 등록
	public void insertTalk(TalkVO talkVO);
	//채팅 메시지 읽기
	public List<TalkVO> selectTalkDetail(Map<String,Integer> map);
	//채팅 멤버 읽기
	public List<TalkVO> selectTalkMember(Integer talkroom_num);
	//채팅방 나가기
	public void deleteTalkRoomMember(TalkVO talkVO);
	//회원정보
	public List<MemberVO> selectMemberList(Map<String,Object> map);
	//회원정보 개수
	public int selectMemberCount (Map<String,Object> map);
	//채팅방 체크(있는지 없는지 확인)
	public int selectTalkRoomCheck(String talkroom_name);
	//채팅방 번호 구하기
	public int selectTalkRoomNumMain(String talkroom_name);
	//채팅방 하나의 정보?
	public List<TalkRoomVO> selectTalkRoomOne(Integer talkroom_num);
	//채팅방 중복 검사
	public void talkRoomCheck(@Param(value="mem_num1") Integer mem_num1, 
			@Param(value="mem_num2") Integer mem_num2);
}
