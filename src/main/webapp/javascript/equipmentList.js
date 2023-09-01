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