<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, tr, td , th{border: 1px solid; border-color: black;}
</style>
</head>
<body>
	<!-- model값 받아와서 문자로 셋팅 -->
	<c:set var="m" value="${oneScheduleMap}"></c:set>
	<a href="/schedule/scheduleList">뒤로가기</a>
	
	<h1>${m.memberId}님의 ${m.targetYear}년 ${m.targetMonth+1}월 ${m.targetDate}일 일정</h1>

	<a href="${pageContext.request.contextPath}/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}">전체</a>
	<a style="color:orange" href="${pageContext.request.contextPath}/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}&scheduleCategory=부서">부서</a>
	<a style="color:green" href="${pageContext.request.contextPath}/schedule/oneSchedule?targetYear=${m.targetYear}&targetMonth=${m.targetMonth}&targetDate=${m.targetDate}&scheduleCategory=개인">개인</a>
	<span>${memberLevel}</span>
	<br><br><br>
	<table>
		<tr>
			<th>카테고리</th>
			<th>제목</th>
			<th>내용</th>
			<th>시작일</th>
			<th>종료일</th>
			<th colspan="2">삭제</th>
		</tr>
		<c:forEach var="c" items="${m.oneScheduleList}">
		<tr>
			<td>${c.scheduleCategory}</td>
			<td>${c.scheduleTitle}</td>
			<td>${c.scheduleContent}</td>
			<td>${c.scheduleBegindate}</td>
			<td>${c.scheduleEnddate}</td>
			<c:if test="${c.scheduleCategory == '개인'}">
				<td><a href="${pageContext.request.contextPath}/schedule/deleteSchedule?scheduleNo=${c.scheduleNo}">개인일정삭제</a></td>
			</c:if>
			<c:if test="${c.scheduleCategory == '부서'}">
				<td><a href="${pageContext.request.contextPath}/schedule/deleteDepartmentSchedule?scheduleNo=${c.scheduleNo}">부서일정삭제</a></td>
			</c:if>
			
		</tr>
		</c:forEach>
	</table>
</body>
</html>