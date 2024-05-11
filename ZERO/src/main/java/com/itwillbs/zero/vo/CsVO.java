package com.itwillbs.zero.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CsVO {
	private int cs_idx;
	private int member_idx;
	private String cs_subject;
	private String cs_content;
	private String cs_date;
	private String cs_type;
	private String cs_file;
	private MultipartFile file;
	private String cs_reply;
	private String cs_phone;
//	private int cs_type_list_idx;
	private int cs_info_idx;
	
	// 작성자를 함께 출력하기 위해 변수 추가
	private String member_name;
	private String member_id;
	private String member_nickname;
	
}
