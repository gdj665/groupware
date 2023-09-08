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
									<span>&nbsp;</span>
								</div>
								<div class="col-sm-4">
									<h5>오늘의 일정 목록</h5>
									<table class="table table-hover">
										<thead class="table-active">
											<tr>
												<th>카테고리</th>
												<th>제목</th>
												<th>내용</th>
											
											</tr>
										</thead>
											<c:forEach var="t" items="${todayScheduleList}">
												<tr>
													<td>${t.scheduleCategory}</td>
													<td>${t.scheduleTitle}</td>
													<td>${t.scheduleContent}</td>
												</tr>
											</c:forEach>
									</table>
								</div>
								<br><br><br><br><br><br><br><br><br><br>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    <!--  <script src="${pageContext.request.contextPath}/javascript/home.js"></script> -->
 <jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>

</html>