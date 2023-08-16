package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DepartmentMapper {
	// 부서 계층형 출력
	List<Map<String,Object>> getDepartmentList();
}
