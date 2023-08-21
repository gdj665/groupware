package com.goodee.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.RepairService;
import com.goodee.groupware.vo.Repair;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class RepairController {

	@Autowired
	private RepairService repairSerivce;
	
	// 1) repair추가
	@PostMapping("/repair/addRepair")
	public String addRepair(Repair repair) {
		
		// repair 추가 서비스 호출
		int row = repairSerivce.addRepair(repair);
		
		if(row > 0) {
			log.debug("RepairController.addRepair() row --->" + row + "AS 추가 성공");
		} else {
			log.debug("RepairController.addRepair() row --->" + row + "AS 추가 실패");
		}
		return "redirec:/repair/watingRepairList";
	}
	// 1.1) addRepair 폼으로
	@GetMapping("/repair/addRepairForm")
	public String addRepairForm() {
		log.debug("RepairController.addRepairForm() AS추가폼으로 이동");
		
		return "/repair/addRepair";
	}
	
	// 2) repairList출력(대기중,수리중,수리완료)
	@GetMapping("/repair/repairList")
	public String repairList(Model model, Repair repair,
							@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
							@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage) {
		String RepairStatus = "대기중";
		
		// repairList 페이징 매개변수 맵
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("currentPage", currentPage);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("RepairStatus", RepairStatus);
		pageMap.put("RepairProductCategory", repair.getRepairProductCategory());
		
		// repairList 서비스 호출
		Map<String,Object> resultMap = repairSerivce.getRepairList(pageMap);
		log.debug("RepairController.repairList() resultMap ---> " + resultMap.toString());
		
		// view에 넘겨줄 리스트 값
		model.addAttribute("repairList", resultMap.get("repairList"));
		// 페이징 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		
		return "/repair/repairList";
	}
}
