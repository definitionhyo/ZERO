package com.itwillbs.zero.handler;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.itwillbs.zero.service.ZpayService;

@Component
public class ZpayUtils {
	
	@Autowired
	private ZpayService zpayService;
	
	public String validateRefund(Integer zpay_balance, String member_id, String zpayAmount) {
		
	    if (zpay_balance < Integer.parseInt(zpayAmount)) {
	        return "ZPAY 잔액을 초과하였습니다.\\n금액을 다시 입력해주세요.";
	    }
	    
	    // 현재 참여하고 있는 경매 입찰이 있는 지 확인
	    List<Map<String, Object>> isAuctionParticipant = zpayService.isAuctionParticipant(member_id);
	    if (isAuctionParticipant.size() > 0) {
	        long auction_log_bid_sum = 0;
	        for (Map<String, Object> participant : isAuctionParticipant) {
	            Integer maxBid = (Integer) participant.get("max_auction_log_bid");
	            auction_log_bid_sum += maxBid;
	        }
	        if (zpay_balance - auction_log_bid_sum < Integer.parseInt(zpayAmount)) {
	            Locale koreanLocale = new Locale("ko", "KR");
	            NumberFormat koreanFormat = NumberFormat.getInstance(koreanLocale);
	            
	            String auctionLogBidSum = koreanFormat.format(auction_log_bid_sum);
	            String availableBalance = koreanFormat.format(zpay_balance - auction_log_bid_sum < 0 ? 0 : zpay_balance - auction_log_bid_sum);
	            
	            return "출금 가능한 금액을 초과하였습니다.\\n입찰금액 합 : " + auctionLogBidSum + "원\\n출금가능 금액 : " + availableBalance + "원";
	        }
	    }
	    	    
	    return null; // Validation 통과
	}

	public String validateSend(Integer buyer_zpay_balance, String buyer_id, long product_price, long order_delivery_commission) {
	    if (buyer_zpay_balance < product_price + order_delivery_commission) {
	        return "ZPAY 잔액을 초과하였습니다. 추가 충전이 필요합니다";
	    }
	    
	    // 현재 참여하고 있는 경매 입찰이 있는 지 확인
	    List<Map<String, Object>> isAuctionParticipant = zpayService.isAuctionParticipant(buyer_id);
	    if (isAuctionParticipant.size() > 0) {
	        long auction_log_bid_sum = 0;
	        for (Map<String, Object> participant : isAuctionParticipant) {
	            Integer maxBid = (Integer) participant.get("max_auction_log_bid");
	            auction_log_bid_sum += maxBid;
	        }
	        
	        if (buyer_zpay_balance - auction_log_bid_sum < product_price + order_delivery_commission) {
	            Locale koreanLocale = new Locale("ko", "KR");
	            NumberFormat koreanFormat = NumberFormat.getInstance(koreanLocale);
	            
	            String auctionLogBidSum = koreanFormat.format(auction_log_bid_sum);
	            String availableBalance = koreanFormat.format(buyer_zpay_balance - auction_log_bid_sum < 0 ? 0 : buyer_zpay_balance - auction_log_bid_sum);
	            
	            return "송금 가능한 금액을 초과하였습니다.\\n입찰금액 합 : " + auctionLogBidSum + "원\\n송금가능 금액 : " + availableBalance + "원";
	        }
	    }
	    
	    return null; // Validation 통과
	}

	public String validateAmount(Integer zpay_balance, String member_id, long amount) {
	    if (zpay_balance < amount) {
	        return "ZPAY 잔액을 초과하였습니다. 추가 충전이 필요합니다";
	    }
	    return null; // Validation 통과
	}
}
