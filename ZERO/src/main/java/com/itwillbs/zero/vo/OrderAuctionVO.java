package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderAuctionVO {
	private int order_auction_idx;
	private long order_auction_price;
	private String order_auction_buyer;
	private String order_auction_seller;
	private int auction_idx;	
	private Timestamp order_auction_deliver_date;
	private String order_auction_delivery_company;
	private int order_auction_delivery_idx;
	private int order_auction_commission;
}
