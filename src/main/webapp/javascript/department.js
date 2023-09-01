/**
 * 
 */
$(document).ready(function () {
    // 부서 선택시 ajax 비동기 팀 리스트 출력  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    $('#bigDepartment').change(function () {
        if ($('#bigDepartment').val() == '') {
            $('#littleDepartment').empty();
            $('#littleDepartment').append('<option value="">==팀 선택==</option>');
        } else {
            $.ajax({
                url: '/rest/departmentList',
                type: 'get',
                data: {
                    departmentId: $('#bigDepartment').val() // 선택한 부서의 값 전달
                },
                success: function (data) {
                    $('#littleDepartment').empty();
                    $('#littleDepartment').append('<option value="">==팀 선택==</option>');
                    // 받아온 팀 리스트를 옵션으로 추가
                    data.teamDepartmentList.forEach(function (item, index) {
                        $('#littleDepartment').append('<option value="' + item.departmentNo + '">' + item.departmentId + '</option>');
                    });
                }
            });
        }
    });

 // ul li 숨기고 보이는 기능  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    $('.toggle-link').click(function (e) {
        e.preventDefault();

        // 클릭한 요소의 하위 ul 요소를 활성화/비활성화합니다.
        $(this).next('ul').toggleClass('active');

        // 아이콘 방향을 변경합니다.
        $(this).toggleClass('active');
    });

   
    
    // 왼쪽 화살표 버튼 동작 구현
    $('#leftArrowButton').click(function() {
        $('#memberIdInput').val("");
        $('#memberNameInput').val(""); // 수정된 부분
    });

    let selectedCheckbox = null; // 선택된 체크박스를 추적하는 변수

 // 체크박스 클릭 이벤트
    $('.member-checkbox').click(function() {
        // 다른 체크박스 선택 해제
        $('.member-checkbox').not(this).prop('checked', false);

        // 클릭한 체크박스 선택
        $(this).prop('checked', true);
        
        selectedCheckbox = this; // 선택된 체크박스 저장
    });

    // 오른쪽 화살표 버튼 동작 구현
    $('#rightArrowButton').click(function() {
        if (selectedCheckbox !== null) {
            const memberIdInput = $('#memberIdInput');
            const memberNameInput = $('#memberNameInput');
            const memberName = $(selectedCheckbox).parent().text().trim();
            const memberId = $(selectedCheckbox).val();
            memberIdInput.val(memberId);
            memberNameInput.val(memberName);
        }
    });
    // 모달창 이벤트 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	$('#addDepartmentLink').click(function(){
		$('.modal').fadeIn();
	}) 
	$('.modal').click(function() {
			$('.modal').fadeOut();
		});
		$('.modal_content').click(function(event) {
			event.stopPropagation(); // 이벤트 전파 중단
		});
	$('#addDepartmentBtn').click(function(){
		//입력값 유효성 검사
		// 부서 선택
		if($('#addDepartmentId').val().length == 0){
			$('#addDepartmentParentMsg').text('상위 부서를 선택해주세요');
			return;
		}else{
			$('#addDepartmentParentMsg').text('');
		}
		// 추가할 부서
		if($('#addDepartmentId').val().length == 0){
			$('#addDepartmentIdMsg').text('추가할 부서명을 입력해주세요');
			return;
    	}else{
    		$('#addDepartmentIdMsg').text('');
    	}
		$('#addDepartmentForm').submit();
    	$('.modal').fadeOut();
	});
	
	$('#close').click(function(){
		$('.modal').fadeOut();
	});
	
	
	
	// 모달창2 이벤트
	$('#deleteDepartmentLink').click(function(){
	    $('.modal2').fadeIn();
	});

	$('#close2').click(function(){
	    $('.modal2').fadeOut();
	});
	$('.modal2').click(function() {
		$('.modal2').fadeOut();
	});
	$('.modal_content2').click(function(event) {
		event.stopPropagation(); // 이벤트 전파 중단
	});

	// 부서 삭제 버튼 클릭 시의 동작 설정
	$("#deleteDepartmentBtn").click(function() {
	    var selectedCheckboxes = $("input[type='checkbox']:checked");
	    
	    // 선택된 부서가 없으면 중단
	    if (selectedCheckboxes.length === 0) {
	        alert("삭제할 부서를 선택해주세요.");
	        return;
	    }
	    
	    // 선택된 체크박스가 하나인지 확인
	    if (selectedCheckboxes.length === 1) {
	        $('#deleteDepartmentForm').submit();
	        $('.modal2').fadeOut();
	    } else {
	        alert("하나의 부서만 선택해주세요.");
	        // 모든 체크박스 해제
	        $("input[type='checkbox']").prop("checked", false);
	        // 클릭한 체크박스만 다시 체크
	        $(this).prop("checked", true);
	    }
	});

	// 다른 체크박스를 클릭할 때 기존에 선택된 체크박스 해제
	$("input[type='checkbox']").click(function() {
	    $("input[type='checkbox']").not(this).prop("checked", false);
	});



});