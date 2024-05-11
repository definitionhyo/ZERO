package com.itwillbs.zero.handler;

import org.springframework.context.annotation.*;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.socket.*;
import org.springframework.web.socket.config.annotation.*;
import org.springframework.web.socket.server.support.*;

import lombok.*;

// 정보를 처리할 Handler와 webSocket 주소를 WebSocketHandlerRegistry에 추가하면
// 해당 주소로 접근 시 웹소켓을 연결할 수 있다

@RequiredArgsConstructor
@Configuration
@EnableWebSocket	// => 웹소켓 활성화
public class WebSockConfig implements WebSocketConfigurer {
	// WebSocketHandler 에 관한 생성자 추가
	private final ChattingHandler chattingHandler;
	private final AlarmHandler alarmHandler;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// endpoint 설정 : /ws/chatMsg
        // 이를 통해서 ws://localhost:8089/ws/chat 으로 요청이 들어오면 websocket 통신을 진행한다.
//		registry.addHandler(chattingHandler, "/chatting").setAllowedOrigins("*");
		registry.addHandler(chattingHandler, "/chatting")
					.setAllowedOrigins("*")
					.addInterceptors(new HttpSessionHandshakeInterceptor());
		// interceptor for adding httpsession into websocket session
		// interceptor를 사용해서 HTTP session안에 있는 member_id 사용하기!
		
		// 분리용으로 만들어둠(지영) - 알림
		registry.addHandler(alarmHandler, "/alarm")
					.setAllowedOrigins("*")
					.addInterceptors(new HttpSessionHandshakeInterceptor());
	}
	
	
	
	
}
