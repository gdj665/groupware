package com.goodee.groupware.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodee.groupware.sevice.HrmService;
import com.goodee.groupware.sevice.MemberService;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberContrller {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HrmService hrmService;
	
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
//		로그인 유의성 검사 및 부서번호, 레벨 가져오기
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		member = memberService.checkMember(member);
		
//		cnt 없을 경우 로그인으로 리턴
		if(member.getCnt() == 0) {
			log.debug("로그인실패");
			return "redirect:/member/login";
		}
//		로그인 성공시
		session.setAttribute("loginMember", memberId);
		session.setAttribute("departmentNo", member.getDepartmentNo());
		session.setAttribute("departmentParentNo", member.getDepartmentParentNo());
		session.setAttribute("memberLevel", member.getMemberLevel());
		session.setMaxInactiveInterval(2*60*60);
		log.debug("세션 유지 시간 : " + session.getMaxInactiveInterval());
		log.debug("seesion loginMember : " + session.getAttribute("loginMember"));
		log.debug("seesion departmentNo : " + session.getAttribute("departmentNo"));
		log.debug("seesion departmentParentNo : " + session.getAttribute("departmentParentNo"));
		log.debug("seesion memberLevel : " + session.getAttribute("memberLevel"));
		if(saveId != null) {
//			쿠키에 저장된 아이디가 있다면 response속성에 저장
			Cookie cookie = new Cookie("saveLoginId", memberId);
			cookie.setDomain("localhost");
			cookie.setMaxAge(7*24*60*60);//일 * 시 * 분 * 초
			response.addCookie(cookie);
			log.debug("쿠키 유지 시간 : " + cookie.getMaxAge());
		} else {
			Cookie cookie = new Cookie("saveLoginId", "");
			cookie.setDomain("localhost");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
//		비밀번호 1234 일때 비밀번호 변경페이지로 이동
		if(memberPw.equals("1234")) {
			return "redirect:/member/updatePw";
		}
		return "redirect:/home";
	}
	
//	비밀번호 수정 페이지
	@GetMapping("/member/updatePw")
	public String updatePw(HttpSession session,
							HttpServletRequest request) {
		String memberId = (String)session.getAttribute("loginMember");
		request.setAttribute("memberId", memberId);
		return "/member/updatePw";
	}
//	비밀번호 수정 실행 페이지
	@PostMapping("/member/updatePw")
	public String updatePw(@RequestParam(name = "memberId") String memberId,
							@RequestParam(name = "memberPw") String memberPw) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		int row = memberService.updatePw(member);
		log.debug("MemberController updatePw row = " + row);
		return "redirct:/member/addSign";
	}
//	비밀번호 수정 실행 페이지
	@ResponseBody
	@PostMapping("/updateMemberPw")
	public int updateMemberPw(@RequestParam(name = "memberId") String memberId,
							@RequestParam(name = "memberPw") String memberPw) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		int row = memberService.updatePw(member);
		log.debug("MemberController updateMemberPw row = " + row);
		return row;
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
		log.debug("MemberController checkMember result 값 : " + memberService.checkMember(member));
//		결과 값 return
		member = memberService.checkMember(member);
		return member.getCnt();
	}
	
//	logout 실행
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	@GetMapping("/home")
	public String home(HttpSession session,
						HttpServletRequest request) {
		String memberId = (String)session.getAttribute("loginMember");
		request.setAttribute("memberId", memberId);
		return "/home";
	}
	
//	마이페이지 출력
	@GetMapping("/member/mypage")
	public String mypage(Model model, String memberId) {
		Member member = hrmService.getOneMember(memberId);
		model.addAttribute("member", member);
		
		return "/member/mypage";
	}
	
//	마이페이지 수정 출력
	@GetMapping("/member/updateMypage")
	public String updateMypage(Model model, String memberId) {
		Member member = hrmService.getOneMember(memberId);
		model.addAttribute("member", member);
		
		return "/member/updateMypage";
	}
//	마이페이지 출력
	@PostMapping("/member/updateMypage")
	public String updateMypage(@RequestParam(name = "memberId") String memberId,
								@RequestParam(name = "memberName") String memberName,
								@RequestParam(name = "memberPhone") String memberPhone,
								@RequestParam(name = "memberEmail") String memberEmail,
								@RequestParam(name = "memberAddress") String memberAddress) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberName(memberName);
		member.setMemberPhone(memberPhone);
		member.setMemberEmail(memberEmail);
		member.setMemberAddress(memberAddress);
		int row = memberService.updateOneMember(member);
		return "redirect:/member/mypage?memberId=" + memberId;
	}
	
}
