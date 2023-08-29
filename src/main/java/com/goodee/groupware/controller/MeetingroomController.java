package com.goodee.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.MeetingroomService;
import com.goodee.groupware.vo.Meetingroom;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MeetingroomController {
	@Autowired
	MeetingroomService meetingroomService;
// ----- 회의실 목록 -----	
	@GetMapping("/meetingroom/meetingroomList")
	public String getMeetingroomList(HttpSession session , Model model, Member member,
									@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(name ="rowPerPage", defaultValue = "3") int rowPerPage) {
		// 세션 부서 레벨 저장
		String memberLevel =(String)session.getAttribute("memberLevel");
		
		// 권한 유효성 검사
		if(!memberLevel.equals("4관리자")) { // 관리자가 아니면 홈으로 되돌아간다.
			log.debug("\u001B[31m"+"관리자가 아닙니다"+"\u001B[0m");
			return "redirect:/home";
		}
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> meetingroomMap = new HashMap<>();
		meetingroomMap = meetingroomService.getMeetingroomList(currentPage, rowPerPage);
		log.debug("\u001B[31m"+"MeetingroomController.getmeetingroomList() meetingroomMap : "+ meetingroomMap.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("meetingroomMap", meetingroomMap);
		
		// 페이징 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", meetingroomMap.get("lastPage"));
		
		return "/meetingroom/meetingroomList";
	}

// ----- 회의실 추가 ------	
	@GetMapping("/meetingroom/addMeetingroom")
	public String addMeetingroom(HttpSession session) {
		 
		// 세션 부서 레벨 저장
		String memberLevel =(String)session.getAttribute("memberLevel");
		
		if(!memberLevel.equals("4관리자")) { // 관리자가 아니면 홈으로 되돌아간다.
			log.debug("\u001B[31m"+"관리자가 아닙니다"+"\u001B[0m");
			return "redirect:/home";
		}
		return "/meetingroom/addMeetingroom";
	}
	
	@PostMapping("/meetingroom/addMeetingroom")
	public String addMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		
		// 회의실 추가
		row = meetingroomService.addMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomController.addMeetingroom() row : "+row+"\u001B[0m");
		return "redirect:/meetingroom/meetingroomList";
	}
	
// ----- 회의실 삭제 -----	
	@GetMapping("/meetingroom/deleteMeetingroom")
	public String deleteMeetingroom(Meetingroom meetingroom) {
		int row = 0;
		
		// 회의실 삭제
		row = meetingroomService.deleteMeetingroom(meetingroom);
		log.debug("\u001B[31m"+"MeetingroomController.deleteMeetingroom() row : "+row+"\u001B[0m");
		return "redirect:/meetingroom/meetingroomList";
	}


}
