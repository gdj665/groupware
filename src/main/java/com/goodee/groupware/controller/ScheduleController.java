package com.goodee.groupware.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodee.groupware.sevice.ScheduleService;
import com.goodee.groupware.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ScheduleController {
	@Autowired
	ScheduleService scheduleService;
	
// ----- 일정 목록 -----
	@GetMapping("/group/schedule/scheduleList")
	public String getScheduleList(HttpSession session, Model model,
									@RequestParam(required = false, name = "fail") String fail,		
									@RequestParam(required = false, name = "targetYear") Integer targetYear,		
									@RequestParam(required = false, name = "targetMonth") Integer targetMonth,
									@RequestParam(required = false, name = "scheduleCategory") String scheduleCategory) {
		// required를 false로 주어야 null값 검사가 가능 // null일시 오늘 날짜 달력 출력 
		log.debug("\u001B[31m"+"targetYear : "+ targetYear+"\u001B[0m");
		log.debug("\u001B[31m"+"targetMonth : "+ targetMonth+"\u001B[0m");
		log.debug("\u001B[31m"+"scheduleCategory : "+ scheduleCategory+"\u001B[0m");
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		// 세션 부서 번호 저장
		int departmentNo = (Integer) session.getAttribute("departmentNo");

		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> scheduleMap = new HashMap<>();
		scheduleMap = scheduleService.getScheduleList(departmentNo, memberId, targetYear, targetMonth, scheduleCategory);
		log.debug("\u001B[31m"+"ScheduleController.getScheduleList() scheduleMap : "+ scheduleMap.toString()+"\u001B[0m");
		
		// 요청한 매개값을 담아 서비스를 호출
		List<Map<String, String>> getHolidayList = new ArrayList<>();
		getHolidayList = scheduleService.getHolidayList(targetYear, targetMonth);
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("scheduleMap", scheduleMap);
		model.addAttribute("fail", fail);
		model.addAttribute("getHolidayList", getHolidayList);
		model.addAttribute("memberId", memberId);
		return "/schedule/scheduleList";
	}
	
// ----- 일 별 일정 상세보기 -----
	@GetMapping("/group/schedule/oneSchedule")
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
		
		// 세션 부서 번호 저장
		int departmentNo = (Integer) session.getAttribute("departmentNo");
		
		// 세션 부서 레벨 저장
		String memberLevel =(String)session.getAttribute("memberLevel");
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> oneScheduleMap = new HashMap<>();
		oneScheduleMap = scheduleService.getOneSchedule(departmentNo, memberId, targetYear, targetMonth, targetDate, scheduleCategory);
		log.debug("\u001B[31m"+"ScheduleController.getOneSchedule() oneScheduleMap : "+ oneScheduleMap.toString()+"\u001B[0m");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("oneScheduleMap", oneScheduleMap);
		model.addAttribute("memberLevel",memberLevel);
		model.addAttribute("memberId", memberId);
		return "/schedule/oneSchedule";
	}
	
// ----- 개인 일정 등록 -----
	@GetMapping("/group/schedule/addPersonalSchedule")
	public String addPersonalSchedule(HttpSession session, Model model) {
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("memberId", memberId);
		return "/schedule/addPersonalSchedule";
	}
	@PostMapping("/group/schedule/addPersonalSchedule")
	public String addPersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleService.addPersonalSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.addPersonalSchedule() row : "+row+"\u001B[0m");
		return "redirect:/group/schedule/scheduleList";
	}
	
// ----- 부서 일정 등록 -----
	@GetMapping("/group/schedule/addDepartmentSchedule")
	public String addDepartmentSchedule(HttpSession session, Model model) {
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		model.addAttribute("memberId", memberId);
		return "/schedule/addDepartmentSchedule";
	}
	@PostMapping("/group/schedule/addDepartmentSchedule")
	public String addDepartmentSchedule(Schedule schedule, RedirectAttributes redirectAttributes) {
		int row = 0;
		row = scheduleService.addDepartmentSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.addDepartmentSchedule() row : "+row+"\u001B[0m");
		
		if(row == 0) { // 등록에 실패하면
			redirectAttributes.addAttribute("fail","실패");
		}
		return "redirect:/group/schedule/scheduleList";
	}
	
// ----- 개인 일정 삭제 ------
	@GetMapping("/group/schedule/deletePersonalSchedule")
	public String deletePersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleService.deletePersonalSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.deletePersonalSchedule() row : "+row+"\u001B[0m");
		return "redirect:/group/schedule/scheduleList";
	}
	
// ----- 부서 일정 삭제(부서장만) ------
	@GetMapping("/group/schedule/deleteDepartmentSchedule")
	public String deleteDepartmentSchedule(HttpSession session, Schedule schedule, RedirectAttributes redirectAttributes) {
		int row = 0;
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		schedule.setMemberId(memberId);
		
		row = scheduleService.deleteDepartmentSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.deleteDepartmentSchedule() row : "+row+"\u001B[0m");
		
		if(row == 0) { // 삭제에 실패하면
			redirectAttributes.addAttribute("fail","실패");
		}
		return "redirect:/group/schedule/scheduleList";
	}
	
// ----- 개인 일정 수정 -----
	@GetMapping("/group/schedule/updatePersonalSchedule")
	public String updatePersonalSchedule(HttpSession session, Model model,
													@RequestParam(required = false, name = "scheduleNo") Integer scheduleNo) {
		log.debug("\u001B[31m"+"scheduleNo : "+ scheduleNo+"\u001B[0m");
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("memberId", memberId);
		model.addAttribute("scheduleNo", scheduleNo);
		return "/schedule/updatePersonalSchedule";
	}
	
	@PostMapping("/group/schedule/updatePersonalSchedule")
	public String updatePersonalSchedule(Schedule schedule) {
		int row = 0;
		row = scheduleService.updatePersonalSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.updatePersonalSchedule() row : "+row+"\u001B[0m");
		return "redirect:/group/schedule/scheduleList"; 
	}
	
	
// ----- 부서 일정 수정(부서장만) -----
	@GetMapping("/group/schedule/updateDepartmentSchedule")
	public String updateDepartmentSchedule(HttpSession session, Model model,
													@RequestParam(required = false, name = "scheduleNo") Integer scheduleNo) {
		log.debug("\u001B[31m"+"scheduleNo : "+ scheduleNo+"\u001B[0m");
		
		// 세션 아이디 값 저장
		String memberId =(String)session.getAttribute("loginMember");
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("memberId", memberId);
		model.addAttribute("scheduleNo", scheduleNo);
		return "/schedule/updateDepartmentSchedule";
	}
	
	@PostMapping("/group/schedule/updateDepartmentSchedule")
	public String updateDepartmentSchedule(Schedule schedule, RedirectAttributes redirectAttributes) {
		int row = 0;
		row = scheduleService.updateDepartmentSchedule(schedule);
		log.debug("\u001B[31m"+"ScheduleController.updateDepartmentSchedule() row : "+row+"\u001B[0m");
		if(row == 0) { // 등록에 실패하면
			redirectAttributes.addAttribute("fail","실패");
		}
		return "redirect:/group/schedule/scheduleList";
	}
	
}
