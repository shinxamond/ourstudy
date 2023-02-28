package kr.spring.talk.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.vo.MemberVO;
import kr.spring.talk.dao.TalkMapper;
import kr.spring.talk.vo.TalkRoomVO;
import kr.spring.talk.vo.TalkVO;

@Service
@Transactional
public class TalkServiceIml implements TalkService{
	
	@Autowired
	private TalkMapper talkMapper;
	
	@Override
	public List<TalkRoomVO> selectTalkRoomList(Map<String, Object> map) {
		return talkMapper.selectTalkRoomList(map);
	}

	@Override
	public TalkRoomVO selectTalkRoom(Integer talkroom_num) {
		return talkMapper.selectTalkRoom(talkroom_num);
	}

	@Override
	public void insertTalkRoom(TalkRoomVO talkRoomVO) {
		//기본키 값 생성
		talkRoomVO.setTalkroom_num(talkMapper.selectTalkRoomNum());//시퀀스값을 넣어준다
		
		//채팅방 생성
		talkMapper.insertTalkRoom(talkRoomVO);
		//채팅방 멤버 생성
		for(Integer mem_num : talkRoomVO.getMembers()) {//배열에 멤버 저장
			talkMapper.insertTalkRoomMember(talkRoomVO.getTalkroom_num(), mem_num);
		}
		
	}

	@Override
	public void insertTalk(TalkVO talkVO) {
		talkVO.setTalk_num(talkMapper.selectTalkNum());
		//채팅 메시지 등록
		talkMapper.insertTalk(talkVO);
		//채팅방 멤버가 읽지 않은 채팅 정보 저장
		for(TalkVO vo : talkMapper.selectTalkMember(talkVO.getTalkroom_num())) {
			talkMapper.insertTalkRead(talkVO.getTalkroom_num(), talkVO.getTalk_num(), vo.getMem_num());
		}
	}

	@Override
	public List<TalkVO> selectTalkDetail(Map<String, Integer> map) {
		talkMapper.deleteTalkRead(map);//읽은 내용 삭제
		return talkMapper.selectTalkDetail(map.get("talkroom_num"));
	}

	@Override
	public List<TalkVO> selectTalkMember(Integer talkroom_num) {
		return talkMapper.selectTalkMember(talkroom_num);
	}

	@Override
	public void deleteTalkRoomMember(TalkVO talkVO) {
		//채팅방 멤버
		List<TalkVO> list = talkMapper.selectTalkMember(talkVO.getTalkroom_num());
				
		//회원멤버 삭제
		talkMapper.deleteTalkRoomMember(talkVO);
		
		if(list.size()>1) {//1명이상일때
			//채팅방 나가기 메시지
			talkVO.setTalk_num(talkMapper.selectTalkNum());
			talkMapper.insertTalk(talkVO);
		}else {
			//채팅멤버가 1명인데 마지막 채팅멤버가 방을 나갈 경우 
			//남아있는 채팅 내용을 모두 지우고 채팅방도 삭제
			talkMapper.deleteTalk(talkVO.getTalkroom_num());
			talkMapper.deleteTalkRoom(talkVO.getTalkroom_num());
		}
		
	}

	@Override
	public List<MemberVO> selectMemberList(Map<String, Object> map) {
		return talkMapper.selectMemberList(map);
	}

	@Override
	public int selectMemberCount(Map<String, Object> map) {
		return talkMapper.selectMemberCount(map);
	}

	@Override
	public int selectTalkRoomCheck(String talkroom_name) {
		return talkMapper.selectTalkRoomCheck(talkroom_name);
	}

	@Override
	public int selectTalkRoomNumMain(String talkroom_name) {
		return talkMapper.selectTalkRoomNumMain(talkroom_name);
	}

	@Override
	public List<TalkRoomVO> selectTalkRoomOne(Integer talkroom_num) {
		return talkMapper.selectTalkRoomOne(talkroom_num);
	}

	@Override
	public int talkRoomCheck(Integer mem_num1, Integer mem_num2) {
		return talkMapper.talkRoomCheck(mem_num1, mem_num2);
	}

	
	
}









