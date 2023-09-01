<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
    /* 모달 컨테이너 스타일 */
	.modal, .statusModal {
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
        margin: 5% auto;
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
        font-size: 14px;
        font-weight: bold;
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<script>
	$(document).ready(function(){
		
// -----------------------------------엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/equipment/equipmentExcel', // 서버의 '/excel' URL로 요청을 보냄
	            type: 'get', // GET 요청 방식
	            dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
	            success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
	            	let arr = [];
	         	    console.log(data);
	                // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
	                data.forEach(function(item) {
	                	 // 장비 정보를 하나의 배열로 묶어서 arr 배열에 추가
	                	arr.push([item.equipmentNo, item.equipmentName, item.equipmentLastInspect, item.nextinspect, item.equipmentStatus, item.equipmentContent]);
	                });

	             	// 엑셀 파일 생성
	             	let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
	             	book.SheetNames.push('장비'); // 시트 이름 '장비' 추가

	             	// 데이터가 들어있는 2차원 배열로부터 시트 생성
	            	let sheet = XLSX.utils.aoa_to_sheet([['장비번호', '장비명', '마지막 점검일', '점검예정일', '점검상태', '상세내용']].concat(arr));
	             	// 위에서 만든 시트를 엑셀 파일에 추가
	             	book.Sheets['장비'] = sheet;

	             	// 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
	             	let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });

	            	 // 엑셀 파일을 Blob 형태로 변환하여 다운로드
	             	let blob = new Blob([buf], { type: 'application/octet-stream' });
	             	// 다운로드할 파일의 이름을 설정하여 다운로드
	             	saveAs(blob, '장비목록.xlsx');
	        	}
	    	});
		});
		
// --------------------------------------장비 추가 모달창-----------------------------------------	
		// 장비추가 모달창 오픈
		$('#open').click(function(){
			$('.modal').fadeIn();
		});
		
		// 장비 추가 버튼
		$('#addEquipmentBtn').click(function(){
			// 입력값 유효성 검사
			
			if($('#equipmeNameId').val().length == 0) {
				$('#equipmeNameIdMsg').text('장비명을 작성해주세요');
				return;
			} else {
				$('#equipmeNameIdMsg').text('');
			}
			
			if($('#equipmentInspectCycleId').val().length == 0 || isNaN($('#equipmentInspectCycleId').val()) == true) {
				$('#equipmentInspectCycleIdMsg').text('점검주기를 설정 입력해주세요');
				return;
			} else {
				$('#equipmentInspectCycleIdMsg').text('');
			}
			
			if($('#equipmentContentId').val().length == 0) {
				$('#equipmentContentIdMsg').text('설명을 작성해주세요');
				return;
			} else {
				$('#equipmentContentIdMsg').text('');
			}
			
			if(!confirm($('#equipmeNameId').val()+'장비를 추가하시겠습니까?')) {
				return false;
			}
			
			$('#addEquipmentForm').submit();
			$('.modal').fadeOut();
		});
		
		// 오류 메시지를 초기화하고 입력란에 포커스를 줄 때 사용되는 함수
		function clearErrorMessage(inputElement, errorMessageElement) {
			// 입력란의 클래스에서 'error' 클래스를 제거하여 스타일을 초기화한다
		    inputElement.removeClass('error');
		    // 오류 메시지 요소의 내용을 빈 문자열로 설정하여 메시지를 지웁니다
		    errorMessageElement.text('');
		}
		// 해당 부분이 focus될시
		$('#equipmeNameId').focus(function() {
			// clearErrorMessage 함수를 호출하여 해당 입력란과 관련된 오류 메시지를 지웁니다
		    clearErrorMessage($(this), $('#equipmeNameIdMsg'));
		});

		$('#equipmentInspectCycleId').focus(function() {
		    clearErrorMessage($(this), $('#equipmentInspectCycleIdMsg'));
		});

		$('#equipmentContentId').focus(function() {
		    clearErrorMessage($(this), $('#equipmentContentIdMsg'));
		});
			
