<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<security:authentication property="principal.realUser" var="authMember" />
<!-- 학생 상세보기 모달 -->
<div id="stuModal" style="display: none;">

	<div id="modalDiv" class="card border-2 border-primary">
		<div id="modalHead" class="card-header toolbar" style="border-bottom: 2px solid #25476a">
			<div class="toolbar-start">
				<h4>학생 상세 정보</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="modalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="modalBody" class="">
			<div id="modalCont1" class="card-body overflow-scroll scrollable-content">
				<div>
					<div id="profileImgDiv"></div>

				</div>
				<div>
					<form id="infoUpdateForm" action="${cPath }/group/studentUpdate.do">
						<table id="profileTb" class="table table-bordered m-2 text-center">
							<tr>
								<th width="13%">이름</th>
								<td width="42%"><input type="text" name="memNameModal" style="width: 100%;" class="form-control"></td>
								<th width="13%">단과대학</th>
								<td width="42%"><input type="text" name="colNameModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled> <input type="text" name="colNoModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled></td>
							</tr>
							<tr>
								<th>학번</th>
								<td><input type="text" name="memNoModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled></td>
								<th>소속학과</th>
								<td><input type="text" name="deptNameModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled> <input type="text" name="deptNoModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled></td>
							</tr>
							<tr>
								<th>주민번호</th>
								<td>
									<div class="row">
										<div class="col-4">
											<input type="text" name="memRrno1Modal" style="display: inline-black; background-color: #f3f5f9;" class="form-control" disabled>
										</div>
										<div class="col-1 fw-bold">-</div>
										<div class="col-4">
											<input type="text" value="*******" style="display: inline-black; background-color: #f3f5f9;" class="form-control" disabled>
										</div>
										<div class="col-3">
											<input type="text" name="memGenderModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled>
										</div>
									</div>
								</td>
								<th>학년</th>
								<td><input type="text" name="stuYearModal" style="width: 100%;" class="form-control"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="text" name="memTelModal" style="width: 100%;" class="form-control"></td>
								<th>학적상태</th>
								<td><input type="text" name="commNameModal" style="width: 100%;" class="form-control"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="text" name="memEmailModal" style="width: 100%;" class="form-control"></td>
								<th>입학일자</th>
								<td><input type="date" name="stuEdateModal" style="width: 100%; background-color: #f3f5f9;" class="form-control" disabled></td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" name="memZipModal" style="width: 100%;" class="form-control"> <input type="text" name="memAdd1Modal" style="width: 100%;" class="form-control"> <input type="text" name="memAdd2Modal" style="width: 100%;" class="form-control"></td>
								<th>졸업일자</th>
								<td><input type="date" name="stuGdateModal" style="width: 100%;" class="form-control"></td>
							</tr>
						</table>
						<div class="d-flex justify-content-between mt-5">
							<input type="file" name="memPhotoFileModal"> <input id="infoUpdateBtn" type="submit" class="btn btn-info" value="저장">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 학생 상세보기 모달 끝 -->

