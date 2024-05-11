package com.itwillbs.zero.controller;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.*;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;

import com.itwillbs.zero.handler.*;
import com.itwillbs.zero.service.*;
import com.itwillbs.zero.vo.*;

@Controller
public class ChattingController {
	
	private static final Logger logger = LoggerFactory.getLogger(ChattingHandler.class);
	
	@Autowired
	private ChattingService service;
	@Autowired
	private ZpayService zpayService;
	@Autowired
	private AlarmService alarmService;
	
	@Autowired
	private SecondhandService secondhandService;
	
	// 채팅 페이지로 이동
	@GetMapping("chatList")
	public String chat(HttpSession session, Model model) {
		
		// 로그인 해야 들어갈 수 있음!
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", "로그인이 필요한 작업입니다!");
			return "fail_back";
		}
		
		// 회원아이디(sId)로 채팅방 조회
		// 파라미터 : member_id		리턴타입 : List<ChatRoomListVO>(chatRoomList)
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int pageNum = 1;
		int listLimit = 12; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		List<ChatRoomListVO> chatRoomList = service.selectChatRoomList(member_id, pageNum, startRow, listLimit);
		logger.info("*** 채팅방 리스트 : " + chatRoomList);
		
		model.addAttribute("chatRoomList", chatRoomList);
		
