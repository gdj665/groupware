package com.goodee.groupware.sevice;

import java.util.List;
import java.util.Map;

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
	// 사원상세보기 (권원중)
		public List<Map<String,Object>> getOneMember2(String memberId){
			List<Map<String,Object>> getOneMember = hrmMapper.getOneMember2(memberId);
			return getOneMember;
		}
	
	// 사원 리스트
	public List<Map<String,Object>> getMemberList(){
		List<Map<String,Object>> memberList = hrmMapper.getMemberList();
		//memberList debug
		log.debug("hrmService.getMemberList() -->" + memberList);
		
		return memberList;
	}
	// 사원 추가
	public int addMember(Member member) {
		int row = 0;
		String memberId = member.getMemberHiredate();
		memberId = memberId.substring(2);
		memberId = memberId.replace("-", "");
		log.debug("hrmService.memberId() -->" + memberId);
		member.setMemberId(memberId);
		//기본 입사날 첫 사원 아이디 형식저장
		memberId = memberId+"01";
		//입사 날짜 int 타입으로 저장
		int memberIdHiredate = Integer.parseInt(memberId);
		int memberCnt = hrmMapper.getLastMemberId(member);
		log.debug("hrmService.memberCnt() -->" + memberCnt);
		if(memberCnt > 0) {
			// 입사날의 사원 수 만큼 더해서 아이디 변경
			memberIdHiredate = memberIdHiredate+memberCnt;
			memberId = Integer.toString(memberIdHiredate);
		}
		log.debug("hrmService.memberId() -->" + memberId);
		member.setMemberId(memberId);
		//처음생성 비밀빈호 고정값
		String memberPw = "1234";
		member.setMemberPw(memberPw);
		row = hrmMapper.addMember(member);
		return row;
	}
	// 사원 수정
	public int updateMember(Member member) {
		int row = 0;
		row = hrmMapper.updateMember(member);
		return row;
		
	}
}
