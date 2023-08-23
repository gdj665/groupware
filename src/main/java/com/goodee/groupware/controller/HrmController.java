package com.goodee.groupware.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.groupware.sevice.HrmService;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HrmController {
	@Autowired
	private HrmService hrmService;
	
	// 사원 리스트 출력
	@GetMapping("/hrm/hrmList")
	public String getMemberList(Model model) {
		List<Map<String,Object>> memberList = hrmService.getMemberList();
		
		model.addAttribute("memberList", memberList);
		
		log.debug("hrmController.getMemberList() -->" + memberList);
		
		return "/hrm/hrmList";
	}
	// 사원 추가
	@PostMapping("/hrm/addHrm")
	public String addMember(Member member) {
		
		int addMemberRow = hrmService.addMember(member);
		log.debug("hrmController.addMemberRow-->" + addMemberRow);
		return "redirect:/hrm/hrmList";
	}
}
