package com.goodee.groupware.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.goodee.groupware.sevice.DepartmentService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	@GetMapping("department/departmentList")
		public String getDepartmentList(Model model) {
		
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		
		log.debug("DepartmentCotroller.getDepartmentList()-->" + resultMap);
		
		return "/department/departmentList";
	}
}
