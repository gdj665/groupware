<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var="h" items="${reservationHistoryList}">
	<span>${h.meetingroomReserveNo}</span>
	<span>${h.meetingroomNo}</span>
	<span>${h.meetingroomReserveDate}</span>
	<span>${h.meetingroomReserveTime}</span>
	<span>${h.meetingroomReserveStatus}</span><br>
</c:forEach>

</body>
</html>