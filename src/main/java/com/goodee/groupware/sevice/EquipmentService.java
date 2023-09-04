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

import com.goodee.groupware.mapper.EquipmentHistoryMapper;
import com.goodee.groupware.mapper.EquipmentMapper;
import com.goodee.groupware.vo.Equipment;
import com.goodee.groupware.vo.EquipmentHistory;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class EquipmentService {
	@Autowired
	private EquipmentMapper equipmentMapper;
	@Autowired
	private EquipmentHistoryMapper eqHistoryMapper;
	
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
		
		// 페이지 네비게이션 페이징
		int pagePerPage = 5;
		
		// 마지막 페이지 구하기
		// 최소페이지,최대페이지 구하기
		int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
		int maxPage = minPage + (pagePerPage -1);
		
		// maxPage가 마지막 페이지를 넘어가지 않도록 함
		if(maxPage > lastPage) {
			maxPage = lastPage;
		}
		
		// 결과값을 반환하는 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("equipmentList", equipmentList);
		resultMap.put("lastPage", lastPage);	
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		
		log.debug("EquipmentService.getEquipmentList()) resultMap --->" + resultMap.toString());
		
		return resultMap;
	}
	
	// 1.1) 장비 목록 엑셀 출력
	public List<Map<String,Object>> getEquipmentExcelList() {
		
		// 엑셀 맵퍼 호출
		List<Map<String,Object>> equipmentExcelLIst = equipmentMapper.getEquipmentExcelList();
		log.debug("EquipmentService.getEquipmentExcelList() equipmentExcelLIst --->" + equipmentExcelLIst.toString());

		return equipmentExcelLIst;
	}
	
	// 2) 장비 추가
	public int addEquipment(Equipment equipment) {
		
		// 추가 매퍼 호출
		int row = equipmentMapper.addEquipment(equipment);
		// 추가된 행 개수 반환
		return row;
	}
	
	// 3) 장비 비활성화
	public int updateEquipment(Equipment equipment) {
		
		// 비활성화 매퍼 호출 
		int row = equipmentMapper.updateEquipment(equipment);
		
		// 비활성화된 행 개수 반환
		return row;
	}
	
	// 4) 장비 점검업데이트
	public int updateEquipmentInspect(Equipment equipment) {
		
		// 업데이트 매퍼 호출
		int row = equipmentMapper.updateEquipmentInspect(equipment);
		
		// 업데이트된 행 개수 반환
		return row;
	}
	
	// 5) 장비 상세보기
	public Map<String,Object> getEquipmentOne(Equipment equipment, int currentPage, int rowPerPage, EquipmentHistory eqHistory, Member member) {
		
		// 장비 상세보기 매퍼 호출
		Map<String,Object> equipmentOne = equipmentMapper.getEquipmentOne(equipment);
		
		// 장비 상세보기 내부 해당장비 사용내역 리스트 페이징 값을 담을 맵
		Map<String,Object> pageMap = new HashMap<>();
		
		// 페이징 작업
		int beginRow = (currentPage -1) * rowPerPage;
				
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("memberName", member.getMemberName());
		pageMap.put("equipmentNo", eqHistory.getEquipmentNo());
		log.debug("EquipmentService.getEquipmentOne() pageMap --->" + pageMap.toString());
		
		// 페이징 값을 매개변수로 한 해당장비 사용내역 목록 매퍼 EquipmentHistoryMapper 여기서 호출
		List<Map<String,Object>> eqHistoryList = eqHistoryMapper.getEqHistoryList(pageMap);
		log.debug("EquipmentService.getEquipmentOne() eqHistoryList --->" + eqHistoryList.toString());
		
		// 페이징을 위한 총행의 개수 매퍼 호출
		int eqHistoryListCnt = eqHistoryMapper.getEqHistoryListCnt(pageMap);
		log.debug("EquipmentService.getEquipmentOne() eqHistoryListCnt --->" + eqHistoryListCnt);

		// 마지막 페이지 구하기
		int lastPage = eqHistoryListCnt / rowPerPage;
		if(eqHistoryListCnt % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("EquipmentService.getEquipmentOne() lastPage --->" + lastPage);
		
		// 반환값을 넣은 resultMap 
		Map<String,Object> resultMap = new HashMap<>();
		// 상세보기
		resultMap.put("equipmentOne", equipmentOne);
		// 사용내역 목록
		resultMap.put("eqHistoryList", eqHistoryList);
		// 페이징 값
		resultMap.put("lastPage", lastPage);
		
		return resultMap;
	}

}