		return "chatting/chat_list";
	}
	
	@GetMapping("chatListJson")
	public String chatListJson (HttpSession session, @RequestParam(defaultValue = "1") int pageNum) {
		
		String member_id = (String) session.getAttribute("member_id");
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 12; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		List<ChatRoomListVO> chatRoomList = service.selectChatRoomList(member_id, pageNum, startRow, listLimit);
		// -------------------------------------------------------------------------
		// 페이징 처리를 위한 계산 작업
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		// 1. BoardService - getBoardListCount() 메서드를 호출하여
		//    전체 게시물 수 조회 요청(페이지 목록 계산에 활용)
		int listCount = service.getChatRoomListCount(member_id);
//		System.out.println("전체 게시물 수 : " + listCount);
//				
		// 2. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		// => 이것도 리턴값으로 들고가고 싶다 => 객체로 넣기(boardList = XX, maxPage = xx) => JSONObject
		
		// 최대 페이지번호(maxPage) 값도 JSON 데이터로 함께 넘기기
		// 기존 목록을 JSONObject 객체를 통해 객체 형태로 변환하고, 최대 페이지번호도 함께 추가
		JSONObject jsonObject = new JSONObject();
		// JSONXXX 객체의 put() 메서드를 사용하여 데이터 추가 가능
		// JSONObject 안에는 Collection 객체를 넣을수도 있기 때문에 굳이 JSONArray를 쓰지 않아도 된다
		// (물론 그냥 JSONArray를 써도 됨) => 그냥 여러개의 목록을 한꺼번에 내보낼 수 있다
		jsonObject.put("chatRoomList", chatRoomList);
		jsonObject.put("maxPage", maxPage);
		jsonObject.put("listCount", listCount);
//		System.out.println(jsonObject);
		
		return jsonObject.toString();
	}
	
	// 채팅창으로 연결
	// 중고거래관련 가져올 정보
	// 중고상품 번호, 사진, 상태, 가격 - secondhand_idx, secondhand_image1, secondhand_deal_status, secondhand_price
	@RequestMapping(value = "chatRoom", method = {RequestMethod.GET, RequestMethod.POST})
	public String chatRoom(String room_idx, HttpSession session, Model model) {
		String member_id = (String) session.getAttribute("member_id");
		
		// 채팅방 번호
		int chat_room_idx = Integer.parseInt(room_idx.split("_")[1]);
//		System.out.println("채팅방 번호 : " + chat_room_idx);
		
		// 채팅방 번호로 들어갈 수 있는 아이디 조회
		ChatRoomVO chatRoom = service.selectChatRoom(chat_room_idx);
		System.out.println("채팅방 정보 : " + chatRoom);
		
		// 채팅방에 저장된 판매자나 구매자가 아닐때는 접근 불가!
		if(!member_id.equals(chatRoom.getBuyer_id()) && !member_id.equals(chatRoom.getSeller_id())) {
			model.addAttribute("msg", "접근불가");
			return "fail_back";
		}
		
		// 받아온 채팅방 번호(chat_room_idx) 로 채팅 조회
		// 파라미터 : chat_room_idx		리턴타입 : List<ChatVO>(chatList)
		int pageNum = 1;
		int listLimit = 15; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit;
		List<ChatVO> chatList = service.selectChatList(chat_room_idx, pageNum, startRow, listLimit);
		logger.info("*** 채팅내역 : " + chatList);
		
		// 채팅방 번호로 중고상품 정보 조회(채팅방 조회로 받아온 값 중 중고상품 번호 받아오기)
		int secondhand_idx = chatRoom.getSecondhand_idx();
		SecondhandVO secondhandInfo = secondhandService.getSecondhandProduct(secondhand_idx);
		logger.info("*** 중고상품 정보 : " + secondhandInfo);
		
		// ORDER_SECONDHAND 테이블에 order_secondhand_idx 등의 정보 들고와야할듯
		OrderSecondhandVO orderSecondhandInfo = service.getOrderSecondhandInfo(secondhand_idx);
		if(orderSecondhandInfo != null) {
			model.addAttribute("orderSecondhandInfo", orderSecondhandInfo);
			logger.info("*** 중고상품 거래정보 orderSecondhandInfo : " + orderSecondhandInfo);
			
			// z맨 호출여부 등을 조회
			ZmanDeliveryVO zmanCallInfo = service.getZmanOrderInfo(orderSecondhandInfo.getOrder_secondhand_idx());
			if(zmanCallInfo != null) {
				model.addAttribute("zmanCallInfo", zmanCallInfo);
				logger.info("*** 호출 여부 zmanCallInfo : " + zmanCallInfo);
			}
		}
		
		
		// 판매자가 z페이 사용자일 때 송금하기 가능
		String seller_id = chatRoom.getSeller_id();
		logger.info("*** 판매자 아이디 : " + seller_id);
		ZpayVO zpay = zpayService.isZpayUser(seller_id);
		boolean isZpayUser = false;
		if(zpay != null) {
			isZpayUser = true;
		}
		
		// 알림을 받아서 들어왔으면 알림 읽었다고 표시하기
		// 파라미터 : member_id(세션), chat_room_idx
//		boolean isRead = alarmService.readAlarm(member_id, chat_room_idx);
//		if(isRead) {
//			logger.info("*** 알림 상태 변경 isRead : " + isRead);
//		}
		
		
		// 채팅내용, 채팅방 정보, 중고상품 정보 받아오기
		model.addAttribute("chatList", chatList);
		model.addAttribute("chat_room_idx", chat_room_idx);
		model.addAttribute("chatRoom", chatRoom);
		model.addAttribute("secondhandInfo", secondhandInfo);
		model.addAttribute("isZpayUser", isZpayUser);
		
		return "chatting/chat";
	}
	
	// 채팅목록 가져오기
	@ResponseBody
	@GetMapping("chatMsgList")
	public String chatMsgList(
			@RequestParam(defaultValue = "2") int pageNum, int chat_room_idx) {
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 15; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		// 받아온 채팅방 번호(chat_room_idx) 로 채팅 조회
		// 파라미터 : chat_room_idx		리턴타입 : List<ChatVO>(chatList)
		List<ChatVO> beforeChatList = service.selectChatList(chat_room_idx, pageNum, startRow, listLimit);
		logger.info("*** 채팅내역 : " + beforeChatList);
		
		// 페이징 처리를 위한 계산 작업
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		//    전체 게시물 수 조회 요청(페이지 목록 계산에 활용)
		int listCount = service.getChatListCount(chat_room_idx);
//		System.out.println("전체 게시물 수 : " + listCount);
//				
		// 2. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		// => 이것도 리턴값으로 들고가고 싶다 => 객체로 넣기(boardList = XX, maxPage = xx) => JSONObject
		
		// 최대 페이지번호(maxPage) 값도 JSON 데이터로 함께 넘기기
		// 기존 목록을 JSONObject 객체를 통해 객체 형태로 변환하고, 최대 페이지번호도 함께 추가
		JSONObject jsonObject = new JSONObject();
		// JSONXXX 객체의 put() 메서드를 사용하여 데이터 추가 가능
		// JSONObject 안에는 Collection 객체를 넣을수도 있기 때문에 굳이 JSONArray를 쓰지 않아도 된다
		// (물론 그냥 JSONArray를 써도 됨) => 그냥 여러개의 목록을 한꺼번에 내보낼 수 있다
		jsonObject.put("beforeChatList", beforeChatList);
		jsonObject.put("maxPage", maxPage);
		jsonObject.put("listCount", listCount);
//		System.out.println(jsonObject);
		
		return jsonObject.toString();
		
	}
	
	
	// 실시간 채팅 DB에 저장하기
	@ResponseBody
	@PostMapping("chatRemember")
	public void chatRemember(@RequestParam Map<String, String> map, HttpSession session) {
		logger.info("*** 넘어온 파라미터들 : " + map.toString());
		
		// 채팅방 번호 String-> int로 바꾸기
		String room_idx = map.remove("room_idx");
		String chat_room_idx = room_idx.split("_")[1];
		map.put("chat_room_idx", chat_room_idx);
		
		// 받아온 채팅내용이 만약 안내타입인 경우("&-안내"로 시작)
		// 키워드를 때고 DB에 저장
		String content = map.get("chat_content");
		if(content.startsWith("&-안내")) {
			map.replace("chat_content", content, content.split("&-안내")[1]);
		}
		
		// 받아온 채팅내용(chat_content), 채팅방번호(chat_room_idx), 메세지보낸사람(member_id) 정보 넣기
		// 파라미터 : map		리턴타입 : boolean(isInsert)
		boolean isInsert = service.insertChat(map);
		logger.info("*** 채팅내역 INSERT : " + isInsert);
		
	}
	
	// 사진 보낼 때
	@ResponseBody
    @RequestMapping(value = "/sendPhoto",
    				method = RequestMethod.POST,
    				produces = "text/plain; charset=utf-8")
    public String sendPhoto(MultipartFile chatImage,
    						HttpServletRequest request){

    	String result = "";
    	System.out.println(chatImage.toString());
//    	
//    	//파일 저장될 경로 가져오기 (HttpServletRequest 필요함)
//		String saveDirectory = request.getServletContext() //context-path (webapp)
//									  .getRealPath("/resources/upload/chat");
//
//
//
//		String fileName = file.getOriginalFilename();
//		logger.debug("fileName = {}", fileName);
//
//		//파일명 생성
//		String renamedFileName = Utils.getRenamedFileName(fileName);
//		
//		//메모리의 파일 -> 서버경로상의 파일로 이동
//		File newFile = new File(saveDirectory, renamedFileName);
//		try {
//			file.transferTo(newFile);
//		} catch (IllegalStateException | IOException e) {
//			e.printStackTrace();
//		}			
//		
//		result = fileName + "/" + renamedFileName ;

    	return result;
    }       
	
	
	// 중고상품에서 채팅하기 클릭 시 채팅방으로 이동
	// 상품페이지에서 secondhand_idx, seller_id를 받아오고 세션에서 buyer_id를 받아와서
	// DB - CHAT_ROOM에 일치하는 값이 
	//		없으면 생성을 (INSERT INTO CHAT_ROOM - 파라미터 세개)
	// 		있으면 값을 가져와서 "chatRoom"로 연결
	@RequestMapping(value = "doChat", method = {RequestMethod.GET, RequestMethod.POST})
	public String doChat(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		
		// 로그인 해야 들어갈 수 있음!
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", "로그인이 필요한 작업입니다!");
			return "fail_back";
		}
		// 판매자 아이디 받아오기
		String buyer_id = member_id;
		
		// 채팅방 찾기
		int chat_room_idx = service.selectChatRoomIdx(map, buyer_id);
		logger.info("채팅방 번호 : " + chat_room_idx);
		
		// 채팅방 유무 판별
		if(chat_room_idx == 0) {
			// 채팅방이 없으면
			// => 채팅방 생성하기
			int insertChatRoom = service.insertChatRoom(map, buyer_id);
			chat_room_idx = service.selectChatRoomIdx(map, buyer_id);
		}
		
		// 채팅방이 있으면
		// => 채팅방으로 이동(채팅방 번호 : chat_room_idx)
	
		// 채팅방 번호 들고오기
		return "redirect:/chatRoom?room_idx=chat_" + chat_room_idx;
		
	}
	
	// 채팅창에서 거래하기 클릭 시 모달창에서 받은 거래방법과 정보를 DB에 저장
	@ResponseBody
	@PostMapping("ChatDeal")
	public void chatDeal (@RequestParam Map<String, String> map, HttpSession session) {
		
		// 거래정보를 ORDER_SECONDHAND에 저장하기
		boolean isInsert = service.insertOrderInfo(map);
		logger.info("*** 거래 정보 INSERT : " + isInsert);
		
		// 거래하기를 선택해서 거래방법을 누르면 상품 상태가 '판매중' 에서 '예약중'으로 변경
		String type = "예약중";
		int secondhand_idx = Integer.parseInt(map.get("secondhand_idx"));
		boolean isChange = service.updateDealStatus(secondhand_idx, type);
		logger.info("*** 상품 상태 UPDATE : " + isChange);
		
	}
	
	// Z맨 호출 접수하기 버튼 클릭 시 뜨는 창 매핑
	@RequestMapping(value = "chatToZ", method = {RequestMethod.GET, RequestMethod.POST})
	public String chatToZ(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		
		int order_secondhand_idx = service.getOrderSecondhandIdx(map.get("secondhand_idx"));
		map.put("order_secondhand_idx", String.valueOf(order_secondhand_idx));
		
		// z맨 호출신청 폼에 필요한 주소 등 데이터 가져오기
		// ORDER_SECONDHAND 에서 입력한 판매자, 구매자 주소 들고오기
		// order_secondhand_idx로 조회해서 zman_delivery_startspot, zman_delivery_endspot 가져오기
		ZmanDeliveryVO zmanOrderInfo = service.getZmanOrderInfo(order_secondhand_idx);
		logger.info("*** Z맨 거래 정보 zmanOrderInfo : " + zmanOrderInfo);

		if(zmanOrderInfo == null) {
//			// 가져올 z맨 호출신청 관련 데이터가 없으면 가져온 값을 DB에 넣기
			int isInsert = service.setZmanOrderInfo(map);
			logger.info("*** Z맨 거래 정보 INSERT : " + isInsert);
		} else if (map.get("type") != null){
			logger.info("*** 가져온 파라미터 map : " + map);
			// z맨 호출신청 관련 데이터가 있으면 가져온 값을 DB에 업데이트 하기
			// zmanOrderInfo 안의 zman_delivery_idx로 조회해 UPDATE 하기
			int updateCount = service.updateZmanOrderInfo(map, zmanOrderInfo.getZman_delivery_idx());
			logger.info("*** Z맨 거래 정보 UPDATE : " + updateCount);
		}
		
		// 입력한 값들, 예전에 넣은 값들을 가져와서 폼으로 전달하기
		model.addAttribute("zmanOrderInfo", zmanOrderInfo);
		// 외에 앞 페이지에서 받은 값 그대로 들고가기(secondhand_subject, secondhand_price)
		model.addAttribute("orderInfo", map);
		
		return "chatting/chat_deal_zman";
	}
	
	// Z맨 최종 호출(주소지 모두 입력)할 때 DB에 입력
	@ResponseBody
	@PostMapping("callZ")
	public void callZ(@RequestParam Map<String, String> map) {
		boolean isCall = service.callZman(map.get("zman_delivery_idx"));
		logger.info("*** Z맨 호출 : " + isCall);
	}
	
	// ----------- 거래하기 관련(송금, 약속, 후기) ---------------
	// Z페이 송금하기 폼으로 이동
	@RequestMapping(value = "ZpayForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String  ZpayForm(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 구매자가 z페이 사용자가 아닐 때 zpay페이지로 이동하기
		String buyer_id = map.get("buyer_id");
		logger.info("*** 구매자 아이디 : " + buyer_id);
		ZpayVO zpay = zpayService.isZpayUser(buyer_id);
		if(zpay == null) {
			model.addAttribute("msg", "현재 Z페이 이용자가 아닙니다!");	
			model.addAttribute("isClose", "true");	
			return "fail_back";
		}
		
		// 받은 값 그대로 전달
		model.addAttribute("map", map);
		logger.info("*** 이동하는 파라미터 : " + map);
		
		return "chatting/chat_deal_zpay";
	}
	
	// 거래완료 버튼 눌렀을 경우 - 거래완료, 판매완료로 변경
	@ResponseBody
	@PostMapping("finishDeal")
	public void finishDeal(int secondhand_idx) {
		logger.info("○○○○○ secondhand_idx : " + secondhand_idx);
		
		// 중고상품 상태 변경 - SECONDHAND - secondhand_deal_status '판매완료'
		String type = "판매완료";
		boolean isChange = service.updateDealStatus(secondhand_idx, type);
		
		logger.info("○○○○○ 상품-판매완료로 상태변경 : " + isChange);
		
		// 주문내역 상태 변경 - ORDER_SECONDHAND - order_secondhand_status '거래완료'
		String order_status_type = "거래완료";
		boolean isOrderStateChange = service.updateOrderStatus(secondhand_idx, order_status_type);
		logger.info("○○○○○ 주문-거래완료로 상태변경 : " + isOrderStateChange);
		
		
	}
	
	
	
	
}
