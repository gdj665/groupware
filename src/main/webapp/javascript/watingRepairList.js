$(document).ready(function(){
		
		// 엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/repair/repairExcel?repairStatus=대기중', // 서버의 restController인 '/repair/repairExcel' URL로 요청을 보냄
	            type: 'get', // GET 요청 방식
	            dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
	            success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
	            	let arr = [];
	         	    console.log(data);
	                // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
	                data.forEach(function(item) {
	                	 // 장비 정보를 하나의 배열로 묶어서 arr 배열에 추가
	                	arr.push([item.repairNo, item.repairProductCategory, item.repairProductName, item.receivingDate, item.repairReceivingReason]);
	                });

	             	// 엑셀 파일 생성
	             	let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
	             	book.SheetNames.push('AS(대기중)'); // 시트 이름 추가

	             	// 데이터가 들어있는 2차원 배열로부터 시트 생성
	            	let sheet = XLSX.utils.aoa_to_sheet([['수리번호', '제품분류', '제품명', '입고날짜', '수리상태', '입고사유']].concat(arr));
	             	// 위에서 만든 시트를 엑셀 파일에 추가
	             	book.Sheets['AS(대기중)'] = sheet;

	             	// 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
	             	let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });

	            	 // 엑셀 파일을 Blob 형태로 변환하여 다운로드
	             	let blob = new Blob([buf], { type: 'application/octet-stream' });
	             	// 다운로드할 파일의 이름을 설정하여 다운로드
	             	saveAs(blob, 'AS(대기중)목록.xlsx');
	        	}
	    	});
		});
		
		// 현재 날짜 구하기 
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);
		
		var preDate = year + '-' + month  + '-' + day;
// ---------------------------------------------------------------- 대기중 -> 수리중 수정 시작 ----------------------------------------------------------
		// 대기중 -> 수리중 모달창 오픈
		$('.underRepairModalOpen').click(function(){
			var underRepairNo = $(this).data("underrepairno");
	        var underRepairProductName = $(this).data("underrepairproductname");
	        var underMemberId = $(this).data("undermemberid");
	        $("#underRepairNoInput").val(underRepairNo); // 모달 내의 input 요소에 수리번호 설정
	        $("#underRepairProductNameInput").val(underRepairProductName); // 모달 내의 input 요소에 수리제품이름 설정
	        $("#underMemberIdInput").val(underMemberId); // 대여자 Id값(세션에서 받아옴)
	        $("#underRepairReleaseDate").val(preDate); // 현재날짜
			$('#underRepairModal').fadeIn();
		});
		
		// 대기중 -> 수리중 수정 버튼
		$('#updateUnderRepairBtn').click(function(){
			
			// 예 아니오 확인
			if(!confirm($('#underRepairProductNameInput').val()+'제품을 수리시작 하시겠습니까?')) {
				return false;
			}
			
			$('#updateUnderRepair').submit();
			$('#underRepairModal').fadeOut();
		});
		
		// 모달창 닫기 (공통)
	    $('.close').click(function(){
			$('#underRepairModal').fadeOut();
		});
		
	});