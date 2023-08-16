package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Parts;

@Mapper
public interface FixturesMapper {
	// 자재리스트 parts테이블과 parts_category join 사용
	List<Map<String, Object>> getFixturesList(Map<String,Object> fixturesMap);
	// 자재리스트 전체 행의 수
	int getFixturesListCount(String partsName);
	
	// 자재 추가(parts 테이블 추가)
	int addParts(Parts parts);
	
	// 자재 추가시 상위 카테고리 출력
	List<Map<String, Object>> getPartsCategoryList();
	
	// 자재 삭제
	int deleteParts(Parts parts);
}
