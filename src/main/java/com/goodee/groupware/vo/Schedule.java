package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class Schedule {
	private int scheduleNo;
	private String memberId;
	private String scheduleCategory;
	private String scheduleTitle;
	private String scheduleContent;
	private String scheduleBegindate;
	private String scheduleEnddate;
	private String createdate;
	private String updatedate;
	
}
