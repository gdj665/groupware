/**
 addBoard js
 */
$(document).ready(function() {
	// 결재버튼 눌렀을때 진행
	$('#uploadForm').submit(function() {
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
});