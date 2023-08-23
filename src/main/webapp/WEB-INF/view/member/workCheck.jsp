<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>근태 체크</h1>
	<c:set var="m" value="${workMap}"></c:set>
	<c:forEach var="wcl" items="${m.workCheckList}">
		${wcl.memberId}, ${wcl.workDate}, ${wcl.workBegin}, ${wcl.workBegin}<br>
	</c:forEach>
</body>
</html>