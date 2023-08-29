package com.goodee.groupware.vo;

import lombok.Data;

@Data
public class EquipmentHistory {
	private int equipmentHistoryNo;
	private int equipmentNo;
	private String memberId;
	private String equipmentBegindate;
	private String equipmentEnddate;
	private String equipmentReason;
}
