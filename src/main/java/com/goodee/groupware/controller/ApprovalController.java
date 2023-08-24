
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
	  
	@GetMapping("/approval/approvalList")
	public String getBoardList(Model model,
		HttpSession session,
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "rowPerPage", defaultValue = "3") int rowPerPage,
		@RequestParam(name = "approvalLastStatus", required = false) String approvalLastStatus,
		@RequestParam(name = "approvalNowStatus", required = false) String approvalNowStatus) {
  
		String memberId = (String) session.getAttribute("loginMember");
		Map<String,Object> resultMap = approvalService.getApprovalList(currentPage,rowPerPage, approvalLastStatus, approvalNowStatus, memberId);
		  
		model.addAttribute("approvalList",resultMap.get("approvalList"));
		  
		// 페이징 변수 값 
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("memberId", resultMap.get("memberId")); 
		
		return "/approval/approvalList"; 
	}
  
  
// 게시물 추가하기
  
	@GetMapping("/approval/addApproval")
	public String addApproval(Model model) { 
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		
		// Model에 addAttribute를 사용하여 view에 값을 보낸다.
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		return "/approval/addApproval";
	}
	  
	@PostMapping("/approval/addApproval")
	public String addBoard(HttpServletRequest request,Approval approval, HttpSession session) {
	//매개값으로 request객체를 받는다 <- request api를 직접 호출하기 위해서 // 파일 이 저장될 경로 설정 
		String memberId = (String) session.getAttribute("loginMember");
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
		String path = request.getServletContext().getRealPath("/approvalFile/"); 
		int row = approvalService.addApproval(approval,path);
		log.debug("ApprovalControllerAddRow --> "+row); 
		
		return "redirect:/approval/approvalList"; 
	}
	
	// 게시물 상세출력
	@GetMapping("/approval/oneApproval")
	public String getOneBoard(Model model,Approval approval,ApprovalFile approvalFile, HttpSession session) {
		
		String loginMemberId = (String) session.getAttribute("loginMember");
		Map<String, Object> oneApprovalMap = approvalService.getOneApproval(approval, approvalFile);
		
		model.addAttribute("approvalOne",oneApprovalMap.get("approvalOne"));
		model.addAttribute("approvalFileList",oneApprovalMap.get("approvalFileList"));
		model.addAttribute("loginMemberId",loginMemberId);
		return "/approval/oneApproval";
	}
	
	// 게시물 삭제하기
	@PostMapping("/approval/updateApprovalRecall")
	public String updateApprovalRecall(Approval approval) {
		int row = approvalService.updateApprovalRecall(approval);
		log.debug("ApprovalController.updateApprovalRecall.Row-->"+row);
		return "redirect:/approval/approvalList";
	}
	
	// 결재 상태 업데이트 및 댓글 작성
	@PostMapping("/approval/updateApprovalComment")
	public String updateApprovalComment(Approval approval,
			@RequestParam(name = "approvalNowStatus", required = false) String approvalNowStatus,
			@RequestParam(name = "approvalLastStatus", required = false) String approvalLastStatus,
			@RequestParam(name = "approvalComment", required = false) String approvalComment) {
		
		log.debug("approval.getApprovalFirstComment-->"+approval.getApprovalFirstComment());
		log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalSecondComment());
		log.debug("approval.getApprovalThirdComment()-->"+approval.getApprovalThirdComment());
		
		
		
		if(approval.getApprovalFirstComment()==null || approval.getApprovalFirstComment().equals("")) {
			approval.setApprovalFirstComment(approvalComment);
			log.debug("approval.getApprovalFirstComment-->"+approval.getApprovalFirstComment());
		} else if(!approval.getApprovalSecondComment().equals("") 
				&& approval.getApprovalSecondComment() == null
				&& approval.getApprovalFirstComment().equals("")
				&& approval.getApprovalFirstComment() != null) {
			approval.setApprovalSecondComment(approvalComment);
			log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalSecondComment());
		} else {
			approval.setApprovalThirdComment(approvalComment);
			log.debug("approval.getApprovalThirdComment()-->"+approval.getApprovalThirdComment());
		}
		
		int row = approvalService.updateApprovalComment(approval);
		
		log.debug("ApprovalController.updateApprovalComment.Row-->"+row);
		return "redirect:/approval/approvalList";
	}
}
 