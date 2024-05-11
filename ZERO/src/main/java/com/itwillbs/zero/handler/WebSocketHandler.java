//package com.itwillbs.zero.handler;
//
//import org.springframework.stereotype.*;
//import org.springframework.web.socket.*;
//import org.springframework.web.socket.handler.*;
//
//import com.fasterxml.jackson.databind.*;
//import com.itwillbs.zero.service.*;
//import com.itwillbs.zero.vo.*;
//
//import lombok.*;
//import lombok.extern.slf4j.*;
//
///* 웹소켓 클라이언트로부터 채팅 메세지를 전달받아 채팅 메세지 객체로 변환
// * 전달받은 메세지에 담긴 채팅방 ID(chat_room_idx)로 발송 대상 채팅방 정보 조회
// * 해당 채팅방에 입장해 있는 모든 클라이언트(Websocket Session) 에게 타입에 따른 메세지 발송
//*/
//
//@Slf4j
//@Component
//@RequiredArgsConstructor
//public class WebSocketHandler extends TextWebSocketHandler {
//	
//	private final ObjectMapper mapper;
//	private final ChatService service;
//	@Override
//	protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
//		String payload = message.getPayload().toString();
//		log.info("payload {}", payload);
////		super.handleBinaryMessage(session, message);
//		
////		TextMessage textMessage = new TextMessage("Welcome Chatting Server");
////		session.sendMessage(textMessage);
//		
//		ChatVO chatMessage = mapper.readValue(payload, ChatVO.class);
//		log.info("session {}", chatMessage.toString());
//		
//		ChatRoomVO chatRoom = service.findRoomById(chatMessage.getChat_room_idx());
//		log.info("room {}", chatRoom.toString());
//		
//		chatRoom.handleAction(session, chatMessage, service);
//	}
//	
//	
//	
//}
