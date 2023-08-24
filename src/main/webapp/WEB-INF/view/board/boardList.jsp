<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script>
    function changeDepartment(departmentNo) {
        document.location.href = "/board/boardList?departmentNo=" + departmentNo;
    }
</script>

</head>
<body>

	<h1>게시판</h1>
	<div>
		<a href="${pageContext.request.contextPath}/home">홈으로</a><br>
		<a href="${pageContext.request.contextPath}/logout">로그아웃</a><br>
		<a href="/board/addBoard">게시물 추가</a>
	</div>
	<button type="button" onclick="changeDepartment(-1)">부서 게시판</button>
    <button type="button" onclick="changeDepartment(0)">회사 게시판</button>
	<table class="table table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>생성날짜</th>
		</tr>
		<c:forEach var="b" items="${boardList}">
			<tr onClick="location.href='/board/boardOne?boardNo=${b.boardNo}'" style="cursor:pointer;">
				<td>${b.boardNo}</td>
				<td>${b.boardTitle}</td>
				<td>${b.boardContent}</td>
				<td>${b.memberId}</td>
				<td>${b.createdate}</td>
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
	<c:if test="${currentPage>1 }">
		<a href="/board/boardList?currentPage=${currentPage-1}&departmentNo=${param.departmentNo}">이전</a>
	</c:if>
	<c:if test="${currentPage<lastPage}">
		<a href="/board/boardList?currentPage=${currentPage+1}&departmentNo=${param.departmentNo}">다음</a>
	</c:if>
</body>
</html>