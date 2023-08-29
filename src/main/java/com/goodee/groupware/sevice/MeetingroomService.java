package com.goodee.groupware.sevice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.MeetingroomMapper;
import com.goodee.groupware.vo.Meetingroom;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class MeetingroomService {
	@Autowired
	private MeetingroomMapper meetingroomMapper;
// ----- 회의실 목록 출력 -----	
	public Map<String, Object> getMeetingroomList(int currentPage, int rowPerPage) {
		
		// 시작 행
		int beginRow = (currentPage-1) * rowPerPage;
		
		// 매개변수 값들을 Map에 담음
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		
		// 회의실 목록 조회
		List<Meetingroom> meetingroomList = new ArrayList<>();
		meetingroomList = meetingroomMapper.getMeetingroomList(paramMap);
		
		// 회의실 목록의 총 행의 개수
		int meetingroomListRow = 0;
		meetingroomListRow = meetingroomMapper.getMeetingroomListRow();
		
		// 마지막 페이지 구하기
		int lastPage = meetingroomListRow / rowPerPage;
		if(meetingroomListRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		// Map에 담아서 controller로 넘기기
		Map<String, Object> meetingroomMap = new HashMap<>(); 
		meetingroomMap.put("meetingroomList", meetingroomList);
		meetingroomMap.put("lastPage", lastPage);
		log.debug("\u001B[31m"+"MeetingroomService.getMeetingroomList() meetingroomMap : "+ meetingroomMap.toString()+"\u001B[0m");
		
		return meetingroomMap;
	}

// ----- 회의실 추가 -----	
	public int addMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		row = meetingroomMapper.addMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomService.addMeetingroom() row : "+row+"\u001B[0m");
		return row;
	}
	
	
// ----- 회의실 삭제 -----	
	public int deleteMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		row = meetingroomMapper.deleteMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomService.deleteMeetingroom() row : "+row+"\u001B[0m");
		return row;
	}
}
