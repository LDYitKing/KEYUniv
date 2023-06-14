package kr.or.ddit.websocket.handler;

import java.io.IOException;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SampleEchoWebSocketHandler extends TextWebSocketHandler {
	private List<WebSocketSession> sessionList = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("연결 수립 : {}", session);
		sessionList.add(session);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("연결 종료 : {}", session);
		sessionList.remove(session);
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log.error(exception.getMessage(), exception);
	}
	
	@Data
	@AllArgsConstructor
	public static class MessageVO implements Serializable{
		private String sender;
		private String message;
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String realMsg = message.getPayload();
		Authentication authentication = (Authentication) session.getPrincipal();
		String sender = authentication.getName();
		MessageVO messageVO = new MessageVO(sender, realMsg);
		String jsonPayload = new ObjectMapper().writeValueAsString(messageVO);
		sessionList.forEach((ws)->{
			try {
				ws.sendMessage(new TextMessage(jsonPayload));
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		});
	}
}


















