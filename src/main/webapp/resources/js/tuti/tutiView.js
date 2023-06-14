let attendModal = $("#PaymentModal");
	let modalOpen = () => {
		attendModal.show();
	}
	let modalClose = () => {
		attendModal.hide();
	}
	$(document).ready(function() {
		
		let refuseOpt = $(".PaymentModal").on("change", function(){
			console.log(this.value);
			if(this.value !="D001"){
				$(this).closest("form").find("#refuseReason").css("display", "inline-block")
			}else {
				$(this).closest("form").find("#refuseReason").css("display", "none")
			}
		
		})
	});