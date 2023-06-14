let aaState = [];
let aaFile = []; 

let i = 0;
while(true){
	if(($(".aaStateTd"+i).data("aastate"+i))==null){
		break;
	}
	aaState.push($(".aaStateTd"+i).data("aastate"+i));
	aaFile.push($(".aaStateTd"+i).data("aafile"+i));
	
	if(aaFile[i] != 0){
		if(aaState[i] == "B001"){
			$(".wait"+i).addClass("active");
		} else if(aaState[i] == "B003"){
			$(".approval"+i).addClass("active").html("반려");
		} else if(aaState[i] == "B002"){
			$(".approval"+i).addClass("active").html("승인");
		}
	}else{
		if(aaState[i] == "B003"){
			$(".approval"+i).addClass("active").html("반려");
		}else {
			$(".submit"+i).addClass("active");
		}
	}
	
	i++; 
}
console.log(aaState);
console.log(aaFile);
