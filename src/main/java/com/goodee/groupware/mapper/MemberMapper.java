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
	
//	근태 관리 출력
	List<Work> getWorkCheckInfoList(Map<String, Object> paramMap);

//	근태 근태 지각, 조퇴, 연차 출력
	List<Map<String, Object>> getWorkCheckList(Map<String, Object> paramMap);
	
//	이번달 개인 근무 횟수와 연차 사용 횟수 출력	
	List<Map<String, Object>> getMyWorkCheckCntList(Map<String, Object> paramMap);
}
