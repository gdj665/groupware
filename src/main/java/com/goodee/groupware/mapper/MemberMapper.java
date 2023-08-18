package com.goodee.groupware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Member;

@Mapper
public interface MemberMapper {
//	로그인 유의성 검사
	Member checkMember(Member member);
	
//	memberPw 수정
	int updatePw(Member member);
	
//	member 수정
	int updateOneMember(Member member);
}
