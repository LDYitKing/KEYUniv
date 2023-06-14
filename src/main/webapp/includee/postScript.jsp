<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!-- JAVASCRIPTS -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

<!-- Popper JS [ OPTIONAL ] -->
<script src="${pageContext.request.contextPath}/resources/assets/vendors/popperjs/popper.min.js" defer></script>

<!-- Bootstrap JS [ OPTIONAL ] -->
<script src="${pageContext.request.contextPath}/resources/assets/vendors/bootstrap/bootstrap.min.js" defer></script>

<!-- Nifty JS [ OPTIONAL ] -->
<script src="${pageContext.request.contextPath}/resources/assets/js/nifty.js" defer></script>

<!-- Zangdar Script [ OPTIONAL ] -->
<script src="${pageContext.request.contextPath}/resources/assets/vendors/zangdar/zangdar.min.js" defer></script>


<!-- 전자출결시스템용 웹소켓 : headerMenu에 버튼 띄우기 -->
<script src="${pageContext.request.contextPath}/resources/js/stompjs/stomp.umd.js" defer></script>

<script>
// 	let pusshWs = new WebSocket("ws://localhost${cPath}/ws/push");
// 	pushWs.onmessage=function(event){
// 		alert(event.data);
// 	}
<security:authorize access="isAuthenticated()">
	<security:authentication property="principal.realUser" var="authUser" />
</security:authorize>

	window.addEventListener("DOMContentLoaded", event=>{
		const pushClient = new StompJs.Client({
			brokerURL:"ws://192.168.36.36${cPath}/ws/push",
			debug:function(str){
				console.log(str);
			},
			onConnect:function(frame){
				const subscription1 = this.subscribe("/topic/push", function(msgFrame){
					let messageVO = JSON.parse(msgFrame.body);
					Swal.fire({
						  icon: messageVO.messageType.toLowerCase(),
						  title: '전체 푸시 메시지',
						  text: messageVO.message
						})
				});
				const subscription2 = this.subscribe("/user/queue/private", function(msgFrame){
					let messageVO = JSON.parse(msgFrame.body);
					alert(`PRIVATE 메시지 [\${messageVO.message}]`);
				});
			}
		});
		pushClient.activate();
		<security:authorize access="hasRole('ROLE_STU')">
		const classRoomClient = new StompJs.Client({
			brokerURL:"ws://192.168.36.36${cPath}/ws/classRoom",
			debug:function(str){
				console.log(str);
			},
			onConnect:function(frame){
				let client = this;
				const subscription1 = this.subscribe("/classroom/open", function(msgFrame){
					let payload = JSON.parse(msgFrame.body);
					let roomId = payload.classRoomId;
					let professor = payload.professor;
					let enterBtn = document.createElement("button");
					enterBtn.className = "btn btn-danger btn-xs rounded-pill";
					enterBtn.innerHTML=`\${roomId} 출석`;
					enterBtn.addEventListener("click", ()=>{
						client.publish({
							destination:`/user/\${professor}/classroom/\${roomId}`,
							body:JSON.stringify({sender:`${authUser.stuNo}`}),
							headers:{"content-type":"application/json"}
						})
						enterBtn.style.display = "none";
					});
					
					headerMenuGroup.innerHTML = "";
					headerMenuGroup.appendChild(enterBtn);
				});
			}
		});
		classRoomClient.activate();
		</security:authorize>
	});
</script>