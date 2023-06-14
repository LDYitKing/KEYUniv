<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1">
    <tiles:insertAttribute name="preScript" />
    <title>Login Page</title>
    <c:if test="${not empty message }">
        <script type="text/javascript">
            window.addEventListener("DOMContentLoaded", function(event) {
            Swal.fire({
                icon : 'error',
                title : 'Oops...',
                text : '${message}'
            });
            });
        </script>
    </c:if>
    <link rel="stylesheet" href="${cPath }/resources/css/login.css" type="text/css">
</head>
<body class="login">
    <!-- PAGE CONTAINER -->
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
    <div id="root" class="loginBackImgDiv root front-container">
        <!-- CONTENTS -->
        <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
        <section id="content" class="content">
            <div class="bigfont content__boxed w-100 min-vh-100 d-flex flex-column align-items-center justify-content-center">
                <div id="loginDiv" class="content__wrap">
                    <!-- Login card -->
                        <div id="loginImgDiv" class="card justify-content-center">
                        <br><br>
                        <h1 class="loginFont loginFontTitle" style="font-size:80px; margin-top:20px;">K E Y</h1>
                        <h2 class="loginFont" style="font-size:40px;">UNIVERSITY</h2><br>
                        <h2 class="loginFont" style="font-size:30px;">통합학사시스템</h2>
                        </div>
                    <div class="card shadow-lg px-4">
                        <div class="card-body">
                            <div class="text-center">
                                <h2 class="fs-2">LOGIN</h2>
                            </div>

                            <form id="loginForm" class="mt-4" method="post">
                        <security:csrfInput/>
                                <div class="d-flex align-items-center justify-content-between border-top pt-3 mt-3 ">
                                	<select name="roleSelect">
					                     <option value>로그인 계정 선택</option>
					                     <option value="220201021">재학생</option>
					                     <option value="0201001">교수</option>
					                     <option value="8888001">교직원</option>
					                  </select>
                                </div>
                                <br><br>
                        
                                <div class="mb-3">
                                    <input id="memNoInput" name="memNo" type="text" class="form-control" placeholder="아이디(학번/사번)" required autofocus>
                                </div>

                                <div class="mb-3">
                                    <input id="memPassInput" name="memPass" type="password" class="form-control" placeholder="비밀번호" required>
                                </div>

                                <div class="form-check">
                                    <input id="loginCheck" class="form-check-input" type="checkbox">
                                    <label for="_dm-loginCheck" class="form-check-label">
                                        아이디 저장
                                    </label>
                                </div>

                                <div class="d-grid mt-5">
                                    <button class="btn btn-primary btn-lg" type="submit">로그인</button>
                                </div>
                            </form>

                            <div class="d-flex justify-content-between mt-4">
                                <a href="#" class="btn-link text-decoration-none" data-bs-toggle="modal" data-bs-target="#searchIdModal">아이디 찾기</a>
                                <a href="#" class="btn-link text-decoration-none" data-bs-toggle="modal" data-bs-target="#searchPasswdModal">임시비밀번호 발송</a>
                            </div>
                            <div class="d-flex justify-content-center mt-4">
                                <img src="${cPath}/resources/assets/img/keyUniv_realLogo.png" alt="Nifty Logo" class="Nifty logo" width="90" height="45"><br>
                            </div>

                        </div>
                    </div>
                    <!-- END : Login card -->

                </div>
            </div>
        </section>

        <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
        <!-- END - CONTENTS -->
    </div>
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
    <!-- END - PAGE CONTAINER -->
    
    <!-- Search Id Modal -->
    <div class="modal fade" id="searchIdModal" tabindex="-1" aria-labelledby="searchIdLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="searchIdLabel">아이디 찾기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body d-flex flex-column align-items-center justify-content-center">
                <div id="searchIdInfoDiv">
                    <span>이름과 생년월일을 입력해주세요.<br>초기 비밀번호는 생년월일 6자리입니다.</span>
                    <br><br>
                </div>
                <div class="content p-3" id="searchIdFormDiv">
                    <form name="searchIdForm">
                       <div class="mt-2">
                           <input class="form-check-input" type="radio" name="memRole" value="ROLE_STU" checked><label class="form-check-label">학생</label>&nbsp;&nbsp;&nbsp;
                           <input class="form-check-input" type="radio" name="memRole" value="ROLE_PRO"><label class="form-check-label">교수</label>&nbsp;&nbsp;&nbsp;
                           <input class="form-check-input" type="radio" name="memRole" value="ROLE_EMP"><label class="form-check-label">교직원</label><br><br>
                       </div>
                       <div class="col-12 mt-2">
                     <label class="form-label">이름</label>
                     <input class="form-control" type="text" name="memName" placeholder="이름" autofocus="autofocus">
                  </div>
                       <div class="col-12 mt-2">
                     <label class="form-label">생년월일(6자리)</label>
                     <input class="form-control" type="text" name="memRrno1" placeholder="(예시:980102)">
                  </div>
                  <div class="justify-content-center mt-2">
                           <input id="searchIdBtn" class="btn btn-secondary" type="submit" value="검색하기">
                  </div>
                    </form>

                </div>
                <div id="searchIdTableArea" class="w-100 mt-4">
            </div>
            <div class="modal-footer justify-content-center">

                </div>
            </div>
            </div>
        </div>
    </div>
    <!-- End Search Id Modal -->

    <!-- Search Passwd Modal -->
    <div class="modal fade" id="searchPasswdModal" tabindex="-1" aria-labelledby="searchPasswdLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="searchPasswdLabel">임시 비밀번호 전송</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body  d-flex flex-column justify-content-center">
                <div class="searchPasswdInfoDiv1">
                    <span>등록된 이메일 주소로 임시 비밀번호를 알려드립니다.<br>로그인 후 비밀번호를 꼭 변경해주세요.</span><br>
                    <span>초기 비밀번호는 생년월일 6자리입니다.</span>
                    <br><br>
                </div>
                <div class="content p-3" id="searchPasswdFormDiv">
                    <form name="searchPasswdForm">
                       <div class="col-12 mt-2">
                     <label class="form-label">아이디</label>
                     <input class="form-control" type="text" name="memNo" placeholder="아이디" autofocus="autofocus">
                  </div>
                       <div class="col-12 mt-2">
                     <label class="form-label">이메일</label>
                     <input class="form-control" type="text" name="memEmail" placeholder="이메일"><br>
                     <span id="searchPasswdError" class="text-danger"></span>
                  </div>
                  <div class="mt-2">
                      <input type="submit" class="btn btn-secondary" value="임시 비밀번호 전송">
                  </div>
                    </form>
                    
                </div>
                <br>
                <div class="searchPasswdInfoDiv2">
                    <span style="font-weight: bold;">-이메일 변경 안내</span><br>
                    <span> 학생:학사지원팀(042-000-0000)<br> 교수/교직원:정보전산원(042-000-0001)<br></span>

                </div>
            </div>
            <div class="modal-footer justify-content-center">
                <span>비밀번호가 기억났습니다! <a data-bs-dismiss="modal" aria-label="Close" class="btn-link text-decoration-none">로그인 하기</a></span>
            </div>
            </div>
        </div>
    </div>
    <!-- End Search Passwd Modal -->
<script src="${cPath }/resources/js/login.js"></script>
<script type="text/javascript">
	let roleSelect = $("[name=roleSelect]").on("change", function(event) {
        console.log($(this).val());
		let id = $(this).val();
		
		$("#memPassInput").val("asdf!123");
		if(id=='230201001'){
			$("#memPassInput").val("111111");
		}
        memNoInput.val(id);
	});
</script>
<tiles:insertAttribute name="postScript" />
</body>
</html>