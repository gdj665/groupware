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
	<a href="/member/mypage?memberId=${memberId}">마이페이지</a>
	<a href="/logout">로그아웃</a>
</body>
</html>