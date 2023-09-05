package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.DepartmentService;
import com.goodee.groupware.vo.Department;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	// 리스트 출력 
	@GetMapping("/group/department/departmentList")
		public String getDepartmentList(Model model,
										HttpSession session) {
		
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		String memberId = (String) session.getAttribute("loginMember");
		model.addAttribute("memberId", memberId);
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		model.addAttribute("getDeleteOnDepartmentList", resultMap.get("getDeleteOnDepartmentList"));
		
		log.debug("DepartmentCotroller.getDepartmentList()-->" + resultMap);
		
		return "/department/departmentList";
	}
	// 부서추가
		@PostMapping("/group/department/addDepartment")
		public String addDepartment(Department department) {
			// 유효성검사
			if(department.getDepartmentId().equals("") || department.getDepartmentId() == null) {
				
			}
			// 현재부서의 가장 높은 번호 가져오기
			int MaxDepartmentNo = departmentService.getMaxDepartmentNo(department);
			// 가장높은 부서번호에 + 1해서 값 넣기
			int addDepartmentNo = 1;
			department.setDepartmentNo(MaxDepartmentNo+addDepartmentNo);
			//추가하는 부서 DB에 값 넣기
			int row = departmentService.addDepartment(department);
			if(row > 0) {
				System.out.println("DepartmentController 부서 추가 성공" + row);
			}else {
				System.out.println("DepartmentController 부서 추가 실패" + row);
			}
			return "redirect:/group/department/departmentList";
		}
	// 부서 이동
		@PostMapping("/group/department/updateDepartment")
		public String updateDepartment( @RequestParam(name="littleDepartment", defaultValue="0") int departmentNo,
										@RequestParam(name="memberId") String memberId){
			log.debug("DepartmentCotroller.@RequestParam()-->" + departmentNo + memberId);
			Member member = new Member();
			member.setMemberId(memberId);
			member.setDepartmentNo(departmentNo);
			int row = departmentService.updateDepartment(member);
			log.debug("DepartmentCotroller.row()-->" + departmentNo + memberId + row);
			return "redirect:/group/department/departmentList";
		}
		
	// 부서 삭제
		@PostMapping("/group/department/deleteDepartment")
		public String deleteDepartments(Department department) {
			
		    int deletedCount = departmentService.deleteDepartments(department);
		    log.debug("DepartmentCotroller.deletedCount()-->" + deletedCount);
		    return "redirect:/group/department/departmentList";
		}

		
}
