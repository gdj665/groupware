<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.0/dist/jquery.min.js"></script>
	<script>
//		비밀번호 정규식 -> 8자리 이상 하나 이상 문자, 하나 이상 특수문자, 하나 이상 숫자	
		const reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
		$(document).ready(function(){
			$("#submitBtn").click(function(){
				let newPw = $("#memberPw").val();
				let checkPw = $("#checkMemberPw").val();
				if(reg.test(newPw) === false){
					alert("비밀번호 규정에 맞지 않습니다.")
				} else if(newPw != checkPw){
					alert("비밀번호가 다릅니다.")
				} else {
					$("#pwForm").submit();
				}
			})
			$("#checkMemberPw").keyup(function(event){
				 if(event.which === 13){
				 $("#submitBtn").click();
				 }
			})
		})
	</script>
</head>
<body>
	${memberId}님 비번 변경<br>
	<form action="/group/member/updatePw" method="post" id="pwForm">
		<input type="hidden" value="${memberId}" name="memberId">
		<h5>최소 8 자, 하나 이상의 문자, 하나의 숫자 및 하나의 특수 문자</h5>
		새 비번 입력 : <input type="password" id="memberPw" name="memberPw"><br>
		새 비번 확인 : <input type="password" id="checkMemberPw"><br>
		<button type="button" id="submitBtn">변경</button>
	</form>
</body>
</html>