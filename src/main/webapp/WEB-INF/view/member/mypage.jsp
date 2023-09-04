<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="m" value="${member}"></c:set>
	<h1>mypage</h1>
	${m.memberId}<br>
	${m.departmentNo}<br>
	${m.memberName}<br>
	${m.memberGender}<br>
	${m.memberPhone}<br>
	${m.memberEmail}<br>
	${m.memberAddress}<br>
	<img src="/signFile/${m.memberSignFile}"><br>
	<a href="/group/member/updateSign?memberId=${m.memberId}">사인 수정</a><br>
	<a href="/group/member/updateMypage?memberId=${m.memberId}">수정페이지</a><br>
</body>
</html>