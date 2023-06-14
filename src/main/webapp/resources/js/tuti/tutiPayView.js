let detailView = $(".detailView");
let changeState =$("#changeState");
let urlsch = changeState.data("urlsch");

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
		detailView.show();
	});
};

let fn_makeTable = function(recState) {
	
	 let makeTr = $("<tr>").append(
					$("<th>").html("상태")
					, $("<td>").html(`${recState}`)
	)
	return makeTr;
	}
