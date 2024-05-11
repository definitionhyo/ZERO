package com.itwillbs.zero.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.zero.service.ZpayService;
import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;

@Component
public class ZpayTransactionHandler {
	
	@Autowired
	private ZpayService zpayService;
		
	public boolean performZpayTransaction(String member_id, long amount, String dealType, int order_secondhand_idx, int order_auction_idx) {
		int zpay_idx = zpayService.getZpayIdx(member_id);
		Integer zpay_balance = zpayService.getZpayBalance(member_id);
		
		ZpayHistoryVO zpayHistory = new ZpayHistoryVO();
		zpayHistory.setZpay_idx(zpay_idx);
		zpayHistory.setMember_id(member_id);
		zpayHistory.setZpay_amount(amount);
		zpayHistory.setZpay_balance(zpay_balance);
		zpayHistory.setZpay_deal_type(dealType);
		
		if (order_secondhand_idx > 0) {
            zpayHistory.setOrder_secondhand_idx(order_secondhand_idx);
        }

		if (order_auction_idx > 0) {
			zpayHistory.setOrder_auction_idx(order_auction_idx);
		}
		
		
		int insertCount = zpayService.insertZpayHistory(zpayHistory);
		
		return insertCount > 0;
	}
	
	
	public boolean performZeroAccountTransaction(String member_id, long amount, String transactionType, int order_secondhand_idx, int order_auction_idx, int auction_idx) {
		
		ZpayHistoryVO zpayHistoryInserted = zpayService.getzpayHistoryInserted2(member_id);
		Integer zeroAccountBalance = zpayService.getZeroAccountBalance();
		
		ZeroAccountHistoryVO zeroAccountHistory = new ZeroAccountHistoryVO();
		zeroAccountHistory.setMember_id(member_id);
		zeroAccountHistory.setZpay_history_idx(zpayHistoryInserted.getZpay_history_idx());
		zeroAccountHistory.setZero_account_amount(amount);
		zeroAccountHistory.setZero_account_balance(zeroAccountBalance);
		zeroAccountHistory.setZero_account_type(transactionType);
		
		if (order_secondhand_idx > 0) {
			zeroAccountHistory.setOrder_secondhand_idx(order_secondhand_idx);
        }

		if (order_auction_idx > 0) {
			zeroAccountHistory.setOrder_auction_idx(order_auction_idx);
		}
		
		if (auction_idx > 0) {
			zeroAccountHistory.setAuction_idx(auction_idx);
		}
		
		int insertCount = zpayService.depositWithdrawZeroAccount(zeroAccountHistory);
		
		return insertCount > 0;
	}
}
