package com.goodee.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodee.groupware.sevice.RepairService;
import com.goodee.groupware.vo.Parts;
import com.goodee.groupware.vo.Repair;
import com.goodee.groupware.vo.RepairParts;

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
		return "/repair/repairList";
	}
	
	// 1.1) addRepair 폼으로
	@GetMapping("/repair/addRepairForm")
	public String addRepairForm() {
		log.debug("RepairController.addRepairForm() AS추가폼으로 이동");
		
		return "/repair/addRepair";
	}
	
	// 2) repairList출력(대기중)
	@GetMapping("/repair/repairList")
	public String repairList(Model model, Repair repair, HttpSession session,
							@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
							@RequestParam(name ="rowPerPage", defaultValue = "3") int rowPerPage) {
		
		log.debug("RepairController.repairList() repair ---> " + repair.toString());
		String memberId = (String) session.getAttribute("loginMember");
		
		// repairList 페이징 매개변수 맵
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("currentPage", currentPage);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("repairStatus", repair.getRepairStatus());
		pageMap.put("repairProductCategory", repair.getRepairProductCategory());
		
		// repairList 서비스 호출
		Map<String,Object> resultMap = repairSerivce.getRepairList(pageMap);
		log.debug("RepairController.repairList() resultMap ---> " + resultMap.toString());
		
		// view에 넘겨줄 리스트 값
		model.addAttribute("repairList", resultMap.get("repairList"));
		model.addAttribute("partsList", resultMap.get("partsList"));
		// view에 넘겨줄 세션아이디값
		model.addAttribute("memberId", memberId);
		
		// 페이징 값
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		
		if(repair.getRepairStatus().equals("대기중")) {
			return "/repair/watingRepairList";
		} else if(repair.getRepairStatus().equals("수리중")) {
			return "/repair/repairList";
		} else if(repair.getRepairStatus().equals("수리완료")) {
			return "/repair/completedList";
		}
		
		return "/repair/watingRepairList";
	}
	
	
	// 3) repair 대기중 -> 수리중 -> 수리완료 수정
	@PostMapping("/repair/updateRepair")
																		// redirect시 값을 K/V형태로 보낼 수 있게 해줌 
	public String updateRepair(Repair repair, RepairParts repairParts, Parts parts, RedirectAttributes redirectAttributes) {
		
		int row =0;
		
		// 매개값에 따라 호출 분기시켜 디버깅코드 확인
		if(repair.getMemberId() != null) {
			// 호출
			row = repairSerivce.updateRepair(repair, repairParts, parts);
			log.debug("RepairController.updateRepair() 대기중 -> 수리중 Param repair" + repair.toString());
			
			if(row > 0) {
				log.debug("RepairController.updateRepair() row 대기중 -> 수리중 변경완료" + row);
			} else {
				log.debug("RepairController.updateRepair() row 대기중 -> 수리중 변경실패" + row);
			}
			redirectAttributes.addAttribute("repairStatus", "수리중");
			return "redirect:/repair/repairList";
			
		} else if(repair.getRepairContent() != null) {
			// 호출
			row = repairSerivce.updateRepair(repair, repairParts, parts);
			log.debug("RepairController.updateRepair() 수리중 -> 수리완료 Param repair" + repair.toString());
			
			if(row > 0) {
				log.debug("RepairController.updateRepair() row 수리중 -> 수리완료 변경완료" + row);
			} else {
				log.debug("RepairController.updateRepair() row 수리중 -> 수리완료 변경실패" + row);
			}
			
			redirectAttributes.addAttribute("repairStatus", "수리완료");
			return "redirect:/repair/repairList";
		}
		
		// 수정 실패시 대기중 리스트로
		redirectAttributes.addAttribute("repairStatus", "대기중");
		return "redirect:/repair/repairList";
	}
}
