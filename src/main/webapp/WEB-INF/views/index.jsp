<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<security:authentication property="principal.realUser" var="authMember" />
<link rel="stylesheet" href="${cPath}/resources/assets/vendors/fullcalendar/fullcalendar.css" type="text/css">
<%-- <link rel="stylesheet" href="${cPath}/resources/css/calendar/calendar.css" type="text/css"> --%>


<!-- <div class="main-back-space"> -->


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~그리드스택 툴 영역~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~도구~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div style="display: flex; padding-left:10px">
	<div>
		<a href="javascript:fn_GSTool()" class="btn btn-icon btn-dark btn-sm"> <ion-icon id="GSToolBtn" name="lock-closed-sharp" style="font-size: 200%;"></ion-icon>
		</a>
	</div>
	<!-- <div class="col" id="GSTool" style="display: none;"> -->
	<div class="col d-none" id="GSTool">
		<!-- 	<div id="trash" style="padding: 5px; margin-bottom: 15px;" class="text-center"> -->
		<!-- 		<div> -->
		<!-- 		</div> -->
		<!-- 	</div> -->
		<!--       <div class="newWidget grid-stack-item"> -->
		<!--         <div class="grid-stack-item-content" style="padding: 5px;" > -->
		<!--           <div class="text-center"> -->
		<!--             <ion-icon name="add-circle-sharp" style="font-size: 500%"></ion-icon> -->
		<!--           </div> -->
		<!--         </div> -->
		<!--       </div> -->
		<button id="trash" class="btn btn-icon btn-dark btn-sm">
			<ion-icon name="trash-outline" style="font-size: 200%;"></ion-icon>
		</button>
		<a href="javascript:fn_Newscore()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="trending-up-sharp" style="font-size: 200%;"></ion-icon>
		</a> <a href="javascript:fn_Newcalendar()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="calendar-number-sharp" style="font-size: 200%;"></ion-icon>
		</a> <a href="javascript:fn_NewtimePlan()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="time-sharp" style="font-size: 200%;"></ion-icon>
		</a> <a href="javascript:fn_Newnews()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="newspaper-sharp" style="font-size: 200%;"></ion-icon>
		</a> <a href="javascript:fn_Newgongji()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="alert-sharp" style="font-size: 200%;"></ion-icon>
		</a> <a href="javascript:fn_NewsikDan()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="restaurant-sharp" style="font-size: 200%;"></ion-icon>
		</a> <a href="javascript:fn_updateGrid()" class="btn btn-icon btn-dark btn-sm"> <ion-icon name="checkmark-circle-sharp" style="font-size: 200%;"></ion-icon>
		</a>
	</div>
</div>


<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~도구~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~그리드스택 툴 영역~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~그리드스택 메인 영역~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div class="col-sm-12">
	<div class="grid-stack" id="gridStackDiv"></div>
</div>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~그리드스택 메인 영역~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- </div> -->



<!-- ~~~~~~~~~~~~~~ cPath JS파일로 가져가기~~~~~~~~~~~~~~~ -->
<input type="hidden" id="cPath" value="${cPath}" />
<!-- ~~~~~~~~~~~~~~ AuthMember JS파일로 가져가기~~~~~~~~~~~~~~~ -->
<input type="hidden" id="memRole" value="${authMember.memRole}" />
<input type="hidden" id="memNo" value="${authMember.memNo}" />
<!-- ~~~~~~~~~~~~~~ JS파일 연결~~~~~~~~~~~~~~~ -->
<script src='${cPath }/resources/js/dist/index.global.js'></script>
<script src='${cPath }/resources/js/dist/ko.global.js'></script>
<script src="${cPath }/resources/js/main.js"></script>