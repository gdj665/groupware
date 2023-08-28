<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주소록</h1>
	<table>
		<tr>
			<td>이름</td>
			<td>부서</td>
			<td>직위</td>
			<td>휴대폰</td>
			<td>이메일</td>
		</tr>
		<c:forEach var="e" items="${getAddressList}">
		<tr>
			<td>${e.memberName}</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>