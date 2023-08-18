<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>장비 상세보기</h2>
	<table>
		<tr>
			<td>장비번호</td>
			<td>${equipmentOneMap.equipmentNo}</td>
		</tr>
		<tr>
			<td>장비명</td>
			<td>${equipmentOneMap.equipmentName}</td>
		</tr>
		<tr>
			<td>마지막 점검일</td>
			<td>${equipmentOneMap.equipmentLastInspect}</td>
		</tr>
		<tr>
			<td>점검주기</td>
			<td>${equipmentOneMap.nextinspect}개월</td>
		</tr>
		<tr>
			<td>설명</td>
			<td>${equipmentOneMap.equipmentContet}</td>
		</tr>
	</table>
</body>
</html>