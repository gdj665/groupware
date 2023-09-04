<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
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
							<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">부서 게시판</div>
						</c:when>
						<c:when test="${param.departmentNo == 0}">
							<div style="padding:20px; font-size: 30pt; font-weight: bold; color:#000000;">공지사항</div>
						</c:when>
					</c:choose>
					<div>
						<a style="float:right;" class="btn btn-primary" href="${pageContext.request.contextPath}/group/board/addBoard">게시글 작성</a>
					</div><br>
					<table class="table table-hover">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>내용</th>
							<th>작성자</th>
							<th>생성날짜</th>
						</tr>
						<c:forEach var="b" items="${boardList}">
							<tr onClick="location.href='/group/board/boardOne?boardNo=${b.boardNo}'" style="cursor:pointer;">
								<c:choose>
									<c:when test="${b.boardStatus eq 'Y'}">
										<td style="font-weight: bold; background-color: #99ccff;"><i class="fas fa-thumbtack"></i>&nbsp;${b.boardNo}</td>
										<td style="font-weight: bold; background-color: #99ccff;">${b.boardTitle}</td>
										<td style="font-weight: bold; background-color: #99ccff;">${b.boardContent}</td>
										<td style="font-weight: bold; background-color: #99ccff;">${b.memberName}</td>
										<td style="font-weight: bold; background-color: #99ccff;">${b.createdate}</td>
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
					<form action="${pageContext.request.contextPath}/board/boardList" method="get">
						<div class="input-group" style="width:30%;">
							<input type="text" class="form-control" name="searchWord" style="width:30% !important;" placeholder="검색어를 입력해주시기 바랍니다">&nbsp;&nbsp;&nbsp;
							<input type="hidden" name="departmentNo" value="${param.departmentNo}">
							<div class="input-group-append">
								<button class="btn btn-primary" type="submit">검색</button>
							</div>
						</div>
					</form>
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
										<span style="background-color: #cccccc;" class="page-link current-page">${i}</span>
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
				</div>
			</div>
		</div>
	</div>
</body>
</html>