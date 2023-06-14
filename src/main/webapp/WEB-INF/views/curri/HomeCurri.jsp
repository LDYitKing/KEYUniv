<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<security:authentication property="principal.realUser" var="authMember"/>
<style>
	.everyCurriTitle{
		text-decoration: none;
		letter-spacing: 5pt;
		padding-bottom: 20px; /* 요소 내부 아래에 20px의 공간을 추가합니다 */
	}
	.widgetDiv *{
		cursor: pointer;
	}
	.widgetDiv{
		box-shadow: 0px 4px #74a3b0;
		height: 130px;
	}
	.widgetDiv:active{
		top: 4px; 
		box-shadow: 0 0 #74a3b0; 
	}
</style>

<nav aria-label="breadcrumb">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item"><a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">홈</li>
	</ol>
</nav>
<div id="searchUI" class="m-2 pb-3 row justify-content-center">
	<div>
		<h3 class="page-title d-flex flex-wrap just justify-content-center mb-3 mt-2">
			<a class="link-light everyCurriTitle fw-bold" href="${cPath}/curri">자기주도적 미래설계</a>
		</h3>
	</div>
</div>
<div>
	<div class="row justify-content-md-center m-3 mt-4">
		<div class="col-3">
			<div class="card bg-info text-white mb-3 widgetDiv" onclick="location.href='${cPath}/subjectRenewal/RenewalUI.do'">
				<div class="p-3 text-center">
					<p class="lead fw-bold fs-4 mb-3">교과 발전</p>
					<p>자신이 수강한 교과목에 대한 직업별 강점을 확인하고, 원하는 교과목을 즐겨찾기 할 수 있는 페이지입니다.</p>
					<i class="demo-psi-coding text-white text-opacity-50 fs-5"></i>
				</div>
			</div>
		</div>
		<div class="col-3">
			<div class="card bg-info text-white mb-3 widgetDiv" onclick="location.href='${cPath}/curri/myCurri.do'">
				<div class="p-3 text-center">
					<p class="lead fw-bold fs-4 mb-3">나의 커리</p>
					<p>나의 커리는 커리큘럼의 줄임말로, 나의 4년간의 커리큘럼을 미리 짜보는 시스템입니다. </p>
					<i class="demo-psi-coding text-white text-opacity-50 fs-5"></i>
				</div>
			</div>
		</div>
		<div class="col-3">
			<div class="card bg-info text-white mb-3 widgetDiv" onclick="location.href='${cPath}/curri/everyCurri'">
				<div class="p-3 text-center">
					<p class="lead fw-bold fs-4 mb-3">모두의 커리</p>
					<p>모두의 커리는 KEY대학교 학생들의 원만한 학교 생활을 위해 정보를 공유하고 소통하는 게시판입니다.</p>
					<i class="demo-psi-coding text-white text-opacity-50 fs-5"></i>
				</div>
			</div>
		</div>
	</div>	
</div>

<div class="col-md-12 mb-3">
	<div style="display: grid; grid-template-columns: 2fr 1fr; grid-gap: 10px;">
	<div class="card m-0 p-3" style="grid-column: 1;">
		<div style="text-align: center;">
			<p class="lead fw-bold fs-3 mb-3">취업 현황</p>
			<p class="fs-5 text-start mx-3">( 지난 5년간 취업률 추이 )</p>
			<div class="mt-2" id="chart" style="width: 100%;"></div>
		</div>
	</div>
	<div class="card m-0 p-3" id="saramin" style="grid-column: 2;">
		<p class="lead fw-bold fs-3 mb-3">취업 뉴스</p>
		<c:forEach var="urlAndText" items="${urlAndTextList}" begin="0" end="4">
			<div class="p-3 mb-2 bg-light text-dark rounded">
				<a href="${urlAndText[0]}" class="text-decoration-none text-primary">${urlAndText[1]}</a>
			</div>
		</c:forEach>
	</div>
