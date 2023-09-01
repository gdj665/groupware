<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>부서관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/hrm.css">
<!-- 카카오API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- excel api : sheetjs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>

<body>
    <!--  사이드바 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
    <div class="body-wrapper">
      <!--  해더바 -->
      <jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
      <!-- 내용물 추가하는 곳 -->
      <div class="container-fluid">
        <div class="container-fluid">
          <div class="card">
            <div class="card-body">
             <h1 class="text-center mt-4">사원관리</h1>
				<div class="container">
				 <div class="button-container">
				    <button id="addHrmLink" class="btn btn-primary toggle-button">
				      <i class="fas fa-user-plus"></i> 사원 추가
				    </button>
				    <button id="excelBtn" class="btn btn-primary toggle-button">
				      <i class="fas fa-file-excel"></i> 엑셀 다운로드
				    </button>
				    <button id="toggleServiceDept" class="btn btn-primary toggle-button">
				      <i class="fas fa-users"></i> 서비스 부서
				    </button>
				    <button id="toggleHRDept" class="btn btn-primary toggle-button">
				      <i class="fas fa-users-cog"></i> 인사 부서
				    </button>
				  </div>
				<div class="table-container" id="serviceDeptTable">
					<table>
					    <thead>
					        <tr>
					            <th>부서</th>
					            <th>멤버</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach var="d" items="${departmentList}">
					            <c:if test="${d.departmentNo == 200}">
					                <tr>
					                    <td>${d.departmentId}</td>
					                    <td>
					                        <ul>
					                            <c:forEach var="a" items="${memberList}">
					                                <c:if test="${d.departmentNo eq a.departmentNo}">
					                                    <li><label><a href="#" class="oneHrm" data-memberId="${a.memberId}">${a.memberName}</a></label></li>
					                                </c:if>
					                            </c:forEach>
					                        </ul>
					                    </td>
					                </tr>
					                <c:forEach var="c" items="${departmentList}">
					                    <c:if test="${d.departmentId eq c.departmentParentId}">
					                        <tr>
					                            <td>${c.departmentId}</td>
					                            <td>
					                                <ul>
					                                    <c:forEach var="t" items="${memberList}">
					                                        <c:if test="${c.departmentNo eq t.departmentNo}">
					                                            <li><label><a href="#" class="oneHrm" data-memberId="${t.memberId}">${t.memberName}</a></label></li>
					                                        </c:if>
					                                    </c:forEach>
					                                </ul>
					                            </td>
					                        </tr>
					                    </c:if>
					                </c:forEach>
					            </c:if>
					        </c:forEach>
					    </tbody>
					</table>
				</div>
				 <div class="table-container" id="hrDeptTable">
			    <table>
				    <thead>
				        <tr>
				            <th>부서</th>
				            <th>멤버</th>
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach var="d" items="${departmentList}">
				            <c:if test="${d.departmentNo == 100}">
				                <tr>
				                    <td>${d.departmentId}</td>
				                    <td>
				                        <ul>
				                            <c:forEach var="a" items="${memberList}">
				                                <c:if test="${d.departmentNo eq a.departmentNo}">
				                                    <li><label><a href="#" class="oneHrm" data-memberId="${a.memberId}">${a.memberName}</a></label></li>
				                                </c:if>
				                            </c:forEach>
				                        </ul>
				                    </td>
				                </tr>
				                <c:forEach var="c" items="${departmentList}">
				                    <c:if test="${d.departmentId eq c.departmentParentId}">
				                        <tr>
				                            <td>${c.departmentId}</td>
				                            <td>
				                                <ul>
				                                    <c:forEach var="t" items="${memberList}">
				                                        <c:if test="${c.departmentNo eq t.departmentNo}">
				                                            <li><label><a href="#" class="oneHrm" data-memberId="${t.memberId}">${t.memberName}</a></label></li>
				                                        </c:if>
				                                    </c:forEach>
				                                </ul>
				                            </td>
				                        </tr>
				                    </c:if>
				                </c:forEach>
				            </c:if>
				        </c:forEach>
				    </tbody>
				</table>
				 </div>
			</div>
		
			<!-- 사원 추가 모달창 html -->
			
			<div class="modal">
				<div class="modal_content">
					<h3>사원 추가</h3>
					<form id="addHrmForm" action="${pageContext.request.contextPath}/hrm/addHrm" method="post">
						<table>
							<tr>
			                    <td>부서</td>
			                    <td>
			                        <select name="bigDepartment" id="bigDepartment">
			                            <option value="">===   부서 선택   ===</option>
			                            <option value="100">인사 부</option>
			                            <option value="200">서비스 부</option>
			                        </select>
			                    </td>
			                </tr>
			                <tr>
			                    <td>팀</td>
			                    <td>
			                        <select name="departmentNo" id="littleDepartment">
			                            <option value="">=== 선택 ===</option>
			                            <!-- 서버에서 받아온 팀 리스트를 반복하여 옵션 생성 -->
			                            <c:forEach var="team" items="${teamDepartmentList}">
			                                <option value="${team.departmentNo}">${team.departmentId}</option>
			                            </c:forEach>
			                        </select>
			                    </td>
			                </tr>
			               <tr>
			                	<td>직원 이름</td>
			                	<td>
			                		<input type="text" name="memberName" id="addMemberName" placeholder="이름을 입력하세요" required="required">
			                	</td>
			                </tr>
			                <tr>
			                	<td>직원 주소</td>
			                	<td>
			                		<textarea name ="memberAddress" id="addMemberAddress" cols ="33" rows="5" placeholder="주소입력" class="single-textarea" required="required" ></textarea> &nbsp; 
			                		<button class="btn btn-primary" id="address_kakao">주소검색</button>
			                	</td>
			                </tr>
			                <tr>
			                	<td>직원 이메일</td>
			                	<td>
			                		<input type="text" name="memberEmail" id="addMemberEmail" placeholder="이메일을 입력하세요" required="required">
			                	</td>
			                </tr>
			                <tr>
			                	<td>성별</td>
			                	<td>
									<input type="radio" name="memberGender" value="남" checked="checked" required="required">남
									<input type="radio" name="memberGender" value="여" required="required">여
			                	</td>
			                </tr>
			                <tr>
			                	<td>생년월일</td>
			                	<td>
									<input type="date" name="memberBirth" id="addMemberBirth" required="required">
			                	</td>
			                </tr>
		  	                <tr>
			                	<td>전화번호</td>
			                	<td>
									<input type="number" name="memberPhone" id="addMemberPhone" placeholder="전화번호을 입력하세요" required="required">
			                	</td>
			                </tr>
			                <tr>
			                	<td>직급</td>
			                	<td>
									<select id="memberRank" name="memberRank">
										<option value="">=== 직급 ===</option>
										<option value="1사원">=== 사원 ===</option>
										<option value="2대리">=== 대리 ===</option>
										<option value="3과장">=== 과장 ===</option>
										<option value="4차장">=== 차장 ===</option>
										<option value="5부장">=== 부장 ===</option>
										<option value="6이사">=== 이사 ===</option>
									</select>
			                	</td>
			                </tr>
			                <tr>
			                	<td>직무 레벨</td>
			                	<td>
									<select id="memberLevel" name="memberLevel">
										<option value="">=== 직무 레벨 ===</option>
										<option value="1팀원">=== 팀원 ===</option>
										<option value="2팀장">=== 팀장 ===</option>
										<option value="3부서장">=== 부서장 ===</option>
										<option value="4관리자">=== 관리자 ===</option>
									</select>
			                	</td>
			                </tr>
			                <tr>
			                	<td>입사 날짜</td>
			                	<td>
			                		<input type="date" name="memberHiredate" required="required" id="addMemberHiredate">
			                	</td>
			                </tr>
						</table>
					</form>
						<button id="addHrmBtn" type="button" class="btn btn-primary">추가</button>
						<button id="close" type="button" class="btn btn-primary">닫기</button>
				</div>
			</div>
			
			<!-- 사원 상세보기 모달창 html -->
			
			<div class="modal2">
				<div class="modal_content2">
					<h3>사원 상세보기 </h3>
					<form id="updateMember" action="${pageContext.request.contextPath}/hrm/updateMember" method="post">
						
						<table>
							<tr>
								<td>직원 아이디 </td>
								<td>
									<input type="text" name="memberId" id="memberId"  readonly="readonly">
								</td>
							</tr>
							
			                <tr>
			                    <td>팀</td>
			                    <td>
									<input type="text" id="departmentId" readonly="readonly">
			                    </td>
			                </tr>
			               <tr>
			                	<td>직원 이름</td>
			                	<td>
			                		<input type="text" name="memberName" id="memberName"  readonly="readonly">
			                	</td>
			                </tr>
			                <tr>
			                	<td>직원 주소</td>
			                	<td>
			                		<input type="text" name="memberAddress"  id="memberAddress"  readonly="readonly"> 
			                	</td>
			                </tr>
			                <tr>
			                	<td>직원 이메일</td>
			                	<td>
			                		<input type="text" name="memberEmail"  id="memberEmail"  readonly="readonly">
			                	</td>
			                </tr>
			                <tr>
			                	<td>성별</td>
			                	<td>
									<input type="text" name="memberGender" id="memberGender" readonly="readonly">
			                	</td>
			                </tr>
			                <tr>
			                	<td>생년월일</td>
			                	<td>
									<input type="text" name="memberBirth"  id="memberBirth" readonly="readonly">
			                	</td>
			                </tr>
		  	                <tr>
			                	<td>전화번호</td>
			                	<td>
									<input type="number" name="memberPhone" id="memberPhone"  readonly="readonly">
			                	</td>
			                </tr>
			                <tr>
			                	<td>현재 직급 : <span id="memberRank2"></span> </td>
			                	<td>
									<select id="updateMemberRank" name="memberRank">
										<option value="">=== 직급 ===</option>
										<option value="1사원">=== 사원 ===</option>
										<option value="2대리">=== 대리 ===</option>
										<option value="3과장">=== 과장 ===</option>
										<option value="4차장">=== 차장 ===</option>
										<option value="5부장">=== 부장 ===</option>
										<option value="6이사">=== 이사 ===</option>
									</select>
			                	</td>
			                </tr>
			                <tr>
			                	<td>현재 직무 레벨 : <span id="memberLevel2"></span></td>
			                	<td>
									<select id="updateMemberLevel" name="memberLevel">
										<option value="">=== 직무 레벨 ===</option>
										<option value="1팀원">=== 팀원 ===</option>
										<option value="2팀장">=== 팀장 ===</option>
										<option value="3부서장">=== 부서장 ===</option>
										<option value="4관리자">=== 관리자 ===</option>
									</select>
			                	</td>
			                </tr>
			                <tr>
			                	<td>입사 날짜</td>
			                	<td>
			                		<input type="text" name="memberHiredate"  id="memberHiredate" readonly="readonly">
			                	</td>
			                </tr>
						</table>
					</form>
				    <button id="updateMemberBtn" type="button" class="btn btn-primary">수정</button>
				    <button id="close2" type="button" class="btn btn-primary">닫기</button>
			        <button id="deleteMemberBtn" type="button" class="btn btn-primary">퇴사</button>
				    <form action="${pageContext.request.contextPath}/hrm/deleteMember" method="post">
				        <input type="hidden" id="memberId2"  name="memberId">
				    </form>
				</div>
			</div>
            </div>
          </div>
        </div>
      </div>
    </div>
	<script src="${pageContext.request.contextPath}/javascript/hrm.js"></script>
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>