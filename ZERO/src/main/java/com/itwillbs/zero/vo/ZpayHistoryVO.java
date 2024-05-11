package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ZpayHistoryVO {
	private int zpay_history_idx;
	private int zpay_idx;
	private long zpay_amount;
	private Timestamp zpay_time;
	private long zpay_balance;
	private String member_id;
	private String zpay_deal_type;
	private int order_auction_idx;
	private int order_secondhand_idx;
	
	// -----------------------------------
	private String order_secondhand_product;
	private String auction_title;
	private String auction_idx;
	private String seller_id;
	private String secondhand_idx;
	private String order_auction_title;
	private int auctionIdxForOrderAuction;
	
}
