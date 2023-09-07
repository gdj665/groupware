package com.goodee.groupware.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class EquipmentHistory {
	@NotEmpty
	private int equipmentHistoryNo;
	@NotEmpty
	private int equipmentNo;
	@NotEmpty
	private String memberId;
	private String equipmentBegindate;
	@NotBlank
	private String equipmentEnddate;
	@NotEmpty
	private String equipmentReason;
}
