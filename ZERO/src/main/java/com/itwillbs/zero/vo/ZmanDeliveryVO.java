package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ZmanDeliveryVO {

	private int zman_delivery_idx;
	private String zman_delivery_startspot;
	private String zman_delivery_endspot;
	private Timestamp zman_delivery_starttime;
	private Timestamp zman_delivery_endtime;
	private int zman_delivery_commission;
	private String zman_delivery_status;

	private int zman_delivery_distance;
	
	// 추가 컬럼
	private Timestamp zman_delivery_accepttime;
	
	// FK
	private String zman_id;
	private int zman_idx;
	private int order_secondhand_idx;
	private String seller_id;
	private String buyer_id;
	
	// JOIN
	private String order_secondhand_product;
	private String zman_name;
	private Timestamp zman_refund_date;
	
	private int zman_earning_idx;
	private int zman_net_profit;
	

}
