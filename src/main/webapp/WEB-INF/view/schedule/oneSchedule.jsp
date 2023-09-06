<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>일정 상세보기</title>
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/modal.css">
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
							<!-- model값 받아와서 문자로 셋팅 -->
							<c:set var="m" value="${oneScheduleMap}"></c:set>
							<div style="display: flex; justify-content: space-between; align-items: center;">
							    <div style="padding: 20px; font-size: 30pt; font-weight: bold; color: #000000;">${m.targetYear}년 ${m.targetMonth+1}월 ${m.targetDate}일 일정</div>
							    <a class="btn btn-primary" href="${pageContext.request.contextPath}/group/schedule/scheduleList">뒤로가기</a>
							</div>
							<br>
							<a class="btn text-white" style="background-color:black" href="${pageContext.request.contextPath}/group/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}">전체</a>
							<a class="btn text-white" style="background-color:orange" href="${pageContext.request.contextPath}/group/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}&scheduleCategory=부서">부서</a>
							<a class="btn text-white" style="background-color:green" href="${pageContext.request.contextPath}/group/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}&scheduleCategory=개인">개인</a>
							<br><br>
							<table class="table table-hover">
								<thead class="table-active">
									<tr>
										<th>카테고리</th>
										<th>부서번호</th>
										<th>제목</th>
										<th>내용</th>
										<th>시작일</th>
										<th>종료일</th>
										<th colspan="2">삭제</th>
									</tr>
								</thead>	
								<c:forEach var="c" items="${m.oneScheduleList}">
									<tr>
										<td>${c.scheduleCategory}</td>
										<td>${m.departmentNo}</td>
										<td>${c.scheduleTitle}</td>
										<td>${c.scheduleContent}</td>
										<td>${c.scheduleBegindate}</td>
										<td>${c.scheduleEnddate}</td>
										<c:if test="${c.scheduleCategory == '개인'}">
											<td><a href="${pageContext.request.contextPath}/group/schedule/deletePersonalSchedule?scheduleNo=${c.scheduleNo}" onClick="return confirm('삭제하시겠습니까?')">개인일정삭제</a></td>
										</c:if>
										<c:if test="${c.scheduleCategory == '부서'}">
											<td><a href="${pageContext.request.contextPath}/group/schedule/deleteDepartmentSchedule?scheduleNo=${c.scheduleNo}" onClick="return confirm('삭제하시겠습니까?')">부서일정삭제</a></td>
										</c:if>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>					
	</div>
	<!-- 템플릿 코드 -->
	<jsp:include page="${pageContext.request.contextPath}/menu/code.jsp"></jsp:include>
</body>
</html>