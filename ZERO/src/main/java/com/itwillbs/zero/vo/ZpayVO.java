package com.itwillbs.zero.vo;

import lombok.Data;

@Data
public class ZpayVO {
	private int zpay_idx;
	private String zpay_bank_name;
	private String zpay_bank_account;
	private String member_id;
	private int zpay_iscertification;
	private String zpay_passwd;

	private String access_token;
	private String fintech_use_num;
	private String bank_code_std;
	private String account_num;
	private String account_num_masked;
	private String account_holder_name;
}
