<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>일정 상세보기</title>
<!-- 개인 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/schedule.css">
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
							<a class="btn btn-primary" href="${pageContext.request.contextPath}/group/schedule/scheduleList">뒤로가기</a>
							
							<h1>${m.targetYear}년 ${m.targetMonth+1}월 ${m.targetDate}일 일정</h1>
						
							<a style="color:orange" href="${pageContext.request.contextPath}/group/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}&scheduleCategory=부서">부서</a>
							<a style="color:green" href="${pageContext.request.contextPath}/group/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}&scheduleCategory=개인">개인</a>
							<br><br>
							<table class="table" style="width: 100%;">
								<tr>
									<th class="table_cell">카테고리</th>
									<th class="table_cell">부서번호</th>
									<th class="table_cell">제목</th>
									<th class="table_cell">내용</th>
									<th class="table_cell">시작일</th>
									<th class="table_cell">종료일</th>
									<th class="table_cell" colspan="2">삭제</th>
								</tr>
								<c:forEach var="c" items="${m.oneScheduleList}">
								<tr>
									<th class="table_cell">${c.scheduleCategory}</th>
									<th class="table_cell">${m.departmentNo}</th>
									<th class="table_cell">${c.scheduleTitle}</th>
									<th class="table_cell">${c.scheduleContent}</th>
									<th class="table_cell">${c.scheduleBegindate}</th>
									<th class="table_cell">${c.scheduleEnddate}</th>
									<c:if test="${c.scheduleCategory == '개인'}">
										<th class="table_cell"><a href="${pageContext.request.contextPath}/group/schedule/deletePersonalSchedule?scheduleNo=${c.scheduleNo}" onClick="return confirm('삭제하시겠습니까?')">개인일정삭제</a></th>
									</c:if>
									<c:if test="${c.scheduleCategory == '부서'}">
										<th class="table_cell"><a href="${pageContext.request.contextPath}/group/schedule/deleteDepartmentSchedule?scheduleNo=${c.scheduleNo}" onClick="return confirm('삭제하시겠습니까?')">부서일정삭제</a></th>
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