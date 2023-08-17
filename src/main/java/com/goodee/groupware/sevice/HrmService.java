package com.goodee.groupware.sevice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodee.groupware.mapper.HrmMapper;
import com.goodee.groupware.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HrmService {
	@Autowired
	private HrmMapper hrmMapper;
	
//	맴버 상세보기 가져오기
	public Member getOneMember(String memberId) {
		return hrmMapper.getOneMember(memberId);
	}
}
