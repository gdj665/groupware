package com.goodee.groupware.sevice;

import java.util.ArrayList;
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
	public int updateRepair(Repair repair, RepairParts repairParts, int[] partsNoArr, int[] partsCntArr) {
		
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
				
				
				// for문돌리기 사용한 자재수만큼 테이블의 각행 추가
				for(int i=0;  i < partsNoArr.length; i++) {
					
					// ArrayList에다가 값을 집어넣음
					Map<String, Object> repairPartsMap = new HashMap<>();
		            repairPartsMap.put("repairNo", repair.getRepairNo());
		            repairPartsMap.put("partsNo", partsNoArr[i]);
		            repairPartsMap.put("repairPartsCnt", partsCntArr[i]);
		            
		            log.debug("RepairService.updateRepair() 수리중 -> 수리완료 repairPartsMap 시작 --->" + repairPartsMap.toString());
		            // 집어넣은 값을 순차적으로 돌며 repair_parts테이블 추가
					repair_partsRow = repairMapper.addRepairParts(repairPartsMap);
					log.debug("RepairService.updateRepair() 수리중 -> 수리완료 repairPartsMap 끝 --->");
				}
				
				// repair_parts테이블이 추가가됬다면 실행
				// 사용한 자재의 수만큼 감소시키기 자재가 여러개일 수 있으니 for문사용
				if(repair_partsRow > 0) {
					for(int i=0; i < partsNoArr.length; i++) {
						// ArrayList에다가 값을 집어넣고 위와 같이
						Map<String, Object> minusPartsMap = new HashMap<>();
						minusPartsMap.put("partsNo", partsNoArr[i]);
						minusPartsMap.put("partsCnt", partsCntArr[i]);

			            log.debug("RepairService.updateRepair() 수리중 -> 수리완료 minusPartsMap22222 --->" + minusPartsMap.toString());
			            
			            // repairNo는 필요없으니 이것만 넣고 돌림
						partsMinusCntRow = fixturesMapper.updatePartsCnt(minusPartsMap);
					}
					
				}
			}
			// else if 실행시 반환값
			return partsMinusCntRow;
		}
		// if 실행시 반환값
		return repairRow;
	}
	
	
}
