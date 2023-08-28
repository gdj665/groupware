<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<script>
	$(document).ready(function(){
		
		// 엑셀다운 ---------------------------------------
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
				<td><a href="${pageContext.request.contextPath}/equipment/equipmentOne?equipmentNo=${e.equipmentNo}">${e.equipmentName}</a></td>
				<td>${e.equipmentLastInspect}</td>
				<td>
					<!-- dateColor이라는 변수를 선언후 daysUntilNextInspect가 <0보다 작으면 점검예정일이 지났으므로 red를 넣고 <= 30 30일이내면 pink 나머지는 black으로 한다 -->
					<c:set var="dateColor" value="${e.daysUntilNextInspect < 0 ? 'red' : e.daysUntilNextInspect <= 30 ? 'blue' : 'black'}" />
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
						<a href="${pageContext.request.contextPath}/eqHistory/addEqHistory?equipmentNo=${e.equipmentNo}&equipmentStatus=대여&memberId=${loginId}" onClick="return confirm('${e.equipmentName} 대여하시겠습니까?')">${e.equipmentStatus}</a>
					</td>
				</c:if>
				<td><a href="${pageContext.request.contextPath}/equipment/updateEquipment?equipmentNo=${e.equipmentNo}"
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
	<c:if test="${currentPage > 1}">
		<a
			href="${pageContext.request.contextPath}/equipment/equipmentList?currentPage=${currentPage-1}&equipmentName=${param.equipmentName}">이전</a>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<a
			href="${pageContext.request.contextPath}/equipment/equipmentList?currentPage=${currentPage+1}&equipmentName=${param.equipmentName}">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
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
							<input type="number" name="equipmentInspectCycle" id="equipmentInspectCycleId">개월
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
</body>
</html>