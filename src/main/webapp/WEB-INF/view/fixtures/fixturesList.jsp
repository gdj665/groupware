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
<title>자재 목록</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

<script>
	$(document).ready(function() {
		
		// 엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/fixtures/fixturesExcel', // 서버의 '/excel' URL로 요청을 보냄
	            type: 'get', // GET 요청 방식
	            dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
	            success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
	            	let arr = [];
	         	    console.log(data);
	                // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
	                data.forEach(function(item) {
	                	arr.push([item.partsNo, item.partsCategoryNo, item.partsName, item.partsCnt, item.partsPrice, item.partsContent]); // 이름과 나이를 하나의 배열로 묶어서 arr 배열에 추가
	                });

	             	// 엑셀 파일 생성
	             	let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
	             	book.SheetNames.push('자재'); // 시트 이름 '자재' 추가

	             	// 데이터가 들어있는 2차원 배열로부터 시트 생성
	            	let sheet = XLSX.utils.aoa_to_sheet([['자재번호', '분류명', '부품명', '부품수량', '가격', '상세내용']].concat(arr));
	             	// 위에서 만든 시트를 엑셀 파일에 추가
	             	book.Sheets['자재'] = sheet;

	             	// 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
	             	let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });

	            	 // 엑셀 파일을 Blob 형태로 변환하여 다운로드
	             	let blob = new Blob([buf], { type: 'application/octet-stream' });
	             	// 다운로드할 파일의 이름을 설정하여 다운로드
	             	saveAs(blob, '자재목록.xlsx');
	        	}
	    	});
		});
		
		// 모달창 이벤트 -------------------------------------
		$('#open').click(function(){
			$('.modal').fadeIn();
		});
		
		$('#partsAddBtn').click(function(){
			// 입력값 유효성 검사
			if($('#partsCategoryId').val().length == 0) {
				$('#partsCategoryIdMsg').text('장비분류를 선택해주세요');
				return;
			} else {
				$('#partsCategoryIdMsg').text('');
			}
			
			if($('#partsNameId').val().length == 0) {
				$('#partsNameIdMsg').text('장비명을 입력해주세요');
				return;
			} else {
				$('#partsNameIdMsg').text('');
			}
			
			if($('#partsCntId').val().length == 0 || isNaN($('#partsCntId').val()) == true) {
				$('#partsCntIdMsg').text('개수를 숫자로 입력해주세요');
				return;
			} else {
				$('#partsCntIdMsg').text('');
			}
			
			if($('#partsPriceId').val().length == 0 || isNaN($('#partsPriceId').val()) == true) {
				$('#partsPriceIdMsg').text('가격을 입력해주세요');
				return;
			} else {
				$('#partsPriceIdMsg').text('');
			}
			
			if($('#partsContentId').val().length == 0) {
				$('#partsContentIdMsg').text('설명을 입력해주세요');
				return;
			} else {
				$('#partsContentIdMsg').text('');
			}
			
			$('#addPartsForm').submit();
			$('.modal').fadeOut();
		});
		
		$('#close').click(function(){
			$('.modal').fadeOut();
		});
	});
</script>
</head>
<body>
	<h1>자재 목록</h1> <button id="open">자재 추가</button>
	<table >
		<tr>
			<th>자재번호</th>
			<th>분류명</th>
			<th>부품명</th>
			<th>수량</th>
			<th>가격</th>
			<th>상세내용</th>
			<th>삭제</th>
		</tr>
		<c:forEach var="f" items="${fixturesList}">
			<tr>
				<td>${f.partsNo}</td>
				<td>${f.partsCategory}</td>
				<td>${f.partsName}</td>
				<td>${f.partsCnt}</td>
				<td>${f.partsPrice}</td>
				<td>${f.partsContent}</td>
				<td><a href="/fixtures/deleteParts?partsNo=${f.partsNo}" onClick="return confirm('삭제하시겠습니까?')">삭제</a></td>
			</tr>
		</c:forEach>
	</table>
	<div>
		<form action="${pageContext.request.contextPath}/fixtures/fixturesList" method="get">
			<input type="text" name="partsName">
			<button type="submit">검색</button>
		</form>
	</div>
	<c:if test="${currentPage > 1}">
		<a
			href="/fixtures/fixturesList?currentPage=${currentPage-1}&partsName=${param.partsName}">이전</a>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<a
			href="/fixtures/fixturesList?currentPage=${currentPage+1}&partsName=${param.partsName}">다음</a>
	</c:if>

	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>
	
	<div class="modal">
		<div class="modal_content">
			<h3>자재 추가</h3>
			<form id="addPartsForm" action="${pageContext.request.contextPath}/fixtures/addParts" method="post">
				<table>
					<tr>
						<td>자재 분류</td>
						<td>
							<select name ="partsCategoryNo" id="partsCategoryId">
								<option value="">= 선택하기 =</option>
								<c:forEach var="fm" items="${partsCategoryList}">
									<option value="${fm.partsCategoryNo}">
										${fm.partsCategory}
									</option>
								</c:forEach>
							</select>
							<span id="partsCategoryIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>자재 이름</td>
						<td>
							<input id="partsNameId" type="text" name="partsName">
							<span id="partsNameIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>총개수</td>
						<td>
							<input id="partsCntId" type="text" name="partsCnt">
							<span id="partsCntIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>가격</td>
						<td>
							<input id="partsPriceId" type="text" name="partsPrice">
							<span id="partsPriceIdMsg" class="msg"></span>
						</td>
					</tr>
					<tr>
						<td>설명</td>
						<td>
							<textarea id="partsContentId" rows="5" cols="50" name="partsContent"></textarea>
							<span id="partsContentIdMsg" class="msg"></span>
						</td>
					</tr>
				</table>
			</form>
			<button id="partsAddBtn" type="button">추가</button>
			<button id="close" type="button">닫기</button>
		</div>
	</div>
</body>
</html>