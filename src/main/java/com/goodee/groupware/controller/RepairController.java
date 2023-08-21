package com.goodee.groupware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
	// 2) addRepair 폼으로
	@GetMapping("/repair/addRepairForm")
	public String addRepairForm() {
		log.debug("RepairController.addRepairForm() AS추가폼으로 이동");
		
		return "/repair/addRepair";
	}
}
