package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Equipment;


@Mapper
public interface EquipmentMapper {
	// 1) 장비 목록
	List<Map<String, Object>> getEquipmentList(Map<String,Object> equipmentMap);
	// 1.1) 장비 목록 페이징위한 전체 행개수
	int getEquipmentListCnt(String equipmentName);
	
	// 2) 장비 추가
	int addEquipment(Equipment equipment);
	
	// 3) 장비 비활성화
	int updateEquipment(Equipment equipment);
	
	// 4) 장비 점검일자 갱신
	int updateEquipmentInspect(Equipment equipment);
	
	// 5) 장비 상세보기
	Map<String,Object> getEquipmentOne(Equipment equipment);
	
}
