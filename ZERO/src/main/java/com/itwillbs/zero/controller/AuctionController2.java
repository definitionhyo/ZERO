package com.itwillbs.zero.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.zero.service.AuctionService2;
import com.itwillbs.zero.service.BankService;
import com.itwillbs.zero.service.ZpayService;
import com.itwillbs.zero.vo.AuctionProductVO;
import com.itwillbs.zero.vo.ResponseTokenVO;
import com.itwillbs.zero.vo.ZeroAccountHistoryVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;
import com.itwillbs.zero.vo.ZpayVO;

@Controller
public class AuctionController2 {
	@Autowired
	private AuctionService2 service;
	@Autowired
	private ZpayService service2;
	@Autowired
	private BankService bankService;
	
	// 경매 상세 페이지로 이동
	@GetMapping("auction_detail")
	public String auction_detail(Model model, int id, HttpSession session, HttpServletRequest request) {
		String member_id = (String) session.getAttribute("member_id");
		ZpayVO zpay = service2.isZpayUser(member_id);
		String beforePage =(String)request.getHeader("REFERER");
		if(member_id == null) {
			model.addAttribute("msg", "로그인이 필요한 작업입니다!");
			model.addAttribute("targetURL", "member_login");
			return "fail_location";
		}else if(zpay == null) {
			model.addAttribute("msg", "zpay 등록이 필요한 작업입니다!");
			model.addAttribute("targetURL", "zpay_main");
			return "fail_location";
		}else if(beforePage==null) {
			model.addAttribute("msg", "잘못된 접근");
			model.addAttribute("targetURL", "./");
			return "fail_location";
		}
		
		
		ResponseTokenVO token = bankService.getTokenForBankAuth(member_id);	
		if(token != null) {
			session.setAttribute("access_token", token.getAccess_token());
			session.setAttribute("user_seq_no", token.getUser_seq_no());
		}	
		
		HashMap<String, String> product= service.getAuctionProduct(id);
		List<HashMap<String, String>> logList=service.getAuctionLog(id);
		int balance=service2.getZpayBalance(member_id); 
		int bidedZpay=service.getBidedZpay(member_id,id);
		int possibleZpay=balance-bidedZpay;
		System.out.println(bidedZpay);
		model.addAttribute("product", product);
		model.addAttribute("logList", logList);
		model.addAttribute("balance", balance);
		model.addAttribute("possibleZpay", possibleZpay);
		
		return "auction/auction_detail";
	}
	@ResponseBody
	@PostMapping("logHistory")
	public String logHistory(@RequestParam Map<String, String> map, HttpSession session) {
		HashMap<String, String> product= service.getAuctionProduct(Integer.parseInt(map.get("auction_idx")));
		int maxBidPrice=service.getMaxPrice(map);
	
		map.put("member_id", (String) session.getAttribute("member_id"));
		int startPrice=Integer.parseInt(String.valueOf(product.get("auction_start_price")));
		int maxPrice=Integer.parseInt(String.valueOf(product.get("auction_max_price")));
		int balance=service2.getZpayBalance((String) session.getAttribute("member_id")); 
		int bidedZpay=service.getBidedZpay((String) session.getAttribute("member_id"),Integer.parseInt(map.get("auction_idx")));
		int possibleZpay=balance-bidedZpay;
		String auction_manage_status=product.get("auction_manage_status");
		System.out.println(auction_manage_status);
		System.out.println(possibleZpay);
		System.out.println(balance);
		long currentBid=Long.parseLong(map.get("auction_log_bid"));
		
		if(auction_manage_status ==  null) {
		
		if(possibleZpay<currentBid) {
			System.out.println("입찰가능금액보다 높게 입찰 불가");
			return "false";
		}else if(maxBidPrice == 0) {
			if(startPrice<=currentBid) {
				System.out.println("입찰성공");
				service.registLog(map);
				return "true";
			}else {
				System.out.println("입찰불가");
				return "false3";
			}
			
		}else{
			if(maxBidPrice<currentBid) {
				System.out.println("입찰성공2");
				service.registLog(map);
				return "true";
			}else {
				System.out.println("입찰불가2");
				return "false4";
			}
			
		}
		
		//발표임시
		}else {
		service.registLog(map);
		return "true";}
	}
	
	// 경매 예정 상세 페이지로 이동
	@GetMapping("auction_prepare_detail")
	public String auction_prepare_detail(Model model, int id) {
		HashMap<String, String> product= service.getAuctionProduct(id);
		String member_id=product.get("auction_seller_id");
		HashMap<String, String> seller= service.getSellerInfo(member_id);
		model.addAttribute("product", product);
		model.addAttribute("member", seller);
		
		return "auction/auction_prepare_detail";
	}

