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
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
	$(document).ready(function(){
	// --------------------------------------- 엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/repair/repairExcel?repairStatus=수리완료', // 서버의 restController인 '/repair/repairExcel' URL로 요청을 보냄
	            type: 'get', // GET 요청 방식
	            dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
	            success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
	            	let arr = [];
	         	    console.log(data);
	                // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
	                data.forEach(function(item) {
	                	 // 장비 정보를 하나의 배열로 묶어서 arr 배열에 추가
	                	arr.push([item.repairNo, item.memberId, item.repairProductCategory, item.repairProductName, item.receivingDate, item.repairDate, item.repairReleaseDate, item.repairStatus]);
	                });

	             	// 엑셀 파일 생성
	             	let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
	             	book.SheetNames.push('AS(수리완료)'); // 시트 이름 추가

	             	// 데이터가 들어있는 2차원 배열로부터 시트 생성
	            	let sheet = XLSX.utils.aoa_to_sheet([['수리번호', '수리담당자', '제품분류', '제품명', '입고날짜', '수리날짜', '출고날짜', '수리상태']].concat(arr));
	             	// 위에서 만든 시트를 엑셀 파일에 추가
	             	book.Sheets['AS(수리완료)'] = sheet;

	             	// 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
	             	let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });

	            	 // 엑셀 파일을 Blob 형태로 변환하여 다운로드
	             	let blob = new Blob([buf], { type: 'application/octet-stream' });
	             	// 다운로드할 파일의 이름을 설정하여 다운로드
	             	saveAs(blob, 'AS(수리완료)목록.xlsx');
	        	}
	    	});
		});
	
		// --------------------------------------- 상세보기 모달 ---------------------------------------
		// 모달열기
		$('.modal_open').click(function(){
			// data를 사용해 매개변수로 보낼 repairNo값 가져옴
			var repairNo = $(this).data("repairno");
			
			$('.modal').fadeIn();
			
			$.ajax({
				url: '/repair/completedOne?repairNo=' + repairNo,
				type: 'get',
				success: function(data) {
					// ajax로 받아온 데이터를 변수화
					const completedOne = data.completedOne;
					const completedOneFixturesList = data.completedOneFixturesList;
					
					// 수리완료 상세보기 출력
					$('#repairNoId').text(completedOne.repairNo);
					$('#memberIdId').text(completedOne.memberId);
					$('#repairProductCategoryId').text(completedOne.repairProductCategory);
					$('#repairProductNameId').text(completedOne.repairProductName);
					$('#receivingDateId').text(completedOne.receivingDate);
					$('#repairDateId').text(completedOne.repairDate);
					$('#repairReleaseDateId').text(completedOne.repairReleaseDate);
					$('#repairPriceId').text(completedOne.repairPrice);
					$('#repairStatusId').text(completedOne.repairStatus);
					$('#repairReceivingReasonId').text(completedOne.repairReceivingReason);
					$('#repairContentId').text(completedOne.repairContent);
					
					// table의 id값 만들어 안에 집어넣을 내용 변수 선언
					var fixturesListHead = $('<tr><th>소비번호</th><th>자재명</th><th>수량</th><th>가격(개)</th><th>총가격</th></tr>');
					// append로 출력
				    $('#fixturesListId').append(fixturesListHead);
					
					// 사용자재는 여러개이므로 반복문 사용해 출력
				    completedOneFixturesList.forEach(function(cf) {
				        var fixturesListBody = $('<tr><td>' + cf.repairPartsNo + '</td><td>' + cf.partsName + '</td><td>' + cf.repairPartsCnt + '</td><td>' + cf.partsPrice + '</td><td>' + (cf.partsPrice * cf.repairPartsCnt) + '</td></tr>');
				        $('#fixturesListId').append(fixturesListBody);
				    });
				}
			});
			// 모달 닫기
			$('.close').click(function(){
				// 모달창을 닫을시 사용자재목록을 비움
				$('#fixturesListId').empty();
				$('.modal').fadeOut();
			})
		});
		
	
	});
</script>
</head>
<body>
	<!-- 수리완료 리스트 -->
	<h1>AS완료리스트</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>수리담당자</th>
			<th>제품분류</th>
			<th>제품명</th>
			<th>입고날짜</th>
			<th>수리날짜</th>
			<th>출고날짜</th>
			<th>수리상태</th>
		</tr>
		<c:forEach var="r" items="${repairList}">
			<tr>
				<td>
					<a href="#" class="modal_open" data-repairNo="${r.repairNo}">${r.repairNo}</a>
				</td>
				<td>${r.memberId}</td>
				<td>${r.repairProductCategory}</td>
				<td>${r.repairProductName}</td>
				<td>${r.receivingDate}</td>
				<td>${r.repairDate}</td>
				<td>${r.repairReleaseDate}</td>
				<td>${r.repairStatus}</td>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색및 페이징 -->
	<div>
		<form action="${pageContext.request.contextPath}/repair/repairList" method="get">
			<input type="text" name="repairProductCategory">
			<input type="hidden" name="repairStatus" value="수리완료">
			<button type="submit">검색</button>
		</form>
	</div>
	<c:if test="${currentPage > 1}">
		<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage-1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리완료">이전</a>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<a href="${pageContext.request.contextPath}/repair/repairList?currentPage=${currentPage+1}&repairProductCategory=${param.repairProductCategory}&repairStatus=수리완료">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>
	
	<!-- modal 상세보기 -->
	<div class="modal">
		<div class="modal_content">
			<h1>수리완료 상세</h1>
			<div class="row">
				<div class="col-lg-6">
					<table>
							<tr>
								<td>수리번호</td>
								<td>
									<span id="repairNoId"></span>
								</td>
							</tr>
							<tr>
								<td>담당자</td>
								<td>
									<span id="memberIdId"></span>
								</td>
							</tr>
							<tr>
								<td>제품분류</td>
								<td>
									<span id="repairProductCategoryId"></span>
								</td>
							</tr>
							<tr>
								<td>제품명</td>
								<td>
									<span id="repairProductNameId"></span>
								</td>
							</tr>
							<tr>
								<td>입고날짜</td>
								<td>
									<span id="receivingDateId"></span>
								</td>
							</tr>
							<tr>
								<td>수리날짜</td>
								<td>
									<span id="repairDateId"></span>
								</td>
							</tr>
							<tr>
								<td>출고날짜</td>
								<td>
									<span id="repairReleaseDateId"></span>
								</td>
							</tr>
							<tr>
								<td>수리금액</td>
								<td>
									<span id="repairPriceId"></span>
								</td>
							</tr>
							<tr>
								<td>상태</td>
								<td>
									<span id="repairStatusId"></span>
								</td>
							</tr>
							<tr>
								<td>입고사유</td>
								<td>
									<span id="repairReceivingReasonId"></span>
								</td>
							</tr>
							<tr>
								<td>수리내용</td>
								<td>
									<span id="repairContentId"></span>
								</td>
							</tr>
					</table>
				</div>
				<div class="col-lg-6">
					<h3>사용자재</h3>
					<table id="fixturesListId">
					
					</table>
				</div>
				<button class="close" type="button">닫기</button>			
			</div>
		</div>
	</div>
</body>
</html>