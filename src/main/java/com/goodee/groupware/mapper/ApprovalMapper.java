
package com.goodee.groupware.mapper;
  
import java.util.List; import java.util.Map;
  
import org.apache.ibatis.annotations.Mapper;
  
import com.goodee.groupware.vo.Approval;
  
@Mapper 
public interface ApprovalMapper { 
	
	List<Map<String,Object>> getApprovalList(Map<String,Object> map);
  
	Approval getOneApproval(Approval approval);
	  
	int getApprovalListCount(Map<String,Object>map);
	  
	int addApproval(Approval approval);
	  
	int updateApprovalRecall(Approval approval);
	
	int updateApprovalComment(Approval approval);
	
	int updateApprovalStatus(Approval approval);
}
 