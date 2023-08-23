package com.goodee.groupware.controller;

import java.util.Map;


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
	@GetMapping("/department/departmentList")
		public String getDepartmentList(Model model) {
		
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		model.addAttribute("getDeleteOnDepartmentList", resultMap.get("getDeleteOnDepartmentList"));
		
		log.debug("DepartmentCotroller.getDepartmentList()-->" + resultMap);
		
		return "/department/departmentList";
	}
	// 부서추가
		@PostMapping("/department/addDepartment")
		public String addDepartment(Department department) {
			int MaxDepartmentNo = departmentService.getMaxDepartmentNo(department);
			department.setDepartmentNo(MaxDepartmentNo+1);
			int row = departmentService.addDepartment(department);
			System.out.println("DepartmentController Rwow " + row);
			return "redirect:/department/departmentList";
		}
	// 부서 이동
		@PostMapping("/department/updateDepartment")
		public String updateDepartment( @RequestParam(name="littleDepartment", defaultValue="0") int departmentNo,
										@RequestParam(name="memberId") String memberId){
			log.debug("DepartmentCotroller.@RequestParam()-->" + departmentNo + memberId);
			Member member = new Member();
			member.setMemberId(memberId);
			member.setDepartmentNo(departmentNo);
			int row = departmentService.updateDepartment(member);
			log.debug("DepartmentCotroller.row()-->" + departmentNo + memberId + row);
			return "redirect:/department/departmentList";
		}
		
	// 부서 삭제
		@PostMapping("/department/deleteDepartment")
		public String deleteDepartments(Department department) {
			
		    int deletedCount = departmentService.deleteDepartments(department);
		    log.debug("DepartmentCotroller.deletedCount()-->" + deletedCount);
		    return "redirect:/department/departmentList";
		}

		
}
