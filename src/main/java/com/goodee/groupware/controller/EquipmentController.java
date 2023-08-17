package com.goodee.groupware.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.EquipmentService;
import com.goodee.groupware.vo.Equipment;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EquipmentController {
	@Autowired
	private EquipmentService equipmentService;
	
	// 1) 장비 리스트 매핑
	@GetMapping("/equipment/equipmentList")
	public String getEquipmentList(Model model,
									@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage,
									@RequestParam(name ="equipmentName", required = false) String equipmentName) {
		log.debug("EquipmentController.getEquipmentList() 요청값 디버깅 --->" + currentPage, rowPerPage, equipmentName);
		// 서비스 호출
		Map<String, Object> resultMap = equipmentService.getEquipmentList(currentPage, rowPerPage, equipmentName);
		log.debug("EquipmentController.getEquipmentList() resultMap --->" + resultMap.toString());
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 장비리스트 데이터
		model.addAttribute("equipmentList", resultMap.get("equipmentList"));
		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		
		return "/equipment/equipmentList";
	}
	
	
	// 2) 장비 추가 매핑
	@PostMapping("/equipment/addEquipment")
	public String addEquipment(Equipment equipment) {
		// 추가 서비스 호출
		int row = equipmentService.addEquipment(equipment);
		
		log.debug("EquipmentController.addEquipment() equipment --->" + equipment.toString());
		if(row > 0) {
			log.debug("EquipmentController.addEquipment() row --->" + row + "장비추가성공"); 
		} else {
			log.debug("EquipmentController.addEquipment() row --->" + row + "장비추가실패"); 
		}
		
		return "redirect:/equipment/equipmentList";
	}
	
	// 3) 장비 삭제 매핑
	@GetMapping("/equipment/deleteEquipment")
	public String deleteEquipment(Equipment equipment) {
		// 삭제 서비스 호출
		int row = equipmentService.deleteEquipment(equipment);
		
		log.debug("EquipmentController.deleteEquipment() equipment --->" + equipment.toString());
		if(row > 0) {
			log.debug("EquipmentController.deleteEquipment() row --->" + row + "장비삭제성공"); 
		} else {
			log.debug("EquipmentController.deleteEquipment() row --->" + row + "장비삭제실패"); 
		}
		return "redirect:/equipment/equipmentList";
	}
	
	// 4) 장비 점검 업데이트 매핑
	@GetMapping("/equipment/updateStatus")
	public String updateEquipmentStatus(Equipment equipment) {
		// 장비 점검 서비스 호출
		int row = equipmentService.updateEquipmentStatus(equipment);
		
		log.debug("EquipmentController.updateEquipmentStatus() equipment --->" + equipment.toString());
		if(row > 0) {
			log.debug("EquipmentController.updateEquipmentStatus() row --->" + row + "장비점검성공"); 
		} else {
			log.debug("EquipmentController.updateEquipmentStatus() row --->" + row + "장비점검실패"); 
		}
		
		return "redirect:/equipment/equipmentList";
	}
}