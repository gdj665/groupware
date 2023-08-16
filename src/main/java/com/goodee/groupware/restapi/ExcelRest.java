package com.goodee.groupware.restapi;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.FixturesService;

@RestController
public class ExcelRest {
	@Autowired 
	private FixturesService fixturesService;
	
	@GetMapping("fixtures/fixturesExcel")
	public List<Map<String,Object>> fixturesExcel(@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
													@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage,
													@RequestParam(name ="partsName", required = false) String partsName) {
		// excel로 뽑을 list
		List<Map<String,Object>> fixturesList = new ArrayList<>();
		// list데이터를 Service를 호출하여 불러옴
		Map<String,Object> fixturesListMap = fixturesService.getFixturesList(currentPage, rowPerPage, partsName);
		// 뽑을 list 안에다가 Service에서 가져온 값을 넣는다.
		fixturesList.add(fixturesListMap);
		return fixturesList;
	}
	
	
}
