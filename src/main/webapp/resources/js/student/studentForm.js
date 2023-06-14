/**
 * 
 */
  var stuNo = "";
  // 단과대 선택하면 그 단과대에 맞는 학과명만 보이게 하기
  let deptNo = $("[name=deptNo]");
  let colNo = $("[name=colNo]").on("change", function(event) {
	deptNo.val("");
	deptNo.prop('disabled', false);
	
	let col = $(this).val();
	console.log(col);
	deptNo.find("option").not(":first").hide();
  deptNo.find("option").filter(`.${col}`).show();
})

  let insertFormArea = $("#insertFormArea");
  let displayDiv = $("#displayDiv");
  var addCnt = 0; // 몇 명 추가할 건지 선택한 값

  // 몇 명 추가할건지 선택하고 추가 누르면 그 개수 만큼 tabele에 tr 태그를 만들어주기
  let deptErrorSpan = $("#deptErrorSpan");
  let addErrorSpan = $("#addErrorSpan");

  let addFormBtn = $("#addFormBtn").on("click", function (event) {
	  
    if(deptNo.val()=='' || colNo.val()==''){
      deptErrorSpan.text("단과대학/학과를 선택해주세요.");
      return;
    }else{
      deptErrorSpan.empty();
    }
    addCnt = $("[name=addCnt]").val();
    
    if(addCnt==''||addCnt<=0){
      addErrorSpan.text("학생 수를 입력해주세요.");
      return;
    }else{
      addErrorSpan.empty();
    }
	  
    insertFormArea.empty();
    $("#insertFormBtn").show();
    displayDiv.show();
    
	 $.ajax({   			
		 method: 'get',
		 url: `${$.CPATH}/group/studentNo`,
		 data: {"ayYear" : $("[name=ayYear]").val() ,"deptNo" : $("[name=deptNo]").val()},
		 dataType:"text",
		 contentType: "application/json; charset=UTF-8",
		 success: function(data) {					
//           		console.log("성공", data);
          		stuNo = data;
		}		
	});

    console.log("addCnt: ", addCnt);
    let trTags = [];
    for (var i = 0; i < addCnt; i++) {
      // console.log("tr" + i);
      trTags.push(fn_makeTr(`${i}`, stuNo));
    }

    insertFormArea.append(trTags);
  });

  stuYearFormat = "<select name='stuYear'><option value='1' selected>신입생</option><option value='3'>편입생</option></select>"; 
  let fn_makeTr = (i, stuNo) => {
  memGenderFormat= `<input type='radio' name='memGender${i}' value='M' checked>남<input type='radio' name='memGender${i}' value='W'>여`;
    // tr 태그 만들어서 td 태그들을 append
    // return tr태그 (data속성에 student객체 넣어줌)

/*      
    let trTag = $("<tr>").append(
        $("<td>").html(stuYearFormat)
        , $("<td>").html("<input type='text' name='memName' placeholder='이름' required>")
        , $("<td>").html(memGenderFormat)
        , $("<td>").html("<input type='text' name='memRrno1' placeholder='주민등록번호 앞자리' required>-<input type='text' name='memRrno2' placeholder='주민등록번호 뒷자리' required>")
        , $("<td>").html("<input type='text' name='memTel' placeholder='예)010-0000-0000' required>")
        , $("<td>").html("<input type='text' name='memZip' placeholder='우편번호' required>")
        , $("<td>").html("<input type='text' name='memAdd1' placeholder='주소' required>")
        , $("<td>").html("<input type='text' name='memAdd2' placeholder='상세주소' required>")
        , $("<td>").html("<input type='text' name='memEmail' placeholder='예)aa123@naver.com' required>")
        , $("<td>").html("<input type='file' accept='image/*'' name='memPhotoFile' required>")
      ).addClass("tr" + i);
*/

    let trTag = $("<tr>").append(
        $("<td>").html(stuYearFormat)
        , $("<td>").html("<input type='text' name='memName' placeholder='이름' required>")
        , $("<td>").html(memGenderFormat)
        , $("<td>").html("<input type='text' name='memRrno1' placeholder='주민등록번호 앞자리' required>-<input type='text' name='memRrno2' placeholder='주민등록번호 뒷자리' required>")
        , $("<td>").html("<input type='text' name='memTel' placeholder='예)010-0000-0000' required>")
        , $("<td>").html("<input type='text' name='memZip' placeholder='우편번호' required>")
        , $("<td>").html("<input type='text' name='memAdd1' placeholder='주소' required>")
        , $("<td>").html("<input type='text' name='memAdd2' placeholder='상세주소' required>")
        , $("<td>").html("<input type='text' name='memEmail' placeholder='예)aa123@naver.com' required>")
        , $("<td>").html("<input type='file'  accept='image/*'' name='memPhotoFile' required>")
      ).addClass("tr" + i);

    return trTag;
  };

