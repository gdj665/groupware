package com.goodee.groupware.sevice;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
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
		
		// 현재 날짜를 가져옵니다.
        LocalDate now = LocalDate.now();
		
		// 각 장비의 정보를 순회하면서 날짜 비교와 일 수 차이 계산을 수행합니다.
        for(Map<String, Object> equipment : equipmentList) {
        	// equipment에서 nextinsepct날짜를 (Date)타입으로 형변환 해준 후 nextinspectDate에 담습니다. // Date클래스는 날짜정보와 시간정보까지 담고 있습니다.
            Date nextinspectDate = (Date) equipment.get("nextinspect");
            // 만약 담긴 날짜가 있다면 
            if (nextinspectDate != null) {
                // Date를 LocalDate로 (LocalDate는 날짜 정보만을 담고 있는 클래스) 변환합니다. -> 날짜만 비교할 것이니 Date클래스의 시간정보는 필요없어 변환하는 것
                LocalDate nextInspectLocalDate = nextinspectDate.toLocalDate();

                // 현재 날짜 now와 점검 예정일 nextInspectLocalDate 사이의 일 수 차이를 계산합니다. -> ChronoUnit.DAYS.between() 메서드를 사용해(두 날짜를 일단위로 계산해준다)
                long daysUntilNextInspect = ChronoUnit.DAYS.between(now, nextInspectLocalDate);

                log.debug("EquipmentService.getEquipmentList() 현재날짜:" + now +"점검예정일 :" + equipment.get("nextinspect") + "점검 D-day" + daysUntilNextInspect);
                // equipmentList에 해당 장비의 일 수 차이를 추가시킨다.
                equipment.put("daysUntilNextInspect", daysUntilNextInspect);
            }
        }	
		
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
