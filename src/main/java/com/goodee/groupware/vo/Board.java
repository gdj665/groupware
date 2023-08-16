package com.goodee.groupware.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Board {
	private int boardNo;
	private String memberId;
	private String boardTitle;
	private String boardContent;
	private int departmentNo;
	private String boardStatus;
	private String createdate;
	private String updatedate;
	
	private BoardFile boardFile;
	
	// jsp에서 multipartFile을 input name으로 잡아서 실행
	private List<MultipartFile> multipartFile;
}
