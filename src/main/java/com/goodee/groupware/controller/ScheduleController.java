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

import com.goodee.groupware.sevice.ScheduleService;
import com.goodee.groupware.vo.Schedule;

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
		// required를 false로 주어야 null값 검사가 가능 // null일시 오늘 날짜 달력 출력 
		log.debug("\u001B[31m"+"targetYear : "+ targetYear+"\u001B[0m");
		log.debug("\u001B[31m"+"targetMonth : "+ targetMonth+"\u001B[0m");
		log.debug("\u001B[31m"+"scheduleCategory : "+ scheduleCategory+"\u001B[0m");
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");

		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> scheduleMap = new HashMap<>();
		scheduleMap = scheduleService.getScheduleList(memberId, targetYear, targetMonth, scheduleCategory);
		log.debug("\u001B[31m"+"ScheduleController.getScheduleList() scheduleMap : "+ scheduleMap.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("scheduleMap", scheduleMap);
		return "/schedule/scheduleList";
	}
	
	// ----- 일 별 일정 상세보기 -----
	@GetMapping("/schedule/oneSchedule")
	public String getOneSchedule(HttpSession session, Model model,
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
		// 세션 부서 레벨 저장
		String memberLevel =(String)session.getAttribute("memberLevel");
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> oneScheduleMap = new HashMap<>();
		oneScheduleMap = scheduleService.getOneSchedule(memberId, targetYear, targetMonth, targetDate, scheduleCategory);
		log.debug("\u001B[31m"+"ScheduleController.getOneSchedule() oneScheduleMap : "+ oneScheduleMap.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("oneScheduleMap", oneScheduleMap);
		model.addAttribute("memberLevel",memberLevel);
		return "/schedule/oneSchedule";
	}
	
	// ----- 개인 일정 등록 -----
	@GetMapping("/schedule/addPersonalSchedule")
	public String addPersonalSchedule(HttpSession session, Model model) {
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("memberId", memberId);
		return "/schedule/addPersonalSchedule";
	}
	@PostMapping("/schedule/addPersonalSchedule")
	public String addPersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleService.addPersonalSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.addPersonalSchedule() row : "+row+"\u001B[0m");
		return "redirect:/schedule/scheduleList";
	}
	
	// ----- 부서 일정 등록 -----
	@GetMapping("/schedule/addDepartmentSchedule")
	public String addDepartmentSchedule(HttpSession session, Model model) {
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		model.addAttribute("memberId", memberId);
		return "/schedule/addDepartmentSchedule";
	}
	@PostMapping("/schedule/addDepartmentSchedule")
	public String addDepartmentSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleService.addDepartmentSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.addDepartmentSchedule() row : "+row+"\u001B[0m");
		return "redirect:/schedule/scheduleList"; 
	}
	
	// ----- 부서 일정 삭제(부서장만) ------
	@GetMapping("/schedule/deleteDepartmentSchedule")
	public String deleteDepartmentSchedule(HttpSession session, Schedule schedule) {
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		schedule.setMemberId(memberId);
		
		int row = 0;
		row = scheduleService.deleteDepartmentSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.deleteDepartmentSchedule() row : "+row+"\u001B[0m");
		return "redirect:/schedule/scheduleList";
	}
	
}
