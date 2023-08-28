
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
	@GetMapping("/approval/approvalList")
	public String getBoardList(Model model,
		HttpSession session,
		@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
		@RequestParam(name = "rowPerPage", defaultValue = "3") int rowPerPage,
		@RequestParam(name = "searchWord", required = false) String searchWord,
		@RequestParam(name = "approvalNowStatus", required = false) String approvalNowStatus) {
  
		String memberId = (String) session.getAttribute("loginMember");

		// 리스트 출력
		Map<String,Object> resultMap = approvalService.getApprovalList(currentPage,rowPerPage, searchWord, approvalNowStatus, memberId);
		model.addAttribute("approvalList",resultMap.get("approvalList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", resultMap.get("lastPage"));
		model.addAttribute("memberId", resultMap.get("memberId")); 
		
		log.debug("ApprovalController.resultMap-->"+resultMap);
		
		return "/approval/approvalList"; 
	}
  
  
	// 4.) 결재 추가
	@GetMapping("/approval/addApproval")
	public String addApproval(Model model) { 
		
		// 결재자 선택을 위해 리스트를 불러온다
		Map<String,Object> resultMap = departmentService.getDepartmentList();
		
		// 부서 리스트
		model.addAttribute("departmentList", resultMap.get("department"));
		model.addAttribute("memberList", resultMap.get("memberList"));
		
		return "/approval/addApproval";
	}
	
	@PostMapping("/approval/addApproval")
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
		
		return "redirect:/approval/approvalList"; 
	}
	
	// 3.) 결재 상세보기 출력
	@GetMapping("/approval/oneApproval")
	public String getOneBoard(Model model,Approval approval,ApprovalFile approvalFile, HttpSession session) {
		
		String loginMemberId = (String) session.getAttribute("loginMember");
		Map<String, Object> oneApprovalMap = approvalService.getOneApproval(approval, approvalFile);
		
		// 상세출력에 필요한 세션 값과 결재 파일 상세 정보, 첨부파일 리스트를 가져오기
		model.addAttribute("approvalOne",oneApprovalMap.get("approvalOne"));
		model.addAttribute("approvalFileList",oneApprovalMap.get("approvalFileList"));
		model.addAttribute("loginMemberId",loginMemberId);
		
		return "/approval/oneApproval";
	}
	
	// 5.) 결재 회수
	@PostMapping("/approval/updateApprovalRecall")
	public String updateApprovalRecall(Approval approval) {
		
		// 5.) 결재 회수
		int row = approvalService.updateApprovalRecall(approval);
		log.debug("ApprovalController.updateApprovalRecall.Row-->"+row);
		
		return "redirect:/approval/approvalList";
	}
	
	// 6.) 결재 진행 코멘트 업데이트 + 7.) 결재 진행 상태 변경
	@PostMapping("/approval/updateApprovalComment")
	public String updateApprovalComment(Approval approval,
			@RequestParam(name = "approvalNowStatus", defaultValue = "결재중") String approvalNowStatus,
			@RequestParam(name = "approvalLastStatus", required = false, defaultValue="") String approvalLastStatus,
			@RequestParam(name = "approvalComment", required = false) String approvalComment) {
		
		log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalFirstComment());
		log.debug("approval.getApprovalSecondComment()-->"+approval.getApprovalSecondComment());
		log.debug("approval.getApprovalThirdComment()-->"+approval.getApprovalThirdComment());
		
		// 받아온 코멘트값 분기로 넘기기
		// 1차 분기 = ID유무와 코멘트 유무확인
		// 2차 분기 = approvalLastStatus에서 승인,반려,취소 확인
		// 3차 분기 = 승인일 경우 더 이상 결재자 없으면 approvalLastStatus 변경
		if(approval.getApprovalFirstComment()==null || approval.getApprovalFirstComment().equals("")) {
			approval.setApprovalFirstComment(approvalComment);
			// 2차 코멘드 넘어오는 것때문에 다시 null값으로 변경
			approval.setApprovalSecondComment(null);
			approval.setApprovalNowStatus(approvalNowStatus);
			log.debug("1차 댓글 입력");
			// 코멘트 디버깅
			log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalFirstComment());
					
			if(approvalLastStatus != null && (approvalLastStatus.equals("반려") || approvalLastStatus.equals("취소"))) {
				approvalNowStatus="결재완료";
				approval.setApprovalLastStatus(approvalLastStatus);
				approval.setApprovalNowStatus(approvalNowStatus);
			} else if(approval.getApprovalSecondId() == null || approval.getApprovalSecondId().equals("")) {
				approvalLastStatus = "승인";
				approvalNowStatus="결재완료";
				approval.setApprovalLastStatus(approvalLastStatus);
				approval.setApprovalNowStatus(approvalNowStatus);
			}
			
		} else if(approval.getApprovalSecondComment() == null
				|| approval.getApprovalSecondComment().equals("")
				&& approval.getApprovalFirstComment() != null
				&& !approval.getApprovalFirstComment().equals("")) {
			
			log.debug("2차 댓글 입력");
			approval.setApprovalSecondComment(approvalComment);
			approval.setApprovalNowStatus(approvalNowStatus);
			
			//코멘트 디버깅
			log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalSecondComment());
			if(approvalLastStatus != null && approvalLastStatus.equals("반려") || approvalLastStatus.equals("취소")) {
				approvalNowStatus="결재완료";
				approval.setApprovalLastStatus(approvalLastStatus);
				approval.setApprovalNowStatus(approvalNowStatus);
			} else if(approval.getApprovalThirdId() == null || approval.getApprovalThirdId().equals("")) {
				approvalLastStatus = "승인";
				approvalNowStatus="결재완료";
				approval.setApprovalLastStatus(approvalLastStatus);
				approval.setApprovalNowStatus(approvalNowStatus);
			}
		} else {
			log.debug("3차 댓글 입력");
			approval.setApprovalThirdComment(approvalComment);
			approval.setApprovalNowStatus(approvalNowStatus);
			// 코멘트 디버깅
			log.debug("approval.getApprovalThirdComment()-->"+approval.getApprovalThirdComment());
			if(approvalLastStatus != null && approvalLastStatus.equals("반려") || approvalLastStatus.equals("취소")) {
				approvalNowStatus="결재완료";
				approval.setApprovalLastStatus(approvalLastStatus);
				approval.setApprovalNowStatus(approvalNowStatus);
			} else {
				approvalLastStatus = "승인";
				approvalNowStatus="결재완료";
				approval.setApprovalLastStatus(approvalLastStatus);
				approval.setApprovalNowStatus(approvalNowStatus);
			}
		}
		
		int row = approvalService.updateApprovalComment(approval);
		log.debug("ApprovalController.updateApprovalComment.Row-->"+row);
		
		return "redirect:/approval/approvalList";
	}
}
 