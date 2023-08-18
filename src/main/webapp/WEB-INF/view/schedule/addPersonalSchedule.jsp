<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<h1>개인 일정 등록</h1>
	<form method="post" action="/schedule/addPersonalSchedule">
		<input type="hidden" name="memberId" value="${memberId}">
		<input type="hidden" name="scheduleCategory" value="개인">
		<table>
			<tr>
				<th>일정 제목</th>
				<td>
					<input type="text" name="scheduleTitle">
				</td>
			</tr>
			<tr>
				<th>일정 상세 내용</th>
				<td>
					<input type="text" name="scheduleContent">
				</td>
			</tr>
			<tr>
				<th>일정 시작일</th>
				<td>
					<input type="date" name="scheduleBegindate">
				</td>
			</tr>
			<tr>
				<th>일정 종료일</th>
				<td>
					<input type="date" name=scheduleEnddate>
				</td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>