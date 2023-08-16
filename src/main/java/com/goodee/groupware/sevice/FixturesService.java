package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.FixturesMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class FixturesService {
	@Autowired
	private FixturesMapper fixturesMapper;
	
	// 자재 리스트
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
		
		// 결과값을 반환하는 resultMap
		Map<String, Object> resultMap = new HashMap<>();
		
		resultMap.put("fixturesList", fixturesList);
		resultMap.put("lastPage", lastPage);
		log.debug("FixturesService.getFixturesList() resultMap --->" + resultMap.toString());
		
		return resultMap;
	}
}
