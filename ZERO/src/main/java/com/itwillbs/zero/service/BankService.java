package com.itwillbs.zero.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.mapper.BankMapper;
import com.itwillbs.zero.vo.ResponseTokenVO;

@Service
public class BankService {
	
	@Autowired
	private BankMapper mapper;

	// 토큰정보 저장
	public boolean registToken(String member_id, ResponseTokenVO responseToken) {
		int exsitTokenCount = mapper.selectExsitTokenCount(member_id, responseToken);
		System.out.println(exsitTokenCount);
		
		if(exsitTokenCount > 0) {	// 토큰 정보가 이미 존재할 경우 BANK_TOEKN 과 ZPAY 의 access_token 업데이트
			if(mapper.updateToken(member_id, responseToken) > 0 && mapper.updateZpayToken(member_id, responseToken) > 0) {
				return true;			
			} else {
				return false;
			}
		} else {	// 토큰 정보가 존재하지 않을 경우 BANK_TOKEN 에 해당 정보 저장
			if(mapper.insertToken(member_id, responseToken) > 0) {
				return true;			
			} else {
				return false;
			}			
		}
		
	}

	// 토큰 정보 조회 요청 - JOIN 구문 활용
	public ResponseTokenVO getTokenForBankAuth(String member_id) {
		return mapper.selectTokenForBankAuth(member_id);
	}
}
