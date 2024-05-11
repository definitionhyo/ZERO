package com.itwillbs.zero.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.zero.vo.ResponseTokenVO;

@Mapper
public interface BankMapper {
	
	// 토큰 정보 저장 전 이미 존재하는 토큰인지 확인
	int selectExsitTokenCount(@Param("member_id") String member_id, @Param("token") ResponseTokenVO responseToken);

	// 이미 토큰이 존재할 경우 토큰 정보 업데이트
	int updateToken(@Param("member_id") String member_id, @Param("token") ResponseTokenVO responseToken);

	// ZPAY 의 access_token 업데이트
	int updateZpayToken(String member_id, ResponseTokenVO responseToken);

	// 토큰 정보 저장
	int insertToken(@Param("member_id") String member_id, @Param("token") ResponseTokenVO responseToken);

	// 토큰 정보 조회
	ResponseTokenVO selectTokenForBankAuth(String member_id);




}
