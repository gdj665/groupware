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
	
	@GetMapping("/schedule/scheculeList")
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
		
		// session.getAttribute(" "); 세션값으로 넣어야함 ㅎㅎ
		String memberId = "23081601";
		
		// 요청한 매개값을 담아 서비스를 호출
		Map<String, Object> scheduleMap = new HashMap<>();
		scheduleMap = scheduleService.getScheduleList(memberId, targetYear, targetMonth, scheduleCategory);
		
		log.debug("\u001B[31m"+"ScheduleController.getScheduleList() scheduleMap : "+ scheduleMap.toString()+"\u001B[0m");
		
		model.addAttribute("scheduleMap", scheduleMap);
		
		return "/schedule/scheculeList";
	}
}
