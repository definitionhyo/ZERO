package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ZmanRefundHistoryVO {
	private int zman_refund_idx;
	private int zman_earning_idx;
	private long zman_net_profit;
	private long zman_balance;
	private String zman_id;
	private Timestamp zman_refund_date;
}
