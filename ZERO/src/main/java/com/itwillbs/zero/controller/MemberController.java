package com.itwillbs.zero.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.spi.FileSystemProvider;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.zero.vo.CsVO;
import com.itwillbs.zero.vo.PageInfoVO;
import com.itwillbs.zero.service.SendMailService;
import com.itwillbs.zero.email.EmailErrorResponse;
import com.itwillbs.zero.email.SuccessResponse;
import com.itwillbs.zero.handler.GenerateRandomCode;
import com.itwillbs.zero.handler.MyPasswordEncoder;
import com.itwillbs.zero.service.AuctionService;
import com.itwillbs.zero.service.LikesService;
import com.itwillbs.zero.service.MemberService;
import com.itwillbs.zero.service.SecondhandService;
import com.itwillbs.zero.service.TestService;
import com.itwillbs.zero.service.ZpayService;
import com.itwillbs.zero.sns.OAuthService;
import com.itwillbs.zero.vo.GoogleOAuthResponseVO;
import com.itwillbs.zero.vo.MemberReviewVO;
import com.itwillbs.zero.vo.MemberVO;
import com.itwillbs.zero.vo.OrderSecondhandVO;
import com.itwillbs.zero.vo.SecondhandVO;
import com.itwillbs.zero.vo.ZpayHistoryVO;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	// 메일 인증을위한 Autowired
	@Autowired
	private ApplicationContext ctx;
	
	// 핸드폰 인증을 위한 Autowired
	@Autowired
	private TestService testService; 
	
	// 현재 참가중인 경매목록을 위한 Autowired
	@Autowired
	private AuctionService auctionService;
	
	// 중고상품 좋아요 Autowired
	@Autowired
	private LikesService likesService;
	
	@Autowired
	private OAuthService oauthService;

	@Autowired
	private ZpayService zpayService;
	
	// 멤버 로그인 - 수정
	@GetMapping("member_login")
	public String memberLogin(HttpSession session
			, Model model
			) {
		System.out.println("MemberController - memberlogin");
		
		if(session.getAttribute("member_id") != null) { // 로그인 상태
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
			
		}
		
		return "member/member_login";
	}
	
	// 멤버 로그인 프로  - 수정
	@PostMapping("member_login_pro")
	public String memberLoginPro(HttpSession session
			, Model model
			, HttpServletResponse response
			, @RequestParam String member_id
			, @RequestParam String member_passwd
			, @RequestParam(defaultValue = "false") boolean remember_me
			) {
		
		System.out.println("MemberController - memberloginPro");
		System.out.println(member_id);
		System.out.println(member_passwd);
		
		if(session.getAttribute("member_id") != null) { // 로그인 상태
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
			
		}
		
		Map<String, String> member = service.isMemberCheck("member_id", member_id);
		System.out.println(member);
		
		if(member == null) {
			model.addAttribute("msg", "등록되지 않은 아이디 입니다. "
					+ "입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		}
	
		// 2. BcryptPasswordEncoder 객체 생성
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
//		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
		String securePasswd = member.get("member_passwd");
		
		// 3. BcryptPasswordEncoder 객체의 matches() 메서드 호출해서 암호 비교
		// => 파라미터 : 평문, 암호화 된 암호 		리턴타입 : boolean
		// 로그인 성공/ 실패 여부 판별하여 포워딩
		// => 성공 : MemberVO 객체에 데이터가 저장되어 있고 입력받은 패스워드가 같음
		// => 실패 : MemberVO 객체가 null 이거나 입력받은 패스워드와 다름
		
//		System.out.println("securePasswd : " + securePasswd);
		
		// 임시 암호화 패스워드
//		System.out.println("securePasswd :" + securePasswd);
//		System.out.println("member_passwd:" + member_passwd);
//		System.out.println(passwordEncoder.matches(member_passwd, member.get("member_passwd").trim()));
		
		if (member.get("member_passwd") ==  null || !passwordEncoder.matches(member_passwd, member.get("member_passwd"))) {
//			// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. "
					+ "입력하신 내용을 다시 확인해주세요.");
			return "fail_back";
		} else {
//			// 로그인 성공 시
//			// ------------------------- 메일 인증 확인 기능 추가 ---------------------------
			if(member.get("member_mail_auth").equals("N")) { // 메일 미인증 회원
			// "fail_back.jsp" 페이지 포워딩("이메일 인증 후 로그인이 가능합니다." 출력)
			model.addAttribute("msg", "이메일 인증 후 로그인이 가능합니다.");
			return "fail_back";
			}
			
//			// 탈퇴한 회원인 경우(member_status가 "탈퇴") 탈퇴한 회원입니다 하고 돌려보내기
			if(member.get("member_status").equals("탈퇴")) {
				model.addAttribute("msg", "탈퇴한 회원입니다. 로그인이 불가능합니다.");
				return "fail_back";
			}
			
			session.setAttribute("member_id", member.get("member_id"));
			session.setAttribute("member_type", member.get("member_type"));
//			
//			// 만약, "아이디 저장" 체크박스 버튼이 눌려진 경우 cookie에 member_id 저장
			Cookie cookie = new Cookie("member_id", member.get("member_id"));
//			
			if(remember_me) {
//				// Cookie에 로그인 성공한 member_id 저장 (name : "member_id")
//				// cookie 유지 시간 지정 (초 단위)
				cookie.setMaxAge(60 * 60 * 24 * 15); // 15일 유지 (초 * 분 * 시 * 일)
			} else if (!remember_me) {
//				// "아이디 저장" 체크박스 버튼이 눌려져 있지 않을 때 => cookie에 member_id 제거
//				// cookie 유지 시간 지정 (초 단위)
				cookie.setMaxAge(0); // 삭제
			}
			response.addCookie(cookie);
			
			return "redirect:/";	// 메인페이지(루트)로 리다이렉트 (href="./" 와 같음)
		}
	}

	
	// 로그아웃 작업 후 메인으로 돌아가기  - 수정
	@GetMapping("member_logout")
	public String member_logout(HttpSession session
			, Model model
			) {
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
		// 세션에 저장한 member_id(저장한 정보들) 초기화
		session.invalidate();
		
		// 세션 초기화 후 main 화면으로 돌아가기
		return "redirect:/";
	}
	
	// 네이버 로그인 콜백  - 수정
	@GetMapping("callback_login_naver")
	public String callbackLoginNaver(HttpSession session
			, Model model) {
		System.out.println("MemberController - callback_login_naver");
		
		return "member/member_callback_naver";
	}
	
	 
	// 네이버 정보 전달  - 수정
	@PostMapping("/ajax/checkUserNaver")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String checkUserNaver(HttpSession session
							, Model model
							, @RequestParam Map map
							) {
		
		  System.out.println("map : "+ map);
		  
		  // 임시 고정값 설정 
		  Iterator<String> iterator = map.keySet().iterator();
		  String column = iterator.next();
		  System.out.println(column);
		  System.out.println(iterator.next());
		  System.out.println(map.get(column).toString());
		  // 회원정보 가져오기
		  Map<String, String> member = service.isMemberCheck(column, map.get(column).toString());
		  System.out.println(member);
		  
		// 네이버에서 전달받은 이메일 값으로 회원가입 여부 판별
		if (member != null) {
//			// DB에 네이버에서 전달받은 이메일이 아이디로 존재할 때
			System.out.println("존재하는 회원");
//				
//			// 이미 가입된 회원이므로 세션에 유저의 아이디 저장
			session.setAttribute("member_id", member.get("member_id"));
			session.setAttribute("member_type", member.get("member_type"));
			return "existing";
//		 
		} else {
//			// DB에 아이디가 존재하지 않는 경우 -> 회원가입으로 넘어가기
			System.out.println("회원가입 넘어가기 : " + map.get(column).toString() + "," +map.get("member_name").toString());
//			session.setAttribute("no_member_id", map.get(column).toString());
//			session.setAttribute("no_member_name", map.get("member_name").toString());
			return "new";
		}
		  
//		  return "";
		
	}

	// 구글 로그인 콜백  - 수정
//	@ResponseBody
	@RequestMapping("callback_login_google")
	public String callbackLoginGoogle(HttpSession session
			, @RequestParam("code") String accessCode
			, Model model
			) {
		
		System.out.println("MemberController - callback_login_google");
		System.out.println("code : " + accessCode);
		
		ResponseEntity<GoogleOAuthResponseVO> response = oauthService.getGoogleAccessToken(accessCode);
		
		String decodedToken = decodeIdToken(response.getBody().getId_token());
		model.addAttribute("data", decodedToken);
		return "member/member_callback";
	}
	
	// 구글 로그인 정보 암호화 해제
	private String decodeIdToken(String idToken) {
	    String[] idTokenParts = idToken.split("\\.");
	    String payloadBase64 = idTokenParts[1];

	    // Base64 디코딩 후 JSON 파싱
	    byte[] decodedBytes = java.util.Base64.getDecoder().decode(payloadBase64);
	    String payloadJson = new String(decodedBytes, StandardCharsets.UTF_8);

	    // JSON 파싱을 위해 Gson 라이브러리 사용
	    Gson gson = new Gson();
	    JsonObject jsonObject = gson.fromJson(payloadJson, JsonObject.class);

	    return jsonObject.toString();
	}
	
	// ajax로 로그인 정보 가져오기  - 수정
	@PostMapping("ajax/checkUser")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String checkUser(HttpSession session
							, Model model
							, @RequestParam Map map
							) {
		
		  System.out.println("map : "+ map);
		  
		  // 임시 고정값 설정 
		  Iterator<String> iterator = map.keySet().iterator();
		  String column = iterator.next();
		  System.out.println(column);
		  System.out.println(iterator.next());
		  System.out.println(map.get(column).toString());
		  // 회원정보 가져오기
		  Map<String, String> member = service.isMemberCheck(column, map.get(column).toString());
		  System.out.println(member);
		  
		// 전달받은 이메일 값으로 회원가입 여부 판별
		if (member != null) {
//			// DB에 네이버에서 전달받은 이메일이 아이디로 존재할 때
			System.out.println("존재하는 회원");
//				
//			// 이미 가입된 회원이므로 세션에 유저의 아이디 저장
			session.setAttribute("member_id", member.get("member_id"));
			session.setAttribute("member_type", member.get("member_type"));
			return "existing";
//		 
		} else {
//			// DB에 아이디가 존재하지 않는 경우 -> 회원가입으로 넘어가기
			System.out.println("회원가입 넘어가기 : " + map.get(column).toString() + "," +map.get("member_name").toString());
//			session.setAttribute("no_member_id", map.get(column).toString());
//			session.setAttribute("no_member_name", map.get("member_name").toString());
			return "new";
		}
		  
		
	}
	
	// 2. 카카오 로그인 클릭
	@PostMapping("/checkKakao")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String checkKakao(@RequestParam String email, @RequestParam String nickname, HttpSession session) {
		// 카카오에서 받아온 데이터 출력
		System.out.println("email : " + email + "name : " + nickname);
		
		
		
		// DB에서 리턴받아 판별
		// MemberService - idCheck()
		// 파라미터 : String(email -> member_id)		리턴타입 : int(idCheck)
		int idCheck = service.idCheck(email);
		
		// 카카오에서 전달받은 이메일 값으로 회원가입 여부 판별
		if (idCheck > 0) {
			// DB에 카카오에서 전달받은 이메일이 아이디로 존재할 때
			System.out.println("존재하는 회원");
			
			// 이미 가입된 회원이므로 세션에 유저의 아이디 저장
			session.setAttribute("member_id", email);
			return "existing";
		} else {
			// DB에 아이디가 존재하지 않는 경우 -> 회원가입으로 넘어가기
			return "new";
		}
		
	}
	
	
	
	// 멤버 로그인정보  - 수정
	@GetMapping("member_Info")
	public String memberLoginInfo(HttpSession session
			, Model model) {
		
		System.out.println("MemberController - memberloginInfo");
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
		String column = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		// 임시 고정값 설정 
		
		System.out.println(column);
		System.out.println(member_id);
		// 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck(column, member_id);
		System.out.println(member);
		
		model.addAttribute("member", member);
		
		return "member/member_Info";
	}
	
//	// 멤버 마케팅 수신 동의 변경
//	@PostMapping("ajax/chgMarketing")
//	@ResponseBody
//	public JSONObject chgMarketing(HttpSession session
//			, Model model
//			, @RequestParam Map<String, String> map
//			) {
//		System.out.println("/ajax/chgMarketing" + map);
//		// 조건 파라미터 - 아이디
//		String column1 = "member_id";
//		String member_id = (String)session.getAttribute("member_id");
//		  
//		// 변경할 컬럼( member_agreement_marketing)
//		String column2 = map.get("column");
//		String value2 = map.get("value");
//		int updateCount = service.updateMember(column1, member_id, column2, value2);
//		
//		JSONObject jo = new JSONObject();
//		jo.put(column2, value2);
//		
//		return jo;
//	}
	
	// 패스워드 일치여부 확인  - 수정
	public String checkPasswd(String column,String member_id, String column1,String value1, HttpSession session
			, Model model) {
		System.out.println("checkPasswd");

		if(session.getAttribute("member_id") != null) { // 로그인 상태
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		// 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck(column, member_id);
		
//		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
//		String securePasswd = member.get("member_passwd");
		
//		if (member.get("member_passwd") ==  null || !passwordEncoder.matches(member_passwd, member.get("member_passwd"))) {
		
		if(!passwordEncoder.isSameCryptoPassword(value1, member.get("member_passwd"))) {
			System.out.println("비밀번호 불일치");
			// 패스워드가 member.getPasswd와 다를 때(비밀번호가 틀림)
//			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했습니다. "
//					+ "입력하신 내용을 다시 확인해주세요.");
			return "false"; // 회원정보 불일치
		}
			return "true"; // 회원정보 일치
			
		
	
	}
	
	// 멤버 패스워드, 폰번호 변경  - 수정
	@PostMapping("ajax/chgInfo")
	@ResponseBody
	public String chgInfo(HttpSession session
			, Model model
			, @RequestParam Map<String, String> map
			) {
		System.out.println("ajax/chgInfo:" + map + ", session");
		
		String column = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		
		String column1 = map.get("column"); // 변경할 정보 컬럼
		String value1 = map.get("value"); // 변경할 정보 값
		
		String column2 = map.get("column2"); // 이전 패스워드
		String value2 = map.get("value2"); // 이전 패스워드 값
		
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		
		System.out.println(column + "," + member_id + "," + column1 + "," + value1);
		
		System.out.println("암호화 : " + column1.equals("member_passwd2"));
		if(column1.equals("member_passwd2")) { // 비밀번호 변경 시 암호화
			
			// 1. 이전 비밀번호 일치 여부 확인
			String result = checkPasswd(column, member_id, column2, value2, session, model);
			if(result.equals("false")) { // 비밀번호 불일치 시
				return "false";
			}
			
			// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
			String securePasswd = passwordEncoder.getCryptoPassword(value1);
			System.out.println("암호화된 비밀번호 : " + securePasswd);
			// 3. 리턴받은 암호문을 value1 덮어쓰기
			value1 = securePasswd;
			column1 = "member_passwd";
			System.out.println("value1:" + value1);
		}
		
		int updateCount = service.updateMember(column, member_id, column1, value1);
		
		return column1;
	}
	
	// 멤버 패스워드, 폰번호 변경
//	@PostMapping("zero/ajax/chgInfo")
//	@ResponseBody
//	public String chgInfo2(HttpSession session
//			, Model model
//			, @RequestParam Map<String, String> map
//			) {
//		System.out.println("ajax/chgInfo2" + map);
//		
//		
//		
//		return "ajax 끝";
//	}
	
	// 멤버 주소 등록 페이지  - 수정
	@GetMapping("member_address")
	public String memberAddress(HttpSession session
			, Model model) {
		System.out.println("MemberController - memberAddress");
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
		String column = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		// 임시 고정값 설정 
		
		System.out.println(column);
		System.out.println(member_id);
		// 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck(column, member_id);
		System.out.println(member);
		
		model.addAttribute("member", member);
		
		return "member/member_address";
	}
	
	// 멤버 주소 등록 추가  - 수정
	@PostMapping("member_address_regist")
	@ResponseBody
	public String memberAddressRegist(HttpSession session
			, @RequestBody Map<String, String> map
			, Model model) {
		
		System.out.println("MemberController - memberAddressRegist");
		System.out.println(map);
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
		String member_id = (String)session.getAttribute("member_id");
		// 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck("member_id", member_id);
		System.out.println(member);
		
		JsonArray myAddress = new JsonArray();
		// 주소 3개가 이미 
		if(member.containsKey("member_address1") && member.containsKey("member_address2") && member.containsKey("member_address3") ) {
			System.out.println("주소 3개 존재");
			
			myAddress.add("주소는 최대 3개까지 추가 가능합니다");
			
			return myAddress.toString();
		}
		
		if(member.get("member_address2") == null) { // 주소 2 추가(만약 대표 배송지 설정시 1번과 2번 변경)
			
			if(map.get("chk_main").equals("true")) { // 대표배송지를 주소2로 변경 후 대표배송지 추가
				
				service.addMainAddress("main_add2" , map); 
				myAddress.add("대표 주소가 추가되었습니다");
				
				return myAddress.toString();
			} else {
				
				service.addAddress("add2" , map); 
				myAddress.add("주소2가 추가되었습니다");
				
				return myAddress.toString();
			}
		} else if (member.get("member_address3") == null) { // 주소 3 추가(만약 대표 배송지 설정시 1번과 3번 변경)
				
			if(map.get("chk_main").equals("true")) { // 대표배송지를 주소3으로 변경 후 대표배송지 추가
				
				service.addMainAddress("main_add3" , map); 
				myAddress.add("대표 주소가 추가되었습니다");
				
				return myAddress.toString();
			} else {
				
				service.addAddress("add3" , map); 
				myAddress.add("주소3가 추가되었습니다");
				
				return myAddress.toString();
			}
		}
		
		return "";
		
	}

	// 멤버 주소 수정  - 수정
	@PostMapping("member_address_update")
	@ResponseBody
	public String memberAddressUpdate(HttpSession session
			, @RequestBody Map<String, String> map
			, Model model) {
		System.out.println("MemberController - memberAddressUpdate");
		System.out.println(map);
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}

		String member_id = (String)session.getAttribute("member_id");
		// 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck("member_id", member_id);
		System.out.println(member);
		
		JsonArray myAddress = new JsonArray();
		if(map.get("chk_main").equals("true")) { // 대표 주소지 변경
			
			service.reWriteAddress(map); 
			
			myAddress.add("대표 주소가 변경되었습니다");
			return myAddress.toString();

		} else if(map.get("rew").equals("rew_num2")) { // 주소 2 변경(만약 대표 배송지 설정시 1번과 2번 변경)
				
			service.reWriteAddress(map); 
			
			myAddress.add("주소2가 변경되었습니다");
			return myAddress.toString();
			
		} else if (map.get("rew").equals("rew_num3")) { // 주소 3 변경(만약 대표 배송지 설정시 1번과 3번 변경)
				
			service.reWriteAddress(map); 
			
			myAddress.add("주소3가 변경되었습니다");
			return myAddress.toString();
			
		}
		
		return "";
		
	}
	
	// 멤버 주소 삭제  - 삭제
	@PostMapping("member_address_delete")
	@ResponseBody
	public String memberAddressDelete(HttpSession session
			, @RequestBody Map<String, String> map
			, Model model) {
		
		System.out.println("MemberController - memberAddressDelete");
		System.out.println(map);
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}

		String member_id = (String)session.getAttribute("member_id");
		// 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck("member_id", member_id);
		System.out.println(member);
		
		JsonArray myAddress = new JsonArray();
		if(map.get("rmv_num").equals("rmv_num2")) { // 주소 2 삭제
			System.out.println("2번째 배송지 삭제");  
			
			if(member.get("member_address3") == null) {// 세번째 배송지가 없는 경우 
				
				service.deleteAddress("rmv2" , map); 
				myAddress.add("주소가 삭제되었습니다");
				
				return myAddress.toString();
			} else { // 세번째 배송지가 있는 경우 두번쨰 배송지로 업데이트 후 세번째 삭제
				service.deleteAddress("rew2_rmv3" , map); 
				myAddress.add("주소가 삭제되었습니다");
				
				return myAddress.toString();
			}
				
		} else if (map.get("rmv_num").equals("rmv_num3")) { // 주소 3 삭제
			System.out.println("3번째 배송지 삭제");
			
			service.deleteAddress("rmv3" , map); 
			myAddress.add("주소가 삭제되었습니다");
			
			return myAddress.toString();
		}
		
		return "";
		
	}
	
	// 멤버 개인 계좌 등록 
	@GetMapping("member_account")
	public String memberAccount(HttpSession session
			, Model model) {
		System.out.println("MemberController - memberAccount");
		
		String column = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		// 임시 고정값 설정 
		
		System.out.println(column);
		System.out.println(member_id);
		// 회원 계좌 정보 가져오기
		Map<String, String> member = service.selectMemberInfo(column, member_id);
		System.out.println(member);
		
		model.addAttribute("member", member);
		
		return "member/member_account";
	}
	
	// 멤버 프로필  - 수정
	@GetMapping("member_profile")
	public String memberProfile(HttpSession session
			, Model model) {
		System.out.println("MemberController - memberProfile");
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
		String column = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		  // 임시 고정값 설정 
		  
		  System.out.println(column);
		  System.out.println(member_id);
		  // 회원정보 가져오기
		  Map<String, String> member = service.isMemberCheck(column, member_id);
		  System.out.println(member);
		
		  model.addAttribute("member", member);
		
		return "member/member_profile";
	}
	 
	// ajax로 프로필 이미지 변경 - 수정
	@PostMapping("ajax/checkUserEmail")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String checkUserEmail(HttpSession session
								, Model model
								, @RequestParam Map<String, String> map
								) {
		
		System.out.println("ajax/checkUserEmail : " + map);	
		String phone = "false";
		
		String column = "member_phone";
		String value = map.get("phone");
		
		// 핸드폰번호와 일치하는 이메일 주소가 있을 경우 이메일 주소 리턴
		Map result = service.isMemberCheck(column, value);
		System.out.println(result);
//		System.out.println(result.get("member_id"));
		if(result != null) {
			phone = result.get("member_id").toString();
		} else {
			phone = "false";
		}
		
		return phone;
		 
	 }
	
	
	
	// ajax로 프로필 이미지 변경  - 수정
	@PostMapping("ajax/profileUpdate")
	@ResponseBody	// Json 형태의 응답을 반환하도록 지정
	public String profileUpdate(HttpSession session
							, Model model
							, @RequestParam MultipartFile profile
							) {
		//  MultipartFile 객체 확인
		  System.out.println("profile : "+ profile);
		  
		  // 조건 파라미터 - 아이디
		  String column1 = "member_id";
		  String member_id = (String)session.getAttribute("member_id");
		  
		  // 변경할 컬럼
		  String column2 = "member_image";
		  
		  // 임시 고정값 설정 
//		  Iterator<String> iterator = map.keySet().iterator();
//		  String column = iterator.next();
//		  System.out.println(column);
//		  System.out.println(iterator.next());
//		  System.out.println(map.get(column).toString());
		  // 회원정보 가져오기
		  
//			System.out.println(request.getRealPath("/resources/upload")); // Deprecated 처리된 메서드
			String uploadDir = "/resources/upload"; 
//			String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			System.out.println("실제 업로드 경로 : "+ saveDir);
			// 실제 업로드 경로 : D:\Shared\Spring\workspace_spring5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring_MVC_Board\resources\ upload
			
			String subDir = ""; // 서브디렉토리(날짜 구분)
			
			try {
				// ------------------------------------------------------------------------------

				Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
//			System.out.println(date);

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				// 기존 업로드 경로에 날짜 경로 결합하여 저장
				subDir = sdf.format(date);
				saveDir += "/" + subDir;
				// --------------------------------------------------------------

				// => 파라미터 : 실제 업로드 경로
				Path path = Paths.get(saveDir);
				
				// Files 클래스의 createDirectories() 메서드를 호출하여
				// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
				Files.createDirectories(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// BoardVO 객체에 전달된 MultipartFile 객체 꺼내기
//			MultipartFile mFile1 = csInfo.getFile1();
//			System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
			

			// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
			String uuid = UUID.randomUUID().toString();
//			System.out.println("uuid : " + uuid);
			
			// 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
//			csInfo.setCs_file("");
			
			// 파일명을 저장할 변수 선언
			String fileName1 = uuid.substring(0, 8) + "_" + profile.getOriginalFilename();
			
			String fileRealName = subDir + "/" + fileName1;
			System.out.println("실제 업로드 파일명1 : " + fileRealName);
			
			// -----------------------------------------------------------------------------------
			// MemberService - updateMember() 메서드를 호출하여 회원정보 변경 작업 요청
			// => 파라미터 : fileName1    리턴타입 : int(updateCount)
			int updateCount = service.updateMember(column1, member_id, column2, fileRealName);
			
			
			// 프로필 변경 작업 요청 결과 판별
			if(updateCount > 0) { // 성공
				try {
					// 업로드 된 파일은 MultipartFile 객체에 의해 임시 디렉토리에 저장
					if(!profile.getOriginalFilename().equals("")) {
						profile.transferTo(new File(saveDir, fileName1));
					}

				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				// 프로필 변경 작업 성공 시 "성공" 출력
				return "성공";
			} else { // 실패
				return "프로필 변경 실패";
			}
		  
	}
	
	// ajax로 프로필 정보 변경  - 수정
	@ResponseBody
	@PostMapping("/ajax/profileUpdateInfo")
	public String profileUpdateInfo(HttpSession session
							, Model model
							, @RequestParam Map<String, String> map
							) {
		
		System.out.println("profileUpdatePost:" + map);
		JsonArray data = new JsonArray();
		
		// 조건 파라미터 - 아이디
		String column1 = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		
		String column2 = map.get("column2");
		String value2 = map.get("value2");
		
		// 닉네임 중복 검사
		
		
		int cnt = service.nickCheck(value2);
		if(cnt > 0) {
			data.add("닉네임 증복으로 변경 실패");
			return data.toString();
		}
		
		// -----------------------------------------------------------------------------------
		// MemberService - updateMember() 메서드를 호출하여 회원정보 변경 작업 요청
		// => 파라미터 : fileName1    리턴타입 : int(updateCount)
		int updateCount = service.updateMember(column1, member_id, column2, value2);
		
		
		// 프로필 변경 작업 요청 결과 판별
		if(updateCount > 0) { // 성공
						
			// 프로필 변경 작업 성공 시 "성공" 출력
			data.add("프로필 정보 변경 성공");
			return data.toString();
		} else { // 실패
			data.add("프로필 정보 변경 실패");
			return data.toString();
		}
	}
	
	// 멤버 아이디 찾기  - 수정
	@GetMapping("member_find_id")
	public String memberFindId(HttpSession session
			, Model model) {
		System.out.println("MemberController - memberFindId");
		
		if(session.getAttribute("member_id") != null) { // 로그인 상태
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		return "member/member_find_id";
	}
	
	// 멤버 패스워드 찾기 폼  - 수정
	@GetMapping("member_find_passwd")
	public String memberFindPasswd(HttpSession session
			, Model model) {
		System.out.println("MemberController - memberFindPasswd");
		
		if(session.getAttribute("member_id") != null) { // 로그인 상태
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		return "member/member_find_passwd";
	}
	
	@ResponseBody
	@PostMapping("/ajax/sendMailPasswd")
	public String sendMailPasswd(HttpSession session
							, Model model
							, @RequestParam Map<String, String> map
							) {
		
		System.out.println("sendMailPasswd:" + map);
		JsonArray data = new JsonArray();
		
		// 조건 파라미터 - 아이디, 휴대폰번호
		String member_id = (String)session.getAttribute("member_id");
		
		String id = map.get("member_id");
		System.out.println("id : " + id);
		
		// 이메일과 휴대폰이 동일한지 검사
		Map<String, String> result = service.isCheckIdPhone(map);
		System.out.println("result : " + result);
		if(result == null) {
			data.add("일치하는 회원 정보가 없습니다");
			return data.toString();
		}
		
		
		// 난수 생성 후 리턴받기 위해 사용자 정의 클래스 GenerateRandomCode 의 static 메서드 getRandomCode() 호출
		// => 파라미터 : 난수 길이(정수)   리턴타입 : String(authCode)
		String authCode = GenerateRandomCode.getRandomCode(10); // 50글자에 맞는 난수(영문자, 숫자) 리턴
		System.out.println(authCode);
		
		
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
		String securePasswd = passwordEncoder.getCryptoPassword(authCode);
		System.out.println("암호화된 비밀번호 : " + securePasswd);
		
		// 3. BcryptPasswordEncoder 객체의 matches() 메서드 호출해서 암호 비교
		// => 파라미터 : 평문, 암호화 된 암호 		리턴타입 : boolean
		// 로그인 성공/ 실패 여부 판별하여 포워딩
		// => 성공 : MemberVO 객체에 데이터가 저장되어 있고 입력받은 패스워드가 같음
		// => 실패 : MemberVO 객체가 null 이거나 입력받은 패스워드와 다름
		
		System.out.println("securePasswd : " + securePasswd);
		result.put("securePasswd", securePasswd);
		
		// -----------------------------------------------------------------------------------
		// MemberService - updateMember() 메서드를 호출하여 회원정보 변경 작업 요청 패스워드 암호화 처리
		// => 파라미터 : fileName1    리턴타입 : int(updateCount)
		int updateCount = service.updateMemberPasswd(result);
		
		
		// 패스워드 변경 작업 요청 결과 판별
		if(updateCount > 0) { // 성공
			new Thread(new Runnable() {
				
				@Override
				public void run() {
					SendMailService mailService = new SendMailService();
					mailService.sendPasswdMail(authCode, id);
				}
			}).start(); // start() 메서드 호출 필수!			
			// 임시비밀번호 전송 작업 성공 시 "성공" 출력
			
//			data.add("임시 비밀번호가 메일로 전송되었습니다");
//			data.add("result");
//			return data.toString();
			return "true";
		} else { // 실패
//			data.add("메일 전송이 실패했습니다");
//			return data.toString();
			return "false";
		}
		
		
	}
	
	// 회원 이메일 인증 페이지 이동  - 수정
	@GetMapping("member_find_emailAuth")
	public String memberFindEmailAuth(HttpSession session
			, Model model
			, @RequestParam Map<String, String> map
			) {
		
		System.out.println("memberWithdrawal:" + map);
	
		return "member/member_find_emailAuth";
	}
	
	
	
	// 멤버 이메일 인증 요청 - 작업중
	@PostMapping("request_authMail_find_passwd")
	public String memberFindEmailAuthPro(HttpSession session
			, Map<String, String> map
			, Model model) {
		System.out.println("MemberController - memberFindEmailAuth");
		System.out.println("메일 인증:" + map);
		// 인증 메일 발송 요청
		String sId = (String)model.getAttribute("sId");
		
		if(session.getAttribute("member_id") != null) { // 로그인 상태
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
			// Service - getId() 메서드를 호출하여
			// member 테이블에서 email 에 해당하는 id 값 조회
			// => 파라미터 : 이메일(email)    리턴타입 : String(id)
//			String id = service.getId(email);
//			System.out.println(id);
			
			// SendAuthMail 인스턴스 생성 후 sendMail() 메서드 호출하여 메일 발송 요청
			// => 파라미터 : 아이디, 이메일   리턴타입 : boolean(isSendSuccess)
//			SendMailService mailService = new SendMailService();
//			String authCode = mailService.sendAuthMail(id, email);
//			System.out.println("메일 발송 결과 인증코드 : " + authCode);
			
			// MemberService - registAuthInfo() 메서드를 호출하여 
			// 인증 메일에 포함된 아이디와 인증코드를 인증정보 테이블에 추가
			// => 파라미터 : 아아디, 인증코드   리턴타입 : void
			// => 단, 메일 발송 후 리턴받은 인증코드가 있을 경우에만 작업 수행
//			if(!authCode.equals("")) {
//				// 인증 코드 DB 작업 요청
//				service.registAuthInfo(id, authCode);
//				
//				// AJAX 요청에 대한 응답으로 "true" 값 리턴
//				return "true";
//			}
//			
//			return "false";
		
		return "member/member_find_emailAuth";
	}
	
	// 회원 탈퇴 확인 페이지 이동  - 수정
	@GetMapping("member_withdrawal")
	public String memberWithdrawal(HttpSession session
			, Model model
			, @RequestParam Map<String, String> map
			) {
		
		System.out.println("memberWithdrawal:" + map);
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
	
		return "member/member_withdrawal";
	}
	
	// 회원 탈퇴 요청/ajax/checkWithrawal  - 수정
	@GetMapping("/ajax/checkWithrawal")
	@ResponseBody
	public String checkWithrawal(HttpSession session
			, Model model
			) {
		System.out.println("ajax/checkWithrawal");
		
		// 세션 파라미터 없을 경우 리턴(구현중)

		
		// 조건 파라미터 - 아이디
		String column1 = "member_id";
		String member_id = (String)session.getAttribute("member_id");
		
		// 변경할 컬럼 파라미터
		String column2 ="member_status";
		String value2 = "탈퇴";
		
		// 옥션 판매중이거나 낙찰진행중인 경우 탈퇴 불가
		boolean isWithDrawalCheck = service.withDrawalCheck(member_id);
		
		if(!isWithDrawalCheck) { // 중고거래 z맨 호출중이거나 옥션 판매중이거나 입찰 진행중인 경우(구현중)
			
			return "false";
		}
		// -----------------------------------------------------------------------------------
		// MemberService - updateMember() 메서드를 호출하여 회원정보 상태 탈퇴 변경 작업 요청
		// => 파라미터 : column2, value2    리턴타입 : int(updateCount)
		int updateCount = service.updateMember(column1, member_id, column2, value2);
		
		
		// 회원상태 탈퇴 변경 작업 요청 결과 판별
		if(updateCount > 0) { // 성공
			
			return "true";
			
		} else { // 실패

			return "false";
			
		}
		
	}
	
	
	// 멤버 마이스토어 - 수정
	@GetMapping("member_mystore")
	public String memberMyStore(HttpSession session
			, @RequestParam(required = false) String member_id
			, Model model) {
		System.out.println("MemberController - memberMyStore");
		// 임시 고정값 설정 
		String column = "member_id";
		
		if(session.getAttribute("member_id") == null) { // 비로그인 상태
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
//		if(member_id == null ) { // 파라미터 member_id가 없을경우 세션 아이디 설정
		member_id = (String)session.getAttribute("member_id");
//		}  
		
		System.out.println(column);
		System.out.println(member_id);
		//상단 프로필 회원정보 가져오기
		Map<String, String> member = service.isMemberCheck(column, member_id);
		System.out.println(member);
		
		// COUNT 함수 값 가져오기
		
		model.addAttribute("member", member);
		
		// 중고 상품 회원정보 가져오기
		List<Map<String, String>> sellList = service.selectSecondhandList(member_id);
		System.out.println("sellList:" + sellList);
		model.addAttribute("sellList", sellList);
		
		return "member/member_mystore";
	}

	
	// 등록한 중고 상품 리스트 - 수정
	@ResponseBody
	@GetMapping("/ajax/mySecondhandList")
	public String myStoreSecondHandList(HttpSession session
							, Model model
							, @RequestParam(required = false) String member_id
							, @RequestParam Map<String, String> map
							) {
		System.out.println("/ajax/mySecondhandList - myStoreSecondHandList ");
		// 임시 고정값 설정 
		if(member_id == null ) { // 파라미터 member_id가 없을경우 세션 아이디 설정
			member_id = (String)session.getAttribute("member_id");
		}  
		System.out.println(member_id);

		List<Map<String, String>> sellList = service.selectSecondhandList(member_id);
		System.out.println("sellList:" + sellList);
		JSONArray myStore = new JSONArray();

		for (Map<String, String> item : sellList) {
		    JSONObject jsonItem = new JSONObject(item);
		    myStore.put(jsonItem);
		}

//		JSONObject resultObject = new JSONObject();
//		resultObject.put("myStore", jsonArray);
		
		return myStore.toString();
	}
	
	// 등록한 중고 상품 후기 리스트 - 수정
	@ResponseBody
	@GetMapping("/ajax/sell_secondhand_reviews")
	public String sellSecondhand_reviews(HttpSession session
							, Model model
							, @RequestParam(required = false) String member_id
							, @RequestParam Map<String, String> map
							) {
		
		System.out.println();
		// 임시 고정값 설정 
		if(member_id == null ) { // 파라미터 member_id가 없을경우 세션 아이디 설정
			member_id = (String)session.getAttribute("member_id");
		}  
		System.out.println(member_id);
		
		List<Map<String, String>> sellReviewList = service.selectsellReviewList(member_id);
		System.out.println("sellReviewList:" + sellReviewList);
		JSONArray myStore = new JSONArray();

		for (Map<String, String> item : sellReviewList) {
		    JSONObject jsonItem = new JSONObject(item);
		    myStore.put(jsonItem);
		}

//		JSONObject resultObject = new JSONObject();
//		resultObject.put("myStore", jsonArray);
		
		return myStore.toString();
	}
	
	// 등록한 경매 상품 리스트 - 수정
	@ResponseBody
	@GetMapping("/ajax/sell_auctionList")
	public String sellAuctionList(HttpSession session
							, Model model
							, @RequestParam(required = false) String member_id
							, @RequestParam Map<String, String> map
							) {
		
		System.out.println();
		
		if(member_id == null ) { // 파라미터 member_id가 없을경우 세션 아이디 설정
			member_id = (String)session.getAttribute("member_id");
		}  
		System.out.println(member_id);

		List<Map<String, String>> auctionList = service.selectAuctionList(member_id);
		System.out.println("auctionList:" + auctionList);
		JSONArray myStore = new JSONArray();

		for (Map<String, String> item : auctionList) {
		    JSONObject jsonItem = new JSONObject(item);
		    myStore.put(jsonItem);
		}

//		JSONObject resultObject = new JSONObject();
//		resultObject.put("myStore", jsonArray);
		System.out.println(myStore.toString());
		return myStore.toString();
	}
	
	// 등록한 찜목록 리스트  - 수정
	@ResponseBody
	@GetMapping("/ajax/myLikeList")
	public String myLikeList(HttpSession session
							, Model model
							, @RequestParam(required = false) String member_id
							, @RequestParam Map<String, String> map
							) {
		
		System.out.println();
		if(member_id == null ) { // 파라미터 member_id가 없을경우 세션 아이디 설정
			member_id = (String)session.getAttribute("member_id");
		} 
		System.out.println(member_id);

		List<Map<String, String>> likeList = service.selectLikeList(member_id);
		System.out.println("likeList:" + likeList);
		JSONArray myStore = new JSONArray();

		for (Map<String, String> item : likeList) {
		    JSONObject jsonItem = new JSONObject(item);
		    myStore.put(jsonItem);
		}

//		JSONObject resultObject = new JSONObject();
//		resultObject.put("myStore", jsonArray);
		
		return myStore.toString();
	}
	
	// 등록한 찜 삭제  - 수정
//	@ResponseBody
//	@GetMapping("/ajax/deleteMyLikeList")
//	public String deleteMyLikeList(HttpSession session
//			, Model model
//			, @RequestParam Map<String, String> map
//			) {
//	
//		System.out.println("/ajax/deleteMyLikeList");
//
//		
//		return "선택학 찜 목록이 삭제되었습니다";
//	}
	
	// 멤버 메인화면
	@GetMapping("member_mypage_main")
	public String memberMypageHome(HttpSession session, Model model) {
		
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
			
			return "fail_location";
		}
		
		// 세션 아이디로 구매내역 받아오기(최근 세개),(myOrderSecondhandList 줄임)
		List<OrderSecondhandVO> myOdShList = service.getMyOdShList(member_id, 0, 3); 
//		Map으로 하면 order_secondhand_date 값 = [unread] 다음에수정하기 
//		List<Map<String, Object>> myOdShList = service.getMyOdShList(member_id, 0, 2);
		
		// 세션 아이디로 판매내역 받아오기(최근 두개)
		List<SecondhandVO> myShList = service.getmyShList(member_id, 0, 3);
		
		// 세션 아이디로 회원내역 가져오기
		MemberVO member = service.getMember(member_id);
		
		// ZPAY잔액 가져오기 위해
		ZpayHistoryVO myZpayList = zpayService.getMyZpayHistory(member_id);
		
		model.addAttribute("myOdShList", myOdShList);
		model.addAttribute("myShList", myShList);
		model.addAttribute("member", member);
		model.addAttribute("myZpayList", myZpayList);
		
		return "member/member_mypage_main";
	}
	
	// 멤버 중고상품 구매내역
	@GetMapping("member_mypage_buyList")
	public String memberMypageBuyList(HttpSession session, Model model) {
		
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
				if(member_id == null) {
					model.addAttribute("msg", " 로그인이 필요합니다!");
					model.addAttribute("targetURL", "member_login");
					
					return "fail_location";
				}
		
		// 세션 아이디로 구매내역 받아오기(myOrderSecondhandList 줄임), 페이징처리해야됨
		List<OrderSecondhandVO> myOdShList = service.getMyOdShList(member_id, 0, 5);
		
		model.addAttribute("myOdShList", myOdShList);
		
		// myOdShList의 order_secondhand_idx 값을 가져오기 위해 리스트를 반복
		List<Integer> orderSecondhandIdxList = new ArrayList<>(); // order_secondhand_idx 값을 저장할 목록
		for(OrderSecondhandVO item : myOdShList) {
		    int order_secondhand_idx = item.getOrder_secondhand_idx(); // 각 요소의 order_secondhand_idx 값을 가져옴
		    orderSecondhandIdxList.add(order_secondhand_idx); // 리스트에 order_secondhand_idx 값을 추가
		}
		
		// 작성한 후기가 있는경우 후기작성하기버튼 -> 후기작성완료 상태로 변경하기 를 위한 isWriteReview
		Map<Integer, Integer> isWriteReviewMap = service.getWriteReviewStatus(member_id, orderSecondhandIdxList);
		model.addAttribute("isWriteReviewMap", isWriteReviewMap);
		
		return "member/member_mypage_buyList";
	}
	
	// 멤버 중고상품 판매내역 - 정의효 필요없음 삭제예정
//	@GetMapping("member_mypage_sellList")
//	public String memberMypageSellList(HttpSession session, Model model) {
//		
//		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
//		String member_id = (String) session.getAttribute("member_id");
////				if(member_id == null) {
////					model.addAttribute("msg", " 로그인이 필요합니다!");
////					model.addAttribute("targetURL", "member_login_form");
////							
////					return "fail_location";
////				}
//		
//		// 세션 아이디로 판매내역 받아오기
//		List<SecondhandVO> myShList = service.getmyShList(member_id, 0, 5);
//		
//		model.addAttribute("myShList", myShList);
//		
//		return "member/member_mypage_sellList";
//	}
	
	// 멤버 참가중인 경매 내역
	@GetMapping("member_mypage_auctionList")
	public String memberMypageAuctionList(HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
						if(member_id == null) {
							model.addAttribute("msg", " 로그인이 필요합니다!");
							model.addAttribute("targetURL", "member_login");
									
							return "fail_location";
						}
		
		// 세션아이디로 현재 진행중인 경매에 참여한 결과가 있는지 확인
		List<Map<String, String>> participateAuction = auctionService.getPartAuction(member_id);
		model.addAttribute("participateAuction", participateAuction);
		
		// 세션아이디랑 비교하여 낙찰받은 경매물품이 있는지 확인
		List<Map<String, String>> successBid = auctionService.getSuccessBid(member_id);
		model.addAttribute("successBid", successBid);
		return "member/member_mypage_auctionList";
	}
	
	// 마이페이지 후기 리스트
	@GetMapping("member_mypage_writeReviewList")
	public String member_mypage_writeReviewList(HttpSession session, Model model) {
		String member_id = (String) session.getAttribute("member_id");
		
		List<Map<String, String>> myReview = service.getReview(member_id);
		model.addAttribute("myReview", myReview);
		
		return "member/member_mypage_writeReviewList";
	}
	
	// 마이페이지 후기 삭제
	@PostMapping("member_mypage_delete_review")
	@ResponseBody
	public ResponseEntity<String> member_mypage_delete_review(HttpSession session, @Param("order_secondhand_idx") String order_secondhand_idx) {
	    String member_id = (String) session.getAttribute("member_id");
	    
	    int deleteReviewCount = service.deleteReview(member_id, order_secondhand_idx);
	    
	    if(deleteReviewCount > 0) {
	        return new ResponseEntity<>("success", HttpStatus.OK);
	    } else {
	        return new ResponseEntity<>("fail", HttpStatus.BAD_REQUEST);
	    }
	}
	
	// 회원가입 메인창
	@GetMapping("join")
	public String join() {
		return "member/member_join";
	}
	
	// 회원가입 메인 - 회원가입 버튼 클릭시 확인 절차후 리다이렉트 -> 완료창 이메일인증해주세요
	@PostMapping("join_pro")
	public String memberJoinPro(MemberVO member, Model model) {
		
		// ------------ BCryptPasswordEncoder 객체 활용한 패스워드 암호화(= 해싱) --------------
		// => MyPasswordEncoder 클래스에 모듈화
		// 1. MyPasswordEncoder 객체 생성
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
		String securePasswd = passwordEncoder.getCryptoPassword(member.getMember_passwd());
		// 3. 리턴받은 암호문을 MemberVO 객체에 덮어쓰기
		member.setMember_passwd(securePasswd);
		// -------------------------------------------------------------------------------------
		
		// MemberService(registMember()) - Member_mapper(insertMember())
		int insertCount = service.registMember(member);
		
		if(insertCount > 0) {
			return "redirect:/join_complete";
		} else {
			model.addAttribute("msg", "회원가입 실패 다시 작성해주세요");
			return "fail_back";
		}
	}
	
	// 회원가입 메일인증
	@PostMapping("sendAuthCode")
	@ResponseBody
	public ResponseEntity<?> sendAuthCode(@RequestParam("email") String email, HttpSession session) {
		// 메일 보내기위한 코드 수정
		JavaMailSenderImpl mailSender = (JavaMailSenderImpl)ctx.getBean("mailSender");
		
		// 로컬에서 되지만 서버에서 안되므로 일단 임시로 난수말고 지정숫자
//		Random random = new Random();
//		int checkNum = random.nextInt(888888) + 111111;
//		session.setAttribute("emailAuthCode", checkNum);
		
		int checkNum = 781017;
		session.setAttribute("emailAuthCode", checkNum);
		
		// 메일 제목, 내용
		String subject = "ZERO 회원가입 인증 메일입니다";
		String content = "아래의 인증 번호를 입력해주세요 인증코드 : " + checkNum;
		
		// 보내는 사람
		String from = "zero_market_itwb@naver.com";
		
		// 받는 사람
		String[] to = new String[]{email};
		
		try {
			// 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "UTF-8");

			// 메일 내용을 채워줌
			mailHelper.setFrom(from);	// 보내는 사람 셋팅
			mailHelper.setTo(to);		// 받는 사람 셋팅
			mailHelper.setSubject(subject);	// 제목 셋팅
			mailHelper.setText(content);	// 내용 셋팅

			// 메일 전송
			mailSender.send(mail);
			
		}  catch(Exception e) {
	        e.printStackTrace();
	        return new ResponseEntity<>(new EmailErrorResponse("이메일 발송에 실패했습니다. 다시 시도해주세요."),
	                HttpStatus.INTERNAL_SERVER_ERROR);
	    }

	    // 반환할 JSON 형식 (성공 시)
	    return new ResponseEntity<>(new SuccessResponse("이메일이 성공적으로 전송되었습니다."), HttpStatus.OK);
	}
	
	// 메일인증 코드 확인
	@PostMapping("checkAuthCode")
	@ResponseBody
	public ResponseEntity<?> checkAuthCode(@RequestParam("inputAuthCode") String inputAuthCode,
	                                       HttpSession session) {
	    Integer storedAuthCode = (Integer) session.getAttribute("emailAuthCode");

	    if (storedAuthCode == null) {
	        return new ResponseEntity<>(new EmailErrorResponse("세션에 인증코드 정보가 없습니다."), HttpStatus.BAD_REQUEST);
	    }

	    if (storedAuthCode.toString().equals(inputAuthCode)) {
	        return new ResponseEntity<>(new SuccessResponse("인증코드가 일치합니다."), HttpStatus.OK);
	    } else {
	        // 인증코드 불일치
	        return new ResponseEntity<>(new EmailErrorResponse("인증코드가 일치하지 않습니다!"), HttpStatus.OK);
	    }
	}

	// 핸드폰 인증
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int)((Math.random()* (9999 - 1000 + 1)) + 1000);//난수 생성

		testService.certifiedPhoneNumber(userPhoneNumber,randomNumber);
		
		return Integer.toString(randomNumber);
		
	}
	
	// 회원가입 폼에서 아이디 중복확인
	@PostMapping("/idCheck")
	@ResponseBody // json 값을 가져오기 위한 어노테이션 @ResponseBody
	public int idCheck(@RequestParam("id") String id) { // id 값을 받아오기 위한 @RequestParam
		int cnt = service.idCheck(id);
		return cnt;
	}
	
	// 회원가입 폼에서 닉네임 중복확인
	@PostMapping("/nickCheck")
	@ResponseBody // json 값을 가져오기 위한 어노테이션 @ResponseBody
	public int nickCheck(@RequestParam("nickname") String nickname) { // id 값을 받아오기 위한 @RequestParam
		int cnt = service.nickCheck(nickname);
		return cnt;
	}
	
	// 회원가입 폼에서 핸드폰 중복확인
	@PostMapping("/phoneCheck")
	@ResponseBody // json 값을 가져오기 위한 어노테이션 @ResponseBody
	public int phoneCheck(@RequestParam("phone") String phone) { // id 값을 받아오기 위한 @RequestParam
		int cnt = service.phoneCheck(phone);
		return cnt;
	}
	
	
	// 회원가입 완료 이동
	@GetMapping("join_complete")
	public String memberJoinComplete() {
		return "member/member_join_complete";
	}
	
	// Z-MAN 신청 - 마이페이지인데 거추장스럽다해서 삭제예정 확인후 삭제하기
//	@GetMapping("zman_join")
//	public String zmanJoin() {
//		return "member/member_zman_join_identification";
//	}
	
//	-------------------- ZMAN 컨트롤러 이동후 삭제예정 정의효 -----------------
	// Z-MAN 신청폼
//	@GetMapping("zman_join_form")
//	public String zmanJoinPro() {
//		return "member/member_zman_join_form";
//	}
//	
//	// Z-MAN 신청완료
//	@PostMapping("zman_join_complete")
//	public String zmanJoinComplete() {
//		return "member/member_zman_join_complete";
//	}
//	-------------------- ZMAN 컨트롤러 이동후 삭제예정 정의효 -----------------
	
	// 마이페이지 작성한 후기
	@GetMapping("member_mypage_write_review")
	public String mypageWriteReview() {
		return "member/member_mypage_write_review";
	}
	
	// 중고상품 구매 리뷰 작성
	@PostMapping("member_buyList_review")
	public String memberBuyListReview(MemberReviewVO review
									  , Model model
									  , @RequestParam("review_reader_id") String review_reader_id
									  , @RequestParam("review_writer_id") String review_writer_id
									  , @RequestParam("order_secondhand_idx") int order_secondhand_idx
									  , @RequestParam("member_review_rating") int member_review_rating
									  , @RequestParam("member_review_content") String member_review_content) {
		// MemberService(writeShReview()) - Member_mapper(insertwriteShReview())
		int insertCount = service.writeShReview(review, review_reader_id, review_writer_id, order_secondhand_idx, member_review_rating, member_review_content);
//		System.out.println("리뷰 작성 요청: " + review + ", " + review_reader_id + ", " + review_writer_id + ", " + order_secondhand_idx + ", " + member_review_rating + ", " + member_review_content);
		if(insertCount > 0) {
			return "redirect:/member_mypage_buyList";
		} else {
			model.addAttribute("msg", "리뷰작성 실패 다시 작성해주세요");
			return "fail_back";
		}
		
	}
	
	// 찜하기 ajax
	@PostMapping("secondhandLike")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> secondhandLike(@RequestBody Map<String, Object> likeInfo) {
	    String memberId = (String) likeInfo.get("member_id");
	    Object secondhandIdxObj = likeInfo.get("secondhand_idx");
	    String likeStatus = (String) likeInfo.get("like_status");

	    // secondhandIdxObj가 null이거나 비어 있으면 예외 처리
	    if (secondhandIdxObj == null) {
	        // 적한 예외 처리를 구현하세요. 예를 들면,
	        throw new RuntimeException("secondhand_idx 값이 없습니다.");
	    }

	    int secondhandIdx = ((Number) secondhandIdxObj).intValue();
	    int cnt;

	    // 찜 상태 확인
	    if ("liked".equals(likeStatus)) {
	        // 찜 취소 처리 및 cnt 감소
	        cnt = likesService.cancelLike(memberId, secondhandIdx);
	    } else {
	        // 찜 추가 처리 및 cnt 증가
	        cnt = likesService.addLike(memberId, secondhandIdx);
	    }

	    String newLikeStatus = likesService.getLikeStatus(memberId, secondhandIdx) > 0 ? "liked" : "unliked";

	    Map<String, Object> response = new HashMap<>();
	    response.put("likeStatus", newLikeStatus);

	    return ResponseEntity.ok(response);
	}
	
	// 마이페이지 - 문의 내역 페이지로 이동
	@GetMapping("myPage_inquiry")
	public String myPage_inquiry(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNo) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
				
			return "fail_location";
		}
			
		// 페이징
		int pageNum = 5;
			
		// 한 페이지에 보여줄 게시물 수
		int listLimit = 5;
			
		int startRow = (pageNo - 1) * listLimit;
			
			
		// 세션에 저장된 아이디로 문의내역 조회
		// myPageService - getMyInq(member_id)
		// 파라미터(member_id)		리턴타입(CsVO)
		List<CsVO> myInqList = service.getMyInqList(member_id, startRow, listLimit);
		System.out.println(myInqList);
			
		List<CsVO> myInqListAll = service.getMyInqList(member_id, 0, 0);
		int listCount = myInqListAll.size();
			
		// 한 페이지에서 표시할 목록 개수 설정(페이지 번호의 개수)
		int pageListLimit = 5;
			
		// 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
					
		// 시작 페이지 번호 계산
		int startPage = (pageNo - 1) / pageListLimit * pageListLimit + 1;
					
		// 끝 페이지 번호 계산
		int endPage = startPage + listLimit -1; // 끝페이지
					
		// 끝페이지 번호가 전체 페이지 번호보다 클 경우 끝 페이지 번호를 최대 페이지로 교체)
		if(endPage > maxPage) { 
				endPage = maxPage;
		}
			
		// 페이징 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("myInqList", myInqList);
		
		return "member/member_inquiry";
	}
		

	// 마이페이지 - 문의 내역 - 상세 조회
	@PostMapping("inquiry_detail")
	public String inquiry_detail(String cs_idx, @RequestParam(required= false) String cs_reply,
						HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
		String member_id = (String) session.getAttribute("member_id");
		if(member_id == null) {
			model.addAttribute("msg", " 로그인이 필요합니다!");
			model.addAttribute("targetURL", "member_login");
					
			return "fail_location";
		}
		
		// cs_num 받아와 조회해서 보여주기
		List<CsVO> myInquiryDetailList = service.getMyInquiryDetail(cs_idx);
//		List<CsInfoVO> myInquiryDetailList = service.getMyInquiryDetail(cs_num);
		
		// 문의 내역 저장
		model.addAttribute("myInquiryDetailList", myInquiryDetailList);
		model.addAttribute("cs_reply", cs_reply);
		
		return "member/member_inquiry_detail";
	}
	
	// 마이페이지 - 문의 내역 - 수정
		@PostMapping("myPage_inquiry_detailModify")
		public String myPage_inquiry_detailModify(
						@ModelAttribute("CsVO") CsVO board
						, @RequestParam("cs_idx") String cs_idx
						, HttpSession session
						, Model model
						, HttpServletRequest request) {
			// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
			String member_id = (String) session.getAttribute("member_id");
			if(member_id == null) {
				model.addAttribute("msg", " 로그인이 필요합니다!");
				model.addAttribute("targetURL", "member_login");
								
				return "fail_location";
			}
			
			// ======================================== 파일 처리 ========================================
			// 이클립스 프로젝트 상 업로드 폴더의 실제 경로 알아내기(request나 session 객체필요)
			String uploadDir = "/resources/upload";	// 현재 폴더상 경로
			String saveDir = request.getServletContext().getRealPath(uploadDir);  // 실제 경로
//					System.out.println(saveDir);
			// (지영) - 서버상 경로 알아두기
			
			String subDir = ""; // 서브디렉토리(업로드 날짜에 따라 디렉토리 구분하기)
			
			try {
				Date date = new Date();	// 1. Date 객체 생성
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");	// 날짜 형식 포맷 지정(/로 디렉토리 구분)
				// 실제 업로드 경로에 날짜 경로 결합
				subDir = sdf.format(date);	// 날짜 디렉토리
				saveDir += "/" + subDir;					// 실제 경로 + 날짜 경로
				
				// 실제 경로를 관리하는 객체 리턴받기(파라미터 : 
				Path path = Paths.get(saveDir);
				
				// path 객체로 관리하는 경로 생성
				Files.createDirectories(path);	// try-catch 필수
			} catch (IOException e) {
				System.out.println("e 이거 오류 : ");
				e.printStackTrace();
			}
			
			// 파라미터로 받은 CsVO board 에서 전달된 MultipartFile 객체 꺼내기
			MultipartFile mFile = board.getFile();
//					System.out.println("원본파일명1 : " + mFile.getOriginalFilename());
			
			// 파일명 중복 방지 처리 - 랜덤ID(8글자) 붙이기 (ex.랜덤ID_파일명.확장자)
			String uuid = UUID.randomUUID().toString().substring(0, 8);
			
			// 파일명이 없을 때를 대비하여 기본 파일명 "" 처리
			board.setCs_file(""); 	
			
			// 파일명을 저장할 변수 선언
			String fileName = uuid + "_" + mFile.getOriginalFilename();
			
			if(!mFile.getOriginalFilename().equals("")) {	// 파일이 있을 경우
				// 실제 이름을 (날짜디렉토리/uuid_실제받은파일명.확장자) 로 저장
				board.setCs_file(subDir + "/" + fileName);
			}
//					System.out.println("실제 업로드 파일명1 : " + board.getCs_file_real());
			
			// ======================================== 파일 처리 끝 ========================================
			
			// Service - updateMyInqList() 메서드를 호출하여 게시물 등록 작업 요청
			// => 파라미터 : cs_num, CsInfoVO    리턴타입 : int(insertCount)
//			int updateCount = service.updateMyInqList(cs_num, csInfo);
			int updateCount = service.updateMyInqList(board);
			
//			System.out.println(cs_num);
			
			// 게시물 등록 작업 요청 결과 판별
			if(updateCount > 0) { // 성공
				try {
					// 이동할 위치의 파일명도 UUID 가 결합된 파일명을 지정해야한다!
					if(!mFile.getOriginalFilename().equals("")) {
						mFile.transferTo(new File(saveDir, fileName));
					}

				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				return "redirect:/myPage_inquiry";
			} else { // 실패
				model.addAttribute("msg", "글 쓰기 실패!");
				return "fail_back";
			}
			
		}
		
		// 마이 페이지 - 문의 내역 - 삭제
		@GetMapping("delete_myInquiry")
		public String deleteMyInquiry(HttpSession session
									, Model model
									, @RequestParam("cs_idx") String cs_idx) {
			// 세션 아이디가 없을 경우 " 로그인이 필요합니다!" 출력 후 이전페이지로 돌아가기
			String member_id = (String) session.getAttribute("member_id");
			if(member_id == null) {
				model.addAttribute("msg", " 로그인이 필요합니다!");
				model.addAttribute("targetURL", "member_login");
						
				return "fail_location";
			}
			
			int deleteCount = service.deleteMyInquiry(cs_idx);
			
			if(deleteCount > 0) { // 삭제 성공
				return "redirect:/myPage_inquiry";
			} else {
				model.addAttribute("msg", "글 삭제 실패!");
				return "fail_back";
			}
			
		}
	
	
}






















