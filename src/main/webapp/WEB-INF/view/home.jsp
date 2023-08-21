<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>home</h1>
	<h5>${memberId}</h5>
	<a href="${pageContext.request.contextPath}/schedule/scheduleList">일정</a><br>
	<a href="${pageContext.request.contextPath}/board/boardList">게시판</a><br>
	<a href="${pageContext.request.contextPath}/approval/approvalList">결재</a><br>
	<a href="${pageContext.request.contextPath}/equipment/equipmentList"> 장비 목록</a><br>
	<a href="${pageContext.request.contextPath}/fixtures/fixtruesList"> 자재 목록</a><br>
	<a href="${pageContext.request.contextPath}/eqHistory/eqHistoryList"> 장비 사용내역 목록</a><br>
	<a href="${pageContext.request.contextPath}/repair/addRepair"> AS추가</a><br>
	<a href="${pageContext.request.contextPath}/department/departmentList">부서관리</a><br>
	<a href="${pageContext.request.contextPath}/hrm/hrmList">인사관리</a><br>
	<a href="${pageContext.request.contextPath}/address/addressList">주소록</a><br>
	<a href="${pageContext.request.contextPath}/member/mypage?memberId=${memberId}">마이페이지</a><br>
	<a href="${pageContext.request.contextPath}/logout">로그아웃</a><br>
</body>
</html>