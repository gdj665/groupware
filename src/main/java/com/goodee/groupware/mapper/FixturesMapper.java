package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FixturesMapper {
	// 자재리스트 parts테이블과 parts_category join 사용
	List<Map<String, Object>> getFixturesList(Map<String,Object> fixturesMap);
	// 자재리스트 전체 행의 수
	int getFixturesListCount(String partsName);
}
