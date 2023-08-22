package com.goodee.groupware.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.goodee.groupware.vo.Member;
import com.goodee.groupware.vo.Work;

@Mapper
public interface MemberMapper {
//	로그인 유의성 검사
	Member checkMember(Member member);
	
//	memberPw 수정
	int updatePw(Member member);
	
//	member 수정
	int updateOneMember(Member member);
	
//	member sign 수정
	int updateSign(Member member);
	
//	근태 출력
	List<Work> getWorkList(Map<String, Object> paramMap);
	
//	출근 입력
	int addWorkBegin(Work work);

//	출근 입력
	int addWorkEnd(Work work);

//	연차 입력
	int addWorkAnnual(Work work);
	
//	출근 유의성 체크
	int checkWork(Work work);
	
}
