package com.itwillbs.zero.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.vo.BankAccountDetailVO;
import com.itwillbs.zero.vo.ResponseDepositVO;
import com.itwillbs.zero.vo.ResponseTokenVO;
import com.itwillbs.zero.vo.ResponseUserInfoVO;
import com.itwillbs.zero.vo.ResponseWithdrawVO;

@Service
public class BankApiService {
	
	// 실제 금융API 요청을 수행할 BankApiClient 타입 선언
	@Autowired
	private BankApiClient bankApiClient;

	// 엑세스토큰 발급요청
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		return bankApiClient.requestToken(authResponse);
	}

	// 사용자 정보 조회 요청
	public ResponseUserInfoVO requestUserInfo(String access_token, String user_seq_no) {
		return bankApiClient.requestUserInfo(access_token, user_seq_no);
	}

	// 잔액 조회
	public BankAccountDetailVO requestAccountDetail(Map<String, String> map) {
		return bankApiClient.requestAccountDetail(map);
	}

	// 출금이체 요청
	public ResponseWithdrawVO requestWithdraw(Map<String, String> map) {
		return bankApiClient.requestWithdraw(map);
	}
	
	// 2.5.2. 입금이체 API 응답 데이터의 1개 입금 정보를 관리하는 클래스 정의
	public ResponseDepositVO requestDeposit(Map<String, String> map) {
		return bankApiClient.requestDeposit(map);
	}

}
