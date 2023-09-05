<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세보기</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- bootStrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/list.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
				<div class="card">
					<div class="list-title">게시글 상세보기</div>
					<!-- 본문 내용 -->
					<div class="detail-content">
						<div class="row">
							<div class="col-sm-4">
								<label class="form-label">번호</label>
								<input type="text" class="form-control" value="${boardOne.boardNo}" readonly="readonly"><br>
							</div>
							<div class="col-sm-4">
								<label class="form-label">작성자아이디</label>
								<input type="text" class="form-control" value="${boardOne.memberId}" readonly="readonly"><br>
							</div>
							<div class="col-sm-4">
								<label class="form-label">생성일짜</label>
								<input type="text" class="form-control" value="${boardOne.createdate}" readonly="readonly"><br>
							</div>
						</div>
						
						<label class="form-label">제목</label>
						<input type="text" class="form-control" value="${boardOne.boardTitle}" readonly="readonly"><br>
						<label class="form-label">내용</label>
						<textarea class="form-control" rows="20" cols="50" readonly="readonly">${boardOne.boardContent}</textarea><br>
						
						<label class="form-label">첨부파일 목록</label><br>
						<c:forEach var="b" items="${boardFileList}">
							<a href="/board/boardDownload?boardFileNo=${b.boardFileNo}" style="cursor:pointer;">${b.boardFileOri}</a><br>
						</c:forEach><br>
						<!-- 작성자만 지울수 있도록 수정 -->
						<c:if test="${boardOne.memberId == loginMemberId}">
							<form action="/group/board/deleteBoard" method="post">
								<input type="hidden" name="boardNo" value="${boardOne.boardNo}">
								<button class="btn btn-primary" type=submit onClick="return confirm('삭제하시겠습니까?')">삭제</button>
							</form>
						</c:if>
					</div><!-- ./detail-content -->
				</div>
			</div>
		</div>
	</div>
	
	<!-- javaScirpt -->
	<script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>