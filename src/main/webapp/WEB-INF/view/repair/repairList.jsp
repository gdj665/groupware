<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
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
        margin: 0% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
        border-radius: 5px;
        overflow-y: auto;
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
   		font-weight: bold;
        color: red;
        font-size: 14px;
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
    
    .parts-list {
	    max-height: 300px; /* 적절한 값으로 조정 */
	    overflow-y: auto;
	    border-radius: 5px;
	    padding: 10px;
	}
    
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script>
	$(document).ready(function(){
		
// --------------------------------------- 엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/repair/repairExcel?repairStatus=수리중', // 서버의 restController인 '/repair/repairExcel' URL로 요청을 보냄
	            type: 'get', // GET 요청 방식
	            dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
	            success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
	            	let arr = [];
	         	    console.log(data);
	                // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
	                data.forEach(function(item) {
	                	 // 장비 정보를 하나의 배열로 묶어서 arr 배열에 추가
	                	arr.push([item.repairNo, item.memberId, item.repairProductCategory, item.repairProductName, item.receivingDate, item.repairDate, item.repairStatus, item.repairReceivingReason]);
	                });

	             	// 엑셀 파일 생성
	             	let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
	             	book.SheetNames.push('AS(수리중)'); // 시트 이름 추가

	             	// 데이터가 들어있는 2차원 배열로부터 시트 생성
	            	let sheet = XLSX.utils.aoa_to_sheet([['수리번호', '수리담당자', '제품분류', '제품명', '입고날짜', '수리날짜', '수리상태', '입고사유']].concat(arr));
	             	// 위에서 만든 시트를 엑셀 파일에 추가
	             	book.Sheets['AS(수리중)'] = sheet;

	             	// 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
	             	let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });
					
	            	 // 엑셀 파일을 Blob 형태로 변환하여 다운로드
	             	let blob = new Blob([buf], { type: 'application/octet-stream' });
	             	// 다운로드할 파일의 이름을 설정하여 다운로드
	             	saveAs(blob, 'AS(수리중)목록.xlsx');
	        	}
	    	});
		});
		
// ---------------------------------------------------------------- 수리중 -> 수리완료 수정 시작 ----------------------------------------------------------
		// 현재 날짜 구하기 
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		
		var preDate = year + '-' + month  + '-' + day;
		
		// 수리중 -> 수리완료 모달창 오픈
		$('.comRepairModalOpen').click(function(){
			var comRepairNo = $(this).data("comrepairno");
	        var comRepairProductName = $(this).data("comrepairproductname");
	        var comMemberId = $(this).data("commemberid");
	        var comRepairReceivingReason = $(this).data("comrepairreceivingreason");
	        $("#comRepairNoInput").val(comRepairNo); // 모달 내의 input 요소에 수리번호 설정
	        $("#comRepairProductNameInput").val(comRepairProductName); // 모달 내의 input 요소에 수리제품이름 설정
	        $("#comMemberIdInput").val(comMemberId); // 대여자 Id값(세션에서 받아옴)
	        $("#repairReceivingReasonId").val(comRepairReceivingReason); // 입고사유
	        $("#comRepairReleaseDate").val(preDate); // 현재날짜
			
			$('#completedRepairModal').fadeIn();
		});
		
