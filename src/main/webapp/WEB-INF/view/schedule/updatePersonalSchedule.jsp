<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	 tr, td , th{border: 1px solid; border-color: black;
		width:100px; height: 50px;
						}
</style>
</head>
<body>
	<h1>개인 일정 수정</h1>
	<form method="post" action="${pageContext.request.contextPath}/schedule/updatePersonalSchedule">
		<input type="hidden" name="scheduleNo" value="${scheduleNo}">
		<input type="hidden" name="memberId" value="${memberId}">
		<table>
			<tr>
				<th>schedule_title</th>
				<td><input type="text" name="scheduleTitle"></td>	
			</tr>
			<tr>
				<th>schedule_content</th>
				<td><input type="text" name="scheduleContent"></td>	
			</tr>
			<tr>	
				<th>schedule_begindate</th>
				<td><input type="date" name="scheduleBegindate"></td>	
			</tr>	
			<tr>
				<th>schedule_enddate</th>
				<td><input type="date" name="scheduleEnddate"></td>	
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>