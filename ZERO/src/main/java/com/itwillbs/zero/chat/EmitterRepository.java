//package com.itwillbs.zero.chat;
//
//import java.util.*;
//
//import org.apache.commons.collections.map.*;
//import org.slf4j.*;
//import org.springframework.stereotype.*;
//import org.springframework.web.servlet.mvc.method.annotation.*;
//
//import lombok.*;
//import lombok.extern.slf4j.*;
//
//// 유저 ID로 저장하고 불러 올 수 있도록 HashMap으로 구현
//// 불러올 SseEmitter 없을 경우 Optional.ofNullable로 반환
//@Slf4j
//@Repository
//@RequiredArgsConstructor
//public class EmitterRepository {
//	
//	// 유저 ID를 키로 SseEmitter를 해시맵에 저장
//	private Map<String, SseEmitter> emitterMap = new HashMap<>();
//	
//	// 유저ID와 이미터 저장 - 파라미터 : id, SseEmitter
//	public void save(String userId, SseEmitter sseEmitter) {
//		emitterMap.put(userId, sseEmitter);
//		log.info("SseEmitter {} 저장", userId);
//	}
////	public SseEmitter save(String userId, SseEmitter sseEmitter) {
////		emitterMap.put(userId, sseEmitter);
////		log.info("SseEmitter {} 저장", userId);
////		return sseEmitter;
////	}
//	
//	// 주어진 아이디의 Emitter 가져오기
//	public SseEmitter get(String userId) {
//		log.info("SseEmitter {} 가져오기", userId);
//		return emitterMap.get(userId);
//	}
//	// Optional은 안해도 되는듯도 함
////	public Optional<SseEmitter> get(String userId) {
////		log.info("SseEmitter {} 가져오기", userId);
////		return Optional.ofNullable(emitterMap.get(userId));
////	}
//	
//	// 주어진 아이디의 Emitter 제거
//	// Service에서 쓰이는 deleteById()
//	public void deleteById(String id) {
//		emitterMap.remove(id);
//		log.info("SseEmitter {} 삭제", id);
//	}
//	
//	
//}
