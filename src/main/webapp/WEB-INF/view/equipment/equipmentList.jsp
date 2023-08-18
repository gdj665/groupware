<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
    /* 모달 컨테이너 스타일 */
	.modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }
	
    .statusModal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }

    /* 모달 내용 스타일 */
    .modal_content {
        background-color: white;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        border-radius: 5px;
    }

    /* 제목 스타일 */
    .modal_content h3 {
        margin-top: 0;
    }

    /* 폼 스타일 */
    .modal_content form {
        margin-top: 20px;
    }

    /* 테이블 스타일 */
    .modal_content table {
        width: 100%;
        border-collapse: collapse;
    }

    /* 테이블 셀 스타일 */
    .modal_content td {
        padding: 8px;
        border-bottom: 1px solid #ddd;
    }

    /* 입력 필드 스타일 */
    .modal_content input[type="text"],
    .modal_content input[type="date"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 3px;
    }

    /* 메시지 스타일 */
    .modal_content .msg {
        color: red;
        font-size: 12px;
    }

    /* 버튼 스타일 */
    .modal_content button {
        margin-top: 10px;
        padding: 8px 15px;
        border: none;
        background-color: #007bff;
        color: white;
        cursor: pointer;
        border-radius: 3px;
    }

    .modal_content button.close {
        background-color: #ccc;
    }

    .modal_content button:hover {
        background-color: #0056b3;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
<script>
	$(document).ready(function(){
		
		// 장비추가 모달창 오픈
		$('#open').click(function(){
			$('.modal').fadeIn();
		});
		
		// 장비 추가 버튼
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
		
		// 장비 대여 모달창 
	    $(".statusOpenModal").click(function() {
	        var equipmentNo = $(this).data("equipmentno");
	        var equipmentName = $(this).data("equipmentname");
	        var loginId = $(this).data("loginid");
	        $("#equipmentNoInput").val(equipmentNo); // 모달 내의 input 요소에 장비번호 설정
	        $("#equipmentNameInput").val(equipmentName); // 모달 내의 input 요소에 장비이름 설정(보여주기식)
	        $("#loginIdInput").val(loginId); // 대여자 Id값(세션에서 받아옴)
	        
	        $('.statusModal').fadeIn();
	    });
		
	 	// 장비 대여 추가 버튼
		$('#addEqHistroyBtn').click(function(){
			if($('#equipmentBegindateId').val().length == 0) {
				$('#equipmentBegindateIdMsg').text('대여시작일을 입력해주세요');
				return;
			} else {
				$('#equipmentBegindateIdMsg').text('');
			}
			
			if($('#equipmentEnddateId').val().length == 0) {
				$('#equipmentEnddateIdMsg').text('반납일을 입력해주세요');
				return;
			} else {
				$('#equipmentEnddateIdMsg').text('');
			}
			
			$('#addEqHistoryForm').submit();
			$('.statusModal').fadeOut();
		});
		
			
			
		// 모달창 닫기
	    $('.close').click(function(){
			$('.modal').fadeOut();
			$('.statusModal').fadeOut();
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
			<th>점검</th>
			<th>대여</th>
			<th>장비 삭제</th>
		</tr>
		<c:forEach var="e" items="${equipmentList}">
			<tr>
				<td><a href="${pageContext.request.contextPath}/equipment/equipmentOne?equipmentNo=${e.equipmentNo}">${e.equipmentNo}</a></td>
				<td>${e.equipmentName}</td>
				<td>${e.equipmentLastInspect}</td>
				<td>
					<!-- dateColor이라는 변수를 선언후 daysUntilNextInspect가 <0보다 작으면 점검예정일이 지났으므로 red를 넣고 <= 30 30일이내면 pink 나머지는 black으로 한다 -->
					<c:set var="dateColor" value="${e.daysUntilNextInspect < 0 ? 'red' : e.daysUntilNextInspect <= 30 ? 'pink' : 'black'}" />
                	<span style="color: ${dateColor};">${e.nextinspect}</span>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/equipment/updateEqInspect?equipmentNo=${e.equipmentNo}" onClick="return confirm('${e.equipmentName} 점검하시겠습니까?')">점검하기</a>
				</td>
				<td><a href="#" class="statusOpenModal" data-equipmentNo="${e.equipmentNo}" data-equipmentName="${e.equipmentName}" data-loginId="${loginId}">${e.equipmentStatus}</a></td>
				<td><a href="/equipment/deleteEquipment?equipmentNo=${e.equipmentNo}"
					onClick="return confirm('${e.equipmentName} 삭제하시겠습니까?')">삭제</a></td>
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
	
	<!-- 장비추가 모달 -->
	<div class="modal">
		<div class="modal_content">
			<h3>장비 추가</h3>
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
			<button class="close" type="button">닫기</button>
		</div>
	</div>
	
	<!-- 장비 대여 모달 -->
	<div class="statusModal">
		<div class="modal_content">
			<h3>장비 대여</h3>
			<form id="addEqHistoryForm" action="${pageContext.request.contextPath}/eqHistory/addEqHistory" method="post">
				<input type="hidden" name="equipmentNo" id="equipmentNoInput" value="equipmentNoInput">
				<input type="hidden" name="equipmentStatus" value="대여">
				<table>
					<tr>
						<td>장비명</td>
						<td>
							<input type="text" id="equipmentNameInput" value="equipmentNameInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>대여자ID</td>
						<td>
							<input type="text" name="memberId" id="loginIdInput" value="loginIdInput" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>대여시작일</td>
						<td>
							<input id="equipmentBegindateId" type="date" name="equipmentBegindate">
							<span id="equipmentBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>반납일</td>
						<td>
							<input id="equipmentEnddateId" type="date" name="equipmentEnddate">
							<span id="equipmentEnddateIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addEqHistroyBtn" type="button">추가</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
</body>
</html>