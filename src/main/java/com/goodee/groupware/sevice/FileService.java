package com.goodee.groupware.sevice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.ApprovalFile;
import com.goodee.groupware.vo.BoardFile;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
public class FileService {
	@Autowired
	private FileMapper fileMapper;
	
	// 2.) Board 게시판 첨부파일 상세 출력
	public BoardFile getOneBoardFile(int boardFileNo) {
		return fileMapper.getOneBoardFile(boardFileNo);
	}
	
	// 6.) Approval 결재 첨부파일 상세 출력
	public ApprovalFile getOneApprovalFile(int approvalFileNo) {
		return fileMapper.getOneApprovalFile(approvalFileNo);
	}
}
