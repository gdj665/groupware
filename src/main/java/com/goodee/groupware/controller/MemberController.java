package com.goodee.groupware.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.goodee.groupware.sevice.BoardService;
import com.goodee.groupware.sevice.HrmService;
import com.goodee.groupware.sevice.MemberService;
import com.goodee.groupware.sevice.ScheduleService;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private HrmService hrmService;
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private BoardService boardService;
	
	
//	home 페이지 이동
	@GetMapping("/group/home")
	public String home(HttpSession session, Model model) {
		// 세션 아이디 값
		String memberId = (String)session.getAttribute("loginMember");
		// 세션 부서 번호 저장
		int departmentNo = (Integer) session.getAttribute("departmentNo");
		
		// 부서번호를 부모 부서 번호로 변경
		int departmentParentNo = departmentNo/100*100;
		
		// 매개 변수 값들을 Map에 저장
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("memberId", memberId);
		paramMap.put("departmentNo", departmentNo);
		paramMap.put("departmentParentNo", departmentParentNo);
		
		// 오늘의 개인일정과 부서일정 Map에 저장
		Map<String,Object> todayScheduleMap = new HashMap<>(); 
		todayScheduleMap = scheduleService.getTodaySchduleList(paramMap);
		
		// 공지 게시판 출력
		Map<String, Object> noticeBoardMap = new HashMap<>();
		noticeBoardMap = boardService.getBoardListByNotice();
		
		// 부서 게시판 출력
		Map<String, Object> departmentBoardMap = new HashMap<>();
		departmentBoardMap = boardService.getBoardListByDepartment(paramMap);
		
		// Model에 담아서 View로 넘기기
		model.addAttribute("todayScheduleList", todayScheduleMap.get("todayScheduleList"));
		model.addAttribute("boardListByNotice", noticeBoardMap.get("boardListByNotice"));
		model.addAttribute("boardListByDepartment", departmentBoardMap.get("boardListByDepartment"));
		
		model.addAttribute("memberId", memberId);
		return "/home";
	}
	
//	login 페이지 이동
	@GetMapping("/group/login")
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
			return "redirect:/group/home";
		};
		
		return "/member/login";
	}
	
//	login 실행
	@PostMapping("/group/login")
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
			return "redirect:/group/member/login";
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
			return "redirect:/group/member/updatePw";
		}
		return "redirect:/group/home";
	}
	
//	비밀번호 수정 페이지
	@GetMapping("/group/member/updatePw")
	public String updatePw(HttpSession session,
							HttpServletRequest request) {
		String memberId = (String)session.getAttribute("loginMember");
		request.setAttribute("memberId", memberId);
		return "/member/updatePw";
	}
	
//	비밀번호 수정 실행 페이지 (첫 로그인 or 비번 초기화 후)
	@PostMapping("/group/member/updatePw")
	public String updatePw(@RequestParam(name = "memberId") String memberId,
							@RequestParam(name = "memberPw") String memberPw) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		int row = memberService.updatePw(member);
		log.debug("MemberController updatePw row = " + row);
		
//		비밀번호 초기화 했을경우 addSign 할 필요없어서 home으로 가게 분기처리
		if (hrmService.getOneMember(memberId).getMemberSignFile() != null) {
			return "redirect:/group/home";
		}
		return "redirect:/group/member/addSign";
	}
	
//	비밀번호 수정 실행 페이지(마이페이지에서 수정)
	@ResponseBody
	@PostMapping("/group/updateMemberPw")
	public int updateMemberPw(@RequestParam(name = "memberId") String memberId,
							@RequestParam(name = "memberPw") String memberPw) {
		Member member = new Member();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		int row = memberService.updatePw(member);
		log.debug("MemberController updateMemberPw row = " + row);
		return row;
	}
	
//	사인 추가 페이지
	@GetMapping("/group/member/addSign")
	public String addSign() {
		return "/member/addSign";
	}
	
