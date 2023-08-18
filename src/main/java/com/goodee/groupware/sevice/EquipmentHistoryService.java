package com.goodee.groupware.sevice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.EquipmentHistoryMapper;
import com.goodee.groupware.vo.EquipmentHistory;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class EquipmentHistoryService {
	@Autowired
	private EquipmentHistoryMapper equipmentHistoryMapper;
	
	// 1) 장비 대여 추가
	public int addEqHistry(EquipmentHistory eqHistory) {
		
		// 매퍼 호출
		int row = equipmentHistoryMapper.addEqHistory(eqHistory);
		
		return row;
	}
}
