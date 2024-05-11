package com.itwillbs.zero.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.zero.mapper.*;
import com.itwillbs.zero.vo.*;

@Service
public class ChattingService {

	@Autowired
	private ChattingMapper mapper;
	
	// 채팅방 정보 조회
	public List<ChatRoomListVO> selectChatRoomList(String member_id, int pageNum, int startRow, int listLimit) {
		return mapper.selectChatRoomList(member_id, pageNum, startRow, listLimit);
	}

	// 채팅방 갯수 조회
	public int getChatRoomListCount(String member_id) {
		return mapper.selectChatRoomListCount(member_id);
	}
	// 채팅 내역 조회
	public List<ChatVO> selectChatList(int chat_room_idx, int pageNum, int startRow, int listLimit) {
		return mapper.selectChatList(chat_room_idx, pageNum, startRow, listLimit);
	}

	// 채팅 무한스크롤을 위한 총 페이지 계산
	public int getChatListCount(int chat_room_idx) {
		return mapper.selectGetChatListCount(chat_room_idx);
	}
	
	// 채팅 내역 삽입
	public boolean insertChat(Map<String, String> map) {
		int insertChat = mapper.insertChat(map);
		if(insertChat > 0) {
			return true;
		}
		return false;
	}
	
	// 채팅방 찾기
	public int selectChatRoomIdx(Map<String, String> map, String buyer_id) {
		return mapper.selectChatRoomIdx(map, buyer_id);
	}
	
	// 채팅방 생성하기
	public int insertChatRoom(Map<String, String> map, String buyer_id) {
		return mapper.insertChatRoom(map, buyer_id);
	}
	
	// 채팅방에 대한 정보 조회
	public ChatRoomVO selectChatRoom(int chat_room_idx) {
		return mapper.selectChatRoom(chat_room_idx);
	}
	
	// 거래정보를 ORDER_SECONDHAND에 저장
	public boolean insertOrderInfo(Map<String, String> map) {
		int insertChat = mapper.insertOrderInfo(map);
		if(insertChat > 0) {
			return true;
		}
		return false;
	}
	
	// 거래상태 변경 '판매중' -> '예약중'
	public boolean updateDealStatus(int secondhand_idx, String type) {
		int updateStatus = mapper.updateDealStatuse(secondhand_idx, type);
		if (updateStatus > 0) {
			return true;
		}
		return false;
	}
	
	// --- 나중에 옮기기 ---
	// 신청폼 들어올 때 값 넣기
	public int setZmanOrderInfo(Map<String, String> map) {
		return mapper.insertZmanOrderInfo(map);
	}
	
	// z맨 호출신청 폼에 필요한 order_secondhand_idx 조회하기
	public int getOrderSecondhandIdx(String secondhand_idx) {
		return mapper.selectOrderSecondhandIdx(secondhand_idx);
	}
	// z맨 호출신청 폼에 필요한 주소 등 데이터 가져오기
	public ZmanDeliveryVO getZmanOrderInfo(int order_secondhand_idx) {
		return mapper.selectZmanOrderInfo(order_secondhand_idx);
	}
	// 주소 받아 DB에 업데이트
	public int updateZmanOrderInfo(Map<String, String> map, int zman_delivery_idx) {
		return mapper.updateZmanOrderInfo(map, zman_delivery_idx);
	}
	
	// Z맨 최종 호출
	public boolean callZman(String zman_delivery_idx) {
		int updateCount = mapper.updateZDelivery(zman_delivery_idx);
		if(updateCount > 0) {
			return true;
		}
		return false;
	}
	
	// 중고거래 정보 조회 - Z페이
	public OrderSecondhandVO getOrderSecondhandInfo(int secondhand_idx) {
		return mapper.selectOrderSecondhandInfo(secondhand_idx);
	}
	
	// 주문내역 상태 변경 - ORDER_SECONDHAND - order_secondhand_status '거래완료'
	public boolean updateOrderStatus(int secondhand_idx, String order_status_type) {
		int updateCount = mapper.updateOrderStatus(secondhand_idx, order_status_type);
		if (updateCount > 0) {
			return true;
		}
		return false;
	}



	
	
}
