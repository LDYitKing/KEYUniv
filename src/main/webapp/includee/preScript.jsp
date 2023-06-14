<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- STYLESHEETS -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--- -->

<!-- Fonts [ OPTIONAL ] -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&family=Ubuntu:wght@400;500;700&display=swap" rel="stylesheet">

<!-- Bootstrap CSS [ REQUIRED ] -->
<link rel="stylesheet" href="${cPath}/resources/assets/css/bootstrap.css">

<!-- Nifty CSS [ REQUIRED ] -->
<link rel="stylesheet" href="${cPath}/resources/assets/css/nifty.css">

<!-- Premium line icons [ OPTIONAL ] -->
<link rel="stylesheet" href="${cPath}/resources/assets/premium/icon-sets/icons/line-icons/premium-line-icons.min.css">

<!-- Premium solid icons [ OPTIONAL ] -->
<link rel="stylesheet" href="${cPath}/resources/assets/premium/icon-sets/icons/solid-icons/premium-solid-icons.min.css">

<!-- Zangdar Style [ OPTIONAL ] -->
<link rel="stylesheet" href="${cPath}/resources/assets/vendors/zangdar/zangdar.min.css">

<!-- Bootstrap 5 tags [ OPTIONAL ] -->
<link rel="stylesheet" href="${cPath}/resources/assets/vendors/bootstrap5-tags/bootstrap5-tags.min.css">
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--- -->


<script type="text/javascript" src="${cPath}/resources/js/sweetalert2/sweetalert2.all.min.js"></script>
<link rel="stylesheet" href="${cPath}/resources/js/sweetalert2/sweetalert2.min.css">
<script type="text/javascript" src="${cPath}/resources/js/jquery-3.6.3.min.js"></script>
<script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script>
<script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script><!-- AGGRID -->
<!-- ~~~~~~~~~~~~~~~~~그리드 스택~~~~~~~~~~~~~~~~~ -->
  <!-- GridStack.js 와 관련된 CSS와 JS 라이브러리를 추가합니다. -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/7.2.3/gridstack.min.css" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/7.2.3/gridstack-all.js"></script>

  <!-- ionicons 아이콘 라이브러리를 추가합니다. -->
  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<!-- ~~~~~~~~~~~~~~~~~그리드 스택~~~~~~~~~~~~~~~~~ -->
<script src="${cPath }/resources/js/ckeditor/ckeditor.js"></script>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~캘린더~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- <script	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script> -->
<!-- <script	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/main.min.css" /> -->
<!-- <script	src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.0/locales/ko.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~캘린더~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~C3 차트~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.15/c3.min.css">
 <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.15.0/d3.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.7.15/c3.min.js"></script>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~C3 차트~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<script>
	let paramName = $("meta[name='_csrf_parameter']").attr("content") // 동기로 보낼때 B
	let headerName = $("meta[name='_csrf_header']").attr("content"); //Ajex로 헤더에 넣어 보낼때 A
	let headerValue = $("meta[name='_csrf']").attr("content"); // A , B

	let headers = {}
	headers[headerName] = headerValue;
	$.ajaxSetup({
	   headers:headers
	})
	$.CPATH = "${cPath}";
	$(document).ajaxError(function(event, jqXHR, settings, error) {
		console.log(`비동기 요청[\${settings.url}, \${settings.type}] 실패, 상태코드 : \${jqXHR.status}, 에러메시지 : \${error}`);
	});
</script>