	// 경매 상품 등록폼
	@GetMapping("auction_regist_form")
	public String auction_regist_form(Model model, HttpSession session) {
		String member_id = (String) session.getAttribute("member_id");
		
		ZpayVO zpay = service2.isZpayUser(member_id);
		if(member_id == null) {
			model.addAttribute("msg", "로그인이 필요한 작업입니다!");
			model.addAttribute("targetURL", "member_login");
			return "fail_location";
		}else if(zpay == null) {
			model.addAttribute("msg", "zpay 등록이 필요한 작업입니다!");
			model.addAttribute("targetURL", "zpay_main");
			return "fail_location";
		}
		List<HashMap<String, String>> category=service.getCategory();
		List<HashMap<String, String>> brand=service.getBrand();
		int balance=service2.getZpayBalance(member_id); 
		int bidedZpay=service.getAllBidedZpay(member_id);
		int possibleZpay=balance-bidedZpay;
		
		model.addAttribute("possibleZpay", possibleZpay);
		model.addAttribute("categorylist", category);
		model.addAttribute("brandlist", brand);
		return "auction/auction_regist_form";
	}
	@ResponseBody
	@PostMapping("direct_pay_pro")
	public String directPay(Model model, HttpSession session, int id) {
			
		System.out.println("즉시구매");
		
		String member_id = (String) session.getAttribute("member_id");
		HashMap<String, String> product= service.getAuctionProduct(id);
		int maxPrice=Integer.parseInt(String.valueOf(product.get("auction_max_price")));
		String auction_manage_status=(product.get("auction_manage_status"));
		System.out.println(maxPrice);
		int balance=service2.getZpayBalance(member_id); 
		int bidedZpay=service.getBidedZpay(member_id,id);
		int possibleZpay=balance-bidedZpay;
		
		if(possibleZpay<maxPrice) {
		return "false";
		}else if(auction_manage_status!=null){
			return "false2";
		}
		HashMap<String, String> winner = new HashMap<String, String>();
		winner.put("member_id", member_id);
		winner.put("auction_idx",Integer.toString( id));
		service.registWinner(winner);
		product= service.getAuctionProduct(id);
//		String uuid = UUID.randomUUID().toString();
//		product.put("order_auction_delivery_idx", uuid);
		product.put("order_auction_commission",Double.toString(maxPrice*0.1));
	
		service.registOrder(product);
		int order_auction_idx= service.getOderauctionIdx(id);
		System.out.println(order_auction_idx);
		String idx=Integer.toString(order_auction_idx);
		return idx;
	}
	@ResponseBody
	@PostMapping("inspectionFee")
	public void inspectionFee(Model model, HttpSession session, @RequestParam long amount) {
		String member_id = (String) session.getAttribute("member_id");
		System.out.println("inspectionFee");
		System.out.println(amount);
		
		ZpayHistoryVO auctionSellerHistory = new ZpayHistoryVO();
		ZpayHistoryVO zpayHistoryInserted = new ZpayHistoryVO();
		int auction_idx=service.getAuctionIdx();
		int seller_zpay_idx = service2.getZpayIdx(member_id);
		Integer seller_zpay_balance = service2.getZpayBalance(member_id);
		// zpaySellerHistory 객체에 저장
		auctionSellerHistory.setZpay_idx(seller_zpay_idx);
		auctionSellerHistory.setMember_id(member_id);
		auctionSellerHistory.setZpay_amount(amount);
		auctionSellerHistory.setZpay_balance(seller_zpay_balance);
		auctionSellerHistory.setZpay_deal_type("검수비");
		auctionSellerHistory.setAuction_idx(Integer.toString(auction_idx)); 
		
		
		// ZPYA_HISTORY 테이블에 송금내역 추가
		service2.insertSendReceiveHistory(auctionSellerHistory);
		
		
		zpayHistoryInserted = service2.getzpayHistoryInserted();
		
		Integer zero_account_balance = service2.getZeroAccountBalance();
		
		ZeroAccountHistoryVO zeroAccount = new ZeroAccountHistoryVO();
		zeroAccount.setMember_id(member_id);
		zeroAccount.setZpay_history_idx(zpayHistoryInserted.getZpay_history_idx());
		zeroAccount.setZero_account_amount(amount);
		zeroAccount.setZero_account_balance(zero_account_balance);
		zeroAccount.setAuction_idx(auction_idx);
		zeroAccount.setZero_account_type("검수비");
		
		service2.depositWithdrawZeroAccount(zeroAccount);
	}
	
	// 경매 상품 등록
	
	@ResponseBody
	@PostMapping ("auction_regist_pro")
	public String auction_regist_pro(AuctionProductVO auctionProduct,HttpSession session, Model model) {
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", "세션이 만료되었습니다 다시 로그인하세요");
			return "fail_back";
		}
		auctionProduct.setAuction_seller_id(member_id);
				
