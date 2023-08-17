<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 입력</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<h1>게시글 입력</h1>
	<form action="/board/addBoard" method="post" enctype="multipart/form-data">
		<table class="table">
			<tr>
				<th>상단 고정 여부</th>
				<td>
					<input type="radio" name="boardStatus" value="N" checked="checked">상단 고정 안함
					<input type="radio" name="boardStatus" value="Y">상단 고정
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="boardTitle"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="boardContent" rows="3" cols="50"></textarea>
				</td>
			</tr>
<!-- 			<tr>
				<th>작성자</th>
				<td>
					<input type="hidden" name="memberId" value="23081601">
					<input type="hidden" name="departmentNo" value="999">
				</td>
			</tr> -->
			<tr>
				<td>
					<input type="file" name="multipartFile" multiple="multiple">
					<!-- 해당 name은 vo.Board에 선언된 이름을 사용 -->
				</td>
			</tr>
		</table>
		<button type="submit">게시물 추가</button>
	</form>
</body>
</html>