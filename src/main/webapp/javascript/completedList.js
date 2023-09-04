$(document).ready(function(){
	// --------------------------------------- 엑셀다운 ---------------------------------------
		$('#excelBtn').click(function() {
		 	// 서버로 AJAX 요청을 보냄
	   		$.ajax({
	        	url: '/group/repair/repairExcel?repairStatus=수리완료', // 서버의 restController인 '/repair/repairExcel' URL로 요청을 보냄
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
				url: '/group/repair/completedOne?repairNo=' + repairNo,
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