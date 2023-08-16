<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<h1>게시판</h1>
	<div>
		<a href="/board/addBoard">게시물 추가</a>
	</div>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>생성날짜</th>
		</tr>
		<c:forEach var="b" items="${boardList}">
			<tr>
				<td>${b.boardNo}</td>
				<td>${b.boardTitle}</td>
				<td>${b.boardContent}</td>
				<td>${b.memberId}</td>
				<td>${b.createdate}</td>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${currentPage>1 }">
		<a href="/board/boardList?currentPage=${currentPage-1}">이전</a>
	</c:if>
	<c:if test="${currentPage<lastPage}">
		<a href="/board/boardList?currentPage=${currentPage+1}">다음</a>
	</c:if>
</body>
</html>