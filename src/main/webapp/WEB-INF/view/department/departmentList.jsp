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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css">
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
              <h1 class="text-center mt-4">부서관리</h1>
				<div class="text-center mt-3">
				<!-- "부서추가" 버튼 -->
				<button id="addDepartmentLink" class="btn btn-primary">부서추가</button>
				<!-- "부서삭제" 버튼 -->
				<button id="deleteDepartmentLink" class="btn btn-primary">부서삭제</button>
				
				</div>
				<div class="container-wrapper">
				    <div class="container">
				  		<h5>이동할 사원 선택</h5>
				        <div>
				            <ul class="main-list">
				                <li>
				                    <!-- 최상위 회사 --> <a href="#" class="toggle-link">회사</a>
				                    <ul class="sub-list">
				                        <c:forEach var="d" items="${departmentList}">
				                            <c:if test="${d.departmentParentId eq '회사'}">
				                                <li><a href="#" class="toggle-link">${d.departmentId}</a>
				                                    <ul class="sub-list">
				                                        <c:forEach var="a" items="${memberList}">
				                                            <c:if test="${d.departmentNo eq a.departmentNo}">
				                                                <li><label> <input type="checkbox" value="${a.memberId}" class="member-checkbox">&nbsp;${a.memberName}
				                                                </label></li>
				                                            </c:if>
				                                        </c:forEach>
				                                        <c:forEach var="c" items="${departmentList}">
				                                            <c:if test="${d.departmentId eq c.departmentParentId}">
				                                                <li><a href="#" class="toggle-link">${c.departmentId}</a>
				                                                    <ul class="sub-list">
				                                                        <c:forEach var="t" items="${memberList}">
				                                                            <c:if test="${c.departmentNo eq t.departmentNo}">
				                                                                <li><label> <input type="checkbox" value="${t.memberId}" class="member-checkbox">&nbsp;${t.memberName}
				                                                                </label></li>
				                                                            </c:if>
				                                                        </c:forEach>
				                                                    </ul></li>
				                                            </c:if>
				                                        </c:forEach>
				                                    </ul></li>
				                            </c:if>
				                        </c:forEach>
				                    </ul>
				                </li>
				            </ul>
				        </div>
				    </div>
				    <div class="container">
				        <div class="arrow-buttons">
				            <button id="leftArrowButton">&larr;</button>
				            <button id="rightArrowButton">&rarr;</button>
				        </div>
				    </div>
				    <div class="container">
				        <!-- 세 번째 컨테이너 내용 -->
				        <h5>이동할 부서 선택</h5>
				        <form id="updateForm" action="/group/department/updateDepartment" method="post">
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
				                        <select name="littleDepartment" id="littleDepartment">
				                            <option value="">=== 선택 ===</option>
				                            <!-- 서버에서 받아온 팀 리스트를 반복하여 옵션 생성 -->
				                            <c:forEach var="team" items="${teamDepartmentList}">
				                                <option value="${team.departmentNo}">${team.departmentId}</option>
				                            </c:forEach>
				                        </select>
				                    </td>
				                </tr>
				                <tr>
				                    <td>직원 아이디</td>
				                    <td>
				                        <input type="text" value="" name="memberId" id="memberIdInput">
				                    </td>
				                </tr>
				                <tr>
				                    <td>직원 이름</td>
				                    <td>
				                        <input type="text" value="" name="memberName" id="memberNameInput" readonly>
				                    </td>
				                </tr>
				            </table>
				            <button type="submit" class="btn btn-primary">업데이트</button>
				        </form>
				    </div>
				</div>
				<!-- 부서 추가 모달창 html -->
				
				<div class="modal">
					<div class="modal_content">
						<h3>부서 추가</h3>
						<form id="addDepartmentForm" action="${pageContext.request.contextPath}/group/department/addDepartment" method="post">
							<table>
								<tr>
									<td>부서목록</td>
									<td>
										<select name="departmentParentNo" id="addDepartmentId">
				                            <option value="">===   부서 선택   ===</option>
				                            <option value="100">인사 부</option>
				                            <option value="200">서비스 부</option>
				                        </select>
				                        <span id="addDepartmentParentMsg" class="msg"></span>
									</td>
								</tr>
								<tr>
									<td>추가할 부서 이름</td>
									<td>
										<input id="addDepartmentId" type="text" name="departmentId">
										<span id="addDepartmentIdMsg" class="msg"></span>
									</td>
								</tr>
							</table>
						</form>
							<button id="addDepartmentBtn" type="button" class="btn btn-primary">추가</button>
							<button id="close" type="button" class="btn btn-primary">닫기</button>
					</div>
				</div>
				<!-- 부서 삭제 모달창 html -->
				<div class="modal2">
					<div class="modal_content2">
						<h3>부서 삭제</h3>
						<h6>부서 삭제를 하시려면 부서인원을 모두 이동 후 삭제가능합니다.</h6>
						<form id="deleteDepartmentForm" action="${pageContext.request.contextPath}/group/department/deleteDepartment" method="post">
							<table>
								<tr>
									<td>삭제 가능 부서 목록</td>
								</tr>
								<c:forEach var="od" items="${getDeleteOnDepartmentList}">
								<tr>
									<td><input type="checkbox" value="${od.departmentNo}" name="departmentNo">&nbsp;&nbsp;&nbsp; ${od.departmentNo}</td>
									<td>${od.departmentId}</td>
								</tr>
								</c:forEach>
							</table>	
						</form>
						<button id="deleteDepartmentBtn" type="button" class="btn btn-primary">삭제</button>
						<button id="close2" type="button" class="btn btn-primary">닫기</button>
					</div>
				</div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="${pageContext.request.contextPath}/javascript/department.js"></script>
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>