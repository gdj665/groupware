package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Equipment;


@Mapper
public interface EquipmentMapper {
	// 장비 목록
	List<Map<String, Object>> getEquipmentList(Map<String,Object> equipmentMap);
	// 장비 목록 페이징위한 전체 행개수
	int getEquipmentListCnt(String equipmentName);
	
	// 장비 추가
	int addEquipment(Equipment equipment);
	
	// 장비 삭제
	int deleteEquipment(Equipment equipment);
	
	// 장비 점검일자 갱신
	int updateEquipmentStatus(Equipment equipment);
}
