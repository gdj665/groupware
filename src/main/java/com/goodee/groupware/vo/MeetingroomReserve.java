package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class MeetingroomReserve {
	private int meetingroomReserveNo;
	private int meetingroomNo;
	private int departmentNo;
	private String meetingroomReserveDate;
	private String meetingroomReserveTime;
	private String meetingroomReserveStatus;
	private String createdate;
	private String updatedate;
}