<!-- 수강신청 강의 상세 정보보기 모달 -->
<div id="lectInfoModal" style="display: none;">

	<div id="lectModalDiv" class="card border-2 border-primary">
		<div id="lectModalHead" class="card-header toolbar" style="border-bottom: 2px solid #25476a">
			<div class="toolbar-start mt-2">
				<h4>강의 상세 정보</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="lectModalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="lectModalBody">
			<div id="lectDetailTab" class="my-3 ">
				<ul class="nav nav-callout nav-fill mb-3">
					<li class="nav-item">
						<button type="button" id="lectTab1" class="nav-link active" data-bs-toggle="tab" data-bs-target="#lectTab1Body" aria-controls="lectTab1Body" aria-selected="true">강의상세조회</button>
					</li>
					<li class="nav-item" role="presentation">
						<button type="button" id="lectTab2" class="nav-link" data-bs-toggle="tab" data-bs-target="#lectTab2Body" aria-controls="lectTab2Body" aria-selected="false">강의계획서</button>
					</li>
					<li class="nav-item" role="presentation">
						<button type="button" id="lectTab3" class="nav-link" data-bs-toggle="tab" data-bs-target="#lectTab3Body" aria-controls="lectTab3Body" aria-selected="false">이전강의정보</button>
					</li>
				</ul>

			</div>
			<div class="tab-content">
				<div id="lectTab1Body" class="tab-pane fade show active" aria-labelledby="lectTab1">
					<div class="m-2">
						<table class="table table-bordered p-3 lectInfoTb">
							<tr>
								<th width="20%">강의명</th>
								<td width="80%"><span id="lectNameM"></span></td>
							</tr>
							<tr>
								<th>강의코드</th>
								<td><span id="lectNoM"></span></td>
							</tr>
							<tr>
								<th>강의구분</th>
								<td><span id="subCommNameM"></span>&nbsp;&nbsp;<span id="subGradeM"></span>학년</td>
							</tr>
							<tr>
								<th>교수명</th>
								<td><span id="memNameM"></span></td>
							</tr>

							<tr>
								<th rowspan="2" class="align-middle">강의 상세</th>
								<td><span id="lectOnfNameM"></span></td>
							</tr>
							<tr>
								<td><span id="lectTimePlaceM"></span></td>
							</tr>
						</table>
					</div>
					<div class="mt-5 m-2">
						<p style="font-size: 1.025rem; font-weight: bold;">
							<ion-icon name="stop-outline"></ion-icon>
							성적 평가 기준
						</p>
					</div>
					<div class="m-2">
						<table id="lectCrtrTb" class="table table-bordered text-center p-3">
							<thead>
								<tr id="lectCrtrTbThead"></tr>
							</thead>
							<tbody>
								<tr id="lectCrtrTbTbody"></tr>
							</tbody>
						</table>
					</div>
					<div></div>
				</div>
				<div id="lectTab2Body" class="tab-pane fade " aria-labelledby="lectTab2">
					<div id="lectPlan" class="mb-5 m-2">
						<table class="table table-bordered p-3 lectInfoTb">
							<tr>
								<th>강의 설명</th>
								<td colspan="3" id="lectExpM"></td>
							</tr>
							<tr>
								<th>학점</th>
								<th>시수</th>
								<th colspan="2">개설학과</th>
							</tr>
							<tr>
								<td id="subScrM"></td>
								<td id="subHoursM"></td>
								<td id="colNameM"></td>
								<td id="deptNameM"></td>
							</tr>
						</table>
					</div>
					<div class="mt-5 m-2">
						<p style="font-size: 1.025rem; font-weight: bold;">
							<ion-icon name="stop-outline"></ion-icon>
							주차별 강의 계획
						</p>
					</div>
					<div style="height: 400px;" class="overflow-scroll scrollable-content m-2">
						<table class="lectInfoTb table table-bordered p-3">
							<tr>
								<th width="20%">주차</th>
								<th width="80%">내용</th>
							</tr>
							<tbody id="lwpM">

							</tbody>
						</table>
					</div>
				</div>
				<div id="lectTab3Body" class="tab-pane fade text-center fs-4" style="margin-top: 30%;" aria-labelledby="lectTab3">
					<div>
						<ion-icon name="chatbubble-ellipses"></ion-icon>
					</div>
					<div class="redfont">
						<span>이전 강의가 없습니다.</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 수강신청 강의 상세 정보보기 끝 -->
<!-- ~~~~~~~~~~~~~~~~~~~~교직원 교과목 요청 처리 모달~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div id="subjectProcessModal" style="display: none;"> 
 
   <div id="subjectProcessModalDiv" class="card border-2 border-primary"> 
       <div id="subjectProcessModalHead" class="card-header toolbar" style="border-bottom:2px solid #25476a">
          <div class="toolbar-start">
              <h4>교과목 요청 목록</h4>
          </div>
          <div class="toolbar-end">
              <button onclick="subjectProcessModalClose()" class="btn"><ion-icon name="close-outline"></ion-icon></button>
          </div>
       </div>
       <div id="subjectProcessModalBody" class="">
       		<form id="subjectProcessForm" method="POST">
       		<table class="table table-striped text-center">
       			<tbody id="subjectProcessTBody"></tbody>
       		</table>
       		</form> 
       </div>
   </div> 
   
