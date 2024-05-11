package com.itwillbs.zero.vo;

import java.util.List;

import org.springframework.web.multipart.*;

import lombok.*;


@Data
public class SecondhandVO {
	private int secondhand_idx; // 상품번호(auto increment)
//	private String secondhand_name; //상품이름
	private int secondhand_price;
	private String secondhand_subject;
	private String secondhand_content;
	private String secondhand_deliveryType_ptp;
	private String secondhand_paymentType_ptp;
	
	private String secondhand_image1;
	private String secondhand_image2;
	private String secondhand_image3;
	
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;
	
	private String secondhand_first_date; // 등록일
	private String secondhand_update_date; //끌어올리기 하였을 경우 날짜(null허용)
	private int secondhand_readcount;
	private int secondhand_re_ref;
	private String secondhand_deal_status;
	private String member_id; //idx->id수정
	private String category_idx;
	
	//추가컬럼
	private String secondhand_deliveryType_parcel;
	private String secondhand_deliveryType_zstation;
	private String secondhand_deliveryType_zman;
	private String secondhand_paymentType_zpay;
	
	//추가(view)
	private String category_name;
	private String category_type;

	List<SecondhandVO> image_list;
	

}
