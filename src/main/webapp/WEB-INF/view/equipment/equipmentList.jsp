<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.modal {
	    position: fixed;
	    top: 30%;
	    left: 40%;
	    background: gray;
	    padding: 20px;
	    display: none;
	    z-index: 1050;
	}	
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
<script>
	$(document).ready(function(){
		
		// 모달창 이벤트 -------------------------------------
		$('#open').click(function(){
			$('.modal').fadeIn();
		});
		
		$('#addEquipmentBtn').click(function(){
			// 입력값 유효성 검사
			
			if($('#equipmeNameId').val().length == 0) {
				$('#equipmeNameIdMsg').text('장비명을 입력해주세요');
				return;
			} else {
				$('#equipmeNameIdMsg').text('');
			}
			
			if($('#equipmentInspectCycleId').val().length == 0 || isNaN($('#equipmentInspectCycleId').val()) == true) {
				$('#equipmentInspectCycleIdMsg').text('점검주기를 숫자로 입력해주세요');
				return;
			} else {
				$('#equipmentInspectCycleIdMsg').text('');
			}
			
			if($('#equipmentContentId').val().length == 0) {
				$('#equipmentContentIdMsg').text('설명을 입력해주세요');
				return;
			} else {
				$('#equipmentContentIdMsg').text('');
			}
			
			$('#addEquipmentForm').submit();
			$('.modal').fadeOut();
		});
		
		$('#close').click(function(){
			$('.modal').fadeOut();
		});
		
	});
</script>
</head>
<body>
	<h1>장비 목록</h1>
	<button id="open">장비 추가</button>
	<table border=1>
		<tr>
			<th>장비번호</th>
			<th>장비명</th>
			<th>마지막 점검일</th>
			<th>점검예정일</th>
			<th>점검갱신</th>
			<th>대여</th>
			<th>장비 삭제</th>
		</tr>
		<c:forEach var="e" items="${equipmentList}">
			<tr>
				<td>${e.equipmentNo}</td>
				<td>${e.equipmentName}</td>
				<td>${e.equipmentLastInspect}</td>
				<td>
					<c:set var="dueDate" value="${e.daysUntilNextInspect < 0 ? 'red' : e.daysUntilNextInspect <= 30 ? 'pink' : 'black'}" />
                	<span style="color: ${dueDate};">${e.nextinspect}</span>
				</td>
				<td>
					<a href="/equipment/updateStatus?equipmentNo=${e.equipmentNo}">점검갱신</a>
				</td>
				<td>${e.equipmentStatus}</td>
				<td><a href="/equipment/deleteEquipment?equipmentNo=${e.equipmentNo}"
					onClick="return confirm('삭제하시겠습니까?')">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
	<div>
		<form
			action="${pageContext.request.contextPath}/equipment/equipmentList"
			method="get">
			<input type="text" name="equipmentName">
			<button type="submit">검색</button>
		</form>
	</div>
	
	<div class="modal">
		<div class="modal_content">
			<h3>자재 추가</h3>
			<form id="addEquipmentForm" action="${pageContext.request.contextPath}/equipment/addEquipment" method="post">
				<table>
					<tr>
						<td>장비명</td>
						<td>
							<input type="text" name="equipmentName" id="equipmeNameId">
							<span id="equipmeNameIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>점검주기</td>
						<td>
							<input type="text" name="equipmentInspectCycle" id="equipmentInspectCycleId">개월
							<span id="equipmentInspectCycleIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>대여유무</td>
						<td>
							<input type="text" name="equipmentStatus" value="비대여" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>설명</td>
						<td>
							<textarea id="equipmentContentId" rows="5" cols="30" name="equipmentContent"></textarea>
							<span id="equipmentContentIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addEquipmentBtn" type="button">추가</button>
			<button id="close" type="button">닫기</button>
		</div>
	</div>
</body>
</html>