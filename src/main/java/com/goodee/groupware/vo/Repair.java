package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class Repair {
	private int repairNo;
	private String memberId;
	private String repairProductCategory;
	private String repairProductName;
	private String receivingDate;
	private String repairDate;
	private String repairReleaseDate;
	private int repairPrice;
	private String repairStatus;
	private String repairReceivingReason;
	private String repairContent;
	private String createdate;
	private String updatedate;
}
