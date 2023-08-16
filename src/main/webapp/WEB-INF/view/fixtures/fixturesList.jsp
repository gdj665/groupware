<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
	.modal {
	
	    position: fixed;
	    top: 50%;
	    left: 50%;
	    background: gray;
	    padding: 20px;
	    display: none;
	    z-index: 1050;
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
	//엑셀다운할 리스트 변수
	let fixturesArr = [];

	$(document).ready(function() {
		$('#excelBtn').click(function() {
			$.ajax({
				// 비동기
				async : false,
				url : '/fixtures/fixturesExcel',
				type : 'get',
				success : function(data) {
					// 데이터가 제대로 넘어왔는지 확인 디버깅
					console.log(data);
					$(data).each(function(index, item) {
						fixturesArr.push(item.partsNo);
						fixturesArr.push(item.partsCategory);
						fixturesArr.push(item.partsName);
						fixturesArr.push(item.partsCnt);
						fixturesArr.push(item.partsPrice);
						fixturesArr.push(item.partsContent);
					});
					console.log(fixturesArr);
				}
			});
			// 1) 엑셀파일
			let book = XLSX.utils.book_new();
			// 2) 1)안에 빈시트와 이름생성
			book.SheetNames.push('one');

			// 3) 시트생성
			let sheet = XLSX.utils.aoa_to_sheet(fixturesArr);

			// 2)와 3)을 연결
			book.Sheets['one'] = sheet;

			// 4) boot -> 기계어파일로
			let source = XLSX.write(book, {
				bookType : 'xlsx',
				type : 'binary'
			});

			// 다운로드
			// 1) source 크기의 빈 스트림 생성
			let buf = new ArrayBuffer(source.length);
			// 2) 8비트(1Byte) 배열로 버프 랩핑 -> 1byte씩 옮길려고....
			let buf2 = new Uint8Array(buf);

			for (let i = 0; i < source.length; i++) {
				buf2[i] = source.charCodeAt(i) & 0xFF;
			}

			let b = new Blob([ buf2 ], {
				type : "application/octet-stream"
			});
			saveAs(b, "test.xlsx");
		});
		
		// 모달창 이벤트
		$('#open').click(function(){
			$('.modal').fadeIn();
		});
		
		$('#partsAddBtn').click(function(){
			// 입력값 유효성 검사
			if($('#partsNameId').val().length == 0) {
				$('#partsNameIdMsg').text('장비명을 입력해주세요');
				return;
			} else {
				$('#partsNameIdMsg').text('');
			}
			
			if($('#partsCntId').val().length == 0) {
				$('#partsCntIdMsg').text('개수를 입력해주세요');
				return;
			} else {
				$('#partsCntIdMsg').text('');
			}
			
			if(isNaN($('partsCntId').val() == true)) {
				$('#partsCntIdMsg').text('개수를 숫자로 입력해주세요');
			} else {
				$('#partsCntIdMsg').text('');
			}
			
			if($('#partsPriceId').val().length == 0) {
				$('#partsPriceIdMsg').text('가격을 입력해주세요');
				return;
			} else {
				$('#partsPriceIdMsg').text('');
			}
			
			if(isNaN($('partsPriceId').val() == true)) {
				$('#partsPriceIdMsg').text('가격을 숫자로 입력해주세요');
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
	<h1>자재 목록</h1> <button id="open">모달창열기</button>
	<table>
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
			href="/fixtures/fixturesList?currentPage=${currentPage-1}&partsName=${fixturesList.partsName}">이전</a>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<a
			href="/fixtures/fixturesList?currentPage=${currentPage+1}&partsName=${fixturesList.partsName}">다음</a>
	</c:if>

	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>
	
	<div class="modal">
		<div class="modal_content">
			<h3>모달테스트</h3>
			<form id="addPartsForm" action="${pageContext.request.contextPath}/fixtures/addParts" method="post">
				<table>
					<tr>
						<td>장비 분류</td>
						<td>
							<select name ="partsCategoryNo">
								<option value="">= 선택하기 =</option>
								<c:forEach var="fm" items="${partsCategoryList}">
									<option value="${fm.partsCategoryNo}">
										${fm.partsCategory}
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>장비 이름</td>
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
							<textarea id="partsContentId" rows="5" cols="30" name="partsContent"></textarea>
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