package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.EquipmentMapper;
import com.goodee.groupware.vo.Equipment;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class EquipmentService {
	@Autowired
	private EquipmentMapper equipmentMapper;
	
	// 1) 장비 목록 리스트(검색, 페이징)
	public Map<String, Object> getEquipmentList(int currentPage, int rowPerPage, String equipmentName) {
		
		// 페이징 작업
		int beginRow = (currentPage -1) * rowPerPage;
		
		// 페이징 && 검색을 위한 변수를 맵에 담아 사용한다.
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("equipmentName", equipmentName);
		
		// 장비리스트메서드 호출 페이징을 위해 만든 pageMap을 매개변수로 한다.
		List<Map<String,Object>> equipmentList = equipmentMapper.getEquipmentList(pageMap);
		log.debug("EquipmentService.getEquipmentList() equipmentList --->" + equipmentList.toString());
		
		// 장비리스트에 전체행의 개수를 구하는 메서드 호출
		int equipmentListCount = equipmentMapper.getEquipmentListCnt(equipmentName);
		log.debug("EquipmentService.getEquipmentList() equipmentListCount --->" + equipmentListCount);
		
		// 마지막 페이지 구하기
		int lastPage = equipmentListCount / rowPerPage;
		if(equipmentListCount % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("EquipmentService.getEquipmentList() lastPage --->" + lastPage);
		
		// 결과값을 반환하는 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("equipmentList", equipmentList);
		resultMap.put("lastPage", lastPage);
		
		return resultMap;
	}
	
	// 2) 장비 추가
	public int addEquipment(Equipment equipment) {
		
		// 추가 매퍼 호출
		int row = equipmentMapper.addEquipment(equipment);
		// 추가된 행 개수 반환
		return row;
	}
	
	// 3) 장비 삭제
	public int deleteEquipment(Equipment equipment) {
		
		// 삭제 매퍼 호출 
		int row = equipmentMapper.deleteEquipment(equipment);
		
		// 삭제된 행 개수 반환
		return row;
	}
	
	// 4) 장비 점검업데이트
	public int updateEquipmentStatus(Equipment equipment) {
		
		// 업데이트 매퍼 호출
		int row = equipmentMapper.updateEquipmentStatus(equipment);
		
		// 업데이트된 행 개수 반환
		return row;
	}
}
