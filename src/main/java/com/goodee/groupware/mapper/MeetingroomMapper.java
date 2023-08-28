package com.goodee.groupware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Meetingroom;
import com.goodee.groupware.vo.Member;

@Mapper
public interface MeetingroomMapper {
	// 관리자 유무 확인
	int getMemberLevelCount(Member member);
	
	// 회의실 목록 조회(관리자만 조회 가능)
	List<Meetingroom> getMeetingroomList();
	
	// 회의실 추가
	int addMeetingroom(Meetingroom meetingroom);
	
	// 회의실 수정
	int updateMeetingroom(Meetingroom meetingroom);
	
	// 회의실 삭제
	int deleteMeetingroom(Meetingroom meetingroom);
	
}
