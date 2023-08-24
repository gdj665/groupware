package com.goodee.groupware.restapi;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class MemberRest {
	@Autowired
	private MemberService memberService;
	
//	사인 추가 실행
	@PostMapping("/member/addSign")
	public String addSign(HttpSession session,
						HttpServletRequest request,
						@RequestParam(name = "sign") String sign) {
		String path = request.getServletContext().getRealPath("/signFile/");
		log.debug("SignRest signFile path" + path);
		String memberId = (String)session.getAttribute("loginMember");
		memberService.updateSign(memberId, sign, path);
		return "yes";
	}
	
//	부서 근태 출력
	@GetMapping("/member/restWorkCheckList")
	public ArrayList<Map<String, Object>> getWorkCheckList(HttpSession session,
									@RequestParam(required = false, name = "targetYear") Integer targetYear,		
									@RequestParam(required = false, name = "targetMonth") Integer targetMonth) {
		String memberId =(String)session.getAttribute("loginMember");
		int departmentNo =(int)session.getAttribute("departmentNo");
//		memberId는 입력값 받아서 출력
		ArrayList<Map<String, Object>> workCheckList = (ArrayList)memberService.getWorkCheckList(departmentNo, targetYear, targetMonth).get("workCheckList");
		return workCheckList;
	}
}
