package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class Work {
	private int workNo;
	private int departmentNo;
	private String memberId;
	private String memberName;
	private String workBegin;
	private String workEnd;
	private String workDate;
	private String workAnnual;
	private String createdate;
	private String updatedate;
}
