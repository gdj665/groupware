package com.goodee.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.ScheduleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ScheduleController {
	@Autowired
	ScheduleService scheduleService;
	
	// ----- 일정 목록 -----
	@GetMapping("/schedule/scheduleList")
	public String getScheduleList(HttpSession session, Model model,
									@RequestParam(required = false, name = "targetYear") Integer targetYear,		
									@RequestParam(required = false, name = "targetMonth") Integer targetMonth,
									@RequestParam(required = false, name = "scheduleCategory") String scheduleCategory) {
		// required를 false로 주어야 null값 검사가 가능
		// null일시 오늘 날짜 달력 출력 
		// null일시 카테고리 = "전체"
		
		log.debug("\u001B[31m"+"targetYear : "+ targetYear+"\u001B[0m");
		log.debug("\u001B[31m"+"targetMonth : "+ targetMonth+"\u001B[0m");
		log.debug("\u001B[31m"+"scheduleCategory : "+ scheduleCategory+"\u001B[0m");
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");

		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> scheduleMap = new HashMap<>();
		scheduleMap = scheduleService.getScheduleList(memberId, targetYear, targetMonth, scheduleCategory);
		log.debug("\u001B[31m"+"ScheduleController.getScheduleList() scheduleMap : "+ scheduleMap.toString()+"\u001B[0m");
		
		model.addAttribute("scheduleMap", scheduleMap);
		return "/schedule/scheduleList";
	}
	
	// ----- 일 별 일정 상세보기 -----
	@GetMapping("/schedule/oneSchedule")
	public String getOnePersonalSchedule(HttpSession session, Model model,
											@RequestParam(required = false, name = "targetYear") Integer targetYear,		
											@RequestParam(required = false, name = "targetMonth") Integer targetMonth,
											@RequestParam(required = false, name = "targetDate") Integer targetDate,
											@RequestParam(required = false, name = "scheduleCategory") String scheduleCategory) {
		
		log.debug("\u001B[31m"+"targetYear : "+ targetYear+"\u001B[0m");
		log.debug("\u001B[31m"+"targetMonth : "+ targetMonth+"\u001B[0m");
		log.debug("\u001B[31m"+"targetDate : "+ targetDate+"\u001B[0m");
		log.debug("\u001B[31m"+"scheduleCategory : "+ scheduleCategory+"\u001B[0m");
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> oneScheduleMap = new HashMap<>();
		oneScheduleMap = scheduleService.getOneSchedule(memberId, targetYear, targetMonth, targetDate, scheduleCategory);
		log.debug("\u001B[31m"+"ScheduleController.getOneSchedule() oneScheduleMap : "+ oneScheduleMap.toString()+"\u001B[0m");
		
		model.addAttribute("oneScheduleMap", oneScheduleMap);
		
		return "/schedule/oneSchedule";
	}
	
	/*
	// ----- 개인 일정 등록 -----
	@GetMapping("/schedule/addPersonalSchedule")
	public String addPersonalSchedule() {
		
		return "/schedule/addPersonalSchedule";
	}
	 */
}
