
package com.goodee.groupware.controller;
  
import java.util.Map;
  
import javax.servlet.http.HttpServletRequest; import
javax.servlet.http.HttpSession;
  
import org.springframework.beans.factory.annotation.Autowired; import
org.springframework.stereotype.Controller; import
org.springframework.ui.Model; import
org.springframework.web.bind.annotation.GetMapping; import
org.springframework.web.bind.annotation.PostMapping; import
org.springframework.web.bind.annotation.RequestParam;
 
import com.goodee.groupware.sevice.ApprovalService;
import com.goodee.groupware.sevice.DepartmentService;
import
com.goodee.groupware.vo.Approval;
import com.goodee.groupware.vo.ApprovalFile;
import com.goodee.groupware.vo.Board;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;
  
@Controller
@Slf4j 
public class ApprovalController {
	@Autowired 
	private ApprovalService approvalService;
	@Autowired
	private DepartmentService departmentService;
	 
	
	// 1.) 결재 리스트출력
	@GetMapping("/group/approval/approvalList")
	public String getBoardList(Model model,
		HttpSession session,
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "rowPerPage", defaultValue = "5") int rowPerPage,
		@RequestParam(name = "searchWord", required = false) String searchWord,
		@RequestParam(name = "approvalNowStatus", required = false) String approvalNowStatus) {
  
		String memberId = (String) session.getAttribute("loginMember");

		// 리스트 출력
		Map<String,Object> resultMap = approvalService.getApprovalList(currentPage,rowPerPage, searchWord, approvalNowStatus, memberId);
		model.addAttribute("approvalList",resultMap.get("approvalList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("memberId",memberId); 
		model.addAttribute("minPage", resultMap.get("minPage"));
		model.addAttribute("maxPage", resultMap.get("maxPage"));
		
		log.debug("ApprovalController.resultMap-->"+resultMap);
		
		return "/approval/approvalList"; 
	}
  
  
	// 4.) 결재 추가
	@GetMapping("/group/approval/addApproval")
	public String addApproval(Model model,HttpSession session) { 
		
		// 결재자 선택을 위해 리스트를 불러온다
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		String memberId = (String) session.getAttribute("loginMember");
		
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		model.addAttribute("memberId", memberId);
		
		return "/approval/addApproval";
	}
	
	@PostMapping("/group/approval/addApproval")
	public String addBoard(HttpServletRequest request,Approval approval, HttpSession session) {
		
		String memberId = (String) session.getAttribute("loginMember");
		
		// 총 결재자 수 확인
		if(!approval.getApprovalThirdId().equals("")) {
			log.debug("총 결재자 3명입니다");
			approval.setApprovalLastNumber(3);
		} else if (approval.getApprovalSecondId().equals("")
				&& !approval.getApprovalFirstId().equals("")) {
			log.debug("총 결재자 1명입니다");
			approval.setApprovalLastNumber(1);
			approval.setApprovalSecondId(null);
			approval.setApprovalThirdId(null);
		} else {
			log.debug("총 결재자 2명입니다");
			approval.setApprovalLastNumber(2);
			approval.setApprovalThirdId(null);
		}
		
		approval.setMemberId(memberId);
		
		// 첨부파일이 저장될 경로
		String path = request.getServletContext().getRealPath("/approvalFile/"); 
		
		// 결재 추가 진행
		int row = approvalService.addApproval(approval,path);
		log.debug("ApprovalControllerAddRow --> "+row); 
		
		return "redirect:/group/approval/approvalList"; 
	}
	
	// 3.) 결재 상세보기 출력
	@GetMapping("/group/approval/oneApproval")
	public String getOneApproval(Model model,Approval approval,ApprovalFile approvalFile, HttpSession session) {
		
		String memberId = (String) session.getAttribute("loginMember");
		Map<String, Object> oneApprovalMap = approvalService.getOneApproval(approval, approvalFile);
		
		// 상세출력에 필요한 세션 값과 결재 파일 상세 정보, 첨부파일 리스트를 가져오기
		model.addAttribute("approvalOne",oneApprovalMap.get("approvalOne"));
		model.addAttribute("approvalFileList",oneApprovalMap.get("approvalFileList"));
		model.addAttribute("memberId",memberId);
		
		log.debug("ApprovalController.oneApprovalMap --> "+oneApprovalMap); 
		
		return "/approval/oneApproval";
	}
	
	// 5.) 결재 회수
	@PostMapping("/group/approval/updateApprovalRecall")
	public String updateApprovalRecall(Approval approval) {
		
		// 5.) 결재 회수
		int row = approvalService.updateApprovalRecall(approval);
		log.debug("ApprovalController.updateApprovalRecall.Row-->"+row);
		
		return "redirect:/group/approval/approvalList";
	}
	
	// 6.) 결재 진행 코멘트 업데이트 + 7.) 결재 진행 상태 변경
	@PostMapping("/group/approval/updateApprovalComment")
	public String updateApprovalComment(Approval approval,
			@RequestParam(name = "approvalNowStatus", defaultValue = "결재중") String approvalNowStatus,
			@RequestParam(name = "approvalLastStatus", required = false, defaultValue="") String approvalLastStatus,
			@RequestParam(name = "approvalComment", required = false) String approvalComment) {
		
		// 6.) 결재 데이터 넘기기
		int row = approvalService.updateApprovalComment(approval,approvalLastStatus,approvalNowStatus,approvalComment);
		log.debug("ApprovalController.updateApprovalComment.Row-->"+row);
		
		return "redirect:/group/approval/approvalList";
	}
}
 