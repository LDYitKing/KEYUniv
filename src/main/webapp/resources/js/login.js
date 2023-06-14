/**
 * 
 */
// 아이디 저장 체크박스 기능 구현

const loginId = localStorage.getItem("memNo");
// console.log(loginId);

let memNoInput = $("#memNoInput");
let loginCheck = $("#loginCheck");

if (loginId != null) {
   memNoInput.val(loginId);
   loginCheck.prop('checked', true);
}

let loginForm = $("#loginForm").on("submit", function(event) {
   if (loginCheck.is(':checked')) {
      localStorage.setItem("memNo", memNoInput.val());
   } else {
      localStorage.removeItem("memNo");
   }
})

// 아이디 찾기 기능 구현
let searchIdTableArea = $("#searchIdTableArea");
let searchIdForm = $("[name=searchIdForm]").on("submit", function(event) {
   event.preventDefault();

   let data = JSON.stringify($(this).serializeObject());
   //       console.log("data : ", data);

   $.ajax({
      url: $.CPATH+"/member/searchId.do",
      method: "post",
      data: data,
      dataType: "json",
      contentType: "application/json"

   }).done(function(resp, textStatus, jqXHR) {
      console.log("resp: ", resp);

      // table 만들기
      // 이름, 아이디, 학과, 선택(버튼)
      // memName memNo deptName
      let trTags = [];

      trTags.push($("<tr>").append(
         $("<th>").html("이름")
         , $("<th>").html("아이디")
         , $("<th>").html("학과")
         , $("<th>").html("선택")
      ));

      if (resp.length > 0) {
         $(resp).each(function(idx, member) {
            console.log(member);

            trTags.push($("<tr>").append(
               $("<td>").html(member.memName)
               , $("<td>").html(member.memNo)
               , $("<td>").html(member.deptName)
               , $("<td>").html($(`<input class='btn btn-link' type='button' value='선택' onclick='fn_sel("${member.memNo}")'>`))
            ));
         });

      } else {
         trTags.push($("<tr>").html($("<td colspan='4'>").html("조회된 결과가 없습니다.")));
      }

      //             let table = $("<table id='searchTable'>").addClass("table table-hover text-center").append(trTags);
      let table = $("<table id='searchTable' class='table table-hover text-center'>").append(trTags);

      searchIdTableArea.empty();
      searchIdTableArea.append(table);
   })

   return false;
});

let searchIdModal = $("#searchIdModal").on("hidden.bs.modal", function(event) {
   searchIdTableArea.empty();
   // console.log("searchIdForm", searchIdForm);
   // console.log("searchIdForm[0]", searchIdForm[0]);

   // table 지우기
   searchIdTableArea.empty();

   // form에 input reset 시키기
   searchIdForm[0].reset();

})

let fn_sel = (memNo) => {
   console.log(memNo);
   memNoInput.val(memNo);

   // 모달 닫기
   searchIdModal.modal("hide");

}

// 임시 비밀번호 전송 기능 구현
var error = $("#searchPasswdError");
let searchPasswdForm = $("[name=searchPasswdForm]").on("submit", function() {
   event.preventDefault();


   let data = JSON.stringify($(this).serializeObject());
   // console.log(data);

   $.ajax({
      url: $.CPATH+"/member/searchPasswd.do",
      method: "post",
      data: data,
      dataType: "json",
      contentType: "application/json"

   }).done((resp, textStatus, jqXHR) => {
      console.log("resp: ", resp);

      if (!resp.successYn) {
         error.html("입력하신 아이디와 이메일이 등록된 정보와 일치하지 않습니다.<br>확인 후 다시 시도하세요.<br>");
         return;
      }

      // 입력한 아이디와 이메일이 맞을 때
      $.ajax({
         url: $.CPATH+"/member/sendMail.do",
         method: "post",
         data: JSON.stringify(resp),
         dataType: "text",
         contentType: "application/json"

      }).done((resp, textStatus, jqXHR) => {
            console.log("send mail resp: ", resp);

            let memEmail = $("[name=memEmail]").val();

            searchPasswdModal.modal("hide");
			
			Swal.fire({
			    icon: 'success',
			    title: '임시 비밀번호 발송',
			    text: '임시 비밀번호를 ' + memEmail + '로 발송하였습니다.'
			});
			
			
				
           /* Swal.fire(
               '임시 비밀번호를 ' + memEmail + '로 발송하였습니다.\n 임시비밀번호로 로그인 하신 후 반드시 비밀번호를 수정해 주세요.'
            );*/

         })

   })

   return false;
});

let searchPasswdModal = $("#searchPasswdModal").on("hidden.bs.modal", function(event) {
   error.empty();

   // form에 input reset 시키기
   searchPasswdForm[0].reset();

})