</div> 
<div id="subjectProcessModal" style="display: none;">

	<div id="subjectProcessModalDiv" class="card border-2 border-primary">
		<div id="subjectProcessModalHead" class="card-header toolbar" style="border-bottom: 2px solid #25476a">
			<div class="toolbar-start">
				<h4>교직원 교과목 요청 처리 모달</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="subjectProcessModalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="subjectProcessModalBody" class="">
			<form id="subjectProcessForm" method="POST">
				<table class="table table-striped text-center">
					<tbody id="subjectProcessTBody"></tbody>
				</table>
			</form>
		</div>
	</div>

</div>

<!-- ~~~~~~~~~~~~~~~~~~~~강의계획서 등록 처리 모달~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div id="lectPlanModal" class="midiumfont" style="display: none;">

	<div id="lectPlanModalDiv" class="card border-2 border-primary">
		<div id="lectPlanModalHead" class="card-header toolbar" style="border-bottom: 2px solid #25476a">
			<div class="toolbar-start">
				<h4 class="fs-2">강의계획서 등록</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="lectPlanModalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="lectPlanModalBody" class="" style="max-height: 100%; overflow-y: auto;">
		<div><button type="button" id="autoLecture" class="btn btn-sm btn-primary">자동완성</button></div>
			<form id="lectPlanForm" method="POST">
				<div class="table-responsive">
					<table class="table table-bordered" style="table-layout: fixed">
						<tbody id="lecturePlanTBody">
							<tr>
								<th>교과목</th>
								<td id="subjectTd"></td>
								<th>학년</th>
								<td id="subjectGrade"></td>
								<th>학점</th>
								<td id="subjectScore"></td>
								<th>시수</th>
								<td id="subjectTime"></td>
							</tr>
							<tr>
								<th>강의명</th>
								<td colspan="4"><input type="text" name="lectName" style="width: 100%; background-color: #f3f5f9;" class="form-control" /></td>
								<th>대면여부</th>
								<td colspan="2"><select name="lectOnf" style="width: 100%; background-color: #f3f5f9;" class="form-select">
										<option value="E001">대면</option>
										<option value="E002">비대면</option>
								</select></td>
							</tr>
							<tr>
								<th>담당교수</th>
								<th>성명</th>
								<td>${authMember.memName }<input type="hidden" value="${authMember.memNo}" name="ProNo"></td>
								<th>전화번호</th>
								<td>${authMember.memTel }</td>
								<th>E-mail</th>
								<td colspan="2">${authMember.memEmail }</td>

							</tr>
							<tr>
								<th>강의목표</th>
								<td colspan="7"><textarea name="lectExp" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control"></textarea></td>
							</tr>
							<tr>
								<th>교재 및 참고문헌</th>
								<td colspan="7"><textarea id="kujae" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control"></textarea></td>
							</tr>
							<tr>
								<th rowspan="2">강의평가 방법</th>

								<th>중간(%)<input type="hidden" name="scoreCRTRList[0].scTitle" value="L001" /></th>
								<th>기말(%)<input type="hidden" name="scoreCRTRList[1].scTitle" value="L002" /></th>
								<th>출석(%)<input type="hidden" name="scoreCRTRList[2].scTitle" value="L003" /></th>
								<th>과제(%)<input type="hidden" name="scoreCRTRList[3].scTitle" value="L004" /></th>
								<th colspan="3">합계(%)</th>
							</tr>
							<tr>
								<td><input type="text" name="scoreCRTRList[0].scRatio" id="wnd" value="0" style="width: 100%; background-color: #f3f5f9;" class="form-control"></td>
								<td><input type="text" name="scoreCRTRList[1].scRatio" id="rl" value="0" style="width: 100%; background-color: #f3f5f9;" class="form-control"></td>
								<td><input type="text" name="scoreCRTRList[2].scRatio" id="cnf" value="0" style="width: 100%; background-color: #f3f5f9;" class="form-control"></td>
								<td><input type="text" name="scoreCRTRList[3].scRatio" id="rhk" value="0" style="width: 100%; background-color: #f3f5f9;" class="form-control"></td>
								<td colspan="3" id="gkq"></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="table-responsive">
					<div id="lectWeekPlanDiv" class="m-2">
						<table class="table table-bordered text-center">
							<tbody>
								<tr>
									<th rowspan="16" width="15%">주차별 강의계획</th>
									<th width="15%">주</th>
									<th width="70%">강의내용</th>
								</tr>
								<tr>
									<th>1<input type="hidden" name="lectPlanList[0].lwpWeek" value="1" /></th>
									<td><textarea name="lectPlanList[0].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>2<input type="hidden" name="lectPlanList[1].lwpWeek" value="2" /></th>
									<td><textarea name="lectPlanList[1].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										</textarea></td>
								</tr>
								<tr>
									<th>3<input type="hidden" name="lectPlanList[2].lwpWeek" value="3" /></th>
									<td><textarea name="lectPlanList[2].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>4<input type="hidden" name="lectPlanList[3].lwpWeek" value="4" /></th>
									<td><textarea name="lectPlanList[3].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>5<input type="hidden" name="lectPlanList[4].lwpWeek" value="5" /></th>
									<td><textarea name="lectPlanList[4].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>6<input type="hidden" name="lectPlanList[5].lwpWeek" value="6" /></th>
									<td><textarea name="lectPlanList[5].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>7<input type="hidden" name="lectPlanList[6].lwpWeek" value="7" /></th>
									<td><textarea name="lectPlanList[6].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>8<input type="hidden" name="lectPlanList[7].lwpWeek" value="8" /></th>
									<td><textarea name="lectPlanList[7].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>9<input type="hidden" name="lectPlanList[8].lwpWeek" value="9" /></th>
									<td><textarea name="lectPlanList[8].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>10<input type="hidden" name="lectPlanList[9].lwpWeek" value="10" /></th>
									<td><textarea name="lectPlanList[9].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>11<input type="hidden" name="lectPlanList[10].lwpWeek" value="11" /></th>
									<td><textarea name="lectPlanList[10].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>12<input type="hidden" name="lectPlanList[11].lwpWeek" value="12" /></th>
									<td><textarea name="lectPlanList[11].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>13<input type="hidden" name="lectPlanList[12].lwpWeek" value="13" /></th>
									<td><textarea name="lectPlanList[12].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>14<input type="hidden" name="lectPlanList[13].lwpWeek" value="14" /></th>
									<td><textarea name="lectPlanList[13].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
								<tr>
									<th>15<input type="hidden" name="lectPlanList[14].lwpWeek" value="15" /></th>
									<td><textarea name="lectPlanList[14].lwpContent" style="width: 100%; background-color: #f3f5f9; resize: none;" class="form-control">
										 </textarea></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="lectureRoomDiv" class="m-2">
						<table class="table table-bordered" style="width: 400px">
							<tr>
								<th>강의실 선택</th>
								<td id="lectureRoomSelectTd"></td>
								<th>최대수강인원</th>
								<td id="lectureRoomMaxTd"></td>
							</tr>
							<tr>
								<th>강의 시간 선택</th>
								<td id="lectDetailHidden" colspan="3"></td>
							</tr>
						</table>
						<table id="lectureRoomTb" class="table text-center table-bordered" style="border: 2px solid #f2f2f2">
							<tr>
								<th class="lecWkTh"></th>
								<th class="lecWkTh">월</th>
								<th class="lecWkTh">화</th>
								<th class="lecWkTh">수</th>
								<th class="lecWkTh">목</th>
								<th class="lecWkTh">금</th>
								<th class="lecWkTh">토</th>
							</tr>
							<c:forEach var="i" begin="1" end="13">
								<tr>
									<th class="lecTimeTh">${i}</th>
									<c:forEach step="100" var="j" begin="100" end="600">
										<td class="lecTimeTd text-center" id="${i+j}" data-value="${i+j}"></td>
									</c:forEach>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="text-center mb-3">
					<input type="hidden" name="lectMm" id="lectMm" /> <input type="hidden" value="0" name="lectPm" /> <input type="hidden" value="J001" name="lectState" />
					<button type="button" id="lectPlanInsertBtn" class="btn btn-sm btn-primary">등록</button>
				</div>
			</form>


		</div>
	</div>

