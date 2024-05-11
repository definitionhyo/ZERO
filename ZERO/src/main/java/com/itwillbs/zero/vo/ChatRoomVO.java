package com.itwillbs.zero.vo;

import java.util.*;

import org.springframework.web.context.annotation.*;
import org.springframework.web.socket.*;

import com.itwillbs.zero.service.*;

import lombok.*;

@RequiredArgsConstructor
@Data
public class ChatRoomVO {
	private int chat_room_idx;
	private int secondhand_idx;
	private String seller_id;	// 구매자 아이디
	private String buyer_id;	// 판매자 아이디
	private String seller_nickname;	// 닉네임(DB에서 받아올 때 AS 로 둘을 구별하기)
	private String buyer_nickname;
	
//	// 세션을 관리할 객체 생성
//	private Set<WebSocketSession> sessions = new HashSet<WebSocketSession>();
//	
//	// 채팅방 생성(파라미터 생성자)
//	@Builder
//	public ChatRoomVO(int chat_room_idx, String buyer_id) {
//		// 판매자가 구매자에게 채팅을 걸때 생성하기 때문에 파라미터로 구매자 아이디를 넣음
//		this.chat_room_idx = chat_room_idx;
//		this.buyer_id = buyer_id;
//	}
//	
//	// 해당 채팅방(chat_room_idx)을 찾아 handlerAction로 메세지와 세션을 보냄
//	// 이 메세지의 상태(MessageType) 에 따라 
//	//	=> ENTER면 session을 연결하고 해당 member_id가 입장했다는 것을 알림
//	//  => TALK면 해당 메세지를 해당 채팅방 입장해 있는 모든 클라이언트들(WebSocket session)에게 메세지 보냄
//	public void handlerActions(WebSocketSession session, ChatVO chatMessage, ChatService chatService) {
//		if(chatMessage.getType().equals(ChatVO.MessageType.ENTER)) {
//			sessions.add(session);
//			chatMessage.setChat_content("매너 채팅! 좋은 거래의 시작을 위해 인삿말로 대화를 시작해보세요!");
//			chatMessage.setChat_content_type("안내");
//		}
//		sendMessage(chatMessage, chatService);
//	}
//	
//	private <T> void sendMessage(T message, ChatService chatService) {
//		sessions.parallelStream().forEach(session -> chatService.sendMessage(session, message));
//	}
//	
}
