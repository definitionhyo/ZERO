	package com.itwillbs.zero.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.zero.service.MemberService;
import com.itwillbs.zero.service.ZmanDeliveryService;
import com.itwillbs.zero.service.ZmanService;
import com.itwillbs.zero.service.ZpayService;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.ZmanDeliveryVO;
import com.itwillbs.zero.vo.ZmanEarningVO;
import com.itwillbs.zero.vo.ZmanRefundHistoryVO;
import com.itwillbs.zero.vo.ZmanVO;
import com.itwillbs.zero.vo.ZpayVO;

@Controller
public class ZmanController {
	
	@Autowired
	private ZmanDeliveryService service;
	
	// 멤버 은행등록여부 조회 및 ZMAN 신청 데이터 가져오기위한 서비스 추가 - 정의효 
	@Autowired
	private MemberService member_service;
	
	// ZMAN 회원가입 페이지에서 계좌번호확인 - 정의효
	@Autowired
	private ZpayService zpay_service;
	
	// ZMAN 회원가입
	@Autowired
	private ZmanService zman_service;
	
	// ZMAN 메인 페이지로 이동
	@GetMapping("zman_main")
	public String zmanMain(HttpSession session, Model model) {
		System.out.println("ZmanController - zman_main");
		
		
		String member_type = (String) session.getAttribute("member_type");
		String member_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(member_id);
		System.out.println(member_type);
		System.out.println(member_id);
		
		if (zman != null) {
			model.addAttribute("zman", zman);
		    System.out.println(zman.getZman_status());
		}
		
		if (zman == null) {
		    session.setAttribute("previousPage", "zman_join_form");
		    return "member/member_zman_join_identification";
		} else if (member_type.equals("Z맨") || member_type.equals("직원") || zman.getZman_status().equals("활동")) {
		    model.addAttribute("zman", zman);
		    
			List<ZmanDeliveryVO> zmanDeliveryYetList = service.getDeliveryYetList();
			System.out.println("ZmanDeliveryVO : " + zmanDeliveryYetList);
//			System.out.println(zmanDeliveryYetList.);
			model.addAttribute("zmanDeliveryYetList", zmanDeliveryYetList);
		    
		    return "zman/zman_delivery_want";
		} else if (zman.getZman_status().equals("대기") || zman.getZman_status().equals("탈퇴")) {
		    model.addAttribute("zman", zman);
		    return "member/member_zman_standby";
		} else {
		    session.setAttribute("previousPage", "zman_join_form");
		    return "member/member_zman_join_identification";
		}
	}
	
	// ZMAN 정산내역 페이지로 이동
	@GetMapping("zman_earning")
	public String zmanEarning(HttpSession session, Model model) {
		System.out.println("ZmanController - zman_earning");
		
		String zman_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(zman_id);
		model.addAttribute("zman", zman);
		
		return "zman/zman_earning";
	}
	
	// ZMAN 정산리스트 가져오기
	@ResponseBody
	@GetMapping("zman_earning_list")
	public String zmanEarningList(HttpSession session) {
		System.out.println("ZmanController - zmanEarningList");
		
		String zman_id = (String) session.getAttribute("member_id");
		
//		List<ZmanDeliveryVO> zmanDeliveryDoneList = service.getDeliveryDoneList();
		List<ZmanDeliveryVO> zmanEarningList = service.getEarningList(zman_id);
		System.out.println("zmanEarningList - " + zmanEarningList);
		
		JSONArray json = new JSONArray(zmanEarningList);
		System.out.println(json);
		
		return json.toString();
	}
	
	// ZMAN 배달 예정 페이지로 이동
	@GetMapping("zman_delivery_want")
	public String zmanDeliveryWant(HttpSession session, Model model) {
		System.out.println("ZmanController - zman_delivery_want");
		
		List<ZmanDeliveryVO> zmanDeliveryYetList = service.getDeliveryYetList();
		System.out.println("ZmanDeliveryVO : " + zmanDeliveryYetList);
//		System.out.println(zmanDeliveryYetList.);
		model.addAttribute("zmanDeliveryYetList", zmanDeliveryYetList);
		
		String member_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(member_id);
		model.addAttribute("zman", zman);
		
		return "zman/zman_delivery_want";
	}
	
