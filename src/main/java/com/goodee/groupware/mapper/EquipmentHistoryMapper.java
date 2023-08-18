package com.goodee.groupware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.EquipmentHistory;

@Mapper
public interface EquipmentHistoryMapper {
	
	// 장비 대여 추가
	int addEqHistory (EquipmentHistory eqHistroy);
}