</div>

<!-- 출석인정신청내역 모달 -->
<div id="attendModal" class="midiumfont" style="display: none;">
	<div id="attendModalDiv" class="card border-2 border-primary">
		<div id="attendModalHead" class="card-header toolbar" style="border-bottom: 2px solid #25476a">
			<div class="toolbar-start">
				<h4>출석인정신청 내역</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="modalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="modalOverflow" class="overflow-scroll scrollable-content">
			<div id="attendModalBody">
				<c:if test="${empty attendAdmitList}">
					<br>
					<br>
					<br>

					<div class="icon">
						<ion-icon name="chatbubble-ellipses"></ion-icon>
					</div>
					<div class="redfont">
						<span>출석인정신청 내역이 없습니다.</span>
					</div>
				</c:if>
				<c:if test="${not empty attendAdmitList}">
					<c:forEach items="${attendAdmitList }" var="attendAdmit" varStatus="vs">
						<form id="searchForm" action="${cPath}/attendance/attendAdmitUpdate.do" method="post">
							<div class="p-4 endfor">
								<table class="table table-hover text-center searchTable underbar">
									<input type="hidden" name="what" value="${what }">
									<tr>
										<th>신청번호</th>
										<td><input type="text" name="aaNo" value="${attendAdmit.aaNo }" readonly="readonly" class="text-center" /></td>
										<th>신청상태</th>
										<td>${attendAdmit.aaState }</td>
									</tr>
									<tr>
										<th>신청학생</th>
										<td colspan="3">
											<table class="table table-hover text-center">
												<tr>
													<th>학번</th>
													<th>단과대학</th>
													<th>학과</th>
													<th>이름</th>
												</tr>
												<tr>
													<td>${attendAdmit.stuNo }</td>
													<td>${attendAdmit.colName }</td>
													<td>${attendAdmit.deptName }</td>
													<td>${attendAdmit.student.memName }</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th>출석정보</th>
										<td colspan="3">
											<table class="table table-hover text-center">
												<tr>
													<th>출석번호</th>
													<th>출석날짜</th>
													<th>출석상태</th>
												</tr>
												<tr>
													<td><input type="text" name="attendNo" value="${attendAdmit.attendNo }" readonly="readonly" class="text-center"></td>
													<td>${attendAdmit.attend.attendDate }</td>
													<td>${attendAdmit.attend.attendState }</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<th width="15%">신청사유</th>
										<td width="40%">${attendAdmit.aaReason }</td>
										<th width="15%">신청서류</th>
										<td width="30%"><c:if test="${attendAdmit.aaFile eq 0}">
								문서 누락
							</c:if> <c:if test="${attendAdmit.aaFile ne 0}">
												<a href="/KEYUniv/attend/attatch/download.do?atchId=${attendAdmit.aaFile }&amp;atchSeq=1 "> 문서다운로드 </a>
											</c:if></td>
									</tr>
									<tr>
										<td colspan="4"><textarea name="aaRefuse" rows="5" cols="90" id="refuseReason" placeholder="반려사유를 작성하세요."></textarea></td>
									</tr>
								</table>
							</div>
							<div class="text-center">
								<br>
								<button type="reset" class="btn btn-icon btn-xs m-2">
									<ion-icon class="fs-1 md hydrated" name="reload-outline" role="img" aria-label="reload outline"></ion-icon>
								</button>
								<div class="btn-group">
									<select name="attendState" class="btn btn-warning dropdown-toggle refuseOpt" data-bs-toggle="dropdown" aria-expanded="false">
										<option class="dropdown-item" value="D001">승인</option>
										<option class="dropdown-item" value="${attendAdmit.attend.attendState }">반려</option>
									</select>
								</div>
								<security:csrfInput />
								<input id="attendBtn" class="btn btn-primary" type="submit" value="저장">
							</div>
						</form>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</div>
