//package com.itwillbs.zero.service;
//
//import java.io.*;
//import java.util.*;
//
//import javax.annotation.*;
//
//import org.springframework.beans.factory.annotation.*;
//import org.springframework.stereotype.*;
//import org.springframework.web.socket.*;
//
//import com.fasterxml.jackson.databind.*;
//import com.itwillbs.zero.vo.*;
//
//import lombok.*;
//import lombok.extern.slf4j.*;
//
//@Slf4j
////@RequiredArgsConstructor
//@Service
//public class ChatService {
//	private final ObjectMapper objectMapper;
//	private Map<Integer, ChatRoomVO> chatRooms; // key-채팅방idx , value-채팅방VO로 갖는 Map
//	
//	@Autowired
//	public ChatService(ObjectMapper objectMapper) {
//		this.objectMapper = objectMapper;
//	}
//	
//	
//	@PostConstruct
//	private void init() {
//		chatRooms = new LinkedHashMap<Integer, ChatRoomVO>();
//	}
//	
//	public List<ChatRoomVO> findAllRoom() {
//		return new ArrayList<>(chatRooms.values());
//	}
//	
//	// chat_room_idx로 채팅방 찾아오는 메서드
//	public ChatRoomVO findRoomById(int chat_room_idx) {
//		return chatRooms.get(chat_room_idx);
//	}
//	
//	// 새로운 방 생성(랜덤 번호로 생성)
//	public ChatRoomVO createRoom(String buyer_id) {
////		String randomId = UUID.randomUUID().toString();
//		int randomIdx = (int)((Math.random()* (99999 - 10000 + 1)) + 10000); // 다섯자리 랜덤 숫자
//		ChatRoomVO chatRoom = ChatRoomVO.builder()
//				.chat_room_idx(randomIdx)
//				.buyer_id(buyer_id)
//				.build();
//		chatRooms.put(randomIdx, chatRoom);
//		return chatRoom;
//	}
//	
//	// TALK 상태일 경우에 실행되는 메서드 - 메세지를 해당 채팅방의 webSocket 세션에 보내는 메서드
//	public <T> void sendMessage(WebSocketSession session, T message) {
//		try {
//			session.sendMessage(new TextMessage(objectMapper.writeValueAsString(message)));
//		} catch (IOException e) {
//			log.error(e.getMessage(), e);
//		}
//	}
//	
//	
//}
