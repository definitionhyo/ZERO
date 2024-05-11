package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AuctionManagingVO {
	private int auction_managing_idx;
	private Timestamp auction_start_datetime;
	private Timestamp auction_end_datetime;
	private String auction_manage_check_status;
	private String auction_manage_status;
	private Timestamp auction_manage_check_date;
	private int auction_idx;
	private String member_id;
	
	// (혜진)
	private String seller_id;

}
