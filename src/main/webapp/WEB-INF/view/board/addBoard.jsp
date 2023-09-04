<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 입력</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- bootStrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addApproval.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/list.css">
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<div class="container-fluid">
			<div class="container-fluid">
				<div class="card">
					<div class="list-title">게시글 작성</div>
					
					<form action="/group/board/addBoard" method="post" enctype="multipart/form-data" id="uploadForm">
						<!-- 상단 고정 여부 -->
						<label class="form-label">상단 고정 여부</label><br>
						<input type="radio" id="radio1" class="form-check-input" name="boardStatus" value="Y"><label for="radio1">상단 고정&nbsp;&nbsp;</label>
						<input type="radio" id="radio2" class="form-check-input" name="boardStatus" value="N" checked="checked"><label for="radio2">상단 비고정</label><br><br>
						
						<!-- 첨부파일 추가 -->
						<input type="file" name="multipartFile" id="fileInput" multiple><br><br>
						<!-- 선택한 첨부파일들 이름 출력 -->
						<label class="form-label">선택된 파일</label>
						<div style="background-color:#FFFFFF; border: 1px solid #cccccc; padding:5px;" id="selectedFiles"></div><br>
						
						<!-- 제목 입력 -->
						<label for="boardTitle" class="form-label" >제목</label>
						<input type="text" name="boardTitle" id="boardTitle" class="form-control" required="required" style="background-color:#FFFFFF;"><br>
						
						<!-- 내용 입력 -->
						<label for="boardContent" class="form-label">내용</label>
						<textarea name="boardContent" id="boardContent" class="form-control" rows="20" cols="50" required="required" style="background-color:#FFFFFF; border: 1px solid #cccccc;"></textarea><br>
						
						<!-- 게시물 추가 -->
						<button type="submit" form="uploadForm" class="btn btn-primary">게시물 추가</button>
						
					</form>
				</div><!-- ./card -->
			</div><!-- ./container-fluid -->
		</div><!-- ./container-fluid -->
	</div><!-- ./body-wrapper -->
	
	<!-- javaScirpt -->
	<script src="${pageContext.request.contextPath}/assets/libs/jquery/dist/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<!-- 개인 js -->
	<script src="${pageContext.request.contextPath}/javascript/addBoard.js"></script>
</body>
</html>