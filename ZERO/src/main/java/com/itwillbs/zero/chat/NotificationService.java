//package com.itwillbs.zero.chat;
//
//import java.io.*;
//import java.util.*;
//
//import org.springframework.stereotype.*;
//import org.springframework.web.servlet.mvc.method.annotation.*;
//
//import com.itwillbs.zero.chat.*;
//
//@Service
//public class NotificationService {
//	
//	// 기본 타입아웃 설정
////	private static final Long DEFAULT_TIMEOUT = 1000 * 60 * 60L;
//	
//	private final EmitterRepository emitterRepository;
//	
//	public NotificationService(EmitterRepository emitterRepository) {
//		this.emitterRepository = emitterRepository;
//	}
//	
//	// ---- 서버 - 서비스(SSE 연결) 구현 ----------------
//	// 클라이언트가 구독하기 위해 호출하는 메서드
//	// 파라미터 userId(구독하는 클라이언트의 사용자 아이디)		리턴타입 : SseEmitter(서버에서 보낸 이벤트 Emitter)
//	public SseEmitter subscribe(String userId, String lastEventId) {
//        // 1. Last-Event-ID 값에 유저id와 currentTimeMillis()를 결합
//		//	=> 마지막으로 수신한 데이터의 id값을 정확히 구분하기
//        String id = userId + "_" + System.currentTimeMillis();
//        
//        // 2. 클라이언트의 SSE연결 요청에 SsseEmitter 객체로 변환해 응답
//        //	key- id, value- SseEmitter 로 저장,
//        //	시간 초과 및 오류 등 모든 이유로 비동기 요청이 정상적 동작하지 않으면 저장해둔 SseEmitter 삭제
//        
//        // 유저 ID로 SseEmitter 저장
////        SseEmitter emitter = emitterRepository.save(id, new SseEmitter(DEFAULT_TIMEOUT));
//        
//        // 세션 종료 시 저장한 SseEmitter 삭제
////        emitter.onCompletion(() -> emitterRepository.deleteById(id));
////        emitter.onTimeout(() -> emitterRepository.deleteById(id));
//        
//        // 
//        SseEmitter emitter = createEmitter(id);
//
//        // 3. 연결 요청으로 SseEmitter 생성 시 더미 데이터를 보내줘야함
//        // 503 에러를 방지하기 위한 더미 이벤트 전송
//        sendToClient(emitter, id, "EventStream Created. [userId=" + userId + "]");
//
//        // 4. (1과 이어짐) Last-Event-ID값이 헤더에 있으면
//        //	저장된 데이터 캐시에서 id값과 Last-Event-ID값을 통해 유실된 데이터들만 다시 보내줌
//        // 클라이언트가 미수신한 Event 목록이 존재할 경우 전송하여 Event 유실 예방
////        if (!lastEventId.isEmpty()) {
////            Map<String, Object> events = emitterRepository.findAllEventCacheStartWithId(String.valueOf(userId));
////            events.entrySet().stream()
////                  .filter(entry -> lastEventId.compareTo(entry.getKey()) < 0)
////                  .forEach(entry -> sendToClient(emitter, entry.getKey(), entry.getValue()));
////        }
//
//        return emitter;
//    }
//	
//    // 3에 쓰이는 메서드 - 503 에러를 방지하기 위한 더미 이벤트 전송
//	// 파라미터 : id(데이터를 받을 사용자 아이디)		리턴타입 : data 전송할 데이터
//    private void sendToClient(SseEmitter emitter, String id, Object data) {
//        try {
//            emitter.send(SseEmitter.event()
//                                   .id(id)
//                                   .name("sse")
//                                   .data(data));
//        } catch (IOException exception) {
//            emitterRepository.deleteById(id);
//            throw new RuntimeException("연결 오류!");
//        }
//    }
//    
//    // ------ 서버 - 서비스(데이터 전송) 구현 ----------
//    
//    // 서버의 이벤트를 클라이언트에게 보내는 메서드
//    // 파라미터 : userId(메세지를 전송할 사용자 아이디), event(전송할 이벤트 객체)
//    public void notify(String userId, Object event) {
//    	SseEmitter emitter = emitterRepository.get(userId);
//    	sendToClient(emitter, userId, event);
//    }
//    
//    // 실제 클라이언트에 데이터를 전송하는 부분
////    public void send(String receiver, String review, String content) {
////    	Notification notification = createNotification(receiver, review, content);
////        String id = String.valueOf(receiver.getId());
////        
////        // 로그인 한 유저의 SseEmitter 모두 가져오기
////        Map<String, SseEmitter> sseEmitters = emitterRepository.findAllStartWithById(id);
////        sseEmitters.forEach(
////                (key, emitter) -> {
////                    // 데이터 캐시 저장(유실된 데이터 처리하기 위함)
////                    emitterRepository.saveEventCache(key, notification);
////                    // 데이터 전송
////                    sendToClient(emitter, key, NotificationResponse.from(notification));
////                }
////        );
////    }
//    
////    private Notification createNotification(String receiver, String review, String content) {
////        return Notification.builder()
////                .receiver(receiver)
////                .content(content)
////                .review(review)
////                .url("/reviews/" + review.getId())
////                .isRead(false)
////                .build();
////    }
//    
//    // 사용자 아이디를 기반으로 이벤트 Emitter 생성
//    // 파라미터 : id(사용자 아이디)		리턴타입 : SseEmitter(생성된 이벤트 Emitter)
//    private SseEmitter createEmitter(String id) {
//    	SseEmitter emitter = new SseEmitter(DEFAULT_TIMEOUT);
//    	emitterRepository.save(id, emitter);
//    	
//    	// Emitter가 완료될 때(모든 데이터가 성공적으로 전송된 상태) => Emitter 삭제
//    	emitter.onCompletion(() -> emitterRepository.deleteById(id));
//    	// 타임아웃될 때(지정된 시간동안 아무 이벤트도 전송되지 않았을 때) => Emitter 삭제
//    	emitter.onCompletion(() -> emitterRepository.deleteById(id));
//    	
//    	return emitter;
//    }
//    
//}