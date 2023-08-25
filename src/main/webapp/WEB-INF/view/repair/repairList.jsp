<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
     /* 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }
    .modal-content {
        background-color: #fff;
        margin: auto;
        padding: 20px;
        max-width: 80%; /* 적절한 값으로 조정 */
        max-height: 80vh; /* 적절한 값으로 조정 */
        border-radius: 5px;
        overflow-y: auto;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
    /* 섹션 간 마진 조정 */
    .row {
        margin: 10px 0;
    }

    /* 테이블 스타일 */
    .modalTable {
        width: 50%;
        border-collapse: collapse;
        border: 1px solid #ddd;
    }

    .modelTable th, .modelTable td {
        padding: 8px;
        border: 1px solid #ddd;
        text-align: center;
    }

    /* 버튼 스타일 */
    button {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 8px 16px;
        cursor: pointer;
    }

    button.close {
        background-color: #f44336;
    }

    /* 자재 목록 스타일 */
    ul {
        list-style-type: none;
        padding: 0;
    }

    li {
        padding: 4px 0;
    }

    /* 화살표 버튼 스타일 */
    .arrow-buttons button {
        margin: 5px;
    }
    
    .parts-list {
	    max-height: 300px; /* 적절한 값으로 조정 */
	    overflow-y: auto;
	    border: 1px solid #ccc; /* 스크롤바를 보여줄 테두리 설정 (선택사항) */
	    border-radius: 5px;
	    padding: 10px;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		// 현재 날짜 구하기 
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		
		var preDate = year + '-' + month  + '-' + day;
// ---------------------------------------------------------------- 수리중 -> 수리완료 수정 시작 ----------------------------------------------------------
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
	    	
	    	const selectedPartsNumbers = [];
	    	// 이미 선택된 항목들의 번호를 배열에 저장
	        $('.selectedPartsCnt').each(function() {
	            selectedPartsNumbers.push($('.partsNoClass').val());
	        });
	    	
	    	// 반복문 돌려 하나씩 출력시키기
	    	checkedPartsName.each(function(){
	    		// 체크된 박스에 총 개수 가져오기
	    		const checkPartsCnt = $(this).data('partscnt');
	    		const checkPartsPrice = $(this).data('partsprice');
	    		const checkPartsNo = $(this).data('partsno');
		    	const checkPartsName = $(this).parent().text();
		    	
		    	// 이미 선택된 항목들의 번호와 비교하여 중복 여부 체크
	            const selectedListItem = $('<span class="selectedPartsCnt"><li><input type="checkbox" class="removeChecked">'+checkPartsName+" 재고량 :"+checkPartsCnt+'<br>사용자재 수: <input type="text" class="partsCntClass" name="partsCnt[]" required="required" data-selectedPrice="'+checkPartsPrice+'" style="width:30px;height:30px;"><input type="hidden" class="partsNoClass" name="partsNo[]" required="required" value="'+checkPartsNo+'"></li></span>'); 
	            $('#selectedPartsList').append(selectedListItem);
	            
	            // 이미 선택된 항목들의 번호 배열에 추가
	            selectedPartsNumbers.push(checkPartsNo);
	            
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
	    	let totalPrice = 0;
	    	// 반복문을 통해 각 선택된 자재의 총 가격 계산
	    	$('.selectedPartsCnt').each(function() {
	    		// 변경된 항목에 자재 가격 가져옴
				const selectedPrice = $(this).find('.partsCntClass').data('selectedprice');
	    		// 변경된 항목에 변경값 가져옴
				const inputCnt = parseInt($(this).find('.partsCntClass').val());
				
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
	 		
	 		const formData = new FormData($("#updateCompletedRepair"));
	 		console.log("111");
	 		
	 		// formData를 컨트롤러로 전송 (예를 들어, AJAX를 사용하여 전송)
	 	    $.ajax({
	 	        url: '/repair/updateRepair',
	 	        type: 'post',
	 	        data: formData,
	 	        processData: false,
	 	        contentType: false,
	 	        success: function(response) {
	 	            // 성공적으로 처리된 경우의 동작
	 	            // 모달창 닫기
	 	        	$('#completedRepairModal').fadeOut();
	 	        },
	 	        error: function(error) {
	 	            // 오류 발생 시의 동작
	 	        }
	 	    });
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
				<td>${r.memberId}</td>
				<td>${r.repairProductCategory}</td>
				<td>${r.repairProductName}</td>
				<td>${r.receivingDate}</td>
				<td>${r.repairDate}</td>
				<td>${r.repairStatus}</td>
				<td>${r.repairReceivingReason}</td>
				<td><a href="#" class="comRepairModalOpen"
					data-comRepairNo="${r.repairNo}" data-comMemberId="${memberId}"
					data-comRepairProductName="${r.repairProductName}"
					data-comRepairReceivingReason="${r.repairReceivingReason}">수리완료</a>
				</td>
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
	<c:if test="${currentPage < lastPage}">
		<a
			href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리중">다음</a>
	</c:if>

	<!-- 수리중 -> 수리완료 업데이트 모달 -->
	<div id="completedRepairModal" class="modal">
		<div class="modal-content">
			<form id="updateCompletedRepair"
				action="${pageContext.request.contextPath}/repair/updateRepair"
				method="post">
				<div class="row">
					<div class="col-lg-12">
						<h3>수리완료 수정</h3>
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
								<td><input id="totalPriceId" type="text" name="repairPrice" required="required">원 
								<span id="repairPriceIdMsg"
									class="msg"></span></td>
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
										name="repairContent"></textarea> <span id="repairContentIdMsg"
									class="msg"></span></td>
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
				<button id="updateCompletedRepairBtn" type="submit">수정</button>
				<button class="close" type="button">닫기</button>
			</form>
		</div>
		<!-- modal content -->
	</div>
	<!-- modal -->
</body>
</html>