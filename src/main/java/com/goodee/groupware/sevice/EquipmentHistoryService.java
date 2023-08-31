package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.EquipmentHistoryMapper;
import com.goodee.groupware.vo.Equipment;
import com.goodee.groupware.vo.EquipmentHistory;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class EquipmentHistoryService {
	@Autowired
	private EquipmentHistoryMapper eqHistoryMapper;
	
	// 1) 장비사용내역 추가 및 장비상태 업데이트
	public int addEqHistry(EquipmentHistory eqHistory, Equipment equipment) {
		
		// 장비사용내역 추가 매퍼 호출
		int historyRow = eqHistoryMapper.addEqHistory(eqHistory);
		
		// 장비상태 대여로 업데이트한 행 반환 변수
		int eqStatusRow =0;
		
		// 장비사용내역이 추가되어야 장비가 대여로 업데이트됨
		
		if(historyRow > 0) {
			eqStatusRow = eqHistoryMapper.updateEquipmentStatus(equipment);
			log.debug("EquipmentHistoryService.addEqHistry() eqStatusRow --->" + eqStatusRow);
		}
		return eqStatusRow;
	}
	
	// 1.1) 장비 반납 업데이트
	public int updateEquipment(Equipment equipment, EquipmentHistory eqHistory) {
		int endRow = 0;
		
		// 장비 비대여로 업데이트 매퍼 호출
		int row = eqHistoryMapper.updateEquipmentStatus(equipment);
		
		// 장비가 비대여로 수정되었을시 사용내역테이블 enddate날짜 현재날짜로 변경
		if(row > 0) {
			endRow = eqHistoryMapper.updateEqHistoryEnddate(eqHistory);
		}
		return endRow;
	}
	
	// 2) 장비 사용내역 목록(장비 상세보기에서 해당장비 사용내역 출력) (EquipmentController에서 호출함)
	public Map<String,Object> getEqHistoryList(int currentPage, int rowPerPage, EquipmentHistory eqHistory) {
		
		// 페이징 작업
		int beginRow = (currentPage -1) * rowPerPage;
		// 페이징 && 검색을 위한 변수를 맵에 담아 사용한다.
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("memberId", eqHistory.getMemberId());
		pageMap.put("equipmentNo", eqHistory.getEquipmentNo());
		
		// 장비 사용내역 목록 메서드 호출 페이징을 위해 만든 pageMap을 매개변수로 한다.
		List<Map<String,Object>> eqHistoryList = eqHistoryMapper.getEqHistoryList(pageMap);
		log.debug("EquipmentHistoryService.getEqHistoryList() eqHistoryList --->" + eqHistoryList.toString());
		
		// 장비 사용내역 목록에 전체행의 개수를 구하는 메서드 호출
		
		int eqHistoryListCnt = eqHistoryMapper.getEqHistoryListCnt(pageMap);
		log.debug("EquipmentHistoryService.getEqHistoryList() eqHistoryListCnt --->" + eqHistoryListCnt);
		
		// 마지막 페이지 구하기
		int lastPage = eqHistoryListCnt / rowPerPage;
		if(eqHistoryListCnt % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("EquipmentHistoryService.getEqHistoryList() lastPage --->" + lastPage);
		
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
		
		resultMap.put("eqHistoryList", eqHistoryList);
		resultMap.put("lastPage", lastPage);	
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		
		return resultMap;
	}
	
	// 3) 장비 사용내역(본인 아이디값으로 본인이 사용한 장비내역 출력)
	public Map<String,Object> getEqHistoryListById(int currentPage, int rowPerPage, String memberId, String equipmentName) {
		// 페이징 작업
		int beginRow = (currentPage -1) * rowPerPage;
		// 페이징 && 검색을 위한 변수를 맵에 담아 사용한다.
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("memberId", memberId);
		pageMap.put("equipmentName", equipmentName);
		
		// 장비 사용내역 목록 메서드 호출 페이징을 위해 만든 pageMap을 매개변수로 한다.
		List<Map<String, Object>> eqHistoryListById = eqHistoryMapper.getEqHistoryListById(pageMap);
		log.debug("EquipmentHistoryService.getEqHistoryListById() eqHistoryListById --->" + eqHistoryListById.toString());
		
		int eqHistoryListByIdCnt = eqHistoryMapper.getEqHistoryListByIdCnt(pageMap);
		log.debug("EquipmentHistoryService.getEqHistoryListById() eqHistoryListByIdCnt --->" + eqHistoryListByIdCnt);
		
		// 마지막 페이지 구하기
		int lastPage = eqHistoryListByIdCnt / rowPerPage;
		if(eqHistoryListByIdCnt % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("EquipmentHistoryService.getEqHistoryListById() lastPage --->" + lastPage);
		
		// 결과값 반환 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("eqHistoryListById", eqHistoryListById);
		resultMap.put("lastPage", lastPage);
		
		return resultMap;
	}

}
