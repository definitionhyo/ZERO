package com.itwillbs.zero.handler;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


// WebSocket 핸들러를 구현하기 위해 TextWebSocketHandler 상속
@Component
@RequestMapping("/alarm")
public class AlarmHandler extends TextWebSocketHandler{
	private static final Logger logger = LoggerFactory.getLogger(AlarmHandler.class);
	
	// WebSocket 세션 저장할 맵 생성(알림) - 회원아이디(방번호로 사용), 웹소켓 세션 아이디
	// 로그인한 회원의 세션받기 (List타입)
//	private List<Map<String, WebSocketSession>> sessionList = new ArrayList<>();
	// 로그인 한 회원의 아이디, 웹소켓세션 저장
	public static Map<String, WebSocketSession> alarmUsers = new HashMap<>();
	
//	public static Map<String, WebSocketSession> getMap(String name, WebSocketSession session) {
//		//innermap 셋팅 함수
//		Map<String, WebSocketSession> map = new HashMap<>();
//		map.put(name, session);
//        return map;
//    }
	
	// 클라이언트가 채팅을 위해 해당 페이지에 들어오면 클라이언트 연결, 해당 클라이언트 세션을 저장
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		logger.info("Socket-알림 연결됨!");
		
		// Map<httpsession아이디 ,WebSocketSession> 설정
//		Map<String, WebSocketSession> alarmUser = new HashMap<>();
		// 로그인 아이디 (알림을 받을 사람 => 세션으로 받아옴)
		String member_id = (String) session.getAttributes().get("member_id");
		logger.info("세션 아이디 : " + member_id);
//		String member_id = session.getUri().getQuery().split("=")[1].toString();
//		String senderId = (String) session.getAttributes().get("member_id");
		
//		logger.info("접근한 로그인 아이디 : " + alarmUsers.toString());
		
		// 세션 끊어졌을 때 처리
		if(member_id == null) {return; }
		// 현재 세션에 해당 로그인 아이디가 없으면 추가하기
		if(!alarmUsers.containsKey(member_id)) {
			alarmUsers.put(member_id, session);
			System.out.println("새로운 로그");
//			
		}else {
			// 현재 세션에 해당 로그인 아이디가 있으면(이거 왜 하지?)
			alarmUsers.replace(member_id, session);
			//방도 있고 유저아이디도 있다? userId에 session을 replace
			System.out.println("replace");
		}
//			System.out.println("입장 : " + alarmUsers.get(session.getUri().getQuery().split("=")[1].toString()));
//			System.out.println("입장 : " + alarmUsers.get(session.getUri().getQuery().split("=")[1].toString()));
//		sessionList.add(session);
//		logger.info("alarmUsers : " + alarmUsers.toString());
	}
	
	// WebSocket 서버로 데이터 전송 - 세션이(누가) 뷰페이지에서 메세지를 보냄
	// Session 모두에게 메세지를 전달해야 하므로 loop를 돌며 메세지를 전송한다.
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		logger.info("#AlarmHandler, handleMessage");
		// 앞의 member_id는 그렇게 중요하지는 않고 메세지를 받았음
		// 오는 주소 /chat?id=' + receiver
//		String receive_id = session.getUri().getQuery().split("=")[1].toString();
		String member_id = (String) session.getAttributes().get("member_id");
		logger.info("{}로부터 {} 받음", member_id, message.getPayload());
		
		// 연결된 방의 클라이언트에게 메세지 전송
//		for ( String key : (alarmUsers.get(member_id).keySet())) {
//			WebSocketSession s = alarmUsers.get(member_id).get(key);
//			s.sendMessage(new TextMessage(senderId + ":" + message.getPayload()));
//		}
		 
//		for(WebSocketSession s : alarmUsers.get(member_id)) {
//			s.sendMessage(new TextMessage(userId + ":" + message.getPayload()));
////			s.sendMessage(new TextMessage(message.getPayload()));
//		}
		
		// -- (알림X)많은 사람들에게 메세지를 보내야할 때
		Iterator<String> sessionIds = alarmUsers.keySet().iterator();
		String sessionId = "";
		while(sessionIds.hasNext()) {
			sessionId = sessionIds.next();
			alarmUsers.get(sessionId).sendMessage(new TextMessage(message.getPayload()));
		}
		// 연결되어 있는 모든 클라이언트들에게 메세지 전송
//		session.sendMessage(new TextMessage(message.getPayload()));
		
		// receive_id와 member_id가 같을 때(알림 받아야하는 아이디 = 현 세션 아이디) 메세지 받기
//		if(receive_id.equals(member_id)) {
//			logger.info("{}로 알림받을 아이디임", member_id);
//			session.sendMessage(new TextMessage(message.getPayload()));
//		}
		
	}
	
	// 연결이 끊어진 경우(채팅방 나가면) 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		// 방 구분에 사용할 회원 아이디(세션으로 받아옴)
//		String member_id = session.getUri().getQuery().split("=")[1].toString();
		
		// 삭제할 아이디
		String member_id = (String) session.getAttributes().get("member_id");
		 
		// 맵에서 해당 아이디 세션 제거
		alarmUsers.remove(member_id);
		logger.info("{} 연결 끊김.", member_id);
		logger.info("세션제거 후 : " + alarmUsers.toString());
		
	}
}
