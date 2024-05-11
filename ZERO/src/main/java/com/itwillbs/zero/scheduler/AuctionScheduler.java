package com.itwillbs.zero.scheduler;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;

import com.itwillbs.zero.handler.AlarmHandler;
import com.itwillbs.zero.service.AlarmService;
import com.itwillbs.zero.service.AuctionService2;
import com.itwillbs.zero.service.ZpayService;
import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;


@Component
public class AuctionScheduler {
	@Autowired
	private AuctionService2 service;
	
	@Autowired
	private ZpayService service2;
	
	@Autowired
	private AlarmService service3;
	//초 분 시 일 월 요일 연도(생략가능)
	@Scheduled(cron="0 0 0 * * *")
	public void autoUpdate() throws IOException {
		LocalDateTime dateTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
		String now=dateTime.format(formatter).toString();
		ZpayHistoryVO zpayBuyerHistory = new ZpayHistoryVO();
		ZpayHistoryVO zpayHistoryInserted = new ZpayHistoryVO();
		
		service.registEnd(now);
		
		List<HashMap<String, String>> winnerList=service.getWinner(now);
		
		for(HashMap<String, String> winner : winnerList) {
			service.registWinner(winner);
			service.registOrder2(winner);
			
			int order_auction_idx=service.getOderauctionIdx(Integer.valueOf(String.valueOf(winner.get("auction_idx"))));
			int buyer_zpay_idx = service2.getZpayIdx(winner.get("member_id"));
			
			Integer buyer_zpay_balance = service2.getZpayBalance(winner.get("member_id"));
			// zpaySellerHistory 객체에 저장
			zpayBuyerHistory.setZpay_idx(buyer_zpay_idx);
			zpayBuyerHistory.setMember_id(winner.get("member_id"));
			zpayBuyerHistory.setZpay_amount(Long.valueOf(String.valueOf(winner.get("max_bid"))));
			zpayBuyerHistory.setZpay_balance(buyer_zpay_balance);
			zpayBuyerHistory.setZpay_deal_type("경매출금");
			zpayBuyerHistory.setOrder_auction_idx(order_auction_idx);
			
			// ZPYA_HISTORY 테이블에 송금내역 추가
			service2.insertSendReceiveHistory(zpayBuyerHistory);
			
			
			zpayHistoryInserted = service2.getzpayHistoryInserted();
			
			Integer zero_account_balance = service2.getZeroAccountBalance();
			
			ZeroAccountHistoryVO zeroAccount = new ZeroAccountHistoryVO();
			zeroAccount.setMember_id(winner.get("member_id"));
			zeroAccount.setZpay_history_idx(zpayHistoryInserted.getZpay_history_idx());
			zeroAccount.setOrder_auction_idx(order_auction_idx); 
			zeroAccount.setZero_account_amount( (long)(Long.parseLong(String.valueOf(winner.get("max_bid")))*0.1));
			zeroAccount.setZero_account_balance(zero_account_balance);
			zeroAccount.setZero_account_type("경매수수료");
			
			service2.depositWithdrawZeroAccount(zeroAccount);
			
			//낙찰알림
			String receiver_id=winner.get("member_id");
			String alarmType ="경매";
			String alarmMsg=String.valueOf(winner.get("max_bid"))+"원 으로 낙찰성공";
			String alarmMsgLink="member_mypage_auctionList";
			Iterator<String> sessionIds = AlarmHandler.alarmUsers.keySet().iterator();
			String sessionId ="";
			String alarmMessage = receiver_id + "p]]/[" + alarmType + "p]]/[" + alarmMsg + "p]]/[" + alarmMsgLink;
			
			while(sessionIds.hasNext()) {
				sessionId = sessionIds.next();
				
				try {
					AlarmHandler.alarmUsers.get(sessionId).sendMessage(new TextMessage(alarmMessage));
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			Map<String, String> map=new HashMap<String, String>();
			map.put("member_id", receiver_id);
			map.put("alarm_message", alarmMsg);
			map.put("alarm_link", alarmMsgLink);
			map.put("alarm_type", alarmType);
			service3.insertAlarm(map);

		}
		
		
	}
		
	

}
