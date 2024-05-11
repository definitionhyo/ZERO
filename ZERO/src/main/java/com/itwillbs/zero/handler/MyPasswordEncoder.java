package com.itwillbs.zero.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class MyPasswordEncoder {
	
//	@Autowired
	private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	// 암호화를 수행할 getCryptoPassword() 메서드 정의
	// => 파라미터 : 평문(String rawPassword)   리턴타입 : String
	public String getCryptoPassword(String rawPassword) {
		// ------------ BCryptPasswordEncoder 객체 활용한 패스워드 암호화(= 해싱) --------------
		// 입력받은 패스워드는 암호화 필요 => 복호화가 불가능하도록 단방향 암호화(해싱) 수행
		// => 평문을 해싱 후 MemberVO 객체의 passwd 에 덮어쓰기
		// => org.springframework.security.crypto.bcrypt 패키지의 BCryptPasswordEncoder 클래스 활용
		//    (spring-security-crypto 라이브러리 추가 또는 spring-security-web 라이브러리 추가)
		//    => 주의! spring-security-web 버전에 따른 컴파일러 버전 오류 발생할 수 있음
		//       (java.lang.UnsupportedClassVersionError: org/springframework/security/crypto/bcrypt/BCryptPasswordEncoder has been compiled by a more recent version of the Java Runtime (class file version 61.0), this version of the Java Runtime only recognizes class file versions up to 55.0 (클래스 [org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder]을(를) 로드할 수 없습니다)
		//       (class file version 이 55.0 일 경우 JDK 11, 61.0 일 경우 JDK 17 을 의미함)
		//       해결방법 : JDK 11 기준 spring-security-web 라이브러리 5.x.x 사용
		// => BCryptPasswordEncoder 활용한 해싱은 Salting(솔팅) 기능을 통해
		//    동일한 평문(원본 암호)이라도 매번 다른 결과값(암호문)을 얻을 수 있다!
		// 1. BCryptPasswordEncoder 객체 생성(@Autowired 어노테이션으로 인한 생략)
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		// 2. BCryptPasswordEncoder 객체의 encode() 메서드를 호출하여 해싱 수행 후 결과값 저장
		//    => 파라미터 : 평문 암호(passwd)   리턴타입 : String(암호문)
		String securePasswd = passwordEncoder.encode(rawPassword);
//		System.out.println("평문 : " + member.getPasswd());
//		System.out.println("암호문 : " + securePasswd); // 매번 동일한 암호라도 결과가 다름
		
		// 3. 암호문 리턴
		return securePasswd;
	}
	
	
	// 두 문자열 비교를 수행할 isSameCryptoPassword() 메서드 정의
	// => 파라미터 : 평문(String rawPassword), 암호문(String EncryptedPassword)  리턴타입 : boolean
	public boolean isSameCryptoPassword(String rawPassword, String EncryptedPassword) {
		// 2. BCryptPasswordEncoder 객체 생성(@Autowired 어노테이션으로 인한 생략)
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		// 3. BCryptPasswordEncoder 객체의 matches() 메서드를 호출하여 두 암호 비교
		// => 입력받은 평문은 그대로 두고, DB 에 저장된 패스워드를 가져와서 비교
		//    (주의! 평문을 암호화하여 DB 의 암호문과 직접 비교 불가능! => 솔팅때문에 서로 다름)
		// => 파라미터 : 평문, 암호화 된 암호    리턴타입 : boolean
		return passwordEncoder.matches(rawPassword, EncryptedPassword);
	}
	
}












