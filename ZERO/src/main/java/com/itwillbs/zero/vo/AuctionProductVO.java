package com.itwillbs.zero.vo;

import java.sql.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AuctionProductVO {
	private int auction_idx;
	private String auction_title;
	private int category_idx;
	private int auction_start_price;
	private String auction_product_status;
	private int auction_max_price;
	private String auction_content;
	private int brand_idx;
	private String auction_seller_id;
	private String auction_seller_address;
	private String auction_seller_address_detail;
	private String board_file1;
	private String board_file2;
	private String board_file3;
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	
	// 목록 가져오기용 파라미터 추가
	private String brand_name;
	private Date auction_manage_check_date;
	private Date auction_start_date;
	private int auction_log_count;
	private String auction_manage_check_status;
	private String auction_manage_status;
}
