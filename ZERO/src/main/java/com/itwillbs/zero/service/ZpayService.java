package com.itwillbs.zero.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.zero.vo.ZpayHistoryVO;
import com.itwillbs.zero.vo.ZpayVO;
import com.itwillbs.zero.vo.OrderAuctionVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZmanEarningVO;
import com.itwillbs.zero.vo.ZmanRefundHistoryVO;
import com.itwillbs.zero.mapper.ZpayMapper;


@Service
public class ZpayService {
	
	@Autowired
	private ZpayMapper mapper;
	
	
	// ZPAY 사용자 여부 조회
	public ZpayVO isZpayUser(String member_id) {
		return mapper.selectZpay(member_id);
	}
	
	// ZPAY 등록
	public int registZpay(ZpayVO zpay) {
		return mapper.insertZpay(zpay);
	}

//	// ZMAN 계좌 등록
//	public int registZmanBankAccount(ZmanAccountVO zmanAccount) {
//		return mapper.insertZmanBankAccount(zmanAccount);
//	}
	
	// ZPAY 잔액 조회
	public Integer getZpayBalance(String member_id) {
		
		Integer zpay_balance = mapper.selectZpayBalance(member_id);
		
		return zpay_balance != null ? zpay_balance : 0;
	}
	
	// ZPAY 사용 내역(목록) 조회
	public List<ZpayHistoryVO> getZpayHistory(String member_id) {
		return mapper.selectZpayHistory(member_id);
	}
	
	// ZPAY 사용 내역(목록) 개수 조회
	public int getZpayHistoryListCount(String member_id, String searchType, String startDate, String endDate) {
		return mapper.selectZpayHistoryListCount(member_id, searchType, startDate, endDate);
	}
	
	// ZPAY 사용 내역(목록) 조회 - 필터링 적용
	public List<ZpayHistoryVO> getZpayHistoryList(String member_id, String searchType, String startDate, String endDate,
			int startRow, int listLimit) {
		return mapper.selectZpayHistoryList(member_id, searchType, startDate, endDate, startRow, listLimit);
	}

	// ZPAY 번호 조회
	public int getZpayIdx(String member_id) {
		return mapper.selectZpayIdx(member_id);
	}
	
	// ZPAY 사용자 정보 조회
	public ZpayVO getZpay(String member_id) {
		return mapper.selectZpay(member_id);
	}

	// ZPYA_HISTORY 테이블에 충전/환급/중고입출금/경매입출금 내역 추가
	public int insertZpayHistory(ZpayHistoryVO zpayHistory) {
		return mapper.insertZpayHistory(zpayHistory);
	}
	
	//  현재 참여하고 있는 경매 입찰이 있는지 확인
	public List<Map<String, Object>> isAuctionParticipant(String member_id) {
		return mapper.selectAuctionParticipant(member_id);
	}

	// ZPYA_HISTORY 테이블에 충전내역 추가
	public int chargeZpay(ZpayHistoryVO zpayHistory) {
		return mapper.insertChargeHistory(zpayHistory);
	}

	// ZPYA_HISTORY 테이블에 환급내역 추가
	public int refundZpay(ZpayHistoryVO zpayHistory) {
		return mapper.insertRefundHistory(zpayHistory);
	}

	// 중고거래 내역 조회
	public OrderSecondhandVO getOrderSecondhand(int order_secondhand_idx) {
		return mapper.selectOrderSecondhand(order_secondhand_idx);
	}
	
	// 경매거래 내역 조회
	public OrderAuctionVO getOrderAuction(int order_auction_idx) {
		return mapper.selectOrderAuction(order_auction_idx);
	}
	
//	// ZPYA_HISTORY 테이블에 송금내역 추가
//	public int sendZpay(ZpayHistoryVO zpayBuyerHistory) {
//		return mapper.insertSendHistory(zpayBuyerHistory);
//	}
//
//	// ZPYA_HISTORY 테이블에 수취내역 추가
//	public int receiveZpay(ZpayHistoryVO zpaySellerHistory) {
//		return mapper.insertReceiveHistory(zpaySellerHistory);
//	}

	// ZPYA_HISTORY 테이블에 송금/수취 내역 추가
	public int insertSendReceiveHistory(ZpayHistoryVO zpayHistory) {
		return mapper.insertSendReceiveHistory(zpayHistory);
	}

	// ORDER_SECONDHAND 테이블의 order_secondhand_status 변경
	public int modifyOrderSecondhandStatus(int order_secondhand_idx) {
		return mapper.updateOrderSecondhandStatus(order_secondhand_idx);
	}

	// 추가한 ZPAY_HISTORY 내역의 idx 찾기
	public ZpayHistoryVO getzpayHistoryInserted() {
		return mapper.selectzpayHistoryInserted();
	}
	
	// 추가한 ZPAY_HISTORY 내역의 idx 찾기
	public ZpayHistoryVO getzpayHistoryInserted2(String member_id) {
		return mapper.selectzpayHistoryInserted2(member_id);
	}
	
	// ZERO_ACCOUNT_HISTORY 잔액조회
	public Integer getZeroAccountBalance() {
		
		Integer zero_account_balance = mapper.selectZeroAccountBalance();
		
		return zero_account_balance != null ? zero_account_balance : 0;
	}
	
//	// ZERO_ACCOUNT_HISTORY 입금내역 추가
//	public int depositZeroAccount(ZeroAccountHistoryVO zeroAccount) {
//		return mapper.insertZeroAccountDepositHistory(zeroAccount);
//	}
//	
//	// ZERO_ACCOUNT_HISTORY 출금내역 추가
//	public int withdrawZeroAccount(ZeroAccountHistoryVO zeroAccount) {
//		return mapper.insertZeroAccountWithdrawHistory(zeroAccount);
//	}
	
	// ZERO_ACCOUNT_HISTORY 입금/출금 내역 추가
	public int depositWithdrawZeroAccount(ZeroAccountHistoryVO zeroAccount) {
		return mapper.insertZeroAccountHistory(zeroAccount);
	}
	
	// ZmanEarning 조회
	public ZmanEarningVO getZmanEarning(int zman_earning_idx) {
		return mapper.selectZmanEarning(zman_earning_idx);
	}

	// ZMAN 정산
	public int zmanRefund(ZmanRefundHistoryVO zmanRefundHistory) {
		return mapper.insertZmanRefund(zmanRefundHistory);
	}

	// ZERO_ACCOUNT_HISTORY ZMAN 정산 내역 추가
	public int zeroAccountZmanHistory(ZeroAccountHistoryVO zeroAccount) {
		return mapper.insertZeroAccountZmanHistory(zeroAccount);
	}

	// (계좌 여러개 등록할 경우) 사용자의 계좌 목록 가져오기
	public List<ZpayVO> getMyAccountList(String member_id) {
		return mapper.selectMyAccountList(member_id);
	}

	// 암호화된 ZPAY 비번 조회
	public String getZpayPasswd(String member_id) {
		return mapper.selectZpayPasswd(member_id);
	}

	// ZPAY 비밀번호 변경
	public int updateZpayPasswd(String member_id, String new_zpay_passwd) {
		return mapper.updateZpayPasswd(member_id, new_zpay_passwd);
	}

	// 마이페이지 ZPAY잔액 조회 - 정의효
	public ZpayHistoryVO getMyZpayHistory(String member_id) {
		return mapper.selectMyZpayHistory(member_id);
	}


	

	


	

	
	
	
	


	

	
	
	

}