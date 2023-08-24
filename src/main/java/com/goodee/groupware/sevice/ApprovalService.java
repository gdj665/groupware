
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

	// 결재 리스트 출력
	public Map<String,Object> getApprovalList(int currentPage, int rowPerPage,String approvalLastStatus, String approvalNowStatus,String memberId){
  
		// 페이징 첫 번째 줄 
		int beginRow = (currentPage-1)*rowPerPage;
	  
		// 페이징을 위한 변수 boardMap에 선언 
		Map<String,Object> approvalMap = new HashMap<String,Object>(); 
		approvalMap.put("beginRow",beginRow);
		approvalMap.put("rowPerPage",rowPerPage);
		approvalMap.put("approvalLastStatus",approvalLastStatus);
		approvalMap.put("approvalNowStatus",approvalNowStatus);
		approvalMap.put("memberId",memberId);
		
		// approvalMap 디버깅
		log.debug("ApprovalService.getApprovalList() approvalMap --->" + approvalMap.toString());
		
		List<Map<String,Object>> approvalList = approvalMapper.getApprovalList(approvalMap);
		 
		// 페이징 
		Map<String,Object> approvalMapCount = new HashMap<String,Object>();
		approvalMapCount.put("approvalLastStatus",approvalLastStatus);
		approvalMapCount.put("approvalNowStatus",approvalNowStatus);
		approvalMapCount.put("memberId",memberId);
		  
		int approvalCount = approvalMapper.getApprovalListCount(approvalMapCount);
		int lastPage = approvalCount / rowPerPage; 
		if((approvalCount%rowPerPage) != 0) { 
			lastPage++; 
		}
		  
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("approvalList",approvalList);
		resultMap.put("lastPage",lastPage);
		  
		return resultMap; 
	}
	
	// 게시물 추가
	// 게시물 추가되면서 첨부파일 있으면 폴더 저장+ DB에 저장
	public int addApproval(Approval approval, String path) {
		// addBoard가 insert된 후의 boardNo를 가져와서 파일 업로드 실행
		log.debug(approval.getApprovalFirstId());
		log.debug(approval.getApprovalSecondId());
		log.debug(approval.getApprovalThirdId());
		int row = approvalMapper.addApproval(approval);
		log.debug("ApprovalService addApproval row-->"+row);
		// 첨부파일 있는지 확인
		// board vo에 선언 해둔 MultipartFile의 사이즈 확인
		List<MultipartFile> approvalFileList = approval.getMultipartFile();
		if(row==1) {
			// Stream Api사용 및 선언
			// 스트림 api 사용하지 않을시에boardFileList가 계속 사이즈가 1로 출력
			List<MultipartFile> validApprovalFileList = approvalFileList.stream()
					// 파일들 중 사이즈가 0초과거나 null이 아닌것 필터링
	                .filter(file -> file != null && file.getSize() > 0)
	                // 필터링한 파일리스트를 다시 새로운 리스트로 만들어서 validBoardFileList에 선언
	                .collect(Collectors.toList());
			System.out.println("validApprovalFileList-->"+validApprovalFileList);
			System.out.println("validApprovalFileList.size()-->"+validApprovalFileList.size());
			if (!validApprovalFileList.isEmpty()) {
				int approvalNo = approval.getApprovalNo();
				System.out.println("ApprovalService approvalNo-->"+approvalNo);
				
				// 첨부파일의 갯수만큼 반복
				for(MultipartFile mf : approvalFileList) {
					ApprovalFile af = new ApprovalFile();
					af.setApprovalNo(approvalNo);
					af.setApprovalFileOri(mf.getOriginalFilename());
					af.setApprovalFileSize(mf.getSize());
					af.setApprovalFileType(mf.getContentType());
					
					String ext = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
					// UUID 랜덤부여후 미들 바를 공백으로 바꾸고나서 파일 타입추가
					af.setApprovalFileSave(UUID.randomUUID().toString().replace("-","")+ext);
					
					fileMapper.addApprovalFile(af);
					
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
	
	// 결재 상세보기 출력
	public Map<String,Object> getOneApproval(Approval approval, ApprovalFile approvalFile) {
		Approval approvalOne = approvalMapper.getOneApproval(approval);
		List<ApprovalFile> approvalFileList = fileMapper.getApprovalFileList(approvalFile);
		
		Map<String,Object> approvalOneMap = new HashMap<String,Object>();
		approvalOneMap.put("approvalOne",approvalOne);
		approvalOneMap.put("approvalFileList",approvalFileList);
		return approvalOneMap;
	}
	
	// 결재 회수하기
	public int updateApprovalRecall(Approval approval) {
		int updateApprovalRecallRow = approvalMapper.updateApprovalRecall(approval);
		return updateApprovalRecallRow;
	}
	
	// 결재 코멘트 적기
	public int updateApprovalComment(Approval approval) {
		int updateApprovalCommentRow = approvalMapper.updateApprovalComment(approval);
		int updateApprovalStatusRow = approvalMapper.updateApprovalStatus(approval);
		int updateRow = updateApprovalCommentRow + updateApprovalStatusRow;
		
		// 디버깅
		log.debug("approval.getApprovalFirstComment()-->"+approval.getApprovalFirstComment());
		log.debug("approval.getApprovalSecondComment()-->"+approval.getApprovalSecondComment());
		log.debug("approval.getApprovalThirdComment()-->"+approval.getApprovalThirdComment());
		log.debug("approval.getApprovalNo()-->"+approval.getApprovalNo());
		log.debug("ApprovalService.updateRow-->"+updateRow);
		return updateRow;
	}
}
