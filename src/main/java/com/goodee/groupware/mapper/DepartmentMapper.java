package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Department;

@Mapper
public interface DepartmentMapper {
	// 부서 계층형 출력
	List<Map<String,Object>> getDepartmentList();
	
	// 부서 삭제
	int deleteDepartment(Department department);
	
	// 부서 추가
	int addDepartment(Department department);
	
	//사원 리스트
	List<Map<String,Object>> getMemberList();
	
	// 부서별 팀 리스트
	List<Map<String,Object>> getTeamDepartment(Department department);
}
