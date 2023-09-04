/**
 * 
 */
$(document).ready(function() {
		
		// 엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/group/fixtures/fixturesExcel', // 서버의 '/excel' URL로 요청을 보냄
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
				$('#partsCategoryIdMsg').text('자재분류를 선택해주세요');
				return;
			} else {
				$('#partsCategoryIdMsg').text('');
			}
			
			if($('#partsNameId').val().length == 0) {
				$('#partsNameIdMsg').text('자재명을 작성해주세요');
				return;
			} else {
				$('#partsNameIdMsg').text('');
			}
			
			if($('#partsCntId').val().length == 0 || isNaN($('#partsCntId').val()) == true) {
				$('#partsCntIdMsg').text('개수를 숫자로 작성해주세요');
				return;
			} else {
				$('#partsCntIdMsg').text('');
			}
			
			if($('#partsPriceId').val().length == 0 || isNaN($('#partsPriceId').val()) == true) {
				$('#partsPriceIdMsg').text('가격을 작성해주세요');
				return;
			} else {
				$('#partsPriceIdMsg').text('');
			}
			
			if($('#partsContentId').val().length == 0) {
				$('#partsContentIdMsg').text('설명을 작성해주세요');
				return;
			} else {
				$('#partsContentIdMsg').text('');
			}
			
			// 예 아니오 확인하기
	 		if(!confirm($('#partsNameId').val()+'자재를 추가하시겠습니까?')) {
	 			return false;
	 		}
			
			$('#addPartsForm').submit();
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
		$('#partsCategoryId').focus(function() {
			// clearErrorMessage 함수를 호출하여 해당 입력란과 관련된 오류 메시지를 지웁니다
		    clearErrorMessage($(this), $('#partsCategoryIdMsg'));
		});

		$('#partsNameId').focus(function() {
		    clearErrorMessage($(this), $('#partsNameIdMsg'));
		});

		$('#partsCntId').focus(function() {
		    clearErrorMessage($(this), $('#partsCntIdMsg'));
		});

		$('#partsPriceIdMsg').focus(function() {
		    clearErrorMessage($(this), $('#partsPriceIdMsg'));
		});
		
		$('#partsContentId').focus(function() {
		    clearErrorMessage($(this), $('#partsContentIdMsg'));
		});
		
		// 모달 닫기
		$('#close').click(function(){
			$('.modal').fadeOut();
		});
	});