//package com.itwillbs.zero.chat;
//
//import org.springframework.beans.factory.annotation.*;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.servlet.mvc.method.annotation.*;
//
//import com.itwillbs.zero.service.*;
//
//@RestController
//public class NotificationController {
//	
//	@Autowired
//	private final NotificationService notificationService;
//	
//	public NotificationController(NotificationService notificationService) {
//		this.notificationService = notificationService;
//	}
//	
//	// 클라이언트에서 구독하기 위한 메서드
//	@GetMapping(value ="/subscribe/{id}", produces = "text/event-stream")
//	public SseEmitter subscribe (@PathVariable String id,
//								@RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId) {
//		// 주기적으로 Last-Event-ID 헤더를 받고 있음(연결 끊어졌을 때 확인 후 계속 받을 수 있기 때문)
//		return notificationService.subscribe(id, lastEventId);
//	}
//	
//	// 임시로 서버에서 클라이언트로 알림을 주기 위한 sendData()
//	@PostMapping("/send-data/{id}")
//	public void sendData(@PathVariable String id) {
//		notificationService.notify(id, "data");
//	}
//}
