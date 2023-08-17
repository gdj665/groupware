<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<h1>게시판 상세보기</h1>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>${boardOne.boardNo}</th>
		</tr>
		<tr>
			<th>작성자아이디</th>
			<th>${boardOne.memberId}</th>
		</tr>
		<tr>
			<th>제목</th>
			<th>${boardOne.boardTitle}</th>
		</tr>
		<tr>
			<th>내용</th>
			<th>${boardOne.boardContent}</th>
		</tr>
		<tr>
			<th>부서</th>
			<th>${boardOne.departmentNo}</th>
		</tr>
		<tr>
			<th>상단고정여부</th>
			<th>${boardOne.boardStatus}</th>
		</tr>
		<tr>
			<th>생성일짜</th>
			<th>${boardOne.createdate}</th>
		</tr>
		<tr>
			<th>수정일</th>
			<th>${boardOne.updatedate}</th>
		</tr>
		<c:forEach var="b" items="${boardFileList}">
			<tr>
				<td>${b.boardFileOri}</td>
				<td><a href="/board/boardDownload?boardFileNo=${b.boardFileNo}" style="cursor:pointer;">${b.boardFileNo}다운로드</a></td>
			</tr>
		</c:forEach>
	</table>
	<form action="/board/deleteBoard" method="post">
		<input type="hidden" name="boardNo" value="${boardOne.boardNo}">
		<button type="submit" onClick="return confirm('삭제하시겠습니까?')">삭제</button>
	</form>
</body>
</html>