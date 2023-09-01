package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Equipment;
import com.goodee.groupware.vo.EquipmentHistory;

@Mapper
public interface EquipmentHistoryMapper {
	
	// 1) 장비 사용내역 추가 
	int addEqHistory (EquipmentHistory eqHistroy);
	
	// 1.1) 장비 대여시 대여로 변경 반납시 비대여로 변경
	int updateEquipmentStatus(Equipment equipment);
	// 1.2) 장비 반납시 equipment_history 테이블 equipment_enddate 현재날짜로 변경
	int updateEqHistoryEnddate(EquipmentHistory eqHistory);
	
	// 2) 장비 사용내역 리스트(장비상세보기에서 해당장비 사용내역만 나옴)
	List<Map<String,Object>> getEqHistoryList (Map<String,Object> eqHistoryMap); 
	
	// 2.1) 장비 사용내역 리스트 총행의 개수(장비상세보기에서 해당장비 사용내역만 나옴)
	int getEqHistoryListCnt (Map<String,Object> pageMap);
	
	// 3) 장비 사용내역 세션아이디값으로 조회해 자신이 사용한 장비 기록 목록
	List<Map<String,Object>> getEqHistoryListById (Map<String,Object> eqHistoryByIdMap);
	
	// 3.1) 장비 사용내역 세션아이디값으로 조회해 자신이 사용한 장비 기록 목록 총 행의 개수
	int getEqHistoryListByIdCnt (Map<String, Object> eqHistoryByIdCntMap);
}
