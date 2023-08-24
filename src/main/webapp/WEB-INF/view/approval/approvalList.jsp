<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<h1>게시판</h1>
	<div>
		<a href="${pageContext.request.contextPath}/home">홈으로</a><br>
		<a href="${pageContext.request.contextPath}/logout">로그아웃</a><br>
		<a href="/approval/addApproval">게시물 추가</a>
	</div>
	<table class="table table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>생성날짜</th>
			<th>현재상태</th>
			<th>결재여부</th>
		</tr>
		<c:forEach var="a" items="${approvalList}">
			<tr onClick="location.href='/approval/oneApproval?approvalNo=${a.approvalNo}'" style="cursor:pointer;">
				<td>${a.approvalNo}</td>
				<td>${a.approvalTitle}</td>
				<td>${a.approvalContent}</td>
				<td>${a.createdate}</td>
				<td>${a.approvalNowStatus}</td>
				<td>${a.approvalLastStatus}</td>
			</tr>
		</c:forEach>
	</table>
<%-- 	<div>
		<form action="${pageContext.request.contextPath}/board/boardList" method="get">
			<input type="text" name="departmentNo" value="${departmentNo}">
			<input type="text" name="searchWord" value="${param.searchWord}">
			<button type="submit">검색</button>
		</form>
	</div> --%>
 	<c:if test="${currentPage>1}">
		<a href="/approval/approvalList?currentPage=${currentPage-1}">이전</a>
	</c:if>
	<c:if test="${currentPage<lastPage}">
		<a href="/approval/approvalList?currentPage=${currentPage+1}">다음</a>
	</c:if>
</body>
</html>