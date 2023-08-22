package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.RepairMapper;
import com.goodee.groupware.vo.Repair;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class RepairService {
	@Autowired
	private RepairMapper repairMapper;
	
	// 1) as접수시 repair테이블 추가
	public int addRepair(Repair repair) {
		// 추가 매퍼 호출
		int row = repairMapper.addRepair(repair);
		
		return row;
	}
	
	// 2) as 목록 출력(대기중,수리중,수리완료)
	public Map<String,Object> getRepairList(Map<String,Object> map) {
		
		// 페이징 작업
		int currentPage = (int) map.get("currentPage");
		int rowPerPage = (int) map.get("rowPerPage");
		
		int beginRow = (currentPage-1) * rowPerPage;
		map.put("beginRow", beginRow);
		
		// 페이징 맵
		// Map<String,Object> pageMap = new HashMap<>();
		//pageMap.put("rowPerPage", rowPerPage);
		//pageMap.put("beginRow", beginRow);
		//log.debug("RepairService.getRepairList() pageMap --->" + pageMap.toString());
		
		List<Map<String,Object>> repairList = repairMapper.getRepairList(map);
		log.debug("RepairService.getRepairList() repairList --->" + repairList.toString());
		
		int repairListCnt = repairMapper.getRepairListCnt(map);
		
		// 마지막 페이지 구하기
		int lastPage = repairListCnt / rowPerPage;
		if(repairListCnt % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("RepairService.getRepairList() lastPage --->" + lastPage);
		
		// 반환할 resultMap
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("repairList", repairList);
		resultMap.put("lastPage", lastPage);
		
		return resultMap;
	}
	
	// 3) repair 대기중 -> 수리중 -> 수리완료 수정
	public int updateRepair(Repair repair) {
		
		int row = repairMapper.updateRepair(repair);
		
		return row;
	}
	
	
}
