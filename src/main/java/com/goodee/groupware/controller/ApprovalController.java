
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
 
import com.goodee.groupware.sevice.ApprovalService; import
com.goodee.groupware.vo.Approval; import com.goodee.groupware.vo.Board;
  
import lombok.extern.slf4j.Slf4j;
  
@Controller
@Slf4j 
public class ApprovalController {
	@Autowired 
	private ApprovalService approvalService;
	  
	@GetMapping("/approval/approvalList")
	public String getBoardList(Model model,
		HttpSession session,
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "rowPerPage", defaultValue = "3") int rowPerPage,
		@RequestParam(name = "approvalLastStatus", required = false) String approvalLastStatus,
		@RequestParam(name = "approvalNowStatus", required = false) String approvalNowStatus) {
  
		String SessionLoginId = (String) session.getAttribute("loginMember");
		Map<String,Object> resultMap = approvalService.getApprovalList(currentPage,
		rowPerPage, approvalLastStatus, approvalNowStatus, SessionLoginId);
		  
		model.addAttribute("approvalList",resultMap.get("approvalList"));
		  
		// 페이징 변수 값 model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("SessionLoginId", resultMap.get("SessionLoginId")); 
		return "/approval/approvalList"; 
	}
  
  
// 게시물 추가하기
  
	@GetMapping("/approval/addApproval")
	public String addApproval() { 
		return "/approval/addApproval";
	}
	  
	@PostMapping("/approval/addApproval")
	public String addBoard(HttpServletRequest request,Approval approval, HttpSession session) {
	//매개값으로 request객체를 받는다 <- request api를 직접 호출하기 위해서 // 파일 이 저장될 경로 설정 
		String SessionLoginId = (String) session.getAttribute("loginMember");
		approval.setMemberId(SessionLoginId);
	 
		String path = request.getServletContext().getRealPath("/boardFile/"); 
		int row = approvalService.addApproval(approval,path);
		System.out.println("ApprovalControllerAddRow --> "+row); 
		return "redirect:/approval/approvalList"; 
	}
  
}
 