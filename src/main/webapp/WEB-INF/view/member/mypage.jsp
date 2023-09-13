<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>마이페이지</title>
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
</head>
<body>
	<!--  사이드바 -->
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<!--  해더바 -->
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<!-- 내용물 추가하는 곳 -->
		<div class="container-fluid">
			<div class="container-wrapper">
				<div class="container">
					<c:set var="m" value="${member}"></c:set>
					<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">마이페이지</div>
					<br>
					<table class="table table-hover">
						<thead class="table-active">
							<tr>
								<th>아이디</th>
								<th>부서번호</th>
								<th>이름</th>
								<th>성별</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>주소</th>
								<th>서명</th>
							</tr>
						</thead>	
							<tr>
								<td>${m.memberId}</td>
								<td>${m.departmentNo}</td>
								<td>${m.memberName}</td>
								<td>${m.memberGender}</td>
								<td>${m.memberPhone}</td>
								<td>${m.memberEmail}</td>
								<td>${m.memberAddress}</td>
								<td><img src="${pageContext.request.contextPath}/signFile/${m.memberSignFile}"></td>
							</tr>
					
					</table>
					<a class="btn text-white" style="background-color:green;" href="${pageContext.request.contextPath}/group/member/updateSign?memberId=${m.memberId}">사인 수정</a>
					<a class="btn text-white" style="background-color:orange;" href="${pageContext.request.contextPath}/group/member/updateMypage?memberId=${m.memberId}">수정페이지</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 템플릿 코드 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>