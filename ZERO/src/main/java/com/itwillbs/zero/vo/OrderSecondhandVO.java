package com.itwillbs.zero.vo;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderSecondhandVO {
	private int order_secondhand_idx;
	private long order_secondhand_price;
	private String order_secondhand_iszpay;
	private String order_secondhand_buyer;
	private String order_secondhand_seller;
	private int secondhand_idx;
	private String order_secondhand_status;
	
	private Timestamp order_secondhand_date;
	private String order_secondhand_product;
	private String order_secondhand_type;
	private String secondhand_image1;
	
	private int order_delivery_commission;
}
