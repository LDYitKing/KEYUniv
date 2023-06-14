<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1">
<security:csrfMetaTags />
<title><tiles:getAsString name="title" /></title>
<tiles:insertAttribute name="preScript" />
<link rel="shortcut icon" href="${cPath}/resources/img/favicon.ico">
<c:if test="${not empty message }">
	<script type="text/javascript">
		window.addEventListener("DOMContentLoaded", function(event) {
			Swal.fire({
				icon : '${messageIcon}',
				title : '${message}'
			// 				text : '${message}'
			});
		});
	</script>
</c:if>

<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~---

    [ REQUIRED ]
    You must include this category in your project.


    [ OPTIONAL ]
    This is an optional plugin. You may choose to include it in your project.


    [ DEMO ]
    Used for demonstration purposes only. This category should NOT be included in your project.


    [ SAMPLE ]
    Here's a sample script that explains how to initialize plugins and/or components: This category should NOT be included in your project.


    Detailed information and more samples can be found in the documentation.

    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~--- -->
</head>

<body class="jumping">
	<!-- 챗봇페이지 -->
	<script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
	<df-messenger chat-title="KEYUniversity" agent-id="421d58a9-74cb-4887-8a43-86a1ce7a4b81" language-code="ko"></df-messenger>
	<!-- PAGE CONTAINER -->
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

	<!-- 모달 모음 jsp -->
	<jsp:include page="modal.jsp" />
	<!-- 모달 모음 jsp 끝 -->

	<div id="root" class="root mn--max hd--expanded">

		<!-- CONTENTS -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<section id="content" class="content">
			<!-- ~~~~~~~~~상단~~~~~~~~~ -->
			<div class="content__header content__boxed overlapping">
				<div class="content__wrap">

					<!-- Breadcrumb -->
					<!--                     <nav aria-label="breadcrumb"> -->
					<!--                         <ol class="breadcrumb mb-0"> -->
					<!--                             <li class="breadcrumb-item"><a href="./index.jsp">Home</a></li> -->
					<!--                             <li class="breadcrumb-item active" aria-current="page">Max Navigation</li> -->
					<!--                         </ol> -->
					<!--                     </nav> -->
					<!-- END : Breadcrumb -->

					<!--                     <h1 class="page-title mb-0 mt-2">Max Navigation</h1> -->

					<p class="lead"></p>

				</div>

			</div>
			<!-- ~~~~~~~~~하단~~~~~~~~~ -->


			<div class="content__boxed">
				<div class="content__wrap">
					<tiles:insertAttribute name="body" />
				</div>
			</div>
			<!-- FOOTER -->
			<footer class="mt-auto">
				<tiles:insertAttribute name="footer" />
			</footer>
			<!-- END - FOOTER -->

		</section>

		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- END - CONTENTS -->

		<!-- HEADER -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<header class="header">
			<tiles:insertAttribute name="header" />
		</header>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- END - HEADER -->

		<!-- MAIN NAVIGATION -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<nav id="mainnav-container" class="mainnav">
			<tiles:insertAttribute name="mainnav" />
		</nav>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- END - MAIN NAVIGATION -->

		<!-- SIDEBAR -->
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<aside class="sidebar">
			<tiles:insertAttribute name="sideBar" />
		</aside>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- END - SIDEBAR -->

	</div>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- END - PAGE CONTAINER -->

	<!-- SCROLL TO TOP BUTTON -->
	<div class="scroll-container">
		<a href="#root" class="scroll-page rounded-circle ratio ratio-1x1" aria-label="Scroll button"></a>
	</div>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- END - SCROLL TO TOP BUTTON -->

	<tiles:insertAttribute name="postScript" />




</body>

</html>