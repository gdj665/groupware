package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.DepartmentMapper;
import com.goodee.groupware.vo.Department;
import com.goodee.groupware.vo.Member;

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
		
		// 삭제 가능한 부서 리스트
		List<Map<String,Object>> getDeleteOnDepartmentList = departmentMapper.getDeleteOnDepartmentList();
		
		//Map에 값을 담아 리턴
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("department", departmentList);
		resultMap.put("memberList", memberList);
		resultMap.put("getDeleteOnDepartmentList", getDeleteOnDepartmentList);
		return resultMap;
	}
	
	// 게시물 추가
	public int addDepartment(Department department) {
		int row = departmentMapper.addDepartment(department);
		return row;
	}
	
	// 부서별 팀 출력
	public Map<String, Object> getTeamDepartment(Department department){
		List<Map<String,Object>> teamDepartmentList = departmentMapper.getTeamDepartment(department);
		
		Map<String,Object> teamResultMap = new HashMap<String,Object>();
		teamResultMap.put("teamDepartmentList", teamDepartmentList);
		log.debug("DepartmentService.getTeamDepartment()-->" + teamResultMap);
		
		return teamResultMap;
	}
	// 부서 이동
	public int updateDepartment(Member member) {
		int row = departmentMapper.updateDepartment(member);
		return row;
	}
	
	// 부서 추가시 가장 큰 부서넘버 가져오기
	public int getMaxDepartmentNo(Department department) {
		int row = departmentMapper.getMaxDepartmentNo(department);
		return row;
	}
	
	// 부서 삭제시 체크된 부서 for문으로 삭제
	public int deleteDepartments(Department department) {
		// 선택된 부서들을 삭제하는 로직 구현
		int deletedCount = departmentMapper.deleteDepartment(department);
		return deletedCount;
	}
}
