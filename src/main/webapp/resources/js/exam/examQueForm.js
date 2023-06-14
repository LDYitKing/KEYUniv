/**
 * 
 */

let insertFormArea = $("#insertFormArea");
let displayDiv = $("#displayDiv");
var addCnt = 0; // 몇 문제 추가할 건지 선택한 값

let ExamNo = document.getElementById("examNo").value;

$("#insertForm").keydown(function (event)
    {
        if (event.keyCode == '13') {
            if (window.event)
            {
                event.preventDefault();
                return;
            }
        }
 });

// 몇 문제 추가할건지 선택하고 추가 누르면 그 개수만큼 table에 tr태그 만들어주기
let addErrorSpan = $("#addErrorSpan");
let addFormBtn = $("#addFormBtn").on("click", function(){
  let addCnt = parseInt($("[name=addCnt]").val());

  if (addCnt === NaN || addCnt <= 0){
    addErrorSpan.text("출제할 문제 수를 입력해주세요.");
    return;
  } else if (addCnt > 10) {
    addErrorSpan.text("최대 10개까지 입력할 수 있습니다.");
    return;
  } else {
    addErrorSpan.empty();
  }

  insertFormArea.empty();
  $("#insertFormBtn").show();
  displayDiv.show();

  console.log("addCnt: ", addCnt);
  console.log("ExamNo: ", ExamNo);

  selectedValuesArray = []; // 배열 초기화

  for (let i = 0; i < addCnt; i++) {
    let startNumber = i + 1; // 문제 번호 설정
    let trTag = fn_makeTr(startNumber, addCnt);
    insertFormArea.append(trTag);
  }
});

// 저장객체를 배열로 만들기
let selectedValuesArray = [];

// 함수 실행 후 객체에 데이터 저장
let fn_makeTr = (startNumber, addCnt) => {
  let set = {
    eqNumber: startNumber.toString(),
    eqQue: "",
    eqScore: "", // eqScore 필드 추가
    etNo: [],
    etQue: [],
    eqRightAnswer: [],
    examNo: ExamNo
  };

  let tdTagEtNo = $("<td>");
  let tdTagEtQue = $("<td>");
  let tdTagEtRightAnswer = $("<td>");

  for (let i = 0; i < 4; i++) {
    let etNoInput = $("<input type='text' name='etNo' value='" + (i + 1) + "' readonly><br><br>").css("width", "30%").css("border", "none");
    tdTagEtNo.append(etNoInput);

    let etQueTextarea = $("<input type='text' name='etQue' placeholder='보기문항' required><br><br>").css("width", "100%");
    tdTagEtQue.append(etQueTextarea);

    etQueTextarea.on("change", function() {
      set.etQue[i] = $(this).val();
    });
  }

  let eqRightAnswerInput = $("<input type='text' name='eqRightAnswer' placeholder='정답' required><br><br>");
  tdTagEtRightAnswer.append(eqRightAnswerInput);

  eqRightAnswerInput.on("change", function() {
    set.eqRightAnswer = [];
    for (let i = 0; i < 4; i++) {
      set.eqRightAnswer[i] = $(this).val();
    }
  });

  let eqNumberInput = $("<input type='text' name='eqNumber' placeholder='문제번호' required' readonly>").val(startNumber).css("width", "20%").css("border", "none");
  let eqQueTextarea = $("<input type='text' name='eqQue' placeholder='문제' required>").css("width", "100%");
  let eqScoreInput = $("<input type='text' name='eqScore' placeholder='문제 배점' readonly>").css("width", "50%").css("border", "none"); // eqScore 필드 읽기 전용으로 변경

  eqQueTextarea.on("change", function() {
    set.eqQue = $(this).val();
  });

  let trTag = $("<tr>").append(
    $("<td>").append(eqNumberInput),
    $("<td>").append(eqQueTextarea),
    $("<td>").append(eqScoreInput),
    tdTagEtNo,
    tdTagEtQue,
    tdTagEtRightAnswer
  ).addClass("tr" + addCnt);

  // set을 selectedValuesArray 배열에 추가
  selectedValuesArray.push(set);

  // addCnt 값에 따라 배점을 설정
  if (addCnt > 0) {
    let scorePerQuestion = 100 / addCnt;
    eqScoreInput.val(scorePerQuestion); // 배점 자동으로 계산하여 입력
    set.eqScore = scorePerQuestion; // set 객체의 eqScore 필드에 값 저장
  }

  return trTag;
};


// 등록 버튼을 누르면 비동기로 문제와 지문 insert
let insertForm = $("#insertForm").on("submit", function(event) {
   event.preventDefault();
	
	console.log("selectedValuesArray입니다:", selectedValuesArray);
  
	
  	// ajax 요청
  	$.ajax({
  		url : `${$.CPATH}/exam/examQuetext.do`,
  		type : "POST",
  		data : JSON.stringify(selectedValuesArray), // 데이터 형식 JSON으로 변환
  		dataType : "json",
  		contentType : "application/json", // 요청 contentType을 JSON형식으로 변환
  		success: function(response){
  			console.log("요청에 성공했습니다", response);
  			
  			displayDiv.find(":input[name]").prop('disabled', true);
  			$("#insertFormBtn").hide();
  			
  			Swal.fire({
  				position : 'center',
  				icon : 'success',
  				title : '문제가 등록되었습니다',
				showConfirmButton : false,
				timer : 2500
  			})
  		},
  		error: function(xhr, status, error){
  			console.log("요청에 실패했습니다", error);
  		}
  		
  		
  	});
  
});



let autoInput = $("#autoInput").on("click", function(event) {
  let value = "3"; // 자동으로 설정할 값입니다.
  let etQueValues = ["HAVING", "GROUP BY", "DROP", "ORDER BY"]; // etQue에 할당할 값들의 배열

  // selectedValuesArray의 각 객체에서 eqRightAnswer 값을 설정합니다.
  for (let i = 0; i < selectedValuesArray.length; i++) {
    let eqRightAnswer = Array(4).fill(value); // 같은 값으로 초기화된 배열을 생성합니다.
    selectedValuesArray[i].eqRightAnswer = eqRightAnswer.map(String); // 문자열로 변환하여 설정합니다.

    // etQue 값을 설정합니다.
    selectedValuesArray[i].etQue = etQueValues; // etQue에 etQueValues 배열을 할당합니다.
    
    selectedValuesArray[i].eqQue = "SQL에서 SELECT 문에 나타날 수 없는 절은?";
  }

  // 해당 입력란에 값 설정
  $(`.tr1 [name=eqRightAnswer]`).val(value);
  $(`.tr1 [name=eqQue]`).val("SQL에서 SELECT 문에 나타날 수 없는 절은?");

  $(".tr1").each(function(index) {
    let etQueInputs = $(this).find("[name=etQue]"); // 현재 행의 모든 etQue 입력란을 찾습니다.

    etQueInputs.each(function(i) {
      $(this).val(etQueValues[i % etQueValues.length]); // etQue 입력란에 etQueValues 배열의 값을 순환하도록 설정합니다.
    });
  });

});