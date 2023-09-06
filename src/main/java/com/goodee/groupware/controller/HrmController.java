package com.goodee.groupware.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.groupware.sevice.DepartmentService;
import com.goodee.groupware.sevice.HrmService;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HrmController {
	@Autowired
	private HrmService hrmService;
	@Autowired
	private DepartmentService departmentService;
	// 사원 리스트 출력
	@GetMapping("/group/hrm/hrmList")
	public String getMemberList(Model model,
								HttpSession session) {
		// 부서관리는 팀장급만 들어올 수 있습니다.
		String Level = (String) session.getAttribute("memberLevel");
		// 앞에 숫자만 사용하여 비교하도록 int값으로 파싱함
		int memberLevel = Integer.parseInt(Level.substring(0, 1));
		if(memberLevel < 3) {
			return "redirect:/group/home";
		}
		List<Map<String,Object>> memberList = hrmService.getMemberList();
		List<Map<String,Object>> departmentCnt = hrmService.departmentCnt();
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		model.addAttribute("memberList", memberList);
		model.addAttribute("departmentCnt", departmentCnt);
		model.addAttribute("departmentList", resultMap.get("department"));
		
		log.debug("hrmController.getMemberList() -->" + memberList);
		
		return "/hrm/hrmList";
	}
	// 사원 추가
	@PostMapping("/group/hrm/addHrm")
	public String addMember(Member member) {
		if(member.getDepartmentNo() < 100 
				|| member.getMemberName().equals("") 
				|| member.getMemberName() == null
				|| member.getMemberAddress().equals("")
				|| member.getMemberAddress() == null
				|| member.getMemberEmail().equals("")
				|| member.getMemberEmail() == null
				|| member.getMemberBirth().equals("")
				|| member.getMemberBirth() == null
				|| member.getMemberHiredate().equals("")
				|| member.getMemberBirth() == null
				|| member.getMemberPhone().equals("")
				|| member.getMemberPhone() == null
				|| member.getMemberRank().equals("")
				|| member.getMemberRank() == null
				|| member.getMemberLevel().equals("")
				|| member.getMemberLevel() == null
				|| member.getMemberHiredate().equals("")
				|| member.getMemberHiredate() == null) {
			return "redirect:/group/hrm/hrmList";
		}
		int addMemberRow = hrmService.addMember(member);
		log.debug("hrmController.addMemberRow-->" + addMemberRow);
		return "redirect:/group/hrm/hrmList";
	}
	// 사원 수정
	@PostMapping("/group/hrm/updateMember")
	public String updateMember(Member member) {
		if(member.getMemberRank().equals("")
				|| member.getMemberRank() == null
				|| member.getMemberLevel().equals("")
				|| member.getMemberLevel() == null) {
			return "redirect:/group/hrm/hrmList";
		}
		int updateRow = hrmService.updateMember(member);
		log.debug("hrmController.updateRow-->" + updateRow);
		return "redirect:/group/hrm/hrmList";
	}
	// 사원 퇴사
		@PostMapping("/group/hrm/deleteMember")
		public String deleteMember(Member member) {
			if(member.getMemberId().equals("")
					|| member.getMemberId() == null) {
				return "redirect:/group/hrm/hrmList";
			}
			int deleteRow = hrmService.deleteMember(member);
			log.debug("hrmController.deleteRow-->" + deleteRow);
			return "redirect:/group/hrm/hrmList";
	}
}
