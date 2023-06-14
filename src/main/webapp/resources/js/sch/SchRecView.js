// function changeState(){
// 	alert('버튼 반응');
// }

// var changeStateBtn=document.getElementById("changeState");
// changeStateBtn.addEventListener("click",changeState);

// $("#changeState").click(function(){
// 	let schRecNo = schrec.schRecNo;
// 	fn_detail(schRecNo);
// });

let detailView = $(".detailView");
let changeState =$("#changeState");
let urlsch = changeState.data("urlsch");
let detailViewDiv =$("#detailViewDiv");

$("#changeState").on("click",function(event) {
	event.preventDefault();
	let schrec =$(this).data("schRecNo");
	fn_detaul(schrec);
});

let fn_detaul = function(schrec) {
	let viewUrl = urlsch;
	let viewMethod ="POST";
	console.log("schrec=",schrec);

	$.ajax({
		url: viewUrl,
		method: viewMethod,
		dataType:"json",
		data:schrec,
		contentType:"application/json"
	}).done(function(resp,textStatus,jsXHR){
		console.log("schRecNo :"+resp.schRecState);
		let recState = resp.schRecState;
		detailView.empty();
		detailView.append(fn_makeTable(recState));
		if(detailViewDiv.css("display")!="none"){
			detailViewDiv.attr("style","display:none;")
		}else{
			detailViewDiv.attr("style","display:block;")
		}
	});
};


let i = 0;
let fn_makeTable = function(recState) {
    const style = {
        "font-size": "3px",
        "font-weight": "bold",
        "color": "blue"
    };

    let makeTr = $("<tr>").append(
        $("<th>").attr("colspan", "5").addClass(`schRecStateTd${i.index}`).attr(`data-schRecState${i.index}`, schrec.schRecState).append(
            $("<div>").addClass("card-header").append(
                $("<ul>").attr("id", "_dm-validWizardSteps").addClass("step-progress my-4").append(
                    $("<li>").addClass(`submit${i.index}`).append(
                        $("<span>").addClass("step-label").text("확인대기").css("background-color", commName === "확인대기" ? "lightgreen" : "")
                    ),
                    $("<li>").addClass(`submit${i.index}`).append(
                        $("<span>").addClass("step-label").text("확인완료").css("background-color", commName === "확인완료" ? "lightgreen" : "")
                    ),
                    $("<li>").addClass(`submit${i.index}`).append(
                        $("<span>").addClass("step-label").text("접수처리").css("background-color", commName === "접수처리" ? "lightgreen" : "")
                    ),
                    $("<li>").addClass(`submit${i.index}`).append(
                        $("<span>").addClass("step-label").text("처리완료").css("background-color", commName === "처리완료" ? "lightgreen" : "")
                    ),
                )
            )
        )
    );
	 
		
		if (recState === "M001") {
		    makeTr.find(`.submit${i.index}`).css(style);
		} else if (recState === "M002") {
		    makeTr.find(`.wait${i.index}`).addClass("active").css(style);
		} else if (recState === "M003") {
		    makeTr.find(`.complete${i.index}`).addClass("active").css(style);
		} else if (recState === "M004") {
		    makeTr.find(`.approval${i.index}`).addClass("active").css(style);
		}
	return makeTr;
}

	