		String uploadDir = "/resources/upload"; 
//		String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로 : "+ saveDir);
		// 실제 업로드 경로 : D:\Shared\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
		
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			// ------------------------------------------------------------------------------
			// 업로드 디렉토리를 날짜별 디렉토리로 자동 분류하기
			// => 하나의 디렉토리에 너무 많은 파일이 존재하면 로딩 시간 길어지며 관리도 불편
			// => 따라서, 날짜별 디렉토리 구별 위해 java.util.Date 클래스 활용
			// 1. Date 객체 생성(기본 생성자 호출하여 시스템 날짜 정보 활용)
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//		System.out.println(date);
			// 2. SimpleDateFormat 클래스를 활용하여 날짜 형식을 "yyyy/MM/dd" 로 지정
			// => 디렉토리 구조로 바로 활용하기 위해 날짜 구분 기호를 슬래시(/)로 지정
			// => 디렉토리 구분자를 가장 정확히 표현하려면 File.pathSeperator 또는 File.seperator 상수 활용
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			// 3. 기존 업로드 경로에 날짜 경로 결합하여 저장
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			// java.nio.file.Paths 클래스의 get() 메서드를 호출하여
			// 실제 경로를 관리하는 java.nio.file.Path 타입 객체 리턴받기
			// => 파라미터 : 실제 업로드 경로
			Path path = Paths.get(saveDir);
			
			// Files 클래스의 createDirectories() 메서드를 호출하여
			// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// BoardVO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = auctionProduct.getFile1();
		MultipartFile mFile2 = auctionProduct.getFile2();
		MultipartFile mFile3 = auctionProduct.getFile3();
//		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
//		System.out.println("원본파일명2 : " + mFile2.getOriginalFilename());
//		System.out.println("원본파일명3 : " + mFile3.getOriginalFilename());
		
		// 파일명 중복 방지를 위한 대첵
		// 현재 시스템(서버)에서 랜덤ID 값을 추출하여 파일명 앞에 붙여서
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		// => 랜덤ID 생성은 java.util.UUID 클래스 활용(UUID = 범용 고유 식별자)
		String uuid = UUID.randomUUID().toString();
//		System.out.println("uuid : " + uuid);
		
		// 생성된 UUID 값을 원본 파일명 앞에 결합(파일명과 구분을 위해 _ 기호 추가)
		// => 나중에 사용자 다운로드 시 원본 파일명 표시를 위해 분리할 때 구분자로 사용
		//    (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
//		System.out.println(uuid.substring(0, 8));
		// 생성된 UUID 값(8자리 추출)과 업로드 파일명을 결합하여 BoardVO 객체에 저장(구분자로 _ 기호 추가)
		// => 단, 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		auctionProduct.setBoard_file1("");
		auctionProduct.setBoard_file2("");
		auctionProduct.setBoard_file3("");

		// 파일명을 저장할 변수 선언
		String fileName1 = null;
		String fileName2 = null;
		String fileName3 = null;
		
		if(mFile1 != null) {
			fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
			auctionProduct.setBoard_file1(subDir + "/" + fileName1);
		}
		
		if(mFile2!= null) {
			fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
			auctionProduct.setBoard_file2(subDir + "/" + fileName2);
		}
		
		if(mFile3!= null) {
			fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
			auctionProduct.setBoard_file3(subDir + "/" + fileName3);
		}
		
		System.out.println("실제 업로드 파일명1 : " + auctionProduct.getBoard_file1());
		System.out.println("실제 업로드 파일명2 : " + auctionProduct.getBoard_file2());
		System.out.println("실제 업로드 파일명3 : " + auctionProduct.getBoard_file3());
		
		// -----------------------------------------------------------------------------------
		// BoardService - registBoard() 메서드를 호출하여 게시물 등록 작업 요청
		// => 파라미터 : BoardVO 객체    리턴타입 : int(insertCount)]
		System.out.println(auctionProduct);
		int insertCount = service.registProduct(auctionProduct);
		
		// 게시물 등록 작업 요청 결과 판별
		// => 성공 시 업로드 파일을 실제 디렉토리에 이동시킨 후 BoardList 서블릿 리다이렉트
		// => 실패 시 "글 쓰기 실패!" 메세지 출력 후 이전페이지 돌아가기 처리
		if(insertCount > 0) { // 성공
			try {
				// 업로드 된 파일은 MultipartFile 객체에 의해 임시 디렉토리에 저장되어 있으며
				// 글쓰기 작업 성공 시 임시 디렉토리 -> 실제 디렉토리로 이동 작업 필요
				// MultipartFile 객체의 transferTo() 메서드를 호출하여 실제 위치로 이동(업로드)
				// => 비어있는 파일은 이동할 수 없으므로(= 예외 발생) 제외
				// => File 객체 생성 시 지정한 디렉토리에 지정한 이름으로 파일이 이동(생성)됨
				//    따라서, 이동할 위치의 파일명도 UUID 가 결합된 파일명을 지정해야한다!
				if(mFile1!= null) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(mFile2!= null) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(mFile3!= null) {
					mFile3.transferTo(new File(saveDir, fileName3));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 글쓰기 작업 성공 시 글목록(BoardList)으로 리다이렉트
			return "true";
		} else { // 실패
			model.addAttribute("msg", "글 쓰기 실패!");
			return "fail_back";
		}
		
	}
}
			
