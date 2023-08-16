package com.goodee.groupware.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodee.groupware.sevice.MemberService;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberContrller {
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/login")
	public String login(HttpSession session,
						HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		for(Cookie c : cookies) {
			if(c.getName().equals("saveLoginId")) {
				request.setAttribute("saveLoginId", c.getValue());
				request.setAttribute("saveId", "checked");
			}
		}
//		로그인 돼있을 경우 홈으로
		if(session.getAttribute("loginId") != null) {
			return "redirect:/home";
		};
		
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String login(HttpSession session,
						HttpServletResponse response,
						@RequestParam(name = "memberId") String memberId,
						@RequestParam(name = "memberPw") String memberPw,
						@RequestParam(name = "saveId", defaultValue = "") String saveId) {
//		로그인 성공시
		session.setAttribute("loginMember", memberId);
		session.setMaxInactiveInterval(2*60*60);
		if(saveId != null) {
//			쿠키에 저장된 아이디가 있다면 response속성에 저장
			Cookie cookie = new Cookie("saveLoginId", memberId);
			cookie.setDomain("localhost");
			cookie.setMaxAge(7*24*60*60*60);
			response.addCookie(cookie);
		}
		Cookie cookie = new Cookie("saveLoginId", "");
		cookie.setDomain("localhost");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		return "redirect:/home";
	}
	
//	login 유의성 검사
//	RestController를 안쓰고 Controller만 썻을때 메소드에 ResponseBody 붙이면 RestController처럼 사용가능
//	AJAX 사용하기위해 붙인 어노테이션
	@ResponseBody
	@PostMapping("/checkMember")
	public int checkId(@RequestParam(name = "memberId") String memberId,
						@RequestParam(name = "memberPw") String memberPw) {
		
//		member에 id, pw 입력
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		log.debug("checkMember result 값 : " + memberService.checkMember(member));
//		결과 값 return
		return memberService.checkMember(member);
	}
	
//	logout 실행
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	@GetMapping("/home")
	public String home(HttpSession session) {
		
		if(session.getAttribute("loginMember") == null) {
			return "redirect:/login";
		};
//		service(memberId, memberPw) -> mapper -> 로그인 성공 유무 반환
		return "/home";
	}
}
