package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.FixturesMapper;
import com.goodee.groupware.vo.Parts;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class FixturesService {
	@Autowired
	private FixturesMapper fixturesMapper;
	
	// 1) 자재 리스트(검색, 페이징)
	public Map<String, Object> getFixturesList(int currentPage, int rowPerPage, String partsName) {
		
		// 페이징 작업
		int beginRow = (currentPage -1) * rowPerPage;
		
		// 페이징 && 검색을 위한 변수를 맵에 담아 사용한다.
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("beginRow", beginRow);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("partsName", partsName);
		log.debug("FixturesService.getFixturesList() pageMap --->" + pageMap.toString());
		
		// 자재리스트메서드 호출 페이징을 위해 만든 pageMap을 매개변수로 한다.
		List<Map<String,Object>> fixturesList = fixturesMapper.getFixturesList(pageMap);
		log.debug("FixturesService.getFixturesList() fixturesList --->" + fixturesList.toString());
		
		// 자재리스트에 전체행의 개수를 구하는 메서드 호출
		int fixturesListCount = fixturesMapper.getFixturesListCount(partsName);
		log.debug("FixturesService.getFixturesList() fixturesListCount --->" + fixturesListCount);
		
		// 마지막 페이지 구하기
		int lastPage = fixturesListCount / rowPerPage;
		if(fixturesListCount % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug("FixturesService.getFixturesList() lastPage --->" + lastPage);
		
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

		// 2번 서비스 에서 자재 추가시 상위 카테고리 목록 호출
		List<Map<String,Object>> partsCategoryList = fixturesMapper.getPartsCategoryList();
		log.debug("FixturesService.getFixturesList() partsCategoryList --->" + partsCategoryList.toString());
		
		// 결과값을 반환하는 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("fixturesList", fixturesList);
		resultMap.put("lastPage", lastPage);
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		resultMap.put("partsCategoryList", partsCategoryList);
		
		log.debug("FixturesService.getFixturesList() resultMap --->" + resultMap.toString());
		
		return resultMap;
	}
	
	// 1.1) 자재리스트 엑셀 restController에서 호출
	public List<Map<String, Object>> getFixturesExcelList() {
		List<Map<String,Object>> partsExcelList = fixturesMapper.getFixturesExcelList();
		log.debug("FixturesService.getFixturesList() partsExcelList --->" + partsExcelList.toString());
		return partsExcelList;
	}
	
	// 2) 자재 추가(parts 테이블 추가)
	public int addParts(Parts parts) {
		// 맵퍼에서 추가 메서드 호출
		 int row = fixturesMapper.addParts(parts);
		log.debug("FixturesService.addParts() row --->" + row);
		
		return row;
	}
	
	// 3) 자재 삭제(parts 테이블 삭제)
	public int updatePartsAlive(Parts parts) {
		// 맵퍼에서 삭제 메서드 호출
		 int row = fixturesMapper.updateParatsAlive(parts);
		return row;
	}
	
	// 수리완료시 사용자재 출력 // 분기해서 partsName 들어올 경우 개수 반환 
	public Map<String,Object> getPartsList(Parts parts) {
		
		// partsList 맵퍼 호출
		List<Map<String,Object>> partsList = fixturesMapper.getPartsList(parts);
		log.debug("FixturesService.getPartsList() partsList --->" + partsList.toString());
		
		// 결과값 반환할 resultMap
		Map<String,Object> resultMap = new HashMap<>();
		resultMap.put("partsList", partsList);
		
		return resultMap;
	}
	
	/*
	 * // repareService에서 사용됨) repair_parts에 사용된 목록이 추가가 되므로 parts테이블의 해당 자재의 개수가
	 * 사용된만큼 감소 public int updatePartsCnt(Parts parts) { // 맵퍼에서 Cnt갯수 감소시키는 메서드 호출
	 * int row = fixturesMapper.updatePartsCnt(parts);
	 * 
	 * return row; }
	 */
}