	// ZMAN 배달 출발지 리스트 가져오기
	@ResponseBody
	@GetMapping("getDeliveryStartspotList") 
	public String getDeliveryStartspotList(@RequestParam("markerId") Long markerId) {
		System.out.println("ZmanController - getDeliveryStartspotList");
		System.out.println("markerId - " + markerId);
		
		List<ZmanDeliveryVO> startspotList = service.getDelivertStartspotList(markerId);
		System.out.println(startspotList);
		
		JSONArray json = new JSONArray(startspotList);
		System.out.println(json);
		
		return json.toString();
		
	}
	
	// 마커 클릭 시 보여줄 정보 가져오기
	@ResponseBody
	@GetMapping("markerClickInfo")
	public String getMarkerClickInfo(@RequestParam("markerTitle") String markerTitle) {
	    System.out.println("ZmanController - markerClickInfo");
	    
	    List<ZmanDeliveryVO> markerClickInfo = service.getMarkerClickInfo(markerTitle);
	    System.out.println(markerClickInfo);
	    
	    JSONArray json = new JSONArray(markerClickInfo);
	    System.out.println(json);
	    
	    return json.toString();
	}
	
	// ZMAN zman_delivery_status "배달 수락"로 변경하기
	@GetMapping("zman_delivery_ing")
	public String zmanDeliveyAccept(HttpSession session, Model model, 
									@RequestParam int zman_delivery_idx) {
		System.out.println("ZmanController - zman_delivery_go");
//		System.out.println("zman_id - " + zman_id);
		
		String zman_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(zman_id);
		model.addAttribute("zman", zman);
		
		// 배달 상세 정보 - 출발지와 배달지 가져오기
		ZmanDeliveryVO zd = service.getDeliveryDetail(zman_delivery_idx);
		System.out.println("출발지  - " + zd.getZman_delivery_startspot());
		System.out.println("도착  - " + zd.getZman_delivery_endspot());
		System.out.println("zd  - " + zd);
		
		// 배달 수락 상태로 변경하기
		int updateCount = service.acceptDelivery(zman_delivery_idx, zman_id);
		
		System.out.println("zman_id 넣어진 값 확인 중입니다  -- " + zman_id);
		
		
		if(updateCount > 0) {
			model.addAttribute("zd", zd);
			model.addAttribute("depart", zd.getZman_delivery_startspot()); // zman_delivery_startspot
			model.addAttribute("arrive", zd.getZman_delivery_endspot()); // zman_delivery_endspot
			
			return "zman/zman_delivery_ing";
			
		} else {
			model.addAttribute("msg", "배달 수락 실패!");
			return "fail_back";
		}
		
	}
	
	// ZMAN zman_delivery_status "배달 시작" 로 변경하기
	@RequestMapping(value = "zman_delivery_start", method = {RequestMethod.GET, RequestMethod.POST})
	public String zmanDeliveryStart(@RequestParam int zman_delivery_idx, Model model, HttpSession session) {
		System.out.println("ZmanController - zman_delivery_start");
		System.out.println("zman_delivery_idx : " + zman_delivery_idx);
		
		String zman_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(zman_id);
		model.addAttribute("zman", zman);
		
		// 배달 상세 정보 - 출발지와 배달지 가져오기
		ZmanDeliveryVO zd = service.getDeliveryDetail(zman_delivery_idx);
		System.out.println("출발지  - " + zd.getZman_delivery_startspot());
		System.out.println("도착  - " + zd.getZman_delivery_endspot());
		System.out.println("zd  - " + zd);
		
		// ZMAN 배달 상태 를 '배달 시작'으로 변경하기
		int updateCount = service.updateDeliveryStatus(zman_delivery_idx);
		
		if(updateCount > 0) {
			System.out.println("zman_delivery_status - 배달 시작 으로 변경");
			
			model.addAttribute("zd", zd);
			model.addAttribute("depart", zd.getZman_delivery_startspot()); // zman_delivery_startspot
			model.addAttribute("arrive", zd.getZman_delivery_endspot()); // zman_delivery_endspot
			 
			
			return "zman/zman_delivery_ing_go";
//			 return "zman/zman_delivery_ing";
		} else {
			model.addAttribute("msg", "배달 시작 실패!");
			return "fail_back";
		}
		
	}

