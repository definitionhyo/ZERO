package com.itwillbs.zero.service;

import org.springframework.stereotype.Service;

import com.itwillbs.zero.handler.GenerateRandomCode;
import com.itwillbs.zero.handler.SendMailClient;

@Service
public class SendMailService {
	
	// 인증 메일 발송을 수행하기 위한 sendAuthMail() 메서드 정의
	// => 파라미터 : 아이디, 이메일   리턴타입 : boolean(isSendSuccess)
	public String sendAuthMail(String id, String email) {
		boolean isSendSuccess = false;
		
		// 난수 생성 후 리턴받기 위해 사용자 정의 클래스 GenerateRandomCode 의 static 메서드 getRandomCode() 호출
		// => 파라미터 : 난수 길이(정수)   리턴타입 : String(authCode)
		String authCode = GenerateRandomCode.getRandomCode(50); // 50글자에 맞는 난수(영문자, 숫자) 리턴
//		System.out.println(authCode);
		
		// =====================================================================
		// 제목과 본문 생성
		String subject = "[ZERO] 가입 인증 메일입니다.";
//		String content = "인증코드 : " + authCode;
		// 사용자가 링크를 클릭하면 인증 수행을 위한 서블릿 주소를 요청하도록 본문에 하이퍼링크를 포함
		String content = "<a href='http://localhost:8089/zero/MemberEmailAuth?id=" + id + "&auth_code=" + authCode + "'>"
//				String content = "<a href='http://c5d2302t1.itwillbs.com/ZERO/MemberEmailAuth?id=" + id + "&auth_code=" + authCode + "'>"
							+ "이메일 인증을 위해 이 링크를 클릭해 주세요!"
							+ "</a>";
		// =====================================================================
		// SendMailClient 인스턴스 생성 후 sendMail() 메서드를 호출하여 인증 메일 발송 요청
		// => 파라미터 : 이메일, 제목, 본문
		SendMailClient mailClient = new SendMailClient();
		isSendSuccess = mailClient.sendMail(email, subject, content);
		
		// 인증 메일 발송 성공 시 인증 코드를 리턴하고, 실패 시 널스트링 리턴
		if(isSendSuccess) {
			return authCode;
		} else {
			return "";
		}
	}
	
	// 인증 메일 발송을 수행하기 위한 sendAuthMail() 메서드 정의
	// => 파라미터 : 아이디, 이메일   리턴타입 : boolean(isSendSuccess)
	public String sendPasswdMail(String authCode, String email) {
		boolean isSendSuccess = false;
		
		
		// =====================================================================
		// 제목과 본문 생성
		String subject = "[ZERO] 임시 비밀번호입니다.";
//		String content = "인증코드 : " + authCode;
		// 사용자가 링크를 클릭하면 인증 수행을 위한 서블릿 주소를 요청하도록 본문에 하이퍼링크를 포함
		String content = "임시 비밀번호 : " + authCode + "<br>"
//				+ "<a href='http://localhost:8089/zero/member_login'>"
				+ "<a href='http://c5d2302t1.itwillbs.com/ZERO/member_login'>"
							+ "로그인을 위해 이 링크를 클릭해 주세요!"
							+ "</a>";
		// =====================================================================
		// SendMailClient 인스턴스 생성 후 sendMail() 메서드를 호출하여 인증 메일 발송 요청
		// => 파라미터 : 이메일, 제목, 본문
		SendMailClient mailClient = new SendMailClient();
		isSendSuccess = mailClient.sendMail(email, subject, content);
		
		// 인증 메일 발송 성공 시 인증 코드를 리턴하고, 실패 시 널스트링 리턴
		if(isSendSuccess) {
			return authCode;
		} else {
			return "";
		}
	}
	
}












