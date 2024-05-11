package com.itwillbs.zero.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.zero.vo.BankAccountDetailVO;
import com.itwillbs.zero.vo.BankAccountVO;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.ResponseDepositVO;
import com.itwillbs.zero.vo.ResponseTokenVO;
import com.itwillbs.zero.vo.ResponseUserInfoVO;
import com.itwillbs.zero.vo.ResponseWithdrawVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;
import com.itwillbs.zero.vo.ZpayVO;
import com.itwillbs.zero.service.BankApiService;
import com.itwillbs.zero.service.BankService;
import com.itwillbs.zero.service.MemberService;
import com.itwillbs.zero.service.ZpayService;

@Controller
public class BankController {
	@Autowired
	private BankService bankService;
	
	@Autowired
	private BankApiService bankApiService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ZpayService zpayService;
	
	// 로그 출력을 위한 변수 선언 => getLogger() 메서드 파라미터로 로그 처리할 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(BankController.class);
	
	// 2.1.1. 사용자인증 API (3-legged)
	// 사용자 인증 요청에 따른 콜백을 통해 인증코드를 전달받기
	@GetMapping("callback")
	public String responseAuthCode(@RequestParam Map<String, String> authResponse, Model model, HttpSession session){
		System.out.println("BankController - responseAuthCode()");
		
		String member_id = (String)session.getAttribute("member_id");
		
		if(authResponse == null || authResponse.get("code") == null) {
			model.addAttribute("msg", "인증 오류 발생! 다시 인증해주세요");
			model.addAttribute("isClose", true);	// true : 창 닫기, false : 창 닫기x(이전 페이지로 돌아가기)
			return "bank_auth_fail_back";
		}
		
		// 2.1.2. 토큰발급 API - 토큰 발급 요청
		ResponseTokenVO responseToken = bankApiService.requestToken(authResponse);
		logger.info("****Access Token : " + responseToken);
		
		// 만약, 리턴받은 액세스 토큰이 없을 경우 오류 메세지 출력 및 인증창 닫기
		if(responseToken.getAccess_token() == null) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "토큰 발급 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true);	// true : 창 닫기, false : 창 닫기x(이전 페이지로 돌아가기)
			return "bank_auth_fail_back";
		}
		
		// BankService - registToken() 메서드를 호출하여 토큰 관련 정보를 DB 에 저장(fintech5.token)
		// => 파라미터 : 세션 아이디, 응답데이터가 저장된 ResponseTokenVO 객체
		//    리턴타입 : boolean(isRegistSuccess)
		boolean isRegistSuccess = bankService.registToken((String)session.getAttribute("member_id"), responseToken);
		
		// MemberService - modifyBankAuth() 호출하여 member_bank_auth 를 'Y' 로 바꾸기
		if(isRegistSuccess) {
			int updateCount = memberService.modifyBankAuth(member_id);
		}
		
		// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
		session.setAttribute("access_token", responseToken.getAccess_token());
		session.setAttribute("user_seq_no", responseToken.getUser_seq_no());
		
		// Model 객체에 리다이렉트할 페이지 저장(MemberInfo - 회원정보 갱신)
		model.addAttribute("msg", "계좌인증 완료!");
		model.addAttribute("targetURL", "zpay_main");
		model.addAttribute("isClose", isRegistSuccess); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
		
		
		// ---------------------------- 08.04(인증과 동시에 계좌 등록) ----------------------------------------------
//		String access_token = responseToken.getAccess_token();
//		String user_seq_no = responseToken.getUser_seq_no();
//		// BankApiService - requestUserInfo() 메서드 호출하여 핀테크 이용자 정보 조회
//		// => 파라미터 : 엑세스토큰, 사용자번호    리턴타입 : ResponseUserInfoVO(userInfo)
//		ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no);
//		
//		LocalDateTime maxInquiryAgreeDtime = LocalDateTime.MIN;
//		int maxIndex = -1; // 최대값을 가지는 요소의 인덱스 초기화
//		
//		for(int i = 0; i < userInfo.getRes_list().size(); i++) {
//			BankAccountVO account = userInfo.getRes_list().get(i);
//			
//			// String 형태의 inquiry_agree_dtime 을 LocalDateTime으로 변환
//			String dateTimeString = account.getInquiry_agree_dtime();
//			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
//			LocalDateTime inquiryAgreeDtime = LocalDateTime.parse(dateTimeString, formatter);
//
//			// inquiry_agree_dtime 중 제일 최근에 인증한 날짜 찾기
//			if (inquiryAgreeDtime.compareTo(maxInquiryAgreeDtime) > 0) {
//				maxInquiryAgreeDtime = inquiryAgreeDtime;
//		        maxIndex = i;
//		    }
//		}
//		
//		// 제일 최근 인증한 계좌
//		BankAccountVO latestAgreeAcc = userInfo.getRes_list().get(maxIndex);
//		
//		// 제일 최근 인증한 계좌 정보 ZPAY 테이블에 등록
//		ZpayVO zpay = new ZpayVO();
//		zpay.setMember_id(member_id);
//		zpay.setZpay_bank_name(latestAgreeAcc.getBank_name());
//		zpay.setZpay_bank_account(latestAgreeAcc.getAccount_num_masked());
//		zpay.setAccess_token(access_token);
//		zpay.setFintech_use_num(latestAgreeAcc.getFintech_use_num());
//		
//		int insertCount = zpayService.registZpay(zpay);
//		
//		if(insertCount > 0) {
//			return "success_forward";
//		} else {
//			model.addAttribute("msg", "ZPAY 등록 실패");
//			return "bank_auth_fail_back";
//		}
		
