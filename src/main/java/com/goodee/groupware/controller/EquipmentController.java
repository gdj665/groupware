package com.goodee.groupware.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.goodee.groupware.sevice.EquipmentHistoryService;
import com.goodee.groupware.sevice.EquipmentService;
import com.goodee.groupware.vo.Equipment;
import com.goodee.groupware.vo.EquipmentHistory;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EquipmentController {
	@Autowired
	private EquipmentService equipmentService;
	
	// 1) 장비 리스트 매핑
	@GetMapping("/group/equipment/equipmentList")
	public String getEquipmentList(Model model, 
									HttpSession session,
									@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(name ="rowPerPage", defaultValue = "2") int rowPerPage,
									@RequestParam(name ="equipmentName", required = false) String equipmentName) {
		log.debug("EquipmentController.getEquipmentList() 요청값 디버깅 --->" + currentPage, rowPerPage, equipmentName);
		// 장비 리스트 서비스 호출
		Map<String, Object> resultMap = equipmentService.getEquipmentList(currentPage, rowPerPage, equipmentName);
		log.debug("EquipmentController.getEquipmentList() resultMap --->" + resultMap.toString());
		
		// 장비 대여 추가시 ID값은 세션사용자 ID값을 넣기 위해 세션에서 값 불러옴
		String memberId = (String) session.getAttribute("loginMember");
		// 장비 추가 및 비활성화는 팀장급만 가능하도록 세션에서 Level값 가져옴 
		String Level = (String) session.getAttribute("memberLevel");
		// 앞에 숫자만 사용하여 비교하도록 int값으로 파싱함
		int memberLevel = Integer.parseInt(Level.substring(0, 1));
		
		System.out.println("레벨 디버깅 테스트 " + memberLevel);
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 장비리스트 데이터
		model.addAttribute("equipmentList", resultMap.get("equipmentList"));
		// 세션 아이디,레벨값
		model.addAttribute("memberId", memberId);
		model.addAttribute("memberLevel", memberLevel);
		// 페이징 변수 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("minPage", resultMap.get("minPage"));
		model.addAttribute("maxPage", resultMap.get("maxPage"));
		
		return "/equipment/equipmentList";
	}
	
	
	// 2) 장비 추가 매핑
	@PostMapping("/group/equipment/addEquipment")
	public String addEquipment(Equipment equipment) {
		// 추가 서비스 호출
		int row = equipmentService.addEquipment(equipment);
		
		log.debug("EquipmentController.addEquipment() equipment --->" + equipment.toString());
		if(row > 0) {
			log.debug("EquipmentController.addEquipment() row --->" + row + "장비추가성공"); 
		} else {
			log.debug("EquipmentController.addEquipment() row --->" + row + "장비추가실패"); 
		}
		
		return "redirect:/group/equipment/equipmentList";
	}
	
	// 3) 장비 비활성화 매핑
	@GetMapping("/group/equipment/updateEquipment")
	public String updateEquipment(Equipment equipment) {
		// 삭제 서비스 호출
		int row = equipmentService.updateEquipment(equipment);
		
		log.debug("EquipmentController.updateEquipment() equipment --->" + equipment.toString());
		if(row > 0) {
			log.debug("EquipmentController.updateEquipment() row --->" + row + "장비삭제성공"); 
		} else {
			log.debug("EquipmentController.updateEquipment() row --->" + row + "장비삭제실패"); 
		}
		return "redirect:/group/equipment/equipmentList";
	}
	
	// 4) 장비 점검 업데이트 매핑
	@GetMapping("/group/equipment/updateEqInspect")
	public String updateEquipmentInspect(Equipment equipment) {
		// 장비 점검 서비스 호출
		int row = equipmentService.updateEquipmentInspect(equipment);
		
		log.debug("EquipmentController.updateEquipmentInspect() equipment --->" + equipment.toString());
		if(row > 0) {
			log.debug("EquipmentController.updateEquipmentInspect() row --->" + row + "장비점검성공"); 
		} else {
			log.debug("EquipmentController.updateEquipmentInspect() row --->" + row + "장비점검실패"); 
		}
		
		return "redirect:/group/equipment/equipmentList";
	}
	
	// 5) 장비 상세보기 매핑
	@GetMapping("/group/equipment/equipmentOne")
	public String getEquipmentOne(Model model, 
									Equipment equipment, 
									EquipmentHistory eqHistory, 
									Member member,
									HttpSession session,
									@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
									@RequestParam(name ="rowPerPage", defaultValue = "10") int rowPerPage) {
		// 장비 대여 추가시 ID값은 세션사용자 ID값을 넣기 위해 세션에서 값 불러옴
		String memberId = (String) session.getAttribute("loginMember");
				
		// 장비 상세보기 서비스 호출
		Map<String, Object> resultMap = equipmentService.getEquipmentOne(equipment, currentPage, rowPerPage, eqHistory, member);
		
		// 장비상세보기 값 
		model.addAttribute("equipmentOne", resultMap.get("equipmentOne"));
		// 장비사용내역 리스트 값
		model.addAttribute("eqHistoryList", resultMap.get("eqHistoryList"));
		// 페이징 값
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		// 장비 대여시 대여자 아이디값
		model.addAttribute("memberId", memberId);
		
		return "/equipment/equipmentOne";
	}
}
