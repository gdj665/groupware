package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Meetingroom;

@Mapper
public interface MeetingroomMapper {
	// 회의실 목록 조회(관리자만 조회 가능)
	List<Meetingroom> getMeetingroomList(Map<String,Object> paramMap);
	
	// 회의실 목록의 총 행 개수
	int getMeetingroomListRow();
	
	// 회의실 추가
	int addMeetingroom(Meetingroom meetingroom);
	
	// 회의실 삭제
	int deleteMeetingroom(Meetingroom meetingroom);
	
}
