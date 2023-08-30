package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Member;
@Mapper
public interface HrmMapper {
	// 사원 상세보기
	Member getOneMember(String memberId);
	// 사원 리스트
	List<Map<String,Object>> getMemberList();
	// 사원 추가
	int addMember(Member member);
	// 사원 입사날 아이디 갯수
	int getLastMemberId(Member member);
	// 사원 상세보기
	List<Map<String,Object>> getOneMember2(String memberId);
	// 사원 수정
	int updateMember(Member member);
	// 퇴사
	int deleteMember(Member member);
	// 부서별사원수
	List<Map<String,Object>> departmentCnt();
}