// ---------------------------------------------------------------- 수리중 -> 수리완료 수정 끝 ----------------------------------------------------------		
		
		// 자재목록 가져오기
	    $('.comRepairModalOpen').click(function(){
	        $.ajax({
	            url: '/parts/getPartsCntList',
	            type: 'get',
	            data: {},
	            success: function(data) {
	                const selectPartsList = data.partsList;
	            	console.log(selectPartsList);
	                
	             	// 기존 내용 제거
	                $('#availablePartsList').empty();

	                // 자재목록 출력
	                selectPartsList.forEach(function(part) {
	                	const listItem = $('<li><input type="checkbox" class="partsNameCheckbox" data-partsCnt= "'+part.partsCnt+'" data-partsPrice="'+part.partsPrice+'" data-partsNo="'+part.partsNo+'">' + part.partsName + '</li>');
	                    $('#availablePartsList').append(listItem);
	                });
	            }
	        });
	    });
	 	
	 	// 오른쪽 화살표클릭시 자재목록에서 체크된 항목 오른쪽에서 출력
	    $('#rightArrowButton').click(function(){
	    	// 체크된 항목 변수
	    	const checkedPartsName = $('.partsNameCheckbox:checked');
	    	
	    	// 반복문 돌려 하나씩 출력시키기
	    	checkedPartsName.each(function(){
	    		// 체크된 박스에 총 개수 가져오기
	    		const checkPartsCnt = $(this).data('partscnt');
	    		const checkPartsPrice = $(this).data('partsprice');
	    		const checkPartsNo = $(this).data('partsno');
		    	const checkPartsName = $(this).parent().text();
		    	
		    	// 이미 추가되어 있는지 확인 1개이상 있으면 true로 설정
		        const isAlreadyAdded = $('#selectedPartsList').find('.partsNoClass[value="' + checkPartsNo + '"]').length > 0;
		    	
		        // true면 추가 안되고 false면 추가 진행됩니다
		        if (!isAlreadyAdded) {
		            const selectedListItem = $('<span class="selectedPartsCnt"><li><input type="checkbox" class="removeChecked" data-partsCnt="'+checkPartsCnt+'" data-partsName="'+checkPartsName+'">'+checkPartsName+" 재고량 :"+checkPartsCnt+'<br>사용자재 수: <input type="text" class="partsCntClass" name="partsCnt[]" required="required" data-selectedPrice="'+checkPartsPrice+'" style="width:50px;height:30px;"></span><input type="hidden" class="partsNoClass" name="partsNo[]" required="required" value="'+checkPartsNo+'">개</li></span>'); 
		            $('#selectedPartsList').append(selectedListItem);
		        }
	            
    			// 모든 체크박스 비체크로 초기화
    		    $('.partsNameCheckbox:checked').prop('checked', false);
	    	});
	    });
	 	
	 	// 왼쪽 화살표 클릭시 선택한 자재에서 checked된 항목 빼버리기
	    $('#leftArrowButton').click(function(){
	    	// 체크된 자재 변수
	    	const checkedParts = $('.selectedPartsCnt');
	    	
	    	// 선택된 항목을 제거
	        checkedParts.each(function() {
	            if ($(this).find('input[class="removeChecked"]').prop('checked')) {
	            	
	            	// 사용자재 수 입력란에 입력된 값 가져와서 해당값을 뒤에 10을 사용해 10진수로 변경
	            	const inputCnt = parseInt($(this).find('.partsCntClass').val(), 10);
	            	// 입력란에 해당 자재의 가격을 찾아와 Float로 변환
	                const selectedPrice = parseFloat($(this).find('.partsCntClass').data('selectedprice'));
	            	// 가격과 입력된 수량을 곱함
	                const totalPrice = inputCnt * selectedPrice;

	                // 제거된 항목의 가격을 현재 총 가격에서 빼기
	                // 수리비에 현재 val()값을 가져옴
	                const currentTotalPrice = parseFloat($('#totalPriceId').val());
	                // 현재 가격에서 위에서 나온 제거시킨 항목의 값을 뺌
	                const updatedTotalPrice = currentTotalPrice - totalPrice;
	                // 뺀 값으로 출력
	                $('#totalPriceId').val(updatedTotalPrice);
	            	// 선택한 자재 항목에서 삭제
	            	$(this).remove();
	            }
	        });
	    });
	 	
	 	
	 	// 선택한 자재 부분에 사용자재 수를 입력할시 총비용 나오게하기
	    $(document).on('change', '.partsCntClass', function(){
	    	
	    	// 총비용 담을 변수
	    	let totalPrice = 0;
	    	// 반복문을 통해 각 선택된 자재의 총 가격 계산
	    	$('.selectedPartsCnt').each(function() {
	    		// 변경된 항목에 자재 가격 가져옴
				const selectedPrice = $(this).find('.partsCntClass').data('selectedprice');
	    		// 변경된 항목에 변경값 가져옴
				let inputCnt = parseInt($(this).find('.partsCntClass').val());
	    		// 경고창에 알려줄 파츠명
				const partsName = $(this).find('.removeChecked').data('partsname');
	    		// 해당행의 총개수를 가져옴
	    		const totalPartsCnt = parseInt($(this).find('.removeChecked').data('partscnt'));
	    		console.log(totalPartsCnt);
	    		console.log("if문 밖에 실행" + inputCnt);
				
	    		// 입력값이 총 개수보다 클경우 총개수로 값 변경
	    		if(inputCnt > totalPartsCnt) {
	    			alert(partsName + ' 자재의 입력개수가 총 개수보다 많이 입력되어 총 개수로 변경됩니다.');
	    			
	    			// 입력값만 총개수로 변경
	    			parseInt($(this).find('.partsCntClass').val(totalPartsCnt));
	    			// 가격 계산 입력개수변수 총개수로 변경 (안해주면 가격계산 이상해짐)
	    			inputCnt = totalPartsCnt;
	    			
	    			console.log("if 문안에 실행 " + inputCnt);
		 		} 
		 		
	    		// 숫자일때만 계산
    			if (!isNaN(inputCnt)) {
		            totalPrice += inputCnt * selectedPrice;
		        }
	    		
	    	});
	    	// 공임비 20000원 추가
	    	totalPrice += 20000;
	    	// 계산된 총 가격을 화면에 출력
	        $('#totalPriceId').val(totalPrice);
	    	
	    });
	 	
	 	// 수정 버튼 클릭시 폼 전송
	 	$('#updateCompletedRepairBtn').click(function(){
	 		
	 		if($('#totalPriceId').val() <= 20000) {
	 			$('#totalPriceIdMsg').text("사용 자재를 추가해주세요")
	 			return;
	 		} else {
	 			$('#totalPriceIdMsg').text("")
	 		}
	 		
	 		if($('#repairContentId').val().length == 0) {
	 			$('#repairContentIdMsg').text("수리내용을 입력하세요")
	 			return;
	 		} else {
	 			$('#repairContentIdMsg').text("")
	 		}
	 		
	 		// 예 아니오 확인하기
	 		if(!confirm($('#comRepairProductNameInput').val()+'제품의 AS를 완료 처리 하시겠습니까?')) {
	 			return false;
	 		}
	 		
	 	    $('#updateCompletedRepair').submit();
	 	    
	 	});
	 	
	 	// 오류 메시지를 초기화하고 입력란에 포커스를 줄 때 사용되는 함수
		function clearErrorMessage(inputElement, errorMessageElement) {
			// 입력란의 클래스에서 'error' 클래스를 제거하여 스타일을 초기화한다
		    inputElement.removeClass('error');
		    // 오류 메시지 요소의 내용을 빈 문자열로 설정하여 메시지를 지웁니다
		    errorMessageElement.text('');
		}
		// 해당 부분이 focus될시
		$('#repairContentId').focus(function() {
			// clearErrorMessage 함수를 호출하여 해당 입력란과 관련된 오류 메시지를 지웁니다
		    clearErrorMessage($(this), $('#repairContentIdMsg'));
		});
		
	 	// 모달창 닫기
	    $('.close').click(function(){
			$('#completedRepairModal').fadeOut();
		});
		
	});
