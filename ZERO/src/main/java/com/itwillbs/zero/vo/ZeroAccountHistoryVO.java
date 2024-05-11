package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ZeroAccountHistoryVO {
	private int zero_account_history_idx;
	private String member_id;
	private int zpay_history_idx;
	private long zero_account_balance;
	private long zero_account_amount;
	private int order_secondhand_idx;
	private int order_auction_idx;
	private Timestamp zero_account_time;
	private int auction_idx;
	private String zman_id;
	private String zero_account_type;
	
}
