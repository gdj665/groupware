package com.goodee.groupware.restapi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.DepartmentService;

@CrossOrigin
@RestController //json을 반환하는 메서드를 가짐
public class DepartmentRest {
	@Autowired
	private DepartmentService departmentService;
	
	//@GetMapping
	//public List<Map<String, Object>> getTeamDepartmentList(){
	//	return;
	//}
}
