package com.goodee.groupware.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Approval {
	private int approvalNo;
	private String memberId;
	private String approvalTitle;
	private String approvalContent;
	private String approvalForm;
	private String approvalNowStatus;
	private String approvalFirstId;
	private String approvalFirstComment;
	private String approvalSecondId;
	private String approvalSecondComment;
	private String approvalThirdId;
	private String approvalThirdComment;
	private int approvalLastNumber;
	private String approvalLastStatus;
	private String createdate;
	private String updatedate;
	
	private List<MultipartFile> multipartFile;
	// jsp에서 multipartFile을 input name으로 잡아서 실행
}
