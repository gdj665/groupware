package com.goodee.groupware.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class Repair {
	@NotEmpty
	private int repairNo;
	private String memberId;
	@NotEmpty
	private String repairProductCategory;
	@NotEmpty
	private String repairProductName;
	private String receivingDate;
	private String repairDate;
	private String repairReleaseDate;
	private int repairPrice;
	@NotEmpty
	private String repairStatus;
	@NotEmpty
	private String repairReceivingReason;
	private String repairContent;
	private String createdate;
	private String updatedate;
}
