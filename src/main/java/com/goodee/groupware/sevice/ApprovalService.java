package com.goodee.groupware.sevice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.goodee.groupware.mapper.ApprovalMapper;
import com.goodee.groupware.mapper.FileMapper;
import com.goodee.groupware.vo.Approval;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ApprovalService {
	@Autowired
	private ApprovalMapper approvalMapper;
	@Autowired
	private FileMapper fileMapper;
	
	// 결재 리스트 출력
	public Map<String,Object> getApprovalList(int currentPage, int rowPerPage, String approvalLastStatus, String approvalNowStatus, String memberId) {
		
		// 페이징 첫 번째 줄
		int beginRow = (currentPage-1)*rowPerPage;
		
		// 페이징을 위한 변수 boardMap에 선언
		Map<String,Object> approvalMap = new HashMap<String,Object>();
		approvalMap.put("beginRow",beginRow);
		approvalMap.put("rowPerPage",rowPerPage);
		approvalMap.put("approvalLastStatus",approvalLastStatus);
		approvalMap.put("approvalNowStatus",approvalNowStatus);
		approvalMap.put("memberId",memberId);
		// boardMap 디버깅
		log.debug("ApprovalService.getApprovalList() approvalMap --->" + approvalMap.toString());
		
		List<Map<String,Object>> approvalList = approvalMapper.getApprovalList(approvalMap);
		
		// 페이징
		Map<String,Object> approvalMapCount = new HashMap<String,Object>();
		approvalMapCount.put("approvalLastStatus",approvalLastStatus);
		approvalMapCount.put("approvalNowStatus",approvalNowStatus);
		
		int approvalCount = approvalMapper.getApprovalListCount(approvalMapCount);
		int lastPage = approvalCount / rowPerPage;
		if((approvalCount%rowPerPage) != 0) {
			lastPage++;
		}
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("approvalList",approvalList);
		resultMap.put("lastPage",lastPage);
		
		return resultMap;
	}
}
