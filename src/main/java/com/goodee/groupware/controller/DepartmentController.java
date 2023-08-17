package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.groupware.sevice.DepartmentService;
import com.goodee.groupware.vo.Department;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	// 리스트 출력 
	@GetMapping("department/departmentList")
		public String getDepartmentList(Model model) {
		
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		
		log.debug("DepartmentCotroller.getDepartmentList()-->" + resultMap);
		
		return "/department/departmentList";
	}
	
	// 부서추가
		@GetMapping("department/addDepartment")
		public String addDepartment() {
			return "department/addDepartment";
		}
		@PostMapping("department/addDepartment")
		public String addDepartment(Department department) {
			//매개값으로 request객체를 받는다 <- request api를 직접 호출하기 위해서
			int row = departmentService.addDepartment(department);
			System.out.println("DepartmentController Rwow " + row);
			return "redirect:/department/departmentList";
		}
}