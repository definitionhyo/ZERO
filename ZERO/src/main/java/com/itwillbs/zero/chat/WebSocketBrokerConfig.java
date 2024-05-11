//package com.itwillbs.zero.chat;
//
//import org.springframework.context.annotation.*;
//import org.springframework.messaging.simp.config.*;
//import org.springframework.web.socket.*;
//import org.springframework.web.socket.config.annotation.*;
//import org.springframework.web.socket.server.support.*;
//
//import com.itwillbs.zero.handler.*;
//
//import lombok.*;
//
//// 정보를 처리할 Handler와 webSocket 주소를 WebSocketHandlerRegistry에 추가하면
//// 해당 주소로 접근 시 웹소켓을 연결할 수 있다
//
//@Configuration
//@EnableWebSocketMessageBroker
//public class WebSocketBrokerConfig implements WebSocketMessageBrokerConfigurer {
//	
//	// sockJS Fallback을 이용해 노출할 endpoint 설정
//	@Override
//	public void registerStompEndpoints(StompEndpointRegistry registry) {
//		// 웹소켓이 handshake를 하기 위해 연결하는 endpoint
//		registry.addEndpoint("/ws").setAllowedOrigins("*").withSockJS();
//	}
//
//	// 알림 관련
//	// 메세지 브로커에 관한 설정
//	@Override
//	public void configureMessageBroker(MessageBrokerRegistry registry) {
//		// TODO Auto-generated method stub
//		WebSocketMessageBrokerConfigurer.super.configureMessageBroker(registry);
//	}
//	
//}
