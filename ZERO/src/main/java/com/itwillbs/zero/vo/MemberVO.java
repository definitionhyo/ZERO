package com.itwillbs.zero.vo;

import java.sql.Date;

import lombok.Data;

/*
CREATE TABLE MEMBER (
member_idx INT AUTO_INCREMENT PRIMARY KEY,
member_id VARCHAR(50) NOT NULL,
member_nickname   VARCHAR(50) NOT NULL,
member_passwd VARCHAR(100) NOT NULL,
member_name   VARCHAR(15) NOT NULL,
member_birth DATE NOT NULL,
member_date DATE NOT NULL,
member_phone VARCHAR(11) NOT NULL,
member_status VARCHAR(10) NOT NULL,
member_agreement_marketing_email BOOLEAN NOT NULL,
member_agreement_marketing_sms BOOLEAN NOT NULL,
member_type VARCHAR(10)   NOT NULL,
member_mail_auth CHAR(1) NOT NULL,
member_account_auth   CHAR(1)   NOT NULL,
member_image VARCHAR(200) NULL,
member_address1 VARCHAR(200) NULL,
member_address_detail1 VARCHAR(200)   NULL,
member_address2 VARCHAR(200) NULL,
member_address_detail2 VARCHAR(200)   NULL,
member_address3 VARCHAR(200) NULL,
member_address_detail3 VARCHAR(200)   NULL,
member_withdrawal DATE NULL
);
 */

@Data
public class MemberVO {
	private int member_idx;
	private String member_id; // 이메일
	private String member_nickname; 
	private String member_passwd;
	private String member_name;
	// Date : java.sqlDate 임포트함 -> DB 상에는 DATE 타입이지만 입력 폼에서 text로 취급되어 String으로 바꿈
	// 스프링에서 String 으로 저장해도 DB 에서는 날짜 형식이 기 때문에 DATE 형식으로 입출력이 이루어진다
	private String member_birth;  
	private Date member_date;	//Date : java.sqlDate 임포트함
	private String member_phone;
	private String member_status; // ENUM 타입 -> String 타입으로 바꿈
	private int member_agreement_marketing;
	private Date member_withdrawal;	//Date : java.sql.Date 임포트함 XX-YY-MM // NULL
	private String member_mail_auth;
	private String member_type;
	private String member_address1;
	private String member_address_detail1;
	private String member_address2;
	private String member_address_detail2;
	private String member_address3;
	private String member_address_detail3;
	private String member_image;
	private String member_bank_name;
	private String member_bank_auth;
	// 우편주소 추가
	private String member_zipcode1;
	private String member_zipcode2;
	private String member_zipcode3;
	private String member_intro;
	// 추가주소 번호 추가
	private String member_address2_phone;
	private String member_address3_phone;
	// 추가 주소 이름
	private String member_address2_name;
	private String member_address3_name;
}






















