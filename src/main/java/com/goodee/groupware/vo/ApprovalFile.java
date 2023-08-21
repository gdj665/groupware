package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class ApprovalFile {
	private int approvalFileNo;
	private int approvalNo;
	private String approvalFileOri;
	private String approvalFileSave;
	private String approvalFileType;
	private long approvalFileSize;
	private String createdate;
	private String updatedate;
}
