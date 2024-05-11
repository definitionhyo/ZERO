package com.itwillbs.zero.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ZmanVO {
	private int zman_idx;
	private String zman_id; // 이메일
	private String zman_nickname; 
//	private String zman_passwd;          //삭제 - 정의효
	private String zman_name;
	private String zman_birth;  
	private String zman_date;	//Date : java.sqlDate 임포트함
	private String zman_phone;
	private String zman_status; // ENUM 타입 -> String 타입으로 바꿈
	private Date zman_withdrawal;	//Date : java.sql.Date 임포트함 XX-YY-MM // NULL
	private String zman_mail_auth;
	private String zman_car_num;
	private int zman_report_count;
	private String zman_transport;
	private String zman_area;
	private String zman_address;
	private String zman_address_detail;
	private String zman_education_completion;
	private String zman_insurance_status;
	private String zman_location_agreement;
	private String zman_bank_name;
	private String zman_account;
	private String zman_driver_license;
	
	
	private Date member_birth;
	private String zpay_bank_name;
	private String zpay_bank_account;
}