	// ZMAN zman_delivery_status "배달 완료" 로 변경하기
	@GetMapping("zman_delivery_end")
	public String zmanDeliveryEnd(@RequestParam int zman_delivery_idx,@RequestParam String zman_id ,Model model, HttpSession session) { 
		System.out.println("ZmanController - zman_delivery_end");
		System.out.println("zman_delivery_idx : " + zman_delivery_idx);
		
		String member_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(member_id);
		
		// ZMAN 배달 상태 를 '배달 완료'으로 변경하기
		int updateCount = service.updateDeliveryStatusEnd(zman_delivery_idx);
		ZmanDeliveryVO zd = service.getDeliveryDetail(zman_delivery_idx);
		System.out.println("zman_delivery_end - zd " + zd);
//		System.out.println("zd.getZman_id() - @@@@@@" + zd.getZman_id());
		System.out.println("zman_id - @@@@@@" + zman_id);
		
		// ZMAN 정산을 위해 ZMAN_EARNING 테입르에 값 삽입
		int insertCount = service.insertDeliveryEarning(zman_delivery_idx, zman_id, zd.getZman_delivery_commission());
		
		
		if(updateCount > 0 && insertCount > 0) {
			System.out.println("zman_delivery_status - 배달 완료 으로 변경");
			model.addAttribute("zman", zman);
			
			return "zman/zman_delivery_done";
		} else {
			model.addAttribute("msg", "배달 완료 실패!");
			return "fail_back";
		}
		
	}
	
	// ZMAN 배달 완료 내역 페이지로 이동
	@GetMapping("zman_delivery_done")
	public String zmanDeliveryDone(HttpSession session, Model model) {
		System.out.println("ZmanController - zman_delivery_done");
		
		String member_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(member_id);
		model.addAttribute("zman", zman);
//		String sId = session.getId();
		
//		List<ZmanDeliveryVO> zmanDeliveryDoneList = service.getDeliveryDoneList();
//		System.out.println("zmanDeliveryDoneList - " + zmanDeliveryDoneList);
//		
//		model.addAttribute("zmanDeliveryDoneList", zmanDeliveryDoneList);
		
		return "zman/zman_delivery_done";
	}
	
	// ZMAN 배달 완료 리스트 가져오기
	@ResponseBody
	@GetMapping("getDeliveryDoneList")
	public String getDeliveryDoneList(HttpSession session) {
		System.out.println("ZmanController - getDeliveryDoneList");
		
		String zman_id = (String) session.getAttribute("member_id");
		
//		List<ZmanDeliveryVO> zmanDeliveryDoneList = service.getDeliveryDoneList();
		List<ZmanDeliveryVO> zmanDeliveryDoneList = service.getDeliveryDoneList(zman_id);
		System.out.println("zmanDeliveryDoneList - " + zmanDeliveryDoneList);
		
		JSONArray json = new JSONArray(zmanDeliveryDoneList);
		System.out.println(json);
		
		return json.toString();
	}
	
	// ZMAN 배달 완료 상세 페이지로 이동
	@GetMapping("GetDeliveryDoneDetail")
	public String getDeliveryDetail(String zman_delivery_idx, Model model, HttpSession session) {
		System.out.println("Zmancontroller - GetDeliveryDoneDetail ");
		
		String member_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(member_id);
		model.addAttribute("zman", zman);
		
		int zmanDeliveryIdx = Integer.parseInt(zman_delivery_idx);
		
		ZmanDeliveryVO zmanDeliveryDetail = service.getDeliveryDetail(zmanDeliveryIdx);
		System.out.println("zmanDeliveryDetail - " + zmanDeliveryDetail);
		model.addAttribute("zd", zmanDeliveryDetail);
		
		// 배달 완료 상세 페이지 - 정산 완료인지 확인하기
		ZmanRefundHistoryVO zmanRefund = service.getEarningRefundIdx(zmanDeliveryIdx);
		System.out.println("zmanRefund - " + zmanRefund); 
		model.addAttribute("zmanRefund", zmanRefund);
		
		// 정산하기 파라미터 넘겨주기
		ZmanEarningVO zmanEarning = service.getEarningIdx(zmanDeliveryIdx);
		System.out.println("zmanEarning - " + zmanEarning);
		model.addAttribute("zmanEarning", zmanEarning);
		
//		ZmanEarningVO zmanEarning = service.acceptDelivery(, zman_delivery_idx)
		
		return "zman/zman_delivery_done_detail";
	}
	
	
	// ZMAN 마이페이지로 이동
	@GetMapping("zman_myPage")
	public String zmanMyPage(HttpSession session, Model model) {
		System.out.println("Zmancontroller - zman_myPage ");
		
		String member_id = (String) session.getAttribute("member_id");
		ZmanVO zman = zman_service.getZman(member_id);
		model.addAttribute("zman", zman);
		
		ZpayVO zpay = service.getZpay(member_id);
		model.addAttribute("zpay", zpay);
		
		return "zman/zman_myPage";
	}
	
