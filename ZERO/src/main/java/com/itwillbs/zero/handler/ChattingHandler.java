package com.itwillbs.zero.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
@RequestMapping("/chatting")
public class ChattingHandler extends TextWebSocketHandler{
	
	// WebSocket 세션 저장할 리스트 생성(전체 채팅, 알림)
//	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Map<String, Map<String,WebSocketSession>> roomUsers = new HashMap<>();
	// Map<방번호, Map<httpsession아이디,WebSocketSession>>
	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	public static Map<String,WebSocketSession>getMap(String name,WebSocketSession session) {
		//innermap 셋팅 함수
		Map<String, WebSocketSession> map = new HashMap<>();
        map.put(name, session);
        return map;
    }
	
	// 클라이언트가 채팅을 위해 해당 페이지에 들어오면 클라이언트 연결, 해당 클라이언트 세션을 저장
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		logger.info("Socket 연결됨!");
		
		String roomNum=session.getUri().getQuery().split("=")[1].toString();
		//session.getUri().getQuery()=>http://localhost:8089/zero/chatting? 뒤에 파라미터 (ex id=1) 가져옴 .split("=")[1].toString()= '1'
		Map<String,Object> map = session.getAttributes();
		 String userId = (String)map.get("member_id");
		
		if(userId==null) {return;}//세션 끊어졌을때 처리
		if(roomUsers.get(roomNum)==null) {
			//Map roomUsers에 저장된 방이 없으면(ex 1번 방 없으면)
			roomUsers.put(roomNum,getMap(userId, session));
			//방번호(ex 1),userId, session 저장
			System.out.println("새로운방");
			
		}else {
			if(roomUsers.get(roomNum).get(userId)==null) {
				//방은 있는데 유저아이디가 없다?
			roomUsers.get(roomNum).put(userId, session);
			//(ex 1번방)에 userId, session 저장
			System.out.println("put");
			}else {
			roomUsers.get(roomNum).replace(userId, session);
			//방도 있고 유저아이디도 있다? userId에 session을 replace
			System.out.println("replace");
			}
			
		}
		
		logger.info(roomUsers.toString());
		
		logger.info(userId + "님이 입장하셨습니다.");
		logger.info(roomUsers.get(roomNum).keySet().toString());
		
		if(!roomNum.contains("chat")) {//채팅방에는 전송안함
		for ( String key : (roomUsers.get(roomNum).keySet())) {
			WebSocketSession s=roomUsers.get(roomNum).get(key);
			s.sendMessage(new TextMessage(userId + ":" + ""+":"+roomUsers.get(roomNum).keySet()));
		}
			
		}
//		sessionList.add(session);
//		logger.info(sessionList.toString());
		
	}
	
	// WebSocket 서버로 데이터 전송 - 세션이(누가) 뷰페이지에서 메세지를 보냄
	// Session 모두에게 메세지를 전달해야 하므로 loop를 돌며 메세지를 전송한다.
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		logger.info("#ChattingHandler, handleMessage");
		
		String roomNum=session.getUri().getQuery().split("=")[1].toString();
		Map<String,Object> map = session.getAttributes();
		 System.out.println(map);
		  String userId = (String)map.get("member_id");
		 logger.info(userId);
		 
		
		 // 연결된 방의 클라이언트에게 메세지 전송
		 for ( String key : (roomUsers.get(roomNum).keySet())) {
				WebSocketSession s=roomUsers.get(roomNum).get(key);
				s.sendMessage(new TextMessage(userId + ":" + message.getPayload()));
				
			}
//		for(WebSocketSession s : sessionList) {
//			s.sendMessage(new TextMessage(userId + ":" + message.getPayload()));
//			s.sendMessage(new TextMessage(message.getPayload()));
//		}
	}
	
	// 연결이 끊어진 경우(채팅방 나가면) 해당 세션 제거
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		String roomNum=session.getUri().getQuery().split("=")[1].toString();
		
		Map<String,Object> map = session.getAttributes();
		 
		  String userId = (String)map.get("member_id");
		
		 // 맵에서 해당 아이디 세션 제거
		 roomUsers.get(roomNum).remove(userId);
		//방비었으면 제거
		 if(roomUsers.get(roomNum).isEmpty()) {
			 roomUsers.remove(roomNum);
		 }
		 logger.info(roomUsers.toString());
		
		 logger.info(userId + "님이 퇴장하셨습니다.");
		
		 if(!roomUsers.isEmpty()) { 
			 logger.info(roomUsers.get(roomNum).keySet().toString());
		 if(!roomNum.contains("chat")) {//채팅방에는 전송안함
				 for ( String key : (roomUsers.get(roomNum).keySet())) {
						WebSocketSession s=roomUsers.get(roomNum).get(key);
						s.sendMessage(new TextMessage(userId + ":" +""+":"+roomUsers.get(roomNum).keySet()));
						
						}
			 }
		 }
		
	}
}
