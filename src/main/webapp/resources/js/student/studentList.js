/**
 * 
 */
// 상세검색 클릭 했는지 안했는지 여부
var detailchk = false;
let detailTr = $("#detailTr");
detailTr.find("[name]").on("change", function (event) {
   console.log("this: ", this);
   console.log("$(this): ", $(this));
   console.log("detailTr: ", detailTr);

   let iptName = this.name;
   let iptValue = $(this).val();
   console.log(iptName, iptValue);

   searchForm.find(`[name=${iptName}]`).val(iptValue);

   searchForm.submit();
});


let detailBtn = $("#detailBtn").on("click", function () {
   detailchk = !detailchk;
   console.log(detailchk);

   //만약 상세검색detailchk이 true면 detailTr display 보이게 하기
   // false 면 display none하기 & 상세 조건 초기화 
   if (detailchk) {
      //          detailTr.attr('style', "display:'';");
      detailTr.show();

   } else {
      detailTr.hide();

      // 검색 조건 초기화
      $("[name=deptNo]").val("");
      $("[name=stuYear]").val("");
      $("[name=memGender]").val("");
      $("[name=stuState]").val("");
      $("[name=page]").val("");

//	 $("[name=searchWord]").val("");

      searchForm.submit();
   }


});


let listBody = $("#listBody");
let pagingArea = $("#pagingArea");

let totalRecord = $("#totalRecord");

// searchForm에 input 값을 가지고 비동기로 리스트 가져오기 (테이블 바디만 새로고침)
let searchForm = $("[name=searchForm]").on("submit", function (event) {
   event.preventDefault();

   // 테이블 바디와 페이징 부분 비우기
   listBody.empty();
   pagingArea.empty();

   // ajax 설정 가져오기
   let url = this.action;
   let data = $(this).serialize();
   console.log("data : ", data);

   $.ajax({
      url: url,
      method: "post",
      data: data,
      dataType: "json"
      //          contentType: "application/json"

   }).done(function (resp, textStatus, jqXHR) {
      console.log("resp : ", resp);

      // resp는 pagination 객체를 json으로 받은 것임
      let pagination = resp;
      // pagination에서 dataList 꺼냄 (여기서 dataList는 List<studentVO>임)
      let studentList = pagination.dataList;

      let trTags = [];
      // studentVO 하나씩 꺼내서 테이블에 trTag 만들기 (함수 - fn_makeTr로 따로 뺌)
      if (studentList.length > 0) {
         $.each(studentList, function (idx, student) {
            trTags.push(fn_makeTr(student));
         })
      } else {
         trTags.push($("<tr>").html($("<td colspan='9'>").html("조회 결과가 없습니다.")));
      }

      // 테이블에 tr태그들 넣어주기
      listBody.append(trTags);

      // 페이징 넣어주기
      pagingArea.append(pagination.pagingHTML);
      // 검색 후엔 1페이지부터 다시 보여줘야 함
      searchForm.find("[name=page]").val("");

      // 총 몇 건인지 보여주기
      totalRecord.text(pagination.totalRecord);

   })

   return false;
   // 처음 한 번은 무조건 실행하기
}).submit();

// 페이지 바꿀 때 마다 리스트 새로 가져오기
let fn_paging = (page, event) => {
   event.preventDefault();
   searchForm.find("[name=page]").val(page);
   searchForm.submit();
   return false;
}

// vo 하나로 tr태그 하나 만드는 함수 
let fn_makeTr = (student) => {

   // tr 태그 만들어서 td 태그들을 append
   // return tr태그 (data속성에 student memNo 넣어줌)
   let trTag = $("<tr>").append(
      $("<td>").html("<input onclick='event.cancelBubble=true' type='checkbox' name='cbkStu' value='" + student.memNo + "'>")
      , $("<td>").html(student.commName)
      , $("<td>").html(student.memName)
      , $("<td>").html(student.memNo)
      , $("<td>").html(student.deptName)
      , $("<td>").html(student.stuYear)
      , $("<td>").html(student.memGender)
      , $("<td>").html(student.memTel)
      , $("<td>").html(student.memEmail)
   ).addClass("stdTr").data("student", student.memNo);
   // console.log("trTag.data('student') : ", trTag.data("student"));
   return trTag;
}

// 검색버튼 누르면 검색 조건이랑 검색 입력값 가지고 다시 리스트 띄우기
let searchUI = $("#searchUI").on("click", "#searchBtn", function (event) {
   $(this).siblings(":input[name]").each(function (idx, input) {
      let iptName = input.name;
      let iptValue = $(input).val();
      searchForm.find(`[name=${iptName}]`).val(iptValue);
   })
   searchForm.submit();
})

// 체크 박스 구현
let cbxStuAll = $("#cbxStuAll").on("click", function () {
   // 만약 cbkStuAll이 checked true이면 cbkStu 모두 checked true
   // 아니면(false) cbkStu 모두 checked false

   $(this).prop("checked", (i, v) => {
      //          console.log("v:",v);
      $("[name=cbkStu]").prop("checked", v);
   })

})

// 몇 건(screenSize)씩 보일지 기능 구현
let screenSize = $("[name=screenSize]").on("change", function (event) {
   searchForm.find("[name=screenSize]").val(screenSize.val());
   searchForm.submit();
})

// 학생 상세 정보 모달
let stuModal = $("#stuModal");
let modalOpen = () => {
   stuModal.show();
   
}
let modalClose = () => {
   stuModal.hide();
}


