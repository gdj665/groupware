package com.goodee.groupware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.goodee.groupware.sevice.EquipmentHistoryService;
import com.goodee.groupware.vo.EquipmentHistory;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EquipmentHistoryController {
	@Autowired
	private EquipmentHistoryService equipmentHistoryService;
	
	// 1) 장비 대여 추가 매핑
	@PostMapping("/eqHistory/addEqHistory")
	public String addEqHistory(EquipmentHistory eqHistory) {
		
		log.debug("EquipmentHistoryController.addEqHistory() eqHistory --->" + eqHistory.toString());
		// 장비 대여 추가 서비스 호출
		int row = equipmentHistoryService.addEqHistry(eqHistory);
		if(row > 0) {
			log.debug("EquipmentController.addEquipment() row --->" + row + "장비 대여 추가성공"); 
		} else {
			log.debug("EquipmentController.addEquipment() row --->" + row + "장비 대여 추가실패"); 
		}
		
		return "redirect:/equipment/equipmentList";
	}
}
