package com.goodee.groupware.restapi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.goodee.groupware.sevice.EquipmentService;
import com.goodee.groupware.sevice.FixturesService;
import com.goodee.groupware.sevice.RepairService;
import com.goodee.groupware.vo.Parts;
import com.goodee.groupware.vo.Repair;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class ExcelRest {
	@Autowired 
	private FixturesService fixturesService;
	@Autowired
	private EquipmentService equipmentService;
	@Autowired
	private RepairService repairService;
	
	// 1) fixturesList(자재목록) 엑셀다운
	@GetMapping("/fixtures/fixturesExcel")
	public List<Map<String,Object>> fixturesExcel() {
		// excel로 뽑을 list
		// list데이터를 Service를 호출하여 불러옴
		List<Map<String,Object>> fixturesExcelList = fixturesService.getFixturesExcelList();
		log.debug("ExcelRest.fixturesExcel() fixturesExcelList --->" + fixturesExcelList.toString());
		
		return fixturesExcelList;
	}
	
	// 2) equipmentList(장비목록) 엑셀다운
	@GetMapping("/equipment/equipmentExcel")
	public List<Map<String,Object>> equipmentExcel(){
		// excel로 뽑을 list
		// list데이터를 Service를 호출하여 불러옴
		List<Map<String,Object>> equipmentExcelList = equipmentService.getEquipmentExcelList();
		log.debug("ExcelRest.equipmentExcel() equipmentExcelList --->" + equipmentExcelList.toString());
		
		return equipmentExcelList;
	}
	
	// 3) repair(수리목록) 엑셀다운 repairStauts로 대기중 수리중 수리완료 각각 출력
	@GetMapping("/repair/repairExcel")
	public List<Map<String,Object>> repairExcel(Repair repair) {
		
		log.debug("ExcelRest.repairExcel() Param repair --->" + repair.toString());
		// excel로 뽑을 list
		// list데이터를 Service를 호출하여 불러옴
		List<Map<String,Object>> repairExcelList = repairService.getRepairExcelLIst(repair);
		log.debug("ExcelRest.repairExcel() repairExcelList --->" + repairExcelList.toString());
		
		return repairExcelList;
	}
	
	// parts 비동기 처리
	@GetMapping("/parts/getPartsCntList")
	public Map<String,Object> partsCntLIst(@RequestParam(required = false) String partsName) {
		
		log.debug("ExcelRest.partsCntLIst() Param partsName --->" + partsName);
			
		Parts parts = new Parts();
		parts.setPartsName(partsName);
		
		// 서비스 호출
		Map<String, Object> resultMap = fixturesService.getPartsList(parts); // fixturesService에서 parts 정보 가져오기
		
		return resultMap;
	}

	// 수리완료 상세보기
	@GetMapping("/repair/completedOne")
	public Map<String,Object> completedOne(Repair repair) {
		
		Map<String,Object> completedMap = repairService.getCompletedOne(repair);
		
		return completedMap;
	}
	
	
}