</div>
	<div class="mt-5 px-3">
		<p class="lead fw-bold fs-4 mb-3"><span class="text-info" id="deptName">${authMember.deptName }</span> 관련 직업 카드</p>
	</div>
	<div class="content__boxed">
		<div class="content__wrap">
			<div class="row">
				<!-- 백엔드 개발자 카드 -->
				<div class="col-sm-6 col-md-4 col-xl-3 mb-3">
					<div class="card">
						<div class="card-body">

							<!-- Profile picture and short information -->
							<div class="d-flex align-items-center position-relative pb-3">
								<div class="flex-shrink-0">
									<img class="img-md rounded-circle" src="${cPath}/resources/img/backEndDeveloper.jpg" alt="백엔드 개발자" loading="lazy">
								</div>
								<div class="flex-grow-1 ms-3">
									<a href="#" class="h5 stretched-link btn-link">시스템 엔지니어</a>
									<p class="text-muted m-0">System Engineer</p>
								</div>
							</div>
							<p>시스템 엔지니어는 사용자가 필요로 하는 정보 저장 및 관리</p>
							<!-- END : Profile picture and short information -->

							<!-- Options buttons -->
							<div class="mt-3 pt-2 text-center border-top">
								<div class="d-flex justify-content-center gap-3">
									<span class="badge bg-info fs-6">컴퓨터 공학과</span> <span class="badge bg-info fs-6">정보통신공학과</span> 
								</div>
							</div>
							<!-- END : Options buttons -->

						</div>
					</div>
				</div>
				<!-- 네트워크 개발자 카드 -->
				<div class="col-sm-6 col-md-4 col-xl-3 mb-3">
					<div class="card">
						<div class="card-body">

							<!-- Profile picture and short information -->
							<div class="d-flex align-items-center position-relative pb-3">
								<div class="flex-shrink-0">
									<img class="img-md rounded-circle" src="${cPath}/resources/img/networkDeveloper.jpg" alt="네트워크 개발자" loading="lazy">
								</div>
								<div class="flex-grow-1 ms-3">
									<a href="#" class="h5 stretched-link btn-link">네트워크 엔지니어</a>
									<p class="text-muted m-0">Network Engineer</p>
								</div>
							</div>
							<p>네트워크 엔지니어는 클라이언트들의 접속 및 데이터 저장</p>
							<!-- END : Profile picture and short information -->

							<!-- Options buttons -->
							<div class="mt-3 pt-2 text-center border-top">
								<div class="d-flex justify-content-center gap-3">
									<span class="badge bg-info fs-6">컴퓨터 공학과</span> <span class="badge bg-info fs-6">보안 학과</span> <span class="badge bg-info fs-6">게임 학과</span>
								</div>
							</div>
							<!-- END : Options buttons -->

						</div>
					</div>
				</div>
				<!-- 기획자 카드 -->
				<div class="col-sm-6 col-md-4 col-xl-3 mb-3">
					<div class="card">
						<div class="card-body">

							<!-- Profile picture and short information -->
							<div class="d-flex align-items-center position-relative pb-3">
								<div class="flex-shrink-0">
									<img class="img-md rounded-circle" src="${cPath}/resources/img/ProductManager.jpg" alt="기획자" loading="lazy">
								</div>
								<div class="flex-grow-1 ms-3">
									<a href="#" class="h5 stretched-link btn-link">정보화 컨설턴트</a>
									<p class="text-muted m-0">Information Service Consultant</p>
								</div>
							</div>
							<p>프로그래머들과 디자이너를 조율하여 프로젝트 전방적인 관리</p>
							<!-- END : Profile picture and short information -->

							<!-- Options buttons -->
							<div class="mt-3 pt-2 text-center border-top">
								<div class="d-flex justify-content-center gap-3">
									<span class="badge bg-info fs-6">컴퓨터 공학과</span> <span class="badge bg-info fs-6">컴퓨터과학</span> <span class="badge bg-info fs-6">소프트웨어공학</span>
								</div>
							</div>
							<!-- END : Options buttons -->

						</div>
					</div>
				</div>
				<!-- 게임 개발자 카드 -->
				<div class="col-sm-6 col-md-4 col-xl-3 mb-3">
					<div class="card">
						<div class="card-body">

							<!-- Profile picture and short information -->
							<div class="d-flex align-items-center position-relative pb-3">
								<div class="flex-shrink-0">
									<img class="img-md rounded-circle" src="${cPath}/resources/img/gameDeveloper.jpg" alt="게임 프로그래머" loading="lazy">
								</div>
								<div class="flex-grow-1 ms-3">
									<a href="#" class="h5 stretched-link btn-link">게임 개발자</a>
									<p class="text-muted m-0">Game Developer</p>
								</div>
							</div>
							<p>게임을 기획하고 디자인하며, 코드를 작성하여 플레이어들에게 즐거운 게임 경험을 제공하는 직업</p>
							<!-- END : Profile picture and short information -->

							<!-- Options buttons -->
							<div class="mt-3 pt-2 text-center border-top">
								<div class="d-flex justify-content-center gap-3">
									<span class="badge bg-info fs-6">컴퓨터 공학과</span> <span class="badge bg-info fs-6">그래픽디자인</span> <span class="badge bg-info fs-6">게임 학과</span>
								</div>
							</div>
							<!-- END : Options buttons -->
						</div>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				let deptName = $("#deptName").text();
				document.addEventListener("DOMContentLoaded", function() {
					var chart = c3
							.generate({
								bindto : '#chart',
								data : {
									x : 'x',
									columns : [
											[ 'x', '2018년도', '2019년도',
													'2020년도', '2021년도',
													'2022년도'],
											[ '학교 전체', 75, 77, 70, 80, 75 ],
											[ deptName, 80, 80, 85, 87, 82] ],
									colors : {
										'학교 전체' : '#4caf50',
										'나의 학과' : '#F97600'
									},
									type : 'bar',
									labels: true
								},
								size : {
									height : 270
								},
								axis : {
									x : {
										type : 'category'
										
									},
									y:{
										tick: {
											format: function(d){
												return d + "%";
											}
										}
									}
								}
							});
				});
			</script>