		// ---------------------------------------------------------------------------------------------------------
		
		return "success_forward";
	}
	
	// 2.2. 사용자/계좌 관리 
	// - 2.2.1. 사용자정보조회 API
	@GetMapping("bankUserInfo")
	public String requestUserInfo(Model model, HttpSession session) {
		// 세션에 저장된 엑세스토큰 및 사용자번호를 변수에 저장
		String access_token = (String)session.getAttribute("access_token");
		String user_seq_no = (String)session.getAttribute("user_seq_no");
		logger.info("●●●●●● access_token : "  + access_token);
		logger.info("●●●●●● user_seq_no : "  + user_seq_no);
		
		// 엑세스토큰이 없을 경우 "계좌인증필수" 출력 후 이전페이지로 돌아가기
		if(access_token == null) {
			model.addAttribute("msg", "계좌 인증 필수!");
			return "bank_auth_fail_back";
		}
		
		// BankApiService - requestUserInfo() 메서드 호출하여 핀테크 이용자 정보 조회
		// => 파라미터 : 엑세스토큰, 사용자번호    리턴타입 : ResponseUserInfoVO(userInfo)
		ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no);
		logger.info("●●●●● userInfo : " + userInfo);
		 
		MemberVO member = memberService.getMember((String)session.getAttribute("member_id"));
		
		// Model 객체에 ResponseUserInfoVO 객체 저장
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("member", member);
		
