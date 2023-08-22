package com.goodee.groupware.restapi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.FixturesService;
import com.goodee.groupware.vo.Parts;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class ExcelRest {
	@Autowired 
	private FixturesService fixturesService;
	
	// fixturesList 엑셀다운
	@GetMapping("/fixtures/fixturesExcel")
	public Map<String,Object> fixturesExcel(@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
													@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage,
													@RequestParam(name ="partsName", required = false) String partsName) {
		// excel로 뽑을 list
		// list데이터를 Service를 호출하여 불러옴
		Map<String,Object> fixturesListMap = fixturesService.getFixturesList(currentPage, rowPerPage, partsName);
		// 뽑을 list 안에다가 Service에서 가져온 값을 넣는다.
		
		return fixturesListMap;
	}
	
	// parts 비동기 처리
	@GetMapping("/parts/getPartsCntList")
	public Map<String,Object> partsCntLIst(@RequestParam String partsName) {
		Map<String, Object> resultMap = new HashMap<>();
		
		log.debug("ExcelRest.partsCntLIst() Param partsName --->" + partsName);
		
		Parts parts = new Parts();
		parts.setPartsName(partsName);
		
		// 서비스 호출
		Map<String, Object> partsInfo = fixturesService.getPartsList(parts); // fixturesService에서 parts 정보 가져오기
	    
	    resultMap.put("partsCnt", partsInfo.get("partsCnt"));
		
		return resultMap;
	}
	
	
}
