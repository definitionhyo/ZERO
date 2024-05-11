package com.itwillbs.zero.handler;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class ZpayPasswdValidationHandler {
	
	public static boolean isPasswordValid(String zpay_passwd, String securePasswd) {
		
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        
        return zpay_passwd ==  null || !passwordEncoder.matches(zpay_passwd, securePasswd);
    }
}
