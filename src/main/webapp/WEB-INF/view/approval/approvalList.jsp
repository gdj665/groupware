<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/list.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
				<div class="card">
					<div class="list-title">결재</div>
					<div style="margin-left:10px;">
						<a class="addButton btn btn-primary" href="/group/approval/addApproval">결재 등록</a>
					</div><br>
					<table class="table table-hover">
						<thead class="table-active">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>내용</th>
								<th>생성날짜</th>
								<th>현재상태</th>
								<th>결재여부</th>
							</tr>
						</thead>
						<c:forEach var="a" items="${approvalList}">
							<tr onClick="location.href='/group/approval/oneApproval?approvalNo=${a.approvalNo}'" style="cursor:pointer;">
								<td>${a.approvalNo}</td>
								<td>${a.approvalTitle}</td>
								<td>${a.approvalContent}</td>
								<td>${a.createdate}</td>
								<td>${a.approvalNowStatus}</td>
								<td>${a.approvalLastStatus}</td>
							</tr>
						</c:forEach>
					</table>
					<br>
					<div>
						<ul class="pagination" style="justify-content: center;">
							<c:if test="${currentPage > 1}">
								<li class="page-item">
								    <a href="/group/approval/approvalList?currentPage=${currentPage-1}&approvalNowStatus=${param.approvalNowStatus}&searchWord=${param.searchWord}" class="page-link">이전</a>
								</li>
							</c:if>
							
							<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
								<li class="page-item">
							    	<c:if test="${i ==  currentPage}">
										<span class="page-link current-page page-one">${i}</span>
									</c:if>
									<c:if test="${i !=  currentPage}">
										<a href="/group/approval/approvalList?currentPage=${i}&approvalNowStatus=${param.approvalNowStatus}&searchWord=${param.searchWord}" class="page-link">${i}</a>
									</c:if>
								</li>
							</c:forEach>
								
							<c:if test="${currentPage < lastPage}">
								<li class="page-item">
								    <a href="/group/approval/approvalList?currentPage=${currentPage+1}&approvalNowStatus=${param.approvalNowStatus}&searchWord=${param.searchWord}" class="page-link">다음</a>
								</li>
							</c:if>
						</ul>
					</div>
					<br>
					<form action="${pageContext.request.contextPath}/group/approval/approvalList" method="get">
						<div class="input-group search-word" style="width:50%; float:right; margin-right:10px;">
							<select name="approvalNowStatus" class="form-select">
								<option value="">===선택해주세요===</option>
								<option value="결재전">결재전</option>
								<option value="결재중">결재중</option>
								<option value="결재완료">결재완료</option>
							</select>
							<input type="text" name="searchWord" class="form-control" placeholder="검색어를 입력해주시기 바랍니다">
							<button class="btn btn-primary" type="submit">검색</button>
						</div>
					</form><br>
				</div>
			</div>
		</div>
	</div>
	<!-- javaScirpt -->
	<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>