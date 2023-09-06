<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/list.css">
<script>
    function changeDepartment(departmentNo) {
        document.location.href = "/group/board/boardList?departmentNo=" + departmentNo;
    }
</script>

</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
				<div class="card">
					<c:choose>
						<c:when test="${param.departmentNo != 0}">
							<div class="list-title">부서 게시판</div>
						</c:when>
						<c:when test="${param.departmentNo == 0}">
							<div class="list-title">공지사항</div>
						</c:when>
					</c:choose>
					<div>
						<a style="float:right; margin-right:10px;" class="btn btn-primary" href="${pageContext.request.contextPath}/group/board/addBoard">게시글 작성</a>
					</div><br>
					<table class="table table-hover">
						<thead class="table-active">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>내용</th>
								<th>작성자</th> 
								<th>생성날짜</th>
							</tr>
						</thead>
						<c:forEach var="b" items="${boardList}">
							<tr onClick="location.href='/group/board/boardOne?boardNo=${b.boardNo}'" style="cursor:pointer;">
								<c:choose>
									<c:when test="${b.boardStatus eq 'Y'}">
										<td class="top-fixed"><i class="fas fa-thumbtack"></i>&nbsp;${b.boardNo}</td>
										<td class="top-fixed">${b.boardTitle}</td>
										<td class="top-fixed">${b.boardContent}</td>
										<td class="top-fixed">${b.memberName}</td>
										<td class="top-fixed">${b.createdate}</td>
									</c:when>
									<c:otherwise>
										<td>${b.boardNo}</td>
										<td>${b.boardTitle}</td>
										<td>${b.boardContent}</td>
										<td>${b.memberName}</td>
										<td>${b.createdate}</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</table>
					<br>
					<div>
						<ul class="pagination" style="justify-content: center;">
							<c:if test="${currentPage > 1}">
								<li class="page-item">
								    <a href="/group/board/boardList?currentPage=${currentPage-1}&departmentNo=${param.departmentNo}" class="page-link">이전</a>
								</li>
							</c:if>
							
							<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
								<li class="page-item">
							    	<c:if test="${i ==  currentPage}">
										<span class="page-link current-page page-one">${i}</span>
									</c:if>
									<c:if test="${i !=  currentPage}">
										<a href="/group/board/boardList?currentPage=${i}&departmentNo=${param.departmentNo}" class="page-link">${i}</a>
									</c:if>
								</li>
							</c:forEach>
								
							<c:if test="${currentPage < lastPage}">
								<li class="page-item">
								    <a href="/group/board/boardList?currentPage=${currentPage+1}&departmentNo=${param.departmentNo}" class="page-link">다음</a>
								</li>
							</c:if>
						</ul>
					</div>
					<br>
					<form action="${pageContext.request.contextPath}/board/boardList" method="get">
						<div class="input-group" style="width:30%; margin-right:10px; float:right">
							<input type="text" class="form-control" name="searchWord" style="width:30% !important;" placeholder="검색어를 입력해주시기 바랍니다">
							<input type="hidden" name="departmentNo" value="${param.departmentNo}">
							<button class="btn btn-primary" type="submit">검색</button>
						</div>
					</form>
					<br>
				</div>
			</div>
		</div>
	</div>
	
	<!-- javaScirpt -->
	<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>