let modalCont1 = $("#modalCont1");
let modalCont2 = $("#modalCont2");
// tr 태그 누르면 student view 보이는 기능 구현
let stdTr = $(document).on("click", ".stdTr", function () {
/*
   console.log("$(this).data() : ", $(this).data());
	
   // tr에 data-student 속성 값 꺼내기
   let student = $(this).data("student");
   console.log("student: ", student);
*/

	// ajax 한 명의 정보 가져와 모달에 넣기
	let memNo = $(this).data("student");
	fn_get_student(memNo);

	// 스크롤 맨 위로
  
   modalOpen();
});

// 학생 한 명의 정보 가져오기
let fn_get_student = (memNo) => {
	$.ajax({
		url: `${$.CPATH}/group/students/${memNo}`,
		method:"post",
		dataType: "json",
		success: function(resp){
			// 모달에 name 있는 input 값 다 비우기
		   let profileImg = $("#profileImgDiv");
		   profileImg.empty();
		   stuModal.find(":input[name]").val("");
			
			student = resp;
			
			// 새로 채우기
		   /*stuModal.find(":input[name]").each((idx, input)=>{
		      let inputval = student[`${input.name}`];
		      console.log("inputval: ", inputval); 
		      $(`[name="${input.name}"]`).val(inputval);
		      console.log("[name=${input.name}] : ", `"[name=${input.name}]"`); 
		   })*/
			
			$("[name=memNameModal]").val(student.memName);
			$("[name=colNameModal]").val(student.colName);
			$("[name=colNoModal]").val(student.colNo);
			$("[name=memNoModal]").val(student.memNo);
			$("[name=deptNameModal]").val(student.deptName);
			$("[name=deptNoModal]").val(student.deptNo);
			$("[name=memRrno1Modal]").val(student.memRrno1);
			$("[name=memGenderModal]").val(student.memGender);
			$("[name=stuYearModal]").val(student.stuYear);
			$("[name=memTelModal]").val(student.memTel);
			$("[name=commNameModal]").val(student.commName);
			$("[name=memEmailModal]").val(student.memEmail);
			$("[name=stuEdateModal]").val(student.stuEdate);
			$("[name=memZipModal]").val(student.memZip);
			$("[name=memAdd1Modal]").val(student.memAdd1);
			$("[name=memAdd2Modal]").val(student.memAdd2);
			$("[name=stuGdateModal]").val(student.stuGdate);
			
			// 프로필 사진
		   if(student.atchSaveName!=null){
		         profileImg.append(
		            $(`<img class="memPhotoModal" src="${$.CPATH }/resources/memberfiles/${student.atchSaveName}" alt="${student.atchOrginName }">`)
		         )

   			}else{
		         profileImg.append(
		            $(`<img class="memPhotoModal" src="${$.CPATH }/resources/img/noImage.png" alt="noImage">`)
		         )
	
			}

		}
	
	})
	
}

// 학생 정보 수정
$("#infoUpdateForm").on("submit", function(event){
   event.preventDefault();

	let memNo = $("[name=memNoModal]").val();
   
   let formData = new FormData();
   console.log("$(this) : ", $(this));

	/*
   $(this).find(":input[name]").each(function (i, v) {
      let name = v['name'];
      // console.log("name.slice(0,-5)", name.slice(0,-5));
     let propName = name.slice(0,-5);
     let propValue = $(v).val();
     //             console.log("student: ", student);
     formData.append(propName, propValue);
   });
	*/
    console.log("체킁:",$("[name=memPhotoFileModal]")[0].files);
	
	formData.append("memName", $("[name=memNameModal]").val());
	formData.append("colName", $("[name=colNameModal]").val());
	formData.append("memNo", $("[name=memNoModal]").val());
	formData.append("deptName", $("[name=deptNameModal]").val());
	formData.append("deptNo", $("[name=deptNoModal]").val());
	formData.append("memRrno1", $("[name=memRrno1Modal]").val());
	formData.append("memGender", $("[name=memGenderModal]").val());
	formData.append("stuYear", $("[name=stuYearModal]").val());
	formData.append("memTel", $("[name=memTelModal]").val());
	formData.append("commName", $("[name=commNameModal]").val());
	formData.append("memEmail", $("[name=memEmailModal]").val());
	formData.append("stuEdate", $("[name=stuEdateModal]").val());
	formData.append("memZip", $("[name=memZipModal]").val());
	formData.append("memAdd1", $("[name=memAdd1Modal]").val());
	formData.append("memAdd2", $("[name=memAdd2Modal]").val());
	formData.append("stuGdate", $("[name=stuGdateModal]").val());
	
	if($("[name=memPhotoFileModal]").val()){
		console.log("파일있음");
		formData.append("memPhotoFile",$("[name=memPhotoFileModal]")[0].files[0]);
	}

   console.log("data: ", formData);
   let url = this.action;
   
   $.ajax({
      url: url,
      method: "post",
      data: formData,
      processData: false,
      contentType: false,
      success: function(data){
      	Swal.fire({
		  position: 'center',
		  icon: 'success',
		  title: '수정되었습니다.',
		  showConfirmButton: false,
		  timer: 1500
		})

		// 모달 수정된 데이터로 다시 넣기
		fn_get_student(memNo);

      }
   })
   
   return false;

})