<!-- 출석인정신청내역 모달 끝 -->

<!--등록금 고지서 납부 상세보기-->

<div id="PaymentModal" style="display: none;">
	<div id="PaymentModalDiv" class="card border-2 border-primary">
		<div id="PaymentModallHead" class="card-header toolbar">
			<div class="toolbar-start">
				<h4>등록금 납부 안내</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="modalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>

		<div id="overflow" class="overflow-scroll scrollable-content">
			<div id="PaymentModalBody">
				<c:if test="${empty tutiPay}">
					<br>
					<br>
					<br>
					<div class="icon text-center">
						<ion-icon name="chatbubble-ellipses"></ion-icon>
					</div>
					<div class="redfont text-center">
						<span>등록금 납부 내역이 존재하지 않습니다.</span>
					</div>
				</c:if>
				<c:if test="${not empty tutiPay}">
					<form id="searchForm" action="${cPath}/tuti/tutiPayUpdate.do" method="post">
						<div class="p-4 endfor">
							<a href="${cPath}/poi/tuitionFee.do?what=${tutiPay.tuitionNo}" class="btn btn-info">등록금고지서 다운로드</a>
							<table class="table table-hover text-center searchTable underbar">
								<tr>
									<th>등록금고지서</th>
									<td><input type="text" name="tpNo" value="${tutiPay.tpNo}" readonly="readonly" class="text-center"></td>

									<th>납부 상태</th>
									<td>${tutiPay.commName}</td>
								</tr>

								<tr>
									<td colspan="4">
										<table class="table table-hover text-center">
											<tr>
												<th>학번</th>
												<td>${tutiPay.stuNo }</td>

												<th>단과대학</th>
												<td>${tutiPay.colName }</td>
											</tr>
											<tr>
												<th>학과</th>
												<td>${tutiPay.deptName }</td>

												<th>이름</th>
												<td>${tutiPay.memName }</td>
											</tr>
										</table>
									</td>
								</tr>

								<tr>
									<td colspan="4">
										<table class="table table-hover text-center">
											<tr>
												<th>전화번호</th>
												<td>${tutiPay.memTel }</td>

												<th>E-mail</th>
												<td>${tutiPay.memEmail }</td>
											</tr>
											<tr>
												<th>학년</th>
												<td>${tutiPay.stuYear }</td>

												<th>학기</th>
												<td>${tutiPay.schRecSemester }</td>
											</tr>
										</table>
									</td>
								</tr>

							</table>

							<table class="table table-hover text-center searchTable underbar">
								<tr>
									<th colspan="4">해당 학기 장학금</th>
								</tr>
								<tr>
									<th>장학금 번호</th>
									<td><input type="text" name="schRecNo" value="${tutiPay.schRecNo}" readonly="readonly" class="text-center"></td>

									<th>장학금 이름</th>
									<td>${tutiPay.schName}</td>
								</tr>
							</table>
							<table class="table table-hover text-center searchTable underbar">

								<tr>
									<th colspan="4">납부금액 안내</th>
								</tr>
								<tr>
									<th>등록금</th>
									<td>${tutiPay.tuitionAmount}</td>

									<th>장학금</th>
									<td>${tutiPay.tuitionSchrec}</td>
								</tr>
								<tr>
									<th>총 납입액</th>
									<td>${tutiPay.tuitionPayment}</td>
								</tr>
							</table>
						</div>
					</form>
				</c:if>
			</div>
		</div>
	</div>
