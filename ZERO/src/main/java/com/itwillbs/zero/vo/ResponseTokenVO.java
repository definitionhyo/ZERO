package com.itwillbs.zero.vo;

import lombok.Data;

@Data
public class ResponseTokenVO {
	private String access_token;
	private String token_type;
	private String expires_in;
	private String refresh_token;
	private String scope;
	private String user_seq_no;
}