</script>

</head>
<body>
	<!-- 수리중 리스트 -->
	<h1>AS수리중리스트</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>수리담당자</th>
			<th>제품분류</th>
			<th>제품명</th>
			<th>입고날짜</th>
			<th>수리날짜</th>
			<th>수리상태</th>
			<th>입고사유</th>
			<th>수리</th>
		</tr>
		<c:forEach var="r" items="${repairList}">
			<tr>
				<td>${r.repairNo}</td>
				<td style="font-weight: bold; color: orange;">${r.memberName}</td>
				<td>${r.repairProductCategory}</td>
				<td>${r.repairProductName}</td>
				<td>${r.receivingDate}</td>
				<td>${r.repairDate}</td>
				<td>${r.repairStatus}</td>
				<td>${r.repairReceivingReason}</td>
				<!-- 수리 완료는 수리담당자 본인만 할 수 있게 세션아이디값으로 보이게설정 -->
				<c:if test="${r.memberId eq memberId}">
					<td><a href="#" class="comRepairModalOpen"
						data-comRepairNo="${r.repairNo}" data-comMemberId="${memberId}"
						data-comRepairProductName="${r.repairProductName}"
						data-comRepairReceivingReason="${r.repairReceivingReason}">수리END</a>
					</td>
				</c:if>
				<c:if test="${r.memberId ne memberId}">
					<td></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색및 페이징 -->
	<div>
		<form action="${pageContext.request.contextPath}/repair/repairList"
			method="get">
			<input type="text" name="repairProductCategory"> <input
				type="hidden" name="repairStatus" value="수리중">
			<button type="submit">검색</button>
		</form>
	</div>
	<c:if test="${currentPage > 1}">
		<a
			href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">이전</a>
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
		<a
			href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>	
	
	<!-- 수리중 -> 수리완료 업데이트 모달 -->
	<div id="completedRepairModal" class="modal">
		<div class="modal_content">
			<form id="updateCompletedRepair"
				action="${pageContext.request.contextPath}/repair/updateRepair"
				method="post">
				<div class="row">
					<div class="col-lg-12">
						<h3>수리완료</h3>
						<input type="hidden" name="repairNo" id="comRepairNoInput"
							value="comRepairNoInput" required="required">
						<table class="modalTable">
							<tr>
								<td>제품명</td>
								<td><input type="text" id="comRepairProductNameInput"
									value="comRepairProductNameInput" readonly="readonly"></td>
							</tr>
							<tr>
								<td>수리담당자</td>
								<td><input type="text" id="comMemberIdInput"
									value="comMemberIdInput" readonly="readonly"></td>
							</tr>
							<tr>
								<td>수리완료일</td>
								<td><input type="text" id="comRepairReleaseDate"
									value="comRepairReleaseDate" readonly="readonly"></td>
							</tr>
							<tr>
								<td>수리비</td>
								<td><input id="totalPriceId" type="number" name="repairPrice" value="20000" required="required" readonly="readonly">원 
								<span id="totalPriceIdMsg" class="msg"></span>
							</tr>
							<tr>
								<td>수리현황</td>
								<td><input type="text" name="repairStatus" value="수리완료"
									readonly="readonly"> 수리중 -> 수리완료</td>
							</tr>
							<tr>
								<td>입고사유</td>
								<td><textarea id="repairReceivingReasonId"
										value="repairReceivingReasonId" rows="5" cols="50"
										readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td>수리내용</td>
								<td><textarea id="repairContentId" rows="5" cols="50"
										name="repairContent" required="required"></textarea>
								<span id="repairContentIdMsg" class="msg"></span>		
							</tr>
						</table>
					</div>
				</div>
				<!--  row 2 -->
				<div class="row">
					<div class="col-lg-5">
						<!-- 조회 클릭시 자재목록 출력 -->
						<div class="parts-list">
						<h4>자재 목록</h4>
							<table class="modalTable">
								<tr>
									<td>
										<ul id="availablePartsList">
											<!-- 조회 결과 자재 목록이 여기에 추가됨 -->
										</ul>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="col-lg-2">
						<div class="arrow-buttons">
							<!-- 이동시킬버튼 -->
							<button id="leftArrowButton" type="button">&larr;</button>
							<button id="rightArrowButton" type="button">&rarr;</button>
						</div>
					</div>
					<div class="col-lg-5">
						<div class="parts-list">
						<h4>선택한 자재</h4>
							<table class="modalTable">
								<tr>
									<td>
										<!-- 옮겨진 자재들 -->
										<ul id="selectedPartsList">
							                <!-- 조회 결과 자재 목록이 여기에 추가됨 -->
							            </ul>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<button id="updateCompletedRepairBtn" type="button">수정</button>
				<button class="close" type="button">닫기</button>
			</form>
		</div>
		<!-- modal content -->
	</div>
	<!-- modal -->
</body>
</html>