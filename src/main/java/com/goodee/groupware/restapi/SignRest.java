package com.goodee.groupware.restapi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class SignRest {
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
}
