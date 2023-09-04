/**
 * 
 */
$(document).ready(function() {
    // "사원 상세보기" 링크를 클릭했을 때의 처리
    $("body").on("click", ".oneHrm", function(event) {
        event.preventDefault(); // 기본 링크 동작을 막습니다.

        var memberId = $(this).data("memberid"); // 소문자 memberId를 대문자 MemberId로 변경

        $.ajax({
            type: "GET",
            url: "/group/rest/getOneMember",
            data: { memberId: memberId },
            success: function(response) {
                var memberData = response[0];

                // 필드에 값 대입
                $("#memberId").val(memberData.memberId);
                $("#departmentId").val(memberData.departmentId);
                $("#memberName").val(memberData.memberName);
                $("#memberAddress").val(memberData.memberAddress);
                $("#memberEmail").val(memberData.memberEmail);
                $("#memberGender").val(memberData.memberGender);
                $("#memberBirth").val(memberData.memberBirth);
                $("#memberPhone").val(memberData.memberPhone);
                $("#memberRank2").text(memberData.memberRank.substring(1)); // 첫 번째 글자(숫자) 제외한 나머지
                $("#memberLevel2").text(memberData.memberLevel.substring(1)); 
                $("#memberHiredate").val(memberData.memberHiredate);
                $("#memberId2").val(memberData.memberId);

                $(".modal2").show(); // 모달 창 보이기
            },
            error: function() {
                alert("사원 데이터 가져오기에 실패했습니다.");
            }
        });
    });

    // 모달을 닫기
    $("#close2").click(function() {
        $(".modal2").hide(); // 모달 창 숨기기
    });

 // "수정" 버튼 클릭 처리
    $("#updateMemberBtn").click(function() {
    	 // 직급 검사
        var memberRank = $('#updateMemberRank').val();
        if (memberRank === "") {
            alert("직급을 선택해주세요.");
            return;
        }

        // 직무 레벨 검사
        var memberLevel = $('#updateMemberLevel').val();
        if (memberLevel === "") {
            alert("직무 레벨을 선택해주세요.");
            return;
        }

        // 폼을 제출합니다
        $("#updateMember").submit();
    });
 
 
 	// 사원리스트 엑셀 다운로드
    // 엑셀 다운로드 버튼을 클릭했을 때 실행되는 함수
    $('#excelBtn').click(function() {
       // 서버로 AJAX 요청을 보냄
       $.ajax({
          url: '/group/rest/getMemberList', // 서버의 '/excel' URL로 요청을 보냄
          type: 'get', // GET 요청 방식
          dataType: 'json', // 서버에서 반환하는 데이터 형식을 JSON으로 설정
          success: function(data) { // AJAX 요청이 성공했을 때 실행되는 콜백 함수
             let arr = [];
             // 서버에서 받아온 JSON 데이터를 가공하여 arr 배열에 추가
             data.forEach(function(item) {
                arr.push([item.memberId, item.departmentId, item.memberLevel, item.memberName]); // 사원아이디 부서이름 직급 이름을 하나의 배열로 묶어서 arr 배열에 추가
             });

             // 엑셀 파일 생성
             let book = XLSX.utils.book_new(); // 빈 엑셀 파일 생성
             book.SheetNames.push('사원목록'); // 시트 이름 '사원목록' 추가

             // 데이터가 들어있는 2차원 배열로부터 시트 생성
             let sheet = XLSX.utils.aoa_to_sheet([['사원아이디', '부서이름','직급','이름']].concat(arr));
             // 위에서 만든 시트를 엑셀 파일에 추가
             book.Sheets['사원목록'] = sheet;

             // 엑셀 파일을 바이너리 형태로 변환하여 버퍼에 저장
             let buf = XLSX.write(book, { bookType: 'xlsx', type: 'array' });

             // 엑셀 파일을 Blob 형태로 변환하여 다운로드
             let blob = new Blob([buf], { type: 'application/octet-stream' });
             // 다운로드할 파일의 이름을 'test.xlsx'로 설정하여 다운로드
             saveAs(blob, '사원목록.xlsx');
          }
       });
    });
 	//리스트 토글
    $("#toggleServiceDept").click(function() {
        $("#serviceDeptTable").show();
        $("#hrDeptTable").hide();
      });

      $("#toggleHRDept").click(function() {
        $("#serviceDeptTable").hide();
        $("#hrDeptTable").show();
      });
      // 부서 선택시 ajax 비동기 팀 리스트 출력  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    $('#bigDepartment').change(function () {
        if ($('#bigDepartment').val() == '') {
            $('#littleDepartment').empty();
            $('#littleDepartment').append('<option value="">==팀 선택==</option>');
        } else {
            $.ajax({
                url: '/group/rest/departmentList',
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
    // 모달창 이벤트 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	$('#addHrmLink').click(function(){
		$('.modal').fadeIn();
	}) 
	
	$('.modal').click(function() {
			$('.modal').fadeOut();
		});
		$('.modal_content').click(function(event) {
			event.stopPropagation(); // 이벤트 전파 중단
		});
	$('#addHrmBtn').click(function(){
		//입력값 유효성 검사
		 // 부서 선택 검사
    var bigDepartment = $('#bigDepartment').val();
    if (bigDepartment === "") {
        alert("부서를 선택해주세요.");
        return;
    }

    // 팀 선택 검사
    var littleDepartment = $('#littleDepartment').val();
    if (littleDepartment === "") {
        alert("팀을 선택해주세요.");
        return;
    }

    // 이름 검사
    var memberName = $('#addMemberName').val();
    if (memberName === "") {
        alert("이름을 입력해주세요.");
        return;
    }
    
	// 이름 검사
	var memberEmail = $('#addMemberEmail').val();
    if (memberName === "") {
        alert("이름을 입력해주세요.");
        return;
    }

    // 생년월일 검사
    var memberBirth = $('#addMemberBirth').val();
    if (memberBirth === "") {
        alert("생년월일을 입력해주세요.");
        return;
    }

    // 전화번호 검사
    var memberPhone = $('#addMemberPhone').val();
    if (memberPhone === "") {
        alert("전화번호를 입력해주세요.");
        return;
    }

    // 직급 검사
    var memberRank = $('select[name="memberRank"]').val();
    if (memberRank === "") {
        alert("직급을 선택해주세요.");
        return;
    }

    // 직무 레벨 검사
    var memberLevel = $('select[name="memberLevel"]').val();
    if (memberLevel === "") {
        alert("직무 레벨을 선택해주세요.");
        return;
    }

    // 입사 날짜 검사
    var memberHiredate = $('#addMemberHiredate').val();
    if (memberHiredate === "") {
        alert("입사 날짜를 입력해주세요.");
        return;
    }
		$('#addHrmForm').submit();
    	$('.modal').fadeOut();
	});
	
	$('#close').click(function(){
		$('.modal').fadeOut();
	});
	window.onload = function(){
	  $("#address_kakao").click(function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	                $('#addMemberAddress').val(data.address) // 주소 넣기
	            }
	        }).open();
	    });
	}
});