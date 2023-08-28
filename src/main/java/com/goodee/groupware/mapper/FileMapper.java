package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.ApprovalFile;
import com.goodee.groupware.vo.Board;
import com.goodee.groupware.vo.BoardFile;

@Mapper
public interface FileMapper {
	
	// 게시판용-------------------------------------------------------------
	
	// 1.) 게시물 첨부파일 리스트 출력
	List<BoardFile> getBoardFileList(BoardFile boardFile);
	
	// 2.) 게시물 첨부파일 상세 출력
	BoardFile getOneBoardFile(int boardFileNo);
	
	// 3.) 게시물 첨부파일 추가
	int addBoardFile(BoardFile boardFile);
	
	// 4.) 게시물 첨부파일 삭제
	int deleteBoardFile(BoardFile boardFile);
	
	// 결재 용-------------------------------------------------------------
	
	// 5.) 결재 첨부파일 리스트 출력
	List<ApprovalFile> getApprovalFileList(ApprovalFile approvalFile);
	
	// 6.) 결재 첨부파일 상세 출력
	ApprovalFile getOneApprovalFile(int approvalFileNo);
	
	// 7.) 결재 첨부파일 추가
	int addApprovalFile(ApprovalFile approvalFile);
	
	// 8.) 결재 첨부파일 삭제
	int deleteApprovalFile(ApprovalFile approvalFile);
}
