/**
 * 
 */
$(document).ready(function() {
  $('.copy-phone').click(function() {
    // 클립보드에 텍스트 복사
    var text = $(this).text();
    
    var tempInput = $('<input>');
    $('body').append(tempInput);
    tempInput.val(text).select();
    document.execCommand('copy');
    tempInput.remove();
    
    alert('복사되었습니다: ' + text);
  });
  $('.copy-email').click(function() {
	    var text = $(this).text();
	    
	    // 이메일 주소에 맞게 클립보드에 복사
	    var tempInput = $('<input>');
	    $('body').append(tempInput);
	    tempInput.val(text).select();
	    document.execCommand('copy');
	    tempInput.remove();
	    
	    alert('복사되었습니다: ' + text);
	  });
});