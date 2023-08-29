<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 입력</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    label {
        display: block;
        margin-bottom: 5px;
    }
    
	input[type=file]::file-selector-button {
	width: 150px;
	height: 30px;
	background: #fff;
	border: 1px solid rgb(77,77,77);
	border-radius: 10px;
	cursor: pointer;
	&:hover {
		background: rgb(77,77,77);
		color: #fff;
	}
}
</style>
<script>
	$(document).ready(function() {
		$('#uploadForm').submit(function() {
			// 첨부파일 갯수 제한
			const fileInput = $('#fileInput')[0];
			if (fileInput.files.length > 5) {
				alert("최대 5개의 파일만 업로드할 수 있습니다.");
				return false; // 폼 제출 방지
			}

            // 업로드된 파일들의 크기를 확인
            const maxFileSize = 50 * 1024 * 1024;

            let totalSize = 0;
            for (let i = 0; i < fileInput.files.length; i++) {
                totalSize += fileInput.files[i].size;
            }

            if (totalSize > maxFileSize) {
                alert("최대 50MB의 파일만 업로드할 수 있습니다.");
                return false; // 폼 제출 방지
            }
        });
    });
	// 파일 선택 시 파일명 표시
	$(document).ready(function() {
		$('#fileInput').change(function() {
			const selectedFiles = [];
			for (let i = 0; i < this.files.length; i++) {
				selectedFiles.push(this.files[i].name);
			}
			// 각 파일 출력후에 <br>태그로 개행(text 타입에서 \n으로는 개행이 되지않음)
			$('#selectedFiles').html(selectedFiles.join("<br>"));
		});
	});
</script>
</head>
<body>
	<h1>게시글 입력</h1>
	<form action="/board/addBoard" method="post" enctype="multipart/form-data" id="uploadForm">
		<!-- 상단 고정 여부 -->
		<label class="form-label">상단 고정 여부</label>
		<input type="radio" name="boardStatus" value="Y">상단 고정
		<input type="radio" name="boardStatus" value="N" checked="checked">상단 비고정<br><br>
		<!-- 파일 첨부 -->
		<input type="file" name="multipartFile" id="fileInput" multiple>
		<label class="form-label">선택된 파일</label>
		<!-- 첨부된 파일 내역 출력 -->
		<div id="selectedFiles"></div>
		<!-- 제목 입력 -->
		<label for="boardTitle" class="form-label">제목</label>
		<input type="text" name="boardTitle" id="boardTitle" class="form-control" required="required"><br>
		<!-- 내용 입력 -->
		<label for="boardContent" class="form-label">내용</label>
		<textarea name="boardContent" id="boardContent" class="form-control" rows="3" cols="50" required="required"></textarea><br>
		<!-- 게시물 추가 -->
		<button type="submit">게시물 추가</button>
	</form>
</body>
</html>