var stuNo = "";
  // 단과대 선택하면 그 단과대에 맞는 학과명만 보이게 하기
  let deptNo = $("[name=deptNo]");
  let colNo = $("[name=colNo]").on("change", function(event) {
	deptNo.val("");
	deptNo.prop('disabled', false);
	
	let col = $(this).val();
	console.log(col);
	deptNo.find("option").not(":first").hide();
    deptNo.find("option").filter(`.${col}` ).show(); 
    
   deptNo.on("change", function(event2) {
   let stuNo = $("[name=stuNo]");
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
  

  