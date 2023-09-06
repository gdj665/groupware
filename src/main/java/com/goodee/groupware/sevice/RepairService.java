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
		
		log.debug("RepairService.getRepairList() map --->" + map.get("repairStatus"));
		log.debug("RepairService.getRepairList() repairList --->" + repairList.toString());
		
		int repairListCnt = repairMapper.getRepairListCnt(map);
		
		// 마지막 페이지 구하기
		int lastPage = repairListCnt / rowPerPage;
		if(repairListCnt % rowPerPage != 0) {
			lastPage += 1;
		}
		
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
		
		log.debug("RepairService.getRepairList() lastPage --->" + lastPage);
		
		// 수리완료 변경시 사용한 자재명과 개수 출력
		Parts parts = new Parts();
		List<Map<String,Object>> partsList = fixturesMapper.getPartsList(parts);
		log.debug("RepairService.getRepairList() partsList --->" + partsList.toString());
		
		// 반환할 resultMap
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("repairList", repairList);
		resultMap.put("lastPage", lastPage);
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		resultMap.put("partsList", partsList);
		
		return resultMap;
	}
	
	// 2.1) repair목록 엑셀 출력
	public List<Map<String,Object>> getRepairExcelLIst(Repair repair) {
		log.debug("RepairService.getRepairExcelLIst() Param repair --->" + repair.toString());
		
		List<Map<String,Object>> repairExcelList = repairMapper.getRepairExcelList(repair);
		log.debug("RepairService.getRepairExcelLIst() repairExcelList --->" + repairExcelList.toString());
		
		return repairExcelList;
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

			            log.debug("RepairService.updateRepair() 수리중 -> 수리완료 자재 개수 차감 minusPartsMap --->" + minusPartsMap.toString());
			            
			            // repairNo는 필요없으니 이것만 넣고 돌림
						partsMinusCntRow = fixturesMapper.updatePartsCnt(minusPartsMap);
						
						// 자재 차감후 개수가 0 이되면 비활성화 시키기
						int DisabledRow = 0;
						// 개수 차감된 자재에 총개수 가져오기
						Parts partsCheckCnt = fixturesMapper.getPartsCntCheck(minusPartsMap);
						// 개수가 0이 면 실행
						if(partsCheckCnt.getPartsCnt() == 0) {
							// 해당 자재 비활성화 시키기
							DisabledRow = fixturesMapper.updateParatsAlive(partsCheckCnt);
							log.debug("RepairService.updateRepair() 수리중 -> 수리완료 자재 개수0될시 비활성 DisabledRow--->" + DisabledRow);
						
						// 차감됬는데 개수가 0보다 작아지면 return시킴
						} else if(partsCheckCnt.getPartsCnt() < 0) {
							
							int returnRow = -1;
							return returnRow;
						}
					}
					
				}
			}
			// else if 실행시 반환값
			return partsMinusCntRow;
		}
		// if 실행시 반환값
		return repairRow;
	}
	
	// 3.1) 수리완료 상세보기
	public Map<String,Object> getCompletedOne(Repair repair) {
		
		// 매개변수로 repairNo를 받아서 맵퍼 호출
		// repair테이블 출력
		Map<String,Object> completedOne = repairMapper.getCompletedOne(repair);
		log.debug("RepairService.getCompletedOne() completedOne--->" + completedOne.toString());
		// repair테이블에 사용한 자재 목록 출력
		List<Map<String,Object>> completedOneFixturesList = repairMapper.getCompletedOneFixturesList(repair);
		log.debug("RepairService.getCompletedOne() completedOneFixturesList--->" + completedOneFixturesList.toString());
		
		// 반환할 맵에 불러온 데이터 담는다
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("completedOne", completedOne);
		resultMap.put("completedOneFixturesList", completedOneFixturesList);
		
		return resultMap;
	}
	
}
