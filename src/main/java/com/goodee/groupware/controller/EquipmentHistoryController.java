package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.EquipmentHistoryService;
import com.goodee.groupware.vo.Equipment;
import com.goodee.groupware.vo.EquipmentHistory;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EquipmentHistoryController {
	@Autowired
	private EquipmentHistoryService equipmentHistoryService;
	
	// 1) 장비 대여 추가 매핑
	@PostMapping("/eqHistory/addEqHistory")
	public String addEqHistory(EquipmentHistory eqHistory, Equipment equipment) {
		
		log.debug("EquipmentHistoryController.addEqHistory() eqHistory --->" + eqHistory.toString());
		// 장비사용내역 추가 및 장비상태 업데이트 서비스 호출
		int row = 0;
		
		if (eqHistory != null && equipment != null) {
		    row = equipmentHistoryService.addEqHistry(eqHistory, equipment);
		    if (row > 0) {
		        log.debug("EquipmentHistoryController.addEquipment() row --->" + row + "장비 대여 추가성공");
		    } else {
		        log.debug("EquipmentHistoryController.addEquipment() row --->" + row + "장비 대여 추가실패");
		    }
		} 
		return "redirect:/equipment/equipmentList";
	}
	
	// 1.1) 장비 반납시 비대여로 업데이트
	@GetMapping("/eqHistory/updateEquipment") 
	public String updateEquipment(Equipment equipment) {
		int row = 0;
		
		if (equipment != null) {
			row = equipmentHistoryService.updateEquipment(equipment);
		    if (row > 0) {
		        log.debug("EquipmentHistoryController.updateEquipment() row --->" + row + "장비 반납 성공");
		    } else {
		        log.debug("EquipmentHistoryController.updateEquipment() row --->" + row + "장비 반납 실패");
		    }
		} 
		return "redirect:/eqHistory/eqHistoryList";
	}
	
	// 2) 장비 사용내역(본인 아이디값으로 본인이 사용한 장비내역) 목록 매핑
	@GetMapping("/eqHistory/eqHistoryList")
	public String eqHistoryList(Model model, HttpSession session,
								@RequestParam(name ="equipmentName", required = false) String equipmentName,
								@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
								@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage) {
		log.debug("EquipmentHistoryController.eqHistoryList() 요청값 디버깅 currentPage :" + currentPage +"rowPerPage :" + rowPerPage + "equipmentName :" + equipmentName);
		
		// 해당 사용자의 장비사용내역을 보여주기 위해 세션에서 아이디값 받아옴
		String memberId = (String) session.getAttribute("loginMember");
		
		// 장비 사용내역 (해당 아이디) 목록 서비스 호출
		Map<String, Object> resultMap = equipmentHistoryService.getEqHistoryListById(currentPage, rowPerPage, memberId, equipmentName);
		log.debug("EquipmentHistoryController.eqHistoryList() resultMap --->" + resultMap.toString());	
		
		// Model을 사용하여 view로 값 전달
		// 장비 사용내역 목록 값
		model.addAttribute("eqHistoryListById", resultMap.get("eqHistoryListById"));
		// 페이징 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		
		return "/eqHistory/eqHistoryList";
	}
}
