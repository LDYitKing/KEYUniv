<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<style>
 .marginSpace{
	margin-right: 66px;
} 
</style>
<nav aria-label="breadcrumb"  class="px-2">
	<ol class="breadcrumb mb-0">
		<li class="breadcrumb-item">&nbsp;&nbsp;&nbsp;&nbsp;<a href="${cPath}/">Main</a></li>
		<li class="breadcrumb-item active" aria-current="page">등록금 관리</li>
	</ol>
</nav>
<div class="d-flex justify-content-between" style="align-items: center;">
	<div class="px-2">
	  <h1 class="m-2 text-light" style="margin-right: 20px;">등록금</h1>
	</div>
</div> 


<div class="space m-3 p-5 bigfont">

	<div class="desc-space m-3 p-2">
		<div id="notice-card" class="card-body mb-4">
			<h3 class="card-title mt-2 fs-2">등록금 안내</h3>
			<div style="display: grid; grid-template-columns: 1fr 1fr; column-gap: 20px;" >
				<div >
					<h5 class="fs-3"><li>가. 등록금 납부 </li></h5>
					<p>- 정해진 기간 내에 등록을 완료하지 않으면 학칙 제28조에 의거 미등록 제적됩니다.</p>
					
					<h5 class="fs-3"><li>나. 휴학생 등록금 안내</li></h5>
					<p> - 휴학생은 등록금을 납부할 필요가 없습니다.<br>
					&nbsp학칙 제55조에 의거 휴학은 등록금 반환사유에 해당되지 않으므로 <br>
					&nbsp등록금 납부 후 휴학하는 경우에도 기납부한 등록금은 환불되지 않습니다.<br>
					&nbsp등록금 납부 후 학기개시 일부터 7주 이내 휴학한 학생은 복학 시<br>
					&nbsp해당학기 등록금 변동에 따른 차액 납부/환불 없이 복학 수속합니다.</p>
			
					<h5 class="fs-3"><li>다. 장학사항 취소&nbsp(휴학신청)</li></h5> 
						<p>&nbsp당해 학기 장학생으로 선발된 자는 해당학기 등록을 필하여야 장학생으로<br>
						인정되며 등록을 완료하지 않을 경우 해당학기의 장학사항은 취소됩니다.<p>
					
					<h5 class="fs-3"><li>라. 장학금 감면혜택&nbsp(휴학생 사항) </li></h5>
					<p>- 휴학 당시 장학생으로 선발되어 등록금 감면혜택을 받아<br>
						&nbsp등록 완료한 학생은 이후 복학학기에 타장학금을 받을 수 없으며,<br>
						&nbsp타장학금을 수혜받기 위해 휴학 당시의 수혜 받았던 장학을 포기할 수 없습니다.</p>
				</div>
		
				<div>
					<h5 class="fs-3"><li>선택 장학금 감면 취소 혜택</li></h5>
					<p> 1)&nbsp전과 시, 전적 학과의 기 선발된 장학금(성적장학금, 국가장학금)은 취소되며 해당학과의 타 학생이 추가 선발됩니다.</p>
					<p> 2)&nbsp험료 납부와 관련하여 기타 문의사항이 있을 경우 국제팀으로 연락하여 주시기 바랍니다.</p>
					
					<h5 class="fs-3"><li>외국인 등록금 유의사항(필독 사항)</li></h5>
					<p> 1)&nbsp외국인 유학생중 등록금 외화송금시 최근 본인이 아닌 지인에 의한 대리납부,불법 사설 환전소<br>
					이용으로 인하여 전자통신금융사기(보이스피싱)가 증가함에 따라공식 금융기관을 통하여<br>
					안전한 방법으로 진행하여 주시기 바랍니다.</p>
					<p> 2)&nbsp교외 장학단체에서 해당 장학생을 지정하지 않은 경우에는 교외 장학생수의 학과별 비율을 고려<br>
						입시학생처장의 추천을 받아 학생생활 운영위원회의 심의를 거쳐 총장이 추천한다.</p>
					<p> 3)&nbsp부적법한 방법으로 등록금이 납부되어 문제가 발생될 경우 기납부한 등록금은 무효처리가 되어 재등록해야하며,
						민․형사상 처벌을 받을수 있으니 납부에 유의하여 주시기 바랍니다.</p>
				</div>
			</div>
		</div>
	</div>
	<div class="bigfont">
		<security:authorize access="hasRole('EMP')">
			<table class="table table-bordered">
				<div class="row m-2">
					<thead class="table-primary">
						<tr>
							<td>번호</td>
							<td>학번</td>
							<td>학과</td>
							<td>이름</td>
							<td>학년</td>
							<td>학기</td>
							<td>납부 상태</td>
	
						</tr>
					</thead>
	
					<tbody id="listBody" data-view-url="${cPath}/tuti/tutiView.do">
					</tbody>
	
					<tfoot>
						<tr>
							<td colspan="8" class="text-center">
	<!-- 							<input type="text" name="searchWord" class="form-control col-auto" /> -->
										<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
										<a href="${cPath}/tuti/tutiInsert.do" class="btn btn-secondary"><spring:message code="regist" /></a>
											
							</td>
						</tr>
					</tfoot>
				</div>
			</table>
		</security:authorize>
		<security:authorize access="hasRole('STU')">
			<table class="table text-center table-bordered">
				<div class="row m-2">
					<thead class="table-primary">
						<tr>
							<td width=10%>번호</td>
							<td width=10%>학년</td>
							<td width=50%>년도/학기</td>
							<td width=10%>납부상태</td>
							<td width=20%></td>
						</tr>
					</thead>
	
					<tbody>
						<tr>
							<td>1</td>
							<td>2</td>
							<td>2023학년도 2학기</td>
							<td>대기</td>
							<td>
							<a href="${cPath}/poi/tuitionFee.do?what=TUTI007">등록금고지서</a>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td>2</td>
							<td>2023학년도 1학기</td>
							<td>완료</td>
							<td></td>
						</tr>
						<tr>
							<td>3</td>
							<td>1</td>
							<td>2022학년도 2학기</td>
							<td>완료</td>
							<td></td>
						</tr>
						<tr>
							<td>4</td>
							<td>1</td>
							<td>2022학년도 1학기</td>
							<td>완료</td>
							<td></td>
						</tr>
					</tbody>
	
					<tfoot>
						<tr>
							<td colspan="8" class="text-center">
								<input type="button" value="검색" id="searchBtn" class="btn btn-primary" />
											
							</td>
						</tr>
					</tfoot>
				</div>
			</table>
		</security:authorize>
	</div>
</div>

<div style="border: 1px solid green;">
	<form name="searchForm" method="post">
		<security:csrfInput/>
		<input type="hidden" name="colNo" placeholder="searchWord" /> 
		<input type="hidden" name="deptNo" placeholder="searchWord" />
	</form>
</div>

<script src="${cPath}/resources/js/tuti/tutiList.js"></script>