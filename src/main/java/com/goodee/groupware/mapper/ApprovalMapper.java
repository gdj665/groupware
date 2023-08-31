
package com.goodee.groupware.mapper;
  
import java.util.List; import java.util.Map;
  
import org.apache.ibatis.annotations.Mapper;
  
import com.goodee.groupware.vo.Approval;
  
@Mapper 
public interface ApprovalMapper { 
	
	// 1.) 결재 리스트출력
	List<Map<String,Object>> getApprovalList(Map<String,Object> map);
	
	// 2.) 결재 리스트 분기값에 따른 결재리스트 행 개수
	int getApprovalListCount(Map<String,Object>map);
	
	// 3.) 결제 상세출력
	Map<String,Object> getOneApproval(Approval approval);
	  
	// 4.) 결재 추가
	int addApproval(Approval approval);
	
	// 5.) 결재 회수
	int updateApprovalRecall(Approval approval);
	
	// 6.) 결재 진행 코멘트 업데이트
	int updateApprovalComment(Approval approval);
	
	// 7.) 결재 진행 상태 변경
	int updateApprovalStatus(Approval approval);
}
 