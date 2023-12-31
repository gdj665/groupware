
package com.goodee.groupware.sevice;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.groupware.mapper.ApprovalMapper;
import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.Approval;
import com.goodee.groupware.vo.ApprovalFile;
import com.goodee.groupware.vo.Board;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ApprovalService {
	@Autowired
	private ApprovalMapper approvalMapper;
	@Autowired
	private FileMapper fileMapper;

	// 1.) 결재 리스트출력
	public Map<String,Object> getApprovalList(int currentPage, int rowPerPage,String searchWord, String approvalNowStatus,String memberId){
  
		// 페이징 첫 번째 줄 변수 선언 
		int beginRow = (currentPage-1)*rowPerPage;
	  
		// 결재 리스트 출력을 위한 변수 Map 생성
		Map<String,Object> approvalMap = new HashMap<String,Object>(); 
		approvalMap.put("beginRow",beginRow);
		approvalMap.put("rowPerPage",rowPerPage);
		approvalMap.put("searchWord",searchWord);
		approvalMap.put("approvalNowStatus",approvalNowStatus);
		approvalMap.put("memberId",memberId);
		// 1.) 결재 리스트출력
		List<Map<String,Object>> approvalList = approvalMapper.getApprovalList(approvalMap);
		// 디버깅
		log.debug("ApprovalService.getApprovalList() approvalMap --->" + approvalMap.toString());
		log.debug("ApprovalService.getApprovalList() approvalList --->" + approvalList.toString());
		
		
		// 결재 게시물 리스트 행 출력을 위한 변수 Map 생성 
		Map<String,Object> approvalMapCount = new HashMap<String,Object>();
		approvalMapCount.put("searchWord",searchWord);
		approvalMapCount.put("approvalNowStatus",approvalNowStatus);
		approvalMapCount.put("memberId",memberId);
		// 2.) 결재 리스트 분기값에 따른 결재리스트 행 개수
		int approvalCount = approvalMapper.getApprovalListCount(approvalMapCount);
		int lastPage = approvalCount / rowPerPage; 
		if((approvalCount%rowPerPage) != 0) { 
			lastPage++; 
		}
		// 페이지 네비게이션 페이징
		int pagePerPage = 5;
		
		// 마지막 페이지 구하기
		// 최소페이지,최대페이지 구하기
		int minPage = ((currentPage-1) / pagePerPage) * pagePerPage + 1;
		int maxPage = minPage + (pagePerPage -1);
		
		// maxPage가 마지막 페이지를 넘어가지 않도록 함
		if(maxPage > lastPage) {
			maxPage = lastPage;
		}
		
		// 결재 리스트와 마지막 페이지 값 resultMap 선언 후 삽입
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("approvalList",approvalList);
		resultMap.put("lastPage",lastPage);
		resultMap.put("minPage", minPage);
		resultMap.put("maxPage", maxPage);
		  
		return resultMap; 
	}
	
	// 3.) 결재 상세보기 출력
	public Map<String,Object> getOneApproval(Approval approval, ApprovalFile approvalFile) {
		
		
		Map<String,Object> approvalOne = approvalMapper.getOneApproval(approval);
		
		// 파일출력
		List<ApprovalFile> approvalFileList = fileMapper.getApprovalFileList(approvalFile);
		
		Map<String,Object> approvalOneMap = new HashMap<String,Object>();
		approvalOneMap.put("approvalOne",approvalOne);
		approvalOneMap.put("approvalFileList",approvalFileList);
		return approvalOneMap;
	}
	
	// 4.) 결재 추가
	public int addApproval(Approval approval, String path) {
		
		// 4.) 결재 추가
		int row = approvalMapper.addApproval(approval);
		log.debug(approval.getApprovalFirstId());
		log.debug(approval.getApprovalSecondId());
		log.debug(approval.getApprovalThirdId());
		log.debug("ApprovalService addApproval row-->"+row);
		
		// 게시물 추가되면서 첨부파일 있으면 폴더 저장+ DB에 저장
		// approval vo에 선언 해둔 MultipartFile의 사이즈 확인
		List<MultipartFile> approvalFileList = approval.getMultipartFile();
		if(row==1) {
			// Stream Api사용 및 선언
			// 스트림 api 사용하지 않을시에boardFileList가 계속 사이즈가 1로 출력
			List<MultipartFile> validApprovalFileList = approvalFileList.stream()
					// 파일들 중 사이즈가 0초과거나 null이 아닌것 필터링
	                .filter(file -> file != null && file.getSize() > 0)
	                // 필터링한 파일리스트를 다시 새로운 리스트로 만들어서 validBoardFileList에 선언
	                .collect(Collectors.toList());
			log.debug("validApprovalFileList-->"+validApprovalFileList);
			log.debug("validApprovalFileList.size()-->"+validApprovalFileList.size());
			if (!validApprovalFileList.isEmpty()) {
				// addApproval가 insert된 후의 approvalNo를 가져와서 파일 업로드 실행
				int approvalNo = approval.getApprovalNo();
				log.debug("ApprovalService approvalNo-->"+approvalNo);
				
				// 첨부파일의 갯수만큼 반복
				for(MultipartFile mf : approvalFileList) {
					ApprovalFile af = new ApprovalFile();
					af.setApprovalNo(approvalNo);
					af.setApprovalFileOri(mf.getOriginalFilename());
					af.setApprovalFileSize(mf.getSize());
					af.setApprovalFileType(mf.getContentType());
					
					// 파일 타입 추출
					String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
					// UUID 랜덤부여후 미들 바를 공백으로 바꾸고나서 파일 타입추가
					af.setApprovalFileSave(UUID.randomUUID().toString().replace("-","")+ext);
					
					// 7.) 결재 첨부파일 추가
					fileMapper.addApprovalFile(af);
					
					// 파일 경로 받아와서 파일 추가
					File f = new File(path+af.getApprovalFileSave());
					
					try {
						mf.transferTo(f);
					} catch (IllegalStateException | IOException e) {
						// 어떤 예외가 발생하더라도 런타임 예외를 던진다
						e.printStackTrace();
						throw new RuntimeException();
					}
				}
			}
		}
		return row;
	}
	
	
	// 5.) 결재 회수
	public int updateApprovalRecall(Approval approval) {
		
		// 5.) 결재 회수
		int updateApprovalRecallRow = approvalMapper.updateApprovalRecall(approval);
		log.debug("ApprovalService updateApprovalRecallRow-->"+updateApprovalRecallRow);
		
		return updateApprovalRecallRow;
	}
	
	// 6.) 결재 진행 코멘트 업데이트 + 7.) 결재 진행 상태 변경
	public int updateApprovalComment(Approval approval, String approvalLastStatus, String approvalNowStatus, String approvalComment) {
		
		log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalFirstComment());
		log.debug("approval.getApprovalSecondComment()-->"+approval.getApprovalSecondComment());
		log.debug("approval.getApprovalThirdComment()-->"+approval.getApprovalThirdComment());
		log.debug("approval.approvalLastStatus()-->"+approvalLastStatus);
		log.debug("approval.approvalNowStatus()-->"+approvalNowStatus);
		
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
		
		// 6.) 결재 진행 코멘트 업데이트
		int updateApprovalCommentRow = approvalMapper.updateApprovalComment(approval);
		// 7.) 결재 진행 상태 변경
		int updateApprovalStatusRow = approvalMapper.updateApprovalStatus(approval);
		// 총 성공 행
		int updateRow = updateApprovalCommentRow + updateApprovalStatusRow;
		
		// 디버깅
		log.debug("approval.getApprovalNo()-->"+approval.getApprovalNo());
		log.debug("ApprovalService.updateRow-->"+updateRow);
		
		return updateRow;
	}
}