</div>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~상세보기 모달~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div id="subjectViewModal" class="midiumfont" style="display: none;">

	<div id="subjectViewModalDiv" class="card border-2 border-primary">
		<div id="subjectViewModalHead" class="card-header toolbar" style="border-bottom: 2px solid #25476a">
			<div class="toolbar-start">
				<h4 class="fs-2">교과목</h4>
			</div>
			<div class="toolbar-end">
				<button onclick="subjectViewModalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="subjectViewModalBody" class="p-3"></div>
	</div>

</div>
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~상세보기 모달~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<!-- ~~~~~~~~~~~~~~~~~~~~~캘린더모달~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
<div id="calendarInsertModal" style="display: none;">
	<div id="calendarmodalDiv" class="card border-2 border-primary">
		<div id="calendarModalHead" class="card-header toolbar">
			<div class="toolbar-start" style="font-size: 20px; font-weight: bold;">일정 추가</div>
			<div class="toolbar-end">
				<button onclick="calendarInsertModalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="calendarmodalBody" class="">
			<div id="modalCont1" class="card-body overflow-scroll scrollable-content">
				<div class="card-body toolbar">
					<form id="calendarinsertForm" method="post">
						<security:csrfInput />
						<table id="profileTb" class="table table-bordered m-2 text-center">
							<div class="calendarModalInput">
								<span class="fs-4">제목:</span>&nbsp;&nbsp;&nbsp;&nbsp; <input type="text" id="title" value="" class="fs-5">
							</div>
							<br>
							<div class="calendarModalInput">
								<span class="fs-4">시작일:</span> <input type="datetime-local" id="sdate" value="" class="fs-5">
							</div>
							<br>
							<div class="calendarModalInput">
								<span class="fs-4">종료일:</span> <input type="datetime-local" id="edate" value="" class="fs-5">
							</div>
							<br>
							<div class="calendarModalInput">
								<span class="fs-4">배경 색상:</span> <input type="color" id="background-color" value="" class="fs-5">
							</div>
							<br>
							<div class="calendarModalInput">
								<span class="fs-4">글씨 색상:</span> <input type="color" id="text-color" value="" class="fs-5">
							</div>
							<br>
						</table>
					</form>
				</div>
			</div>
			<div class="toolbar-end d-flex justify-content-end me-3" style="margin-left: auto;">
				<input type="submit" class="btn btn-success" value="추가" onclick="insert()"> <input type="reset" class="btn btn-danger" onclick="calendarInsertModalClose()" value="취소">
			</div>
		</div>
	</div>