// enter누를 때 submit 막기
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
  // 등록 버튼을 누르면 비동기로 한 명 씩 학생을 insert 해준다
  let insertForm = $("#insertForm").on("submit", function (event) {
    event.preventDefault();

/*   if(!$("[name=postTitle]").val().trim()){
        Swal.fire({
            icon: 'fail',
            title: '제목을 입력해주세요.',
            text: "바보얌 제목이 없엉",
        });
      return;
   }*/

/*-----------------------------------------------------------------
성별 체크 여부 확인 방법 모르겠다

	 let radios = $(this).find(":radio[value='M']");
	console.log("", this);
	console.log("radios : ", radios);
	 for(let i = 0; i < radios.length; i++) {
	   var $this = $(radios[i]);
	   if(!$this.is(":checked")) {  //동의함에 선택되어있지 않다면
	     alert('반드시 동의해야 합니다.');
	     $this.focus();
	     return;
	   }
	 }


	  if(!$(`[name=memGender${i}]:checked`).val()){
        Swal.fire({
            text: "성별을 선택하세요."
        });
      return;
	}
----------------------------------------------------------------*/
	
    // var formdata = new FormData();

    // console.log("체킁:",$("[name*=memPhotoFile]"));
    // console.log("체킁:",$("[name*=memPhotoFile]").eq(0));
    // console.log("체킁:",$("[name*=memPhotoFile]").eq(1));
    // console.log("체킁:",$("[name*=memPhotoFile]")[0].files);
    // console.log("체킁:",$("[name*=memPhotoFile]")[1].files);
    

    // development(1) -> 건들기 쉽게 , stage(2) - 디버깅->리팩토링  ,production(3)
    
    //let data = [];
    for (let i = 0; i < addCnt; i++) {
      // let student = {};
      // console.log($(`.tr\${i}`));
      
      // input 값을 formData에 담기 (ajax의 data)
      let formData = new FormData();  
      formData.append("ayYear", $("[name=ayYear]").val()); // ayYear
      formData.append("deptNo", deptNo.val()); // deptNo
      formData.append("colNo", colNo.val()); // colNo 
      formData.append("stuYear",$("[name=stuYear]").val()); // stuState 학적변동
      
      formData.append("memNo",parseInt(stuNo)+i);
      formData.append("stuNo",parseInt(stuNo)+i);

      formData.append("memName",$("[name=memName]").eq(i).val());
      formData.append("memGender",$(`[name=memGender${i}]:checked`).val());
      formData.append("memRrno1",$("[name=memRrno1]").eq(i).val());
      formData.append("memRrno2",$("[name=memRrno2]").eq(i).val());
      formData.append("memTel",$("[name=memTel]").eq(i).val());
      formData.append("memZip",$("[name=memZip]").eq(i).val());
      formData.append("memAdd1",$("[name=memAdd1]").eq(i).val());
      formData.append("memAdd2",$("[name=memAdd2]").eq(i).val());
      formData.append("memEmail",$("[name=memEmail]").eq(i).val());
      formData.append("memPhotoFile",$("[name=memPhotoFile]")[i].files[0]);
      

      /*
      $(`.tr\${i}`)
        .find(":input[name]")
        .each(function (i, v) {
          let propName = v.name;
          let propValue = $(v).val();
          //             console.log("student: ", student);
          student[propName] = propValue;
          formData.append(v.name,$(v).val());
        });
      */
      console.log("data: ", formData);
      let url = this.action;

      $.ajax({
        url: url,
        method: "post",
        processData: false,
        contentType: false,
        data: formData,
        //         dataType:"json",
        //         contentType:"multipart/form-data"
      }).done(function (resp) {
        // 결과 resp는 FAIL, OK 받기
        if(resp=='FAIL'){
          console.log("실패");
          return;
        }
        
        // resp가 OK
    	  // insert 성공한 tr ( $(`.tr\${i}`) ) 삭제
		console.log("성공");
        
		displayDiv.find(":input[name]").prop('disabled', true);
        $("#insertFormBtn").hide();
        // resp가 FAIL
        // 실패했으면 ... 에러 어떻게 보여주지

      }).fail(function(){
      });

      // data.push(student);
    }
	
	Swal.fire({
		  position: 'center',
		  icon: 'success',
		  title: '등록되었습니다.',
		  showConfirmButton: false,
		  timer: 1500
	})

    //     data = JSON.stringify(data);
    //     console.log("JSON.stringify(data): ", data);

    return false;
  });

// 자동완성
const nameArr = ["김철수","나영희","도서희", "신인정", "양승호", "이은혁", "정지은", "홍연진"];
 let autoInput = $("#autoInput").on("click", function(event){
		for(let i=0; i<addCnt; i++){
			console.log("i", i);
			 $("[name=memName]").eq(i).val(nameArr[i%8]);
		}
			 $(`.tr0`).find("[name=memRrno1]").val("040512");
			 $(`.tr1`).find("[name=memRrno1]").val("041123");
			 $(`.tr0`).find("[name=memRrno2]").val("3419645");
			 $(`.tr1`).find("[name=memRrno2]").val("3912061");
			 $(`.tr0`).find("[name=memTel]").val("010-6593-0172");
			 $(`.tr1`).find("[name=memTel]").val("010-5981-1298");
			 $(`.tr0`).find("[name=memZip]").val("23452");
			 $(`.tr1`).find("[name=memZip]").val("98231");
			 $(`.tr0`).find("[name=memAdd1]").val("대전시 중구 오류동");
			 $(`.tr1`).find("[name=memAdd1]").val("대전시 유성구 덕명동");
			 $(`.tr0`).find("[name=memAdd2]").val("도시빌라");
			 $(`.tr1`).find("[name=memAdd2]").val("유성아파트");
			 $(`.tr0`).find("[name=memEmail]").val("asdf98@naver.com");
			 $(`.tr1`).find("[name=memEmail]").val("lo2hj@naver.com");
		 
 })
