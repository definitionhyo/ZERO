package com.itwillbs.zero.vo;

import lombok.*;

@Data
public class ChatRoomListVO {
	private int chat_room_idx;
	private int secondhand_idx;
	private String seller_id;	// 구매자 아이디
	private String buyer_id;	// 판매자 아이디
	private String seller_nickname;	// 닉네임(DB에서 받아올 때 AS 로 둘을 구별하기)
	private String buyer_nickname;
	private String seller_image;	// 프로필 사진
	private String buyer_image;
	
	private String secondhand_image1;	// 중고상품 사진 (채팅방-이름, 가격, 상태 여기서 들고와야하나)
	private String chat_time_fromNow;		// 최근 채팅 시간(n분전, n시간 전 표시하기 위해)
	private String chat_content;		// 최근 채팅 내용(미리보기)
	
	
}
