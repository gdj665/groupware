package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.DepartmentMapper;
import com.goodee.groupware.vo.Department;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	// 부서 리스트
	public Map<String,Object> getDepartmentList(){
		List<Map<String,Object>> departmentList = departmentMapper.getDepartmentList();
		// departmentList 디버깅
		log.debug("DepartmentService.getDepartmentList()-->" + departmentList);
		
		// 사원 리스트
		List<Map<String,Object>> memberList = departmentMapper.getMemberList();
		log.debug("DepartmentService.getMemberList()-->" + memberList);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("department", departmentList);
		resultMap.put("memberList", memberList);
		return resultMap;
	}
	
	// 게시물 추가
	public int addDepartment(Department department) {
		int row = departmentMapper.addDepartment(department);
		return row;
	}
}
