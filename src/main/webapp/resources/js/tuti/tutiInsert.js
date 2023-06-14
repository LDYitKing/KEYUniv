var stuNo = "";
  // 단과대 선택하면 그 단과대에 맞는 학과명만 보이게 하기
  let deptNo = $("[name=tuitionDept]");
  let colNo = $("[name=tuitionCol]").on("change", function(event) {
	deptNo.val("");
	deptNo.prop('disabled', false);

	let col = $(this).val();
	console.log(col);
	deptNo.find("option").not(":first").hide();
    deptNo.find("option").filter(`.${col}` ).show();

   deptNo.on("change", function(event2) {
   let stuNo = $("[name=tuitionName]");
   stuNo.val("");
   stuNo.prop('disabled', false);

   let dept=$(this).val();
   console.log(dept);
   stuNo.find("option").not(":first").hide();
   stuNo.find("option").filter(`.${dept}`).show();

	  })
  })

$("[name=schNo]").on("change", function () {
   let sch=$(this).val();
   console.log(sch)

  let selectedScholarshipAmount = $(this).find("option:selected").data("amount");
  $("#scholarshipAmountInput").val(selectedScholarshipAmount);

  let selectedScholarshipCont = $(this).find("option:selected").data("cont");
  $("#scholarshipContInput").val(selectedScholarshipCont);

});

$("[name=tuitionName]").on("change", function () {
   let sch=$(this).val();
   console.log(sch)

  let scholarshipEmail = $(this).find("option:selected").data("email");
  $("#scholarshipEmail").val(scholarshipEmail);

  let scholarshipPhonecall = $(this).find("option:selected").data("tel");
  $("#scholarshipPhonecall").val(scholarshipPhonecall);

 let scholarshipStuNo = $(this).find("option:selected").data("stuno");
  $("#scholarshipStuNo").val(scholarshipStuNo);

	let scholarshipName = $(this).find("option:selected").data("name");
  $("#scholarshipName").val(scholarshipName);

});


let wnd = $("#scholarshipAllAmount");
let gkq = $("#scholarshipAmountInput");
let chd =$("#scholarshipAmount")
wnd.on('keyup',()=>{
      let result = parseInt(wnd.val()) - parseInt(gkq.val());
      let parResult = parseInt(result);
      if( parResult >= 0){
         chd.val(parResult);
      }else{
         chd.val("등록금액이 맞지 않습니다.");
      }
   })