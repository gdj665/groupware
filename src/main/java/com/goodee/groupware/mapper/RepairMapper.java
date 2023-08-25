package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Repair;
import com.goodee.groupware.vo.RepairParts;

@Mapper
public interface RepairMapper {
	
	// 1) as접수시 repair테이블에 추가
	int addRepair(Repair repair);
	
	// 2) repair리스트 
	List<Map<String,Object>> getRepairList(Map<String,Object> repairListMap);
	
	// 2.1) repair리스트의 총 행 개수
	int getRepairListCnt(Map<String, Object> pageMap);
	
	// 3) repair 대기중->수리중->수리완료 수정
	int updateRepair(Repair repair);
	
	// 3.1) 수리완료시 repair_parts(수리 자재사용 테이블)추가
	int addRepairParts(Map<String,Object> repairPartsMap);
	
}
