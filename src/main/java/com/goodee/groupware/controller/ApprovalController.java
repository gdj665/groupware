package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.ApprovalService;
import com.goodee.groupware.vo.Approval;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ApprovalController {
	@Autowired
	private ApprovalService approvalService;
	
	@GetMapping("/approval/approvalList")
	public String getBoardList(Model model,
			HttpSession session,
			String memberId,
			@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam(name = "rowPerPage", defaultValue = "3") int rowPerPage,
			@RequestParam(name = "approvalLastStatus", required = false) String approvalLastStatus,
			@RequestParam(name = "approvalNowStatus", required = false) String approvalNowStatus) {
		
		Map<String,Object> resultMap = approvalService.getApprovalList(currentPage, rowPerPage, approvalLastStatus, approvalNowStatus, memberId);
		
		String SessionLoginId = (String) session.getAttribute("loginMember");
		
		model.addAttribute("approvalList",resultMap.get("approvalList"));
		
		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("memberId", resultMap.get("memberId"));
		return "/approval/approvalList";
	}
}
