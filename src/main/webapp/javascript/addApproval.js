/**
 addApproval js
 */
$(document).ready(function() {
	// 결재버튼 눌렀을때 진행
	$('#uploadForm').submit(function() {
		// 결재 코멘트와 세션 로그인 정보 변수선언
		const firstApprovalId = $('.memberIdInputFirst').val();
        const secondApprovalId= $('.memberIdInputSecond').val();
        const thirdApprovalId = $('.memberIdInputThird').val();
        const memberId = '${sessionScope.loginMember}';
        
        // 두 번째 결재자 입력 확인
        if (secondApprovalId && !firstApprovalId && !thirdApprovalId) {
            alert("두 번째 결재자를 선택하려면 첫 번째 결재자를 먼저 선택해야 합니다.");
            return false;
        }

        // 세 번째 결재자 입력 확인
        if (thirdApprovalId && (!thirdApprovalId || !firstApprovalId)) {
            alert("세 번째 결재자를 선택하려면 첫 번째와 두 번째 결재자를 먼저 선택해야 합니다.");
            return false;
        }
        
        // 결재자 중복확인
        if (!firstApprovalId
        		&& (thirdApprovalId === secondApprovalId) 
        		|| (secondApprovalId === firstApprovalId)
        		|| (thirdApprovalId === firstApprovalId)) {
            alert("결재자가 중복 또는 누락되었습니다. 수정바랍니다");
            return false;
        }
        
   		// 결재자란에 작성자가 들어가면 오류
        if ((firstApprovalId === memberId)
        		|| (thirdApprovalId === memberId) 
        		|| (secondApprovalId === memberId)) {
            alert("자기 자신은 결재자로 선택할수 없습니다. 수정바랍니다");
            return false;
        }
   		
		// 첨부파일 갯수 5개 까지만으로 제한
		const fileInput = $('#fileInput')[0];
		if (fileInput.files.length > 5) {
			alert("최대 5개의 파일만 업로드할 수 있습니다.");
			return false;
		}

		// 업로드된 파일들의 크기를 확인
		// 파일들의 합 최대 50MB로 제한
		const maxFileSize = 50 * 1024 * 1024;

		let totalSize = 0;
		for (let i = 0; i < fileInput.files.length; i++) {
			totalSize += fileInput.files[i].size;
		}

		if (totalSize > maxFileSize) {
			alert("최대 50MB의 파일만 업로드할 수 있습니다.");
			return false;
		}
	});
	
	// 파일 선택 시 파일명 표시
	$('#fileInput').change(function() {
		const selectedFiles = [];
		for (let i = 0; i < this.files.length; i++) {
			selectedFiles.push(this.files[i].name);
		}
		// 각 파일 출력후에 <br>태그로 개행(text 타입에서 \n으로는 개행이 되지않음)
		$('#selectedFiles').html(selectedFiles.join("<br>"));
	});

	const selectElement = document.getElementById("approvalForm");

	selectElement.addEventListener("change", function() {
		if (selectElement.value === "") {
			selectElement.setAttribute("required", "required");
		} else {
			selectElement.removeAttribute("required");
		}
	});

	// 모달창 이벤트 -------------------------------------
	$('#open').click(function() {
		$('.modal').fadeIn();
	});
	$('#close').click(function() {
		$('.modal').fadeOut();
	});
	$('.modal').click(function() {
		$('.modal').fadeOut();
	});
	$('.modal_content').click(function(event) {
		event.stopPropagation(); // 이벤트 전파 중단
	});

	// ul li 숨기고 보이는 기능  ------------------------------------
	$('.toggle-link').click(function(e) {
		e.preventDefault();

		// 클릭한 요소의 하위 ul 요소를 활성화/비활성화합니다.
		$(this).next('ul').toggleClass('active');

		// 아이콘 방향을 변경합니다.
		$(this).toggleClass('active');
	});
	
	// 체크박스 관련 기능
	let selectedCheckbox = null; // 선택된 체크박스를 추적하는 변수

	// 체크박스 클릭 이벤트
	$('.member-checkbox').click(function() {
		// 다른 체크박스 선택 해제
		$('.member-checkbox').not(this).prop('checked', false);

		// 클릭한 체크박스 선택
		$(this).prop('checked', true);

		selectedCheckbox = this; // 선택된 체크박스 저장
	});
	
	// 오른쪽 화살표 첫번째 버튼 동작 구현
	$('#rightArrowButtonFirst').click(function() {
		if (selectedCheckbox !== null) {
			const memberIdInputFirst = $('.memberIdInputFirst');
			const memberNameInputFirst = $('.memberNameInputFirst');
			const memberId = $(selectedCheckbox).val();
			const memberName = $(selectedCheckbox).parent().text().trim();
			memberIdInputFirst.val(memberId);
			memberNameInputFirst.val(memberName);
		}
	});
	
	// 오른쪽 화살표 두번째 버튼 동작 구현
	$('#rightArrowButtonSecond').click(function() {
		if (selectedCheckbox !== null) {
			const memberIdInputSecond = $('.memberIdInputSecond');
			const memberNameInputSecond = $('.memberNameInputSecond');
			const memberId = $(selectedCheckbox).val();
			const memberName = $(selectedCheckbox).parent().text().trim();
			memberIdInputSecond.val(memberId);
			memberNameInputSecond.val(memberName);
		}
	});
	
	// 오른쪽 화살표 세번째 버튼 동작 구현
	$('#rightArrowButtonThird').click(function() {
		if (selectedCheckbox !== null) {
			const memberIdInputThird = $('.memberIdInputThird');
			const memberNameInputThird = $('.memberNameInputThird');
			const memberId = $(selectedCheckbox).val();
			const memberName = $(selectedCheckbox).parent().text().trim();
			memberIdInputThird.val(memberId);
			memberNameInputThird.val(memberName);
		}
	});
});