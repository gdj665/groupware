package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Parts;

@Mapper
public interface FixturesMapper {
	// 1) 자재리스트 parts테이블과 parts_category join 사용
	List<Map<String, Object>> getFixturesList(Map<String,Object> fixturesMap);
	// 1.1) 자재리스트 전체 행의 수
	int getFixturesListCount(String partsName);
	// 1.2) 자재 엑셀 리스트
	List<Map<String, Object>> getFixturesExcelList();
	
	// 2) 자재 추가(parts 테이블 추가)
	int addParts(Parts parts);
	
	// 2.1) 자재 추가시 상위 카테고리 출력
	List<Map<String, Object>> getPartsCategoryList();
	
	// 3) 자재 비활성화
	int updateParatsAlive(Parts parts);
	
	// repairService 2번에서 사용 수리완료시 사용자재 출력  
	List<Map<String,Object>> getPartsList(Parts parts);
	
	// repareService에서 사용됨) repair_parts에 사용된 목록이 추가가 되므로 parts테이블의 해당 자재의 개수가 사용된만큼 감소
	int updatePartsCnt(Map<String,Object> minusPartsMap);
	
	// repair_parts에 사용된 자재가 0이되면 비활성화 시키기 위해 0이된 항목 조회에 사용
	Parts getPartsCntCheck (Map<String,Object> ParamMap);
}
