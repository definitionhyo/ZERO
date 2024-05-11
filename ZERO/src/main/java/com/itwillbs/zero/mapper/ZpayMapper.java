package com.itwillbs.zero.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZmanEarningVO;
import com.itwillbs.zero.vo.ZmanRefundHistoryVO;
import com.itwillbs.zero.vo.OrderAuctionVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;
import com.itwillbs.zero.vo.ZpayVO;

@Mapper
public interface ZpayMapper {
	
	// 1. ZPAY 사용자 여부 조회
	// 2. ZPAY 사용자 정보 조회
	ZpayVO selectZpay(String member_id);

	// ZPZY 등록
	int insertZpay(ZpayVO zpay);
	
//	// ZMAN 계좌 등록
//	int insertZmanBankAccount(ZmanAccountVO zmanAccount);
	
	// ZPAY 잔액 조회
	Integer selectZpayBalance(String member_id);	

	// ZPAY 사용 내역(목록) 조회
	List<ZpayHistoryVO> selectZpayHistory(String member_id);
	
	// ZPAY 사용 내역(목록) 개수 조회
	int selectZpayHistoryListCount(@Param("member_id") String member_id, 
								@Param("searchType") String searchType, 
								@Param("startDate") String startDate, 
								@Param("endDate") String endDate);
	
	// ZPAY 사용 내역(목록) 조회 - 필터링 적용
	List<ZpayHistoryVO> selectZpayHistoryList(@Param("member_id") String member_id, 
											@Param("searchType") String searchType, 
											@Param("startDate") String startDate, 
											@Param("endDate") String endDate, 
											@Param("startRow") int startRow,
											@Param("listLimit") int listLimit);

	// ZPAY 번호 조회
	int selectZpayIdx(String member_id);

	// ZPYA_HISTORY 테이블에 충전/환급/중고입출금/경매입출금 내역 추가
	int insertZpayHistory(ZpayHistoryVO zpayHistory);
	
	// 현재 참여하고 있는 경매 입찰이 있는지 확인
	List<Map<String, Object>> selectAuctionParticipant(String member_id);
	
	// ZPYA_HISTORY 테이블에 충전내역 추가
	int insertChargeHistory(ZpayHistoryVO zpayHistory);
	
	// ZPYA_HISTORY 테이블에 환급내역 추가
	int insertRefundHistory(ZpayHistoryVO zpayHistory);
	
	// 중고거래 내역 조회
	OrderSecondhandVO selectOrderSecondhand(int order_secondhand_idx);
	
	// 경매거래 내역 조회
	OrderAuctionVO selectOrderAuction(int order_auction_idx);

//	// ZPYA_HISTORY 테이블에 송금내역 추가
//	int insertSendHistory(ZpayHistoryVO zpayBuyerHistory);
//
//	// ZPYA_HISTORY 테이블에 수취내역 추가
//	int insertReceiveHistory(ZpayHistoryVO zpaySellerHistory);

	// ZPYA_HISTORY 테이블에 송금/수취 내역 추가
	int insertSendReceiveHistory(ZpayHistoryVO zpayHistory);

	// ORDER_SECONDHAND 테이블의 order_secondhand_status 변경
	int updateOrderSecondhandStatus(int order_secondhand_idx);
	
	// 추가한 ZPAY_HISTORY 내역의 idx 찾기
	ZpayHistoryVO selectzpayHistoryInserted();
	ZpayHistoryVO selectzpayHistoryInserted2(String member_id);
	
	// ZERO_ACCOUNT_HISTORY 잔액조회
	Integer selectZeroAccountBalance();
	
//	// ZERO_ACCOUNT_HISTORY 입금내역 추가
//	int insertZeroAccountDepositHistory(ZeroAccountHistoryVO zeroAccount);
//
//	// ZERO_ACCOUNT_HISTORY 출금내역 추가
//	int insertZeroAccountWithdrawHistory(ZeroAccountHistoryVO zeroAccount);
	
	// ZERO_ACCOUNT_HISTORY 입금/출금 내역 추가
	int insertZeroAccountHistory(ZeroAccountHistoryVO zeroAccount);

	// ZmanEarning 조회
	ZmanEarningVO selectZmanEarning(int zman_earning_idx);
	
	// ZMAN 정산
	int insertZmanRefund(ZmanRefundHistoryVO zmanRefundHistory);

	// ZERO_ACCOUNT_HISTORY ZMAN 정산 내역 추가
	int insertZeroAccountZmanHistory(ZeroAccountHistoryVO zeroAccount);

	// (계좌 여러개 등록할 경우) 사용자의 계좌 목록 가져오기
	List<ZpayVO> selectMyAccountList(String member_id);

	// 암호화된 ZPAY 비번 조회
	String selectZpayPasswd(String member_id);

	// ZPAY 비밀번호 변경
	int updateZpayPasswd(@Param("member_id") String member_id, @Param("new_zpay_passwd") String new_zpay_passwd);

	// ZPAY잔액 조회
	ZpayHistoryVO selectMyZpayHistory(String member_id);


	

	


	
	

	
	
	
	
}