</div>

<!-- 일정을 클릭하면 나오는 모달 -->
<div id="calendarDetailModal" style="display: none;">
	<div id="calendarmodalDiv" class="card border-2 border-primary">
		<div id="calendarModalHead" class="card-header toolbar">
			<div class="toolbar-start" style="font-size: 20px; font-weight: bold;">일정 정보</div>
			<div class="toolbar-end">
				<button onclick="calendarDetailModalClose()" class="btn">
					<ion-icon name="close-outline"></ion-icon>
				</button>
			</div>
		</div>
		<div id="calendarmodalBody" class="">
			<div id="modalCont1" class="card-body overflow-scroll scrollable-content">
				<div class="card-body toolbar">
					<form action="${cPath}/calendarView" id="calendarDetailForm" method="post">
						<security:csrfInput />
						<table id="profileTb" class="table table-bordered m-2 text-center">
							<div class="calendarModalInput">
								<input type="hidden" id="cid" value="">
								<div class="calendarModalInput">
									<span class="fs-4">제목:&nbsp;&nbsp;&nbsp;&nbsp;</span> <input type="text" id="ctitle" value="" class="fs-5" style="">
								</div>
								<br>
								<div class="calendarModalInput">
									<span class="fs-4">시작일:</span> <input type="datetime-local" id="csdate" value="" class="fs-5">
								</div>
								<br>
								<div class="calendarModalInput">
									<span class="fs-4">종료일:</span> <input type="datetime-local" id="cedate" value="" class="fs-5">
								</div>
								<br>
								<div class="calendarModalInput">
									<span class="fs-4">배경 색상:</span> <input type="color" id="cbackgroundColor" value="" class="fs-5">
								</div>
								<br>
								<div class="calendarModalInput">
									<span class="fs-4">글씨 색상:</span> <input type="color" id="ctextColor" value="" class="fs-5">
								</div>
								<br>
						</table>
					</form>
				</div>
			</div>
			<div class="toolbar-end d-flex justify-content-end me-3" style="margin-left: auto;">
				<button class="btn btn-success" onclick="modify()">수정</button>
				<button class="btn btn-danger" onclick="remove()">삭제</button>
			</div>
		</div>
	</div>
</div>