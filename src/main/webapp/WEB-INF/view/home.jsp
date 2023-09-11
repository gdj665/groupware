<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>홈</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>

<body>
	<!--  사이드바 -->
    <jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	<div class="body-wrapper">
		<!--  해더바 -->
		<jsp:include page="${pageContext.request.contextPath}/menu/header.jsp"></jsp:include>
		<!-- 내용물 추가하는 곳 -->
		<div class="container-fluid">
			<div class="card">
				<div class="card-body">
					<div class="container-wrapper">
						<div class="container">
							<h1>출근 버튼 누르셨나요??</h1>
							<br><br>
							<div class="row">
								<div class="col-sm-8">
									<span>여기에 그래프 하나 넣을까요?</span>
								</div>
								<div class="col-sm-4">
									<table class="table table-hover">
										<tr style="background-color:#E4F1FF; font-size: 18px;">
											<td colspan="3">오늘의 일정 목록</td>
										</tr>
										<tr>
											<th class="table-active">카테고리</th>
											<th class="table-active">제목</th>
											<th class="table-active">내용</th>
										</tr>
										<c:forEach var="t" items="${todayScheduleList}">
											<tr>
												<td>${t.scheduleCategory}</td>
												<td>${t.scheduleTitle}</td>
												<td>${t.scheduleContent}</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
							<br><br>
							<div class="row">
								<div class="col-sm-6">
									<table class="table table-hover">
										<tr style="background-color:#E4F1FF; font-size: 18px;">
											<td colspan="2">공지사항</td>
										</tr>
										<tr>
											<th class="table-active">제목</th>
											<th class="table-active">내용</th>
										</tr>
										<c:forEach var="n" items="${boardListByNotice}">
											<tr>
												<td>${n.boardTitle}</td>
												<td>${n.boardContent}</td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div class="col-sm-6">
									<table class="table table-hover">
										<tr style="background-color:#E4F1FF; font-size: 18px;">
											<td colspan="2">부서 게시판</td>
										</tr>
										<tr>
											<th class="table-active">제목</th>
											<th class="table-active">내용</th>
										</tr>
										<c:forEach var="d" items="${boardListByDepartment}">
											<tr>
												<td>${d.boardTitle}</td>
												<td>${d.boardContent}</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>