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
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class MeetingroomService {
	@Autowired
	private MeetingroomMapper meetingroomMapper;
	
	public Map<String, Object> getMeetingroomList(Member member) {
		int cnt = 0;
		
		// 관리자 유무 조회
		cnt = meetingroomMapper.getMemberLevelCount(member);
		log.debug("\u001B[31m"+"MeetingroomService.getMeetingroomList() cnt : "+cnt+"\u001B[0m");
		
		// 회의실 목록 조회
		List<Meetingroom> meetingroomList = new ArrayList<>();
		if(cnt>0) { // 관리자가 맞으면
			meetingroomList = meetingroomMapper.getMeetingroomList();
		}
		
		// Map에 담아서 controller로 넘기기
		Map<String, Object> meetingroomMap = new HashMap<>(); 
		meetingroomMap.put("meetingroomList", meetingroomList);
		
		log.debug("\u001B[31m"+"MeetingroomService.getMeetingroomList() meetingroomMap : "+ meetingroomMap.toString()+"\u001B[0m");
		
		return meetingroomMap;
	}
}
