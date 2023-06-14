/**
 * 
 */
$(document).ready(function() {
    // 폼 제출 이벤트 핸들러
      // totalScore 값을 가져오기
	  let examNo = $("#examNo").val();
	  let stuNo = $("#stuNo").val();
	  let esFscore = $("#esFscore").val();
	        

      // AJAX 요청 보내기
      $.ajax({
        url: `${$.CPATH}/exam/stuExamPaperSubmitForm.do?what=${examNo}`, // 서버 컨트롤러 URL을 지정해야 합니다.
        method: "POST", // 요청 메서드 (GET, POST 등)
        data: { 
			esFscore: esFscore, 
			examNo : examNo,
			stuNo : stuNo
			}, // 전송할 데이터 (키: 값 형태로 전달)
        success: function(response) {
          // 요청이 성공한 경우에 실행될 코드
          console.log("요청이 성공하였습니다.");
        },
        error: function(xhr, status, error) {
          // 요청이 실패한 경우에 실행될 코드
          console.log("요청이 실패하였습니다.");
        }
      });

});