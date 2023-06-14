<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class=" w-100 min-vh-100 d-flex flex-column align-items-center">
		<div class="card shadow-lg">
			<div class="card-body">
				<div class="text-center">
					<h1 class="h3">비밀번호 변경</h1>
				</div>
				<form id="passwdForm" class="mt-4" method="post" action="${cPath }/member/changePasswd.do">
				<security:csrfInput/>
					<div class="mb-4">
						<p class="fw-bold">현재 비밀번호</p>
						<input type="text" name="checkMemPass" class="form-control" placeholder=""
							autofocus>
						<span id="nowPassError" class="text-danger">${msg }</span>
					</div>
					<div class="mb-4">
						<p><span class="fw-bold">새 비밀번호</span><br>
						( 비밀번호는 8~20자리의 영문 대/소문자, 숫자, 특수문자를 조합하여 사용하실 수 있습니다. )</p>
						<input type="text" name="memPass" class="form-control" placeholder="">
						<span id="newPassError"  class="text-danger"></span>
					</div>
					<div class="mb-4">
						<p class="fw-bold">새 비밀번호 확인</p>
						<input type="text" name="reMemPass" class="form-control" placeholder="">
						<span id="rePassError"  class="text-danger"></span>
					</div>
					<div class="d-grid mt-5">
						<input id="passwdFormBtn" type="button" class="btn btn-info btn-lg" value="수정">
					</div>
				</form>
			</div>
		</div>
</div>
<script>
	let nowPassError = $("#nowPassError");
	let newPassError = $("#newPassError");
	let rePassError = $("#rePassError");
	
	let passwdForm = $("#passwdForm").on("click", "#passwdFormBtn", function(event){
		
		nowPassError.empty();
		newPassError.empty();
		rePassError.empty();
		
		if(!$("[name=checkMemPass]").val().trim()){
			nowPassError.html("현재 비밀번호를 입력해주세요.");
	      return;
	   }		
		if(!$("[name=memPass]").val().trim()){
			newPassError.html("새 비밀번호를 입력해주세요.");
	      return;
	   }	
		
		let pass_rule = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
		if(!pass_rule.test($("[name=memPass]").val())){
			newPassError.html("비밀번호 형식에 맞지 않습니다. 다시 입력해주세요.");
			return false;
		}
		
// 		console.log("remempass val",$("[name=reMemPass]").val());
// 		console.log("mempass val",$("[name=memPass]").val());
// 		console.log($("[name=reMemPass]").val() != $("[name=memPass]").val());
		if(!$("[name=reMemPass]").val().trim() ||
				$("[name=reMemPass]").val() != $("[name=memPass]").val()
		){
			rePassError.html("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
	      return;
	   }	
		
		passwdForm.submit();		
	})
</script>


