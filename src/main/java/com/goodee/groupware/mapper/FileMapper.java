package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.ApprovalFile;
import com.goodee.groupware.vo.Board;
import com.goodee.groupware.vo.BoardFile;

@Mapper
public interface FileMapper {
	
	// 게시물 첨부파일 추가
	int addBoardFile(BoardFile boardFile);
	
	// 게시물 첨부파일 삭제
	int deleteBoardFile(BoardFile boardFile);
	
	// 게시물 첨부파일 리스트 출력
	List<BoardFile> getBoardFileList(BoardFile boardFile);
	
	// 게시물 첨부파일 상세 출력
	BoardFile getOneBoardFile(int boardFileNo);
	
	// 결재 첨부파일 추가
	int addApprovalFile(ApprovalFile approvalFile);
	
	// 결재 첨부파일 삭제
	int deleteApprovalFile(ApprovalFile approvalFile);
	
	// 결재 첨부파일 리스트 출력
	List<BoardFile> getApprovalFileList(ApprovalFile approvalFile);
	
	// 결재 첨부파일 상세 출력
	ApprovalFile getOneApprovalFile(int approvalFileNo);
}
