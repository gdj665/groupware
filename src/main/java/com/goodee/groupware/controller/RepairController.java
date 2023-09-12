package com.goodee.groupware.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@PostMapping("/group/repair/addRepair")
	public String addRepair(@Valid Repair repair, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		
		if (bindingResult.hasErrors()) {
	        // 유효성 검사에서 오류가 발생한 경우
	        // 오류 처리를 수행하고 원하는 페이지로 리다이렉트하거나 메시지를 표시할 수 있습니다.
	        return "/repair/addRepair"; // 오류 페이지로 리다이렉트 또는 이동
	    }
		
		// repair 추가 서비스 호출
		int row = repairSerivce.addRepair(repair);
		
		if(row > 0) {
			log.debug("RepairController.addRepair() row --->" + row + "AS 추가 성공");
		} else {
			log.debug("RepairController.addRepair() row --->" + row + "AS 추가 실패");
		}
		
		redirectAttributes.addAttribute("repairStatus", "대기중");
		return "redirect:/group/repair/repairList";
	}
	
	// 1.1) addRepair 폼으로
	@GetMapping("/group/repair/addRepairForm")
	public String addRepairForm(Model model, HttpSession session) {
		log.debug("RepairController.addRepairForm() AS추가폼으로 이동");
		
		// myPage 들어가기 위한 세션 아이디값
		String memberId = (String) session.getAttribute("loginMember");
		
		model.addAttribute("memberId", memberId);
		
		return "/repair/addRepair";
	}
	
	// 2) repairList출력
	@GetMapping("/group/repair/repairList")
	public String repairList(Model model, Repair repair, HttpSession session,
							@RequestParam(name ="currentPage", defaultValue = "1") int currentPage,
							@RequestParam(name ="rowPerPage", defaultValue = "8") int rowPerPage) {
		// 아무값이 넘어오지 않을경우 대기중으로 넣음
		
		log.debug("RepairController.repairList() repair.getRepairStatus() ---> " + repair.getRepairStatus());
		if(repair.getRepairStatus() == null || repair.getRepairStatus().equals("")) {
			System.out.println("null값이라 대기중 추가");
			repair.setRepairStatus("대기중");
		}
		
		String repairStatus = repair.getRepairStatus();
		
		log.debug("RepairController.repairList() repair ---> " + repair.toString());
		String memberId = (String) session.getAttribute("loginMember");
		
		// repairList 페이징 매개변수 맵
		Map<String,Object> pageMap = new HashMap<>();
		pageMap.put("currentPage", currentPage);
		pageMap.put("rowPerPage", rowPerPage);
		pageMap.put("repairStatus", repairStatus);
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
		model.addAttribute("minPage", resultMap.get("minPage"));
		model.addAttribute("maxPage", resultMap.get("maxPage"));
		
		if(repairStatus.equals("대기중")) {
			System.out.println("대기중 리스트로!");
			return "/repair/watingRepairList";
		} else if(repairStatus.equals("수리중")) {
			System.out.println("수리중 리스트로!");
			return "/repair/repairList";
		} else if(repairStatus.equals("수리완료")) {
			System.out.println("수리완료 리스트로!");
			return "/repair/completedList";
		} 
		
		return "/repair/watingRepairList";
	}
	
	
	// 3) repair 대기중 -> 수리중 -> 수리완료 수정
	@PostMapping("/group/repair/updateRepair")
	public String updateRepair(@RequestParam(name = "partsNo[]", required = false) int[] partsNoArray,
            					@RequestParam(name = "partsCnt[]", required = false) int[] partsCntArray,
								Repair repair, RepairParts repairParts, RedirectAttributes redirectAttributes) {
		int row =0;
		
		// 매개값에 따라 호출 분기시켜 디버깅코드 확인
		if(repair.getMemberId() != null) {
			// 호출
			row = repairSerivce.updateRepair(repair, repairParts, partsNoArray, partsCntArray);
			log.debug("RepairController.updateRepair() 대기중 -> 수리중 Param repair" + repair.toString());
			
			if(row > 0) {
				log.debug("RepairController.updateRepair() row 대기중 -> 수리중 변경완료" + row);
			} else {
				log.debug("RepairController.updateRepair() row 대기중 -> 수리중 변경실패" + row);
			}
			System.out.println("updateRepair() 수리중 실행!");
			redirectAttributes.addAttribute("repairStatus", "수리중");
			return "redirect:/group/repair/repairList";
			
		} else if(repair.getRepairContent() != null) {
			// 호출
			row = repairSerivce.updateRepair(repair, repairParts, partsNoArray, partsCntArray);
			log.debug("RepairController.updateRepair() 수리중 -> 수리완료 Param partsNoArray" + partsNoArray.length);
			log.debug("RepairController.updateRepair() 수리중 -> 수리완료 Param partsCntArray" + partsCntArray.length);
			log.debug("RepairController.updateRepair() 수리중 -> 수리완료 Param repair--->" + repair.toString());
			log.debug("RepairController.updateRepair() 수리중 -> 수리완료 Param repairParts--->" + repairParts.toString());
			
			if(row > 0) {
				log.debug("RepairController.updateRepair() row 수리중 -> 수리완료 변경완료" + row);
			} else {
				log.debug("RepairController.updateRepair() row 수리중 -> 수리완료 변경실패" + row);
			}
			
			System.out.println("updateRepair() 수리완료 실행!");
			redirectAttributes.addAttribute("repairStatus", "수리완료");
			return "redirect:/group/repair/repairList";
		}
		
		System.out.println("updateRepair() 대기중 실행!");
		// 수정 실패시 대기중 리스트로
		redirectAttributes.addAttribute("repairStatus", "대기중");
		return "redirect:/group/repair/repairList";
	}
	
}
