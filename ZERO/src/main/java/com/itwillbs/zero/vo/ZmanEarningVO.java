package com.itwillbs.zero.vo;

import lombok.Data;

@Data
public class ZmanEarningVO {
	private int zman_earning_idx;
	private int zman_delivery_idx;
	private long zman_delivery_commission;
	private long zman_net_profit;
	private String zman_id;
}