	// ZMAN 지도 test 페이지로 이동하기
	@GetMapping("zman_test_location")
	public String zman_test_location(Model model) {
		
		System.out.println("Zmancontroller - zman_test_location ");
		
		// DB 에 저장된 출발지와 도착지 가져오기 - 파라미터 zman_delivery_idx
//		ZmanDeliveryVO zd = service.getDeliveryLocation();
//		System.out.println("zd - " + zd);
		
//		model.addAttribute("depart", zd.getZman_delivery_startspot());
//		model.addAttribute("arrive", zd.getZman_delivery_endspot());
		
//		ZMANDELIVERYVO ZD = SERVICE.GETDELIVERYDETAIL(ZMAN_DELIVERY_IDX);
//		SYSTEM.OUT.PRINTLN("출발지  - " + ZD.GETZMAN_DELIVERY_STARTSPOT());
//		SYSTEM.OUT.PRINTLN("도착  - " + ZD.GETZMAN_DELIVERY_ENDSPOT());
		
		model.addAttribute("depart", "부산 부산진구 동천로 109 "); // zman_delivery_startspot 
		model.addAttribute("arrive", "부산 부산진구 동천로 4"); // zman_delivery_endspot
		
		return "zman/zman_delivery_want_test";
	}
	
	
	
	
	// 신청 폼
	@GetMapping("zero_report_form")
	public String zmanReportForm() {
		
		return "zero_report_form";
	}
	
	// 정의효 - Z-MAN관련
	// Z-MAN 가입 신청폼
	@GetMapping("zman_join_form")
	public String zmanJoinForm(HttpSession session, Model model, MemberVO member) {
		
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
			if(member_id == null) {
				model.addAttribute("msg", " 로그인이 필요합니다!");
				model.addAttribute("targetURL", "member_login");
									
				return "fail_location";
			}
		
		// member_id로 member 데이터 조회후 member_bank_auth 유무에 따른 이동 - 필요없음 신청시 zpay신청으로보내면됨
//		MemberVO memberBankAuth = member_service.isValidBank(member_id);
//		
//		if(memberBankAuth.getMember_bank_auth().equals("N")) {
//			model.addAttribute("msg", "계좌등록이 완료된 상태여야합니다!");
//			model.addAttribute("targetURL", "member_account");
//			return "fail_location";
//		} else {
//		}
		
		// zpay계좌 확인 있으면 1
		ZpayVO zpayCheck = zpay_service.isZpayUser(member_id);
		model.addAttribute("zpayCheck", zpayCheck);
		
		// 로그인된 아이디로 member 테이블에서 가져올수있는거 가져오기(혜진코드 재사용)
		MemberVO memberInfo = member_service.getMember(member_id); 
		model.addAttribute("memberInfo", memberInfo);
		
		
		
		return "member/member_zman_join_form";
	}
	
	
	
	// Z-MAN 신청 메인 - 신청하기 버튼 클릭시 확인 절차 후 리다이렉트 -> 완료창
	@PostMapping("zman_join_pro")
	public String zmanJoinPro(HttpSession session, 
							  Model model, 
							  ZmanVO zman,
							  @RequestParam("vehicle[]") String[] vehicles,
							  @RequestParam("zman_area") String zman_area) {
		
		
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
				if(member_id == null) {
					model.addAttribute("msg", " 로그인이 필요합니다!");
					model.addAttribute("targetURL", "member_login");
									
					return "fail_location";
				}

		// Arrays를 사용하여 vehicles 배열을 문자열로 변환하고, 각 요소 사이에 쉼표를 추가합니다.
	    String vehiclesStr = String.join(",", vehicles);
		System.out.println(zman.getZman_id());
		int insertCount = zman_service.registZman(zman, vehiclesStr, zman_area);
		
		if(insertCount > 0) {
			return "redirect:/zman_main";
		} else {
			model.addAttribute("msg", "Z-MAN 신청 실패 다시 작성해주세요");
			return "fail_back";
		}
		
	}
	
	
	// Z-MAN 신청완료 이동
	@GetMapping("zman_join_complete")
	public String zmanJoinComplete() {
		return "member/member_zman_join_complete";
	}
	
	
	
	
}