//		return "zpay/bank_user_info";
		return "zpay/zpay_bank_user_info";
	}
	
	
	// 2.3. 조회서비스(사용자) - 2.3.1. 잔액조회 API
	// => 예금주명, 계좌번호(마스킹), 핀테크이용번호 파라미터 => Map 타입으로 처리
	@PostMapping("bankAccountDetail")
	public String bankAccountDetail(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 미로그인 또는 엑세스토큰이 없으면 "권한이 없습니다."출력 후 이전 페이지로 돌아가기
		if(session.getAttribute("member_id") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "bank_auth_fail_back";
		}
		
		// 요청에 사용될 엑세스토큰을 Map 객체에 추가
		map.put("access_token", (String)session.getAttribute("access_token"));
		logger.info("●●●●● bankAccountDetail : " + map);
		
		// BankApiService - requestAccountDetail() 메서드 호출하여 계좌 상세정보 조회 요청
		// => 파라미터 : Map 객체   리턴타입 : BankAccountDetailVO(accountDetail)
		BankAccountDetailVO accountDetail = bankApiService.requestAccountDetail(map);
		logger.info("●●●●● BankAccountDetailVO : " + accountDetail);
		
		// Model 객체에 조회 결과 저장 - BankAccountDetailVO 객체, 예금주명, 계좌번호(마스킹)
		model.addAttribute("accountDetail", accountDetail);
		model.addAttribute("account_num_masked", map.get("account_num_masked"));
		model.addAttribute("user_name", map.get("user_name"));
		
		return "zpay/zpay_bank_account_detail";
	}
	
	
	// 2.5. 이체서비스 - 2.5.1. 출금이체 API 요청을 위한 폼 생성(PDF p74)
	@PostMapping("bankWithdraw")
	public String bankWithdraw(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 미로그인 또는 엑세스토큰이 없으면 "권한이 없습니다."출력 후 이전 페이지로 돌아가기
		if(session.getAttribute("member_id") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "bank_auth_fail_back";
		}
		
		// Map 객체에 엑세스토큰 추가
		map.put("access_token", (String)session.getAttribute("access_token"));
		
		// BankApiService - requestWithdraw() 메서드를 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : ResponseWithdrawVO
		ResponseWithdrawVO  withdrawResult = bankApiService.requestWithdraw(map);
		
		// Model 객체에 ResponseWithdrawVO 객체 저장
		model.addAttribute("withdrawResult", withdrawResult);
		
		// -------------------------------------------------------------------------------
		// 출금이체한 금액을 ZPAY에 충전
		ZpayHistoryVO zpayHistory = new ZpayHistoryVO();
		String member_id = (String)session.getAttribute("member_id");
		
		// ZPAY 테이블에서 member_id에 일치하는 zpay_idx 조회
		int zpay_idx = zpayService.getZpayIdx(member_id);
		System.out.println(zpay_idx);
		
		// ZPAY_HISTORY 테이블에서 잔액조회
		Integer zpay_balance = zpayService.getZpayBalance(member_id);
		
		zpayHistory.setZpay_idx(zpay_idx);
		zpayHistory.setMember_id(member_id);
		zpayHistory.setZpay_amount(withdrawResult.getTran_amt());
		zpayHistory.setZpay_balance(zpay_balance);
		zpayHistory.setZpay_deal_type("충전");
		
		// ZPYA_HISTORY 테이블에 충전내역 추가
		int insertCount = zpayService.chargeZpay(zpayHistory);
		
		if(insertCount > 0) {
//			model.addAttribute("accountDetail", accountDetail);
			return "zpay/zpay_charge_success";			
		} else {
			model.addAttribute("msg", "ZPAY 충전 실패");
			return "bank_auth_fail_back";
		}
		
//		return "zpay/bank_withdraw_result";
	}
	
	// 2.5.2. 입금이체 API 응답 데이터의 1개 입금 정보를 관리하는 클래스 정의
	@PostMapping("bankDeposit")
	public String requestDeposit(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// 미로그인 또는 엑세스토큰 없으면 "권한이 없습니다!" 출력 후 이전페이지로 돌아가기
		if(session.getAttribute("member_id") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "bank_auth_fail_back";
		}
		
		// Map 객체에 엑세스토큰 추가
		map.put("access_token", (String)session.getAttribute("access_token"));
		
		// BankApiService - requestWithdraw() 메서드를 호출하여 출금이체 요청
		// => 파라미터 : Map 객체   리턴타입 : ResponseDepositVO
		ResponseDepositVO depositResult = bankApiService.requestDeposit(map);
		
		// Model 객체에 ResponseDepositVO 객체 저장
		model.addAttribute("depositResult", depositResult);
		
		// -------------------------------------------------------------------------------
//		// 출금이체한 금액을 ZPAY에 충전
//		ZpayHistoryVO zpayHistory = new ZpayHistoryVO();
//		String member_id = (String)session.getAttribute("member_id");
//		
//		// ZPAY 테이블에서 member_id에 일치하는 zpay_idx 조회
//		int zpay_idx = zpayService.getZpayIdx(member_id);
//		System.out.println(zpay_idx);
//		
//		// ZPAY_HISTORY 테이블에서 잔액조회
//		Integer zpay_balance = zpayService.getZpayBalance(member_id);
//		
//		zpayHistory.setZpay_idx(zpay_idx);
//		zpayHistory.setMember_id(member_id);
//		zpayHistory.setZpay_amount(withdrawResult.getTran_amt());
//		zpayHistory.setZpay_balance(zpay_balance);
//		zpayHistory.setZpay_deal_type("충전");
//		
//		// ZPYA_HISTORY 테이블에 충전내역 추가
//		int insertCount = zpayService.chargeZpay(zpayHistory);
//		
//		if(insertCount > 0) {
////					model.addAttribute("accountDetail", accountDetail);
//			return "zpay/zpay_charge_success2";			
//		} else {
//			model.addAttribute("msg", "ZPAY 충전 실패");
//			return "bank_auth_fail_back";
//		}
		
		return "zpay/bank_deposit_result";
	}
	
	
	
}
