package com.goodee.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.goodee.groupware.sevice.MeetingroomService;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MeetingroomController {
	@Autowired
	MeetingroomService meetingroomService;
	
	@GetMapping("/meetingroom/meetingroomList")
	public String getMeetingroomList(HttpSession session , Model model, Member member) {
		
		// 세션 아이디 값 저장
		String memberId = (String)session.getAttribute("loginMember");
		member.setMemberId(memberId);
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> meetingroomMap = new HashMap<>();
		meetingroomMap = meetingroomService.getMeetingroomList(member);
		log.debug("\u001B[31m"+"MeetingroomController.getmeetingroomList() meetingroomMap : "+ meetingroomMap.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("meetingroomMap", meetingroomMap);
		return "/meetingroom/meetingroomList";
	}

}
