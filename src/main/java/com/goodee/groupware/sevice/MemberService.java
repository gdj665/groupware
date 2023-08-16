package com.goodee.groupware.sevice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodee.groupware.mapper.MemberMapper;
import com.goodee.groupware.vo.Member;

@Service
public class MemberService {
	@Autowired
	private MemberMapper memberMapper;
	
	public int checkMember(Member member) {
		return memberMapper.checkMember(member);
	}
	
	public int updatePw(Member member) {
		return memberMapper.updatePw(member);
	}
}