// -------------------------------------장비대여 모달창 시작--------------------------------------------------
		// 현재 날짜 구하기 
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		
		var preDate = year + '-' + month  + '-' + day;
		
		// 장비 대여 모달창 
	    $(".statusOpenModal").click(function() {
	        var equipmentNo = $(this).data("equipmentno");
	        var equipmentName = $(this).data("equipmentname");
	        var loginId = $(this).data("loginid");
	        $("#equipmentNoInput").val(equipmentNo); // 모달 내의 input 요소에 장비번호 설정
	        $("#equipmentNameInput").val(equipmentName); // 모달 내의 input 요소에 장비이름 설정(보여주기식)
	        $("#loginIdInput").val(loginId); // 대여자 Id값(세션에서 받아옴)
	        $('#equipmentBegindateId').val(preDate); // 대여시작일은 현재 날짜	        
	        $('.statusModal').fadeIn();
	    });
		
		// 장비 대여 추가 버튼
		$('#addEqHistroyBtn').click(function(){
			
			if($('#equipmentReasonId').val().length == 0) {
				$('#equipmentReasonIdMsg').text('대여사유를 작성해주세요');
				return;
			} else {
				$('#equipmentReasonIdMsg').text('');
			}
			
			// alert창 확인
			if(!confirm($('#equipmentReasonId').val()+ '장비를 대여하시겠습니까?')) {
				return false;
			}
			
			$('#addEqHistoryForm').submit();
			$('.statusModal').fadeOut();
		});
	 	
		// 오류 메시지를 초기화하고 입력란에 포커스를 줄 때 사용되는 함수
		function clearErrorMessage(inputElement, errorMessageElement) {
			// 입력란의 클래스에서 'error' 클래스를 제거하여 스타일을 초기화한다
		    inputElement.removeClass('error');
		    // 오류 메시지 요소의 내용을 빈 문자열로 설정하여 메시지를 지웁니다
		    errorMessageElement.text('');
		}
		// 해당 부분이 focus될시
		$('#equipmentReasonId').focus(function() {
			// clearErrorMessage 함수를 호출하여 해당 입력란과 관련된 오류 메시지를 지웁니다
		    clearErrorMessage($(this), $('#equipmentReasonIdMsg'));
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
	<jsp:include page="${pageContext.request.contextPath}/menu/menu.jsp"></jsp:include>
	

	<h1>장비 목록</h1>
	<!-- 장비추가는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
	<c:if test="${memberLevel > 1}">
		<button id="open">장비 추가</button>
	</c:if>
	<table border=1>
		<tr>
			<th>장비번호</th>
			<th>장비명</th>
			<th>마지막 점검일</th>
			<th>점검예정일</th>
			<th>점검</th>
			<th>대여</th>
			<!-- 비활성화는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
			<c:if test="${memberLevel > 1}">
				<th>비활성화</th>
			</c:if>
		</tr>
		<c:forEach var="e" items="${equipmentList}">
			<tr>
				<td><a href="${pageContext.request.contextPath}/equipment/equipmentOne?equipmentNo=${e.equipmentNo}">${e.equipmentNo}</a></td>
				<td><a href="${pageContext.request.contextPath}/equipment/equipmentOne?equipmentNo=${e.equipmentNo}">${e.equipmentName}</a></td>
				<td>${e.equipmentLastInspect}</td>
				<td>
					<!-- dateColor이라는 변수를 선언후 daysUntilNextInspect가 <0보다 작으면 점검예정일이 지났으므로 red를 넣고 <= 30 30일이내면 pink 나머지는 black으로 한다 -->
					<c:set var="dateColor" value="${e.daysUntilNextInspect < 0 ? 'red' : e.daysUntilNextInspect <= 30 ? 'orange' : 'black'}" />
                	<span style="color: ${dateColor};">${e.nextinspect}</span>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/equipment/updateEqInspect?equipmentNo=${e.equipmentNo}" onClick="return confirm('${e.equipmentName} 점검하시겠습니까?')">점검하기</a>
				</td>
				<!-- 대여중인 상품은 대여 불가 대여중아닌 상품만 대여 가능 -->
				<c:if test="${e.equipmentStatus eq '대여'}">
					<td>${e.equipmentStatus}중</td>
				</c:if>
				<c:if test="${e.equipmentStatus ne '대여'}">
					<td>
						<a href="#" class="statusOpenModal" data-equipmentNo="${e.equipmentNo}" data-equipmentName="${e.equipmentName}" 
						data-loginId="${memberId}">${e.equipmentStatus}</a>
					</td>
				</c:if>
				<!-- 비활성화는 팀장급부터만 가능하게 세션에 level값으로 조건 -->
				<c:if test="${e.equipmentStatus eq '비대여' && memberLevel > 1}">
					<td><a href="${pageContext.request.contextPath}/equipment/updateEquipment?equipmentNo=${e.equipmentNo}"
						onClick="return confirm('${e.equipmentName} 비활성 하시겠습니까?')">비활성</a>
					</td>
				</c:if>
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
	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/equipment/equipmentList?currentPage=${currentPage-1}&equipmentName=${param.equipmentName}">이전</a>
	</c:if>
	
	<c:forEach var="i" begin="${minPage}" end="${maxPage}" step="1">
		<c:if test="${i ==  currentPage}">
			<span style="color: red;">${i}</span>
		</c:if>
		<c:if test="${i !=  currentPage}">
			<span>${i}</span>
		</c:if>
	</c:forEach>
	
	<c:if test="${currentPage < lastPage}">
		<a href="${pageContext.request.contextPath}/equipment/equipmentList?currentPage=${currentPage+1}&equipmentName=${param.equipmentName}">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>
	
	<!-- 장비추가 모달 -->
	<div class="modal">
		<div class="modal_content">
			<h3>장비 추가</h3>
			<form id="addEquipmentForm" action="${pageContext.request.contextPath}/equipment/addEquipment" method="post">
				<input type="hidden" name="equipmentStatus" value="비대여" readonly="readonly">
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
							<input type="number" name="equipmentInspectCycle" id="equipmentInspectCycleId">개월
							<span id="equipmentInspectCycleIdMsg" class="msg"></span>
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
							<input id="equipmentBegindateId" type="date" name="equipmentBegindate" readonly="readonly">
							<span id="equipmentBegindateIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>대여 사유</td>
						<td>	
							<textarea id="equipmentReasonId" rows="5" cols="50" name="equipmentReason"></textarea>
							<span id="equipmentReasonIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="addEqHistroyBtn" type="button">대여</button>
			<button class="close" type="button">닫기</button>
		</div>
	</div>
</body>
</html>