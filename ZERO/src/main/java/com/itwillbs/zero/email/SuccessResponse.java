package com.itwillbs.zero.email;

public class SuccessResponse {
	private boolean success;
    private String message;

    public SuccessResponse(String message) {
        this.success = true;
        this.message = message;
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }
}