//	사인 수정 페이지
	@GetMapping("/group/member/updateSign")
	public String updateSign(Model model, String memberId) {
//		기존 사인 데이터 가지고 오기 위함
		Member member = hrmService.getOneMember(memberId);
		model.addAttribute("member", member);
		return "/member/updateSign";
	}
	
//	login 유의성 검사
//	RestController를 안쓰고 Controller만 썻을때 메소드에 ResponseBody 붙이면 RestController처럼 사용가능
//	AJAX 사용하기위해 붙인 어노테이션
	@ResponseBody
	@PostMapping("/group/checkMember")
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
	@GetMapping("/group/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/group/login";
	}
	
//	마이페이지 출력
	@GetMapping("/group/member/mypage")
	public String mypage(Model model, String memberId) {
		Member member = hrmService.getOneMember(memberId);
		model.addAttribute("member", member);
		model.addAttribute("memberId", member.getMemberId());
		return "/member/mypage";
	}
	
//	마이페이지 수정 출력
	@GetMapping("/group/member/updateMypage")
	public String updateMypage(Model model, HttpSession session, String memberId) {
		Member member = hrmService.getOneMember(memberId);
		
		// 세션 아이디 값
		String sessionId = (String)session.getAttribute("loginMember");
		
		model.addAttribute("member", member);
		model.addAttribute("memberId", sessionId);
		return "/member/updateMypage";
	}
	
//	마이페이지 출력
	@PostMapping("/group/member/updateMypage")
	public String updateMypage(Member member) {
		int row = memberService.updateOneMember(member);
		return "redirect:/group/member/mypage?memberId=" + member.getMemberId();
	}
	
//	근태 출력
	@GetMapping("/group/member/workResister")
	public String getWorkList(HttpSession session, Model model,
									@RequestParam(required = false, name = "targetYear") Integer targetYear,		
									@RequestParam(required = false, name = "targetMonth") Integer targetMonth) {
		String memberId =(String)session.getAttribute("loginMember");
		Map<String, Object> workMap = memberService.getWorkList(memberId, targetYear, targetMonth);
		
		// 요청한 매개값을 담아 서비스를 호출
		List<Map<String, String>> getHolidayList = new ArrayList<>();
		getHolidayList = scheduleService.getHolidayList(targetYear, targetMonth);
		
		model.addAttribute("workMap", workMap);
		model.addAttribute("getHolidayList", getHolidayList);
		model.addAttribute("todayDate", workMap.get("todayDate"));
		model.addAttribute("todayMonth", workMap.get("todayMonth"));
		return "/member/workResister";
	}
	
//	출근 등록
	@GetMapping("/group/member/workBegin")
	public String addWorkBegin(@RequestParam(name = "memberId") String memberId) {
		memberService.addWorkBegin(memberId);
		return "redirect:/group/member/workResister";
	}

//	퇴근 등록
	@GetMapping("/group/member/workEnd")
	public String addWorkEnd(@RequestParam(name = "memberId") String memberId) {
		memberService.addWorkEnd(memberId);
		return "redirect:/group/member/workResister";
	}
	
//	부서 근태 출력
	@GetMapping("/group/member/workCheck")
	public String getWorkCheckList(HttpSession session, Model model,
									@RequestParam(required = false, name = "targetYear") Integer targetYear,		
									@RequestParam(required = false, name = "targetMonth") Integer targetMonth,
									@RequestParam(required = false, name = "targetDate") Integer targetDate) {
		String memberId =(String)session.getAttribute("loginMember");
		int departmentNo =(int)session.getAttribute("departmentNo");
//		memberId는 입력값 받아서 출력
		Map<String, Object> workInfoMap = memberService.getWorkCheckInfoList(departmentNo, targetYear, targetMonth, targetDate);
//		Map<String, Object> workCheckMap = memberService.getWorkCheckList(departmentNo, targetYear, targetMonth);
		model.addAttribute("workInfoMap", workInfoMap);
//		model.addAttribute("workCheckMap", workCheckMap);
		model.addAttribute("targetYear", targetYear);
		model.addAttribute("targetMonth", targetMonth);
		model.addAttribute("targetDate", targetDate);
		return "/member/workCheck";
	}
}
