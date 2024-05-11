package com.itwillbs.zero.email;

public class EmailErrorResponse {
	private boolean success;
	private String message;
	
	public EmailErrorResponse(String message) {
		this.success = false;
		this.message = message;
	}
	
	public boolean isSuccsess() {
		return success;
	}
	
	public String getMessage() {
		return message;
	}
	
}
