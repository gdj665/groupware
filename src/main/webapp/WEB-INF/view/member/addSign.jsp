<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
</head>
<body>
	<h1>사인 등록</h1>
	<canvas id="goal" style="border: 1px solid black"></canvas>
	<div>
		<button id="clear">초기화</button>
		<button id="send">저장</button>
	</div>
</body>
	<script>
		// canvas 데이터 가지고 오기
		let goal = $('#goal')[0];
		// canvas 데이터 크기지정 및 색 지정
		let sign = new SignaturePad(goal, {minWidth: 2, maxWidth: 2, penColor: 'rgb(0,0,0)'});
		// canvas 초기화
		$('#clear').click(function () {
			sign.clear();
		});
		// canvas 내용물 있을때 ajax로 데이터 json 형태로 전송 성공 시 home페이지로 이동
		$('#send').click(function () {
			if (sign.isEmpty()) {
				alert("내용이 없습니다.");
			} else {
				$.ajax({
					url : '/member/addSign', 
					data : {sign : sign.toDataURL('image/png', 1.0)},
					type : 'post',
					success : function(jsonData) {
						alert('사인이 성공적으로 저장 되었습니다')
						location.href="/home";
					},
					error : function(jsonData){
						alert('사인 저장에 실패했습니다.')
					}
				});
			}
		});
</script>
</html>