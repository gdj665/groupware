package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.FixturesMapper;
import com.goodee.groupware.mapper.RepairMapper;
import com.goodee.groupware.vo.Parts;
import com.goodee.groupware.vo.Repair;
import com.goodee.groupware.vo.RepairParts;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class RepairService {
	@Autowired
	private RepairMapper repairMapper;
	@Autowired
	private FixturesMapper fixturesMapper;
	
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
		
		// 수리완료 변경시 사용한 자재명과 개수 출력
		Parts parts = new Parts();
		List<Map<String,Object>> partsList = fixturesMapper.getPartsList(parts);
		log.debug("RepairService.getRepairList() partsList --->" + partsList.toString());
		
		// 반환할 resultMap
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("repairList", repairList);
		resultMap.put("lastPage", lastPage);
		resultMap.put("partsList", partsList);
		
		return resultMap;
	}
	
	// 3) repair 대기중 -> 수리중 -> 수리완료 수정
	public int updateRepair(Repair repair, RepairParts repairParts, Parts parts) {
		
		log.debug("RepairService.updateRepair() Param repair --->" + repair.toString());
		
		
		// 결과값 받을 변수
		int repairRow = 0;
		int repair_partsRow = 0;
		int partsMinusCntRow = 0;
		
		// memberId 가 null이 아니면 대기중 -> 수리중 수정이기 때문에 repair_parts는 실행x
		if(repair.getMemberId() != null) {
			repairRow = repairMapper.updateRepair(repair);
		// repairContent가 null이 아니면 수리중 -> 수리완료 수정이기 때문에 자재 사용내역 값도 repairParts vo에 함께 넘어옴 그러므로 repair_parts 테이블 추가
			
		} else if(repair.getRepairContent() != null) {
			repairRow = repairMapper.updateRepair(repair);
			
			// repairRow가 수정된 내용이 있어야 repair_parts테이블이 추가되므로 repairRow가 0보다 클때만 실행
			if(repairRow > 0) {
				log.debug("RepairService.updateRepair() Param repairParts --->" + repairParts.toString());
				repair_partsRow = repairMapper.addRepairParts(repairParts);
				
				if(repair_partsRow > 0) {
					log.debug("RepairService.updateRepair() Param parts --->" + parts.toString());
					partsMinusCntRow = fixturesMapper.updatePartsCnt(parts);
					
				}
			}
			// else if 실행시 반환값
			return partsMinusCntRow;
		}
		// if 실행시 반환값
		return repairRow;
	}
	
	
}
