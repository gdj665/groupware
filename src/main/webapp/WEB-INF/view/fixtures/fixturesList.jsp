<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 목록</title>
<!-- jquery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- excel api : sheetjs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- file download api : FileServer saveAs-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>

<script>
	// 엑셀다운할 리스트 변수
	let fixturesArr =[];
	
	$(document).ready(function(){
		$('#excelBtn').click(function(){
			$.ajax({
				// 비동기
				async : false,
				url : '/fixtures/fixturesExcel',
				type : 'get',
				success : function(data) {
					$(data).each(function(index, item) {
						let row = [];
						row.push(item.partsNo);
						row.push(item.partsCategory);
						row.push(item.partsName);
						row.push(item.partsCnt);
						row.push(item.partsPrice);
						row.push(item.partsContent);
						fixturesArr.push(row)
					});
				}
			});
			console.log(fixturesArr);
			
			// 1) 엑셀파일
			let book = XLSX.utils.book_new(); 
			// 2) 1)안에 빈시트와 이름생성
			book.SheetNames.push('one');
			
			// 3) 시트생성
			let sheet = XLSX.utils.aoa_to_sheet(fixturesArr);
			
			// 2)와 3)을 연결
			book.Sheets['one'] = sheet;
			
			// 4) boot -> 기계어파일로
			let source = XLSX.write(book, {bookType:'xlsx', type:'binary'});
			
			// 다운로드
			// 1) source 크기의 빈 스트림 생성
			let buf = new ArrayBuffer(source.length);
			// 2) 8비트(1Byte) 배열로 버프 랩핑 -> 1byte씩 옮길려고....
			let buf2 = new Uint8Array(buf);
			
			for(let i=0; i<source.length; i++) {
				buf2[i] = source.charCodeAt(i) & 0xFF;
			}
			
			let b = new Blob([buf2], {type:"application/octet-stream"});
			saveAs(b, "test.xlsx");
		});
	});
</script>
</head>
<body>
	<h1>자재 목록</h1>
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
				<td>
					<a href="fixtures/deleteFixtures?${f.partsNo}">삭제</a>
				</td>
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
		<a href="/fixtures/fixturesList?currentPage=${currentPage-1}&partsName=${fixturesList.partsName}">이전</a>
	</c:if>
	<c:if test="${currentPage < lastPage}">
		<a href="/fixtures/fixturesList?currentPage=${currentPage+1}&partsName=${fixturesList.partsName}">다음</a>
	</c:if>
	
	<div>
		<button id="excelBtn">엑셀 다운</button>
	</div>
	
</body